FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["SDKHRMS.Web/SDKHRMS.Web/SDKHRMS.Web.csproj", "SDKHRMS.Web/SDKHRMS.Web/"]
COPY ["SDKHRMS.Web/SDKHRMS.Entities/SDKHRMS.Entities.csproj", "SDKHRMS.Web/SDKHRMS.Entities/"]

RUN dotnet restore "SDKHRMS.Web/SDKHRMS.Web/SDKHRMS.Web.csproj"

COPY . .

WORKDIR "/src/SDKHRMS.Web/SDKHRMS.Web"
RUN dotnet publish "SDKHRMS.Web.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# Install wkhtmltopdf and rendering dependencies for Linux
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wkhtmltopdf \
        libgdiplus \
        libc6-dev \
        libxrender1 \
        libxext6 \
        libfontconfig1 \
        libx11-dev \
        libjpeg62-turbo \
        fontconfig \
        fonts-dejavu-core \
        xfonts-75dpi \
        xfonts-base \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/publish .

# Ensure /app/Rotativa directory exists and wkhtmltopdf binary is available with execute permissions
RUN mkdir -p /app/Rotativa \
    && cp -f /usr/bin/wkhtmltopdf /app/Rotativa/wkhtmltopdf 2>/dev/null || ln -sf /usr/bin/wkhtmltopdf /app/Rotativa/wkhtmltopdf \
    && chmod +x /app/Rotativa/wkhtmltopdf

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "SDKHRMS.Web.dll"]
