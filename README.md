# Keycloak Custom Theme - Taskium

A custom Keycloak theme for the Taskium application, featuring a modern login interface with custom branding and styling.

## Features

- Custom login page with branded styling
- Custom fonts (Space Grotesk)
- Custom logo and branding assets
- Responsive design
- PatternFly v5 integration

## Prerequisites

- Docker and Docker Compose installed
- MySQL database (or compatible database)
- SSL certificates (for HTTPS) - optional but recommended

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/raghuhasanbokam/Keycloak-Custom-theme.git
cd Keycloak-Custom-theme
```

### 2. Configure Environment Variables

Copy the example environment file and fill in your credentials:

```bash
cp .env.example .env
```

Edit `.env` and update the following required variables:

```env
# Database Configuration
KC_DB_URL=jdbc:mysql://your-database-host:3306/keycloak
KC_DB_USERNAME=your_db_username
KC_DB_PASSWORD=your_db_password

# Keycloak Admin Credentials
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=your_secure_admin_password

# Hostname (update if not running locally)
KC_HOSTNAME=localhost
```

### 3. SSL Certificates Setup (Optional but Recommended)

If you're using HTTPS, place your SSL certificates in the `certs/` directory:

```bash
certs/
  ├── tls.crt  # Your SSL certificate
  └── tls.key  # Your SSL private key
```

**Note:** The `certs/` directory is already in `.gitignore` to prevent committing sensitive files.

### 4. Build the Docker Image

Build the custom Keycloak image with the theme:

```bash
docker build -t raghuhasan/taskium-keycloak:centered .
```

Or use your preferred image name:

```bash
docker build -t your-registry/taskium-keycloak:latest .
```

**Note:** Update the `image` field in `docker-compose.yml` if you use a different image name.

### 5. Start Keycloak with Docker Compose

```bash
docker-compose up -d
```

To view logs:

```bash
docker-compose logs -f
```

## Accessing Keycloak

### Admin Console

Once Keycloak is running, access the admin console at:

- **HTTPS:** https://localhost:8443/admin
- **HTTP (if enabled):** http://localhost:8080/admin

**Default Credentials:**
- Username: Value from `KEYCLOAK_ADMIN` in your `.env` file (default: `admin`)
- Password: Value from `KEYCLOAK_ADMIN_PASSWORD` in your `.env` file

### User Login Page

Access the login page at:

- **HTTPS:** https://localhost:8443/realms/{realm-name}/account
- **HTTP (if enabled):** http://localhost:8080/realms/{realm-name}/account

## Applying the Custom Theme

1. Log in to the Keycloak Admin Console
2. Navigate to **Realm Settings** → **Themes**
3. Under **Login theme**, select **Taskium**
4. Click **Save**

The custom theme will now be applied to all login pages in your realm.

## Configuration Options

### Environment Variables

All configuration is done through the `.env` file. Key variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `KC_HOSTNAME` | Keycloak hostname | `localhost` |
| `KC_HTTP_ENABLED` | Enable HTTP (not recommended for production) | `false` |
| `KC_DB` | Database type | `mysql` |
| `KC_DB_URL` | Database connection URL | **Required** |
| `KC_DB_USERNAME` | Database username | **Required** |
| `KC_DB_PASSWORD` | Database password | **Required** |
| `KEYCLOAK_ADMIN` | Admin username | `admin` |
| `KEYCLOAK_ADMIN_PASSWORD` | Admin password | **Required** |
| `KC_HEALTH_ENABLED` | Enable health checks | `true` |
| `KC_LOG_LEVEL` | Logging level | `info` |

### Port Configuration

By default, Keycloak runs on port `8443` for HTTPS. To change this, modify the port mapping in `docker-compose.yml`:

```yaml
ports:
  - 8443:8443  # Change the first number to your desired host port
```

## Database Setup

### MySQL Database

Ensure your MySQL database is accessible and create a database for Keycloak:

```sql
CREATE DATABASE keycloak;
CREATE USER 'keycloak_user'@'%' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON keycloak.* TO 'keycloak_user'@'%';
FLUSH PRIVILEGES;
```

Update your `.env` file with the database connection details.

## Health Check

If health checks are enabled, you can check the status at:

```
https://localhost:8443/health
```

## Troubleshooting

### Container Won't Start

1. Check logs: `docker-compose logs keycloak`
2. Verify your `.env` file has all required variables
3. Ensure database is accessible from the container
4. Check SSL certificates are in the correct format if using HTTPS

### Theme Not Appearing

1. Verify the theme is copied correctly: Check `/opt/keycloak/themes/Taskium` in the container
2. Clear browser cache
3. Ensure "Taskium" is selected in Realm Settings → Themes
4. Check browser console for CSS/asset loading errors

### Database Connection Issues

1. Verify database credentials in `.env`
2. Ensure database is accessible from Docker network
3. Check firewall rules allow connections
4. Verify database URL format: `jdbc:mysql://host:port/database`

### SSL Certificate Issues

1. Ensure certificates are in `certs/` directory
2. Verify file names: `tls.crt` and `tls.key`
3. Check certificate permissions
4. Verify certificate is valid and not expired

## Development

### Theme Structure

```
themes/custom-theme/theme/Taskium/
├── login/
│   ├── login.ftl              # Login page template
│   ├── template.ftl           # Base template
│   ├── theme.properties       # Theme configuration
│   ├── messages/
│   │   └── messages_en.properties
│   └── resources/
│       ├── css/               # Custom stylesheets
│       ├── fonts/             # Custom fonts
│       └── img/               # Images and logos
```

### Making Theme Changes

1. Edit theme files in `themes/custom-theme/theme/Taskium/`
2. Rebuild the Docker image: `docker build -t raghuhasan/taskium-keycloak:centered .`
3. Restart the container: `docker-compose restart`

## Security Notes

⚠️ **Important Security Reminders:**

- Never commit your `.env` file to version control
- Use strong passwords for database and admin accounts
- Keep SSL certificates secure and never commit them
- Regularly update Keycloak and dependencies
- Use HTTPS in production environments

## License

This project contains a custom Keycloak theme. Keycloak itself is licensed under the Apache License 2.0.

## Support

For issues related to:
- **Keycloak:** Visit [Keycloak Documentation](https://www.keycloak.org/documentation)
- **This Theme:** Open an issue in this repository

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

