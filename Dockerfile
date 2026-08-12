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
COPY --from=build /app/publish .

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "SDKHRMS.Web.dll"]
