
# 🛠️ PlanRadar Due Date Reminder System

This Ruby on Rails 8.0.2 application implements a **due date reminder notification system** for ticket management. Users can configure personalized reminder settings to receive email notifications before ticket due dates.

---

## 📌 Features

- Enable/disable due date reminders per user
- Set reminder **interval**, **time of day**, and **time zone**
- Send **email notifications** with a summary of due tickets
- Background processing via **Sidekiq**
- Designed for future extensibility (SMS, push notifications, etc.)
- Fully tested using **RSpec**

---

## 🚀 Tech Stack

- **Ruby**: `3.2.8`
- **Rails**: `8.0.2`
- **Redis**: `7.0.15`
- **Sidekiq**: for background jobs
- **RSpec**: for testing
- **PostgreSQL** for database

---

## ⚙️ Setup Instructions

### 1. Clone the Project

```bash
git clone https://github.com/HebaMamdouh93/PlanRadar-duedate-reminder
cd PlanRadar-duedate-reminder
````

### 2. Install Dependencies

```bash
bundle install
```

### 3. Set Up the Database

```bash
bin/rails db:create db:migrate db:seed
```

> ✅ `db:seed` adds development users and tickets for testing.

### 4. Start Redis

Make sure Redis is running:

```bash
redis-server
```

### 5. Start Rails Server

```bash
bin/rails server
```

### 6. Start Sidekiq (in a separate terminal)

```bash
bundle exec sidekiq
```

> Sidekiq processes background jobs including `DueDateRemindersJob`.

---

## 🧪 Running Tests

Run the full RSpec test suite:

```bash
bundle exec rspec
```

Run a specific test file:

```bash
bundle exec rspec spec/services/notification_service_spec.rb
```

---

## 🧱 Project Structure

| File / Folder                              | Description                            |
| ------------------------------------------ | -------------------------------------- |
| `app/jobs/due_date_reminders_job.rb`       | Periodic job for checking reminders    |
| `app/services/notification_service.rb`     | Main entry point for sending reminders |
| `app/services/email_notification.rb`       | Handles email delivery logic           |
| `app/mailers/due_date_reminders_mailer.rb` | Renders and sends the email            |
| `spec/`                                    | Full test coverage using RSpec         |

---

## 🧩 Future Improvements

* Add support for:

  * SMS
  * Push notifications
* Dockerize app


