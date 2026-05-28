# VetClinic App

## Authorization
This application now enforces authorization using Pundit. Users can only perform actions and access data according to their role matrix:
- **Admin**: Full CRUD access to all resources and can see all data.
- **Vet**: Can edit their own vet record. Has read-only access to owners and pets. Can manage (create/update/destroy) appointments assigned to them, and can manage treatments on their appointments.
- **Owner**: Can only edit their own owner record. Can manage their own pets and book/manage appointments for their pets. Cannot manage treatments.

### Seeded Credentials
The following users are available by default if you use the seed data:
- **Admin**: `admin@vetclinic.cl` / `password123`
- **Vet 1**: `vet@vetclinic.cl` / `password123`
- **Vet 2**: `vet2@vetclinic.cl` / `password123`
- **Owner 1**: `owner@vetclinic.cl` / `password123`
- **Owner 2**: `owner2@vetclinic.cl` / `password123`

## Authentication

To set up and run the VetClinic application locally, follow these steps:

```bash
bundle install
bin/rails db:setup
bin/rails server
```

The application will be available at `http://localhost:3000`.

## Image Processing Dependencies

This application uses Active Storage to upload pet images. It requires `libvips` for processing image variants on the fly. 
Please install it based on your operating system:

* **Debian/Ubuntu:** `sudo apt install libvips`
* **macOS (Homebrew):** `brew install vips`
* **Arch Linux:** `sudo pacman -S libvips`

## Action Text Sanitization

Action Text securely sanitizes input. As part of Lab 7 development, an explicit sanitization check was successfully performed: passing `<script>alert(1)</script>` into the rich text editor of a treatment was successfully sanitized. When rendered on the appointment show page, no alert fired and the malicious script tag was eliminated from the output HTML.
