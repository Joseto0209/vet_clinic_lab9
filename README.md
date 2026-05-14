# VetClinic App

## Authentication
This application now requires authentication for most features (owners, pets, vets, appointments, treatments). Only the home page is publicly accessible without an account.
Devise has been added to handle this, along with specific modifications for first_name, last_name, and role variables for the `User` model.

### Seeded Credentials
The following users are available by default if you use the seed data:
- **Admin**: `admin@vetclinic.cl` / `password123`
- **Vet**: `vet@vetclinic.cl` / `password123`
- **Owner**: `owner@vetclinic.cl` / `password123`

## Setup

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
