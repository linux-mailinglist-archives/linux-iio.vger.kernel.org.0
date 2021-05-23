Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4214B38DC93
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhEWTTo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhEWTTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 15:19:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD2C061574
        for <linux-iio@vger.kernel.org>; Sun, 23 May 2021 12:18:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 22so18657132pfv.11
        for <linux-iio@vger.kernel.org>; Sun, 23 May 2021 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Td9WtVo/r9UjlLKLbVwAkJZXZSkB1vSbED0vod6KyFk=;
        b=AbVqrknel6QQE3ghdFJAkXxwvM05/eOCiMbsHjy9GCa9+JvdW6fKuzHLZqb1qXLSbl
         gs9GojgOVkGKXgZL/J4KnfEPHuEZCUYeCfqgpdM4wIWsMQIG7KeFm6uAEMChJegkdJd0
         gTNR9vWvVUIh9LtJOt3sQY6UG9H9R7J2NqOHADHlpZG8C6wihXS8HYZEJl+5ZfwMhSH4
         Oz6kPQsVN4uJJQFcHM63LonJySuSnDdGljBB1Qt7YlP/Cbura2wLic1oDRLeh64DEDAV
         q/m5lxl9yP50Ao4R/MAQ4YKR9Jjqz2QnZHsMzrVtrTfyQbv5DOn2Zo/6A4SQyAQMsDYK
         Ldcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Td9WtVo/r9UjlLKLbVwAkJZXZSkB1vSbED0vod6KyFk=;
        b=Ceke6gVGswb2mJx9TWy19xXdZbjldEqzjdfTEdz3GFaBm/j4HC8sIlwi5Q9Ef5GtoV
         lJZ6bCfNXE1AwgAxT5wcYZQ/Pclm5dCbr/IKN/WBd44ALyOA+gzwiuNaB3bxr92ku5PH
         G1zvHcr3s5haiHLDAPaepfwUuAsBjz8YAn3uRZt75q/uoVLbZ4ZqfKuktzsPW2lS8Dao
         h0eVG3gf/SFQIW26OEeICsE8eMvi065C4UItTpFBOpl9YbCEoRByy71AHmIvFn5JZC8h
         T9JpNpKEbwDqlJEbjfdntCAj39ZVMWPjITFxJC4zOXZl9VkuUzME0/v7oANoc03TIcjW
         phVA==
X-Gm-Message-State: AOAM532CPBQO6SrBAeluoRCGrm2S87Ki+X+UIRruIgAUju5FAxssz9Jr
        6vddfLZ7EZfswK9Yzem1m8mTCOkCSzzFePqt5/cAHgQdHSEVhQ==
X-Google-Smtp-Source: ABdhPJzH8BUKwIY/xzvwiWEQHJFWAYzTKLoUPoV6PfNYPXjLh1x+BznlXGe4BKSANmwC28iXWK6oyKR1pntNX7HMtM4=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr9866138pgc.203.1621797495198;
 Sun, 23 May 2021 12:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210523162315.1965869-1-jic23@kernel.org> <20210523162315.1965869-2-jic23@kernel.org>
In-Reply-To: <20210523162315.1965869-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 23 May 2021 22:17:58 +0300
Message-ID: <CAHp75Vd8RUi3pMj+hi9C+0qt=FBi9KosC61YPiegZ_DEkYHx8g@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: accel: mma9551/mma9553: Drop explicit ACPI match support
To:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc: Hans, who asked to Cc him on such patches.

On Sun, May 23, 2021 at 7:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The IDs look highly suspicious as they are just the part numbers in
> capitals, so lets drop these if no one screams.

let's

I suggest adding some additional information to such commits (based on
what I just have done):
- MMA is registered PNP ID for Micromedia AG (is it part of Freescale?)
- Googling doesn't show any results for such ACPI _HID to be present in the wild

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/accel/mma9551.c | 21 ---------------------
>  drivers/iio/accel/mma9553.c | 21 ---------------------
>  2 files changed, 42 deletions(-)
>
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 4c359fb05480..2b74f67536a3 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -435,17 +435,6 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
>         return 0;
>  }
>
> -static const char *mma9551_match_acpi_device(struct device *dev)
> -{
> -       const struct acpi_device_id *id;
> -
> -       id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -       if (!id)
> -               return NULL;
> -
> -       return dev_name(dev);
> -}
> -
>  static int mma9551_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -464,8 +453,6 @@ static int mma9551_probe(struct i2c_client *client,
>
>         if (id)
>                 name = id->name;
> -       else if (ACPI_HANDLE(&client->dev))
> -               name = mma9551_match_acpi_device(&client->dev);
>
>         ret = mma9551_init(data);
>         if (ret < 0)
> @@ -591,13 +578,6 @@ static const struct dev_pm_ops mma9551_pm_ops = {
>                            mma9551_runtime_resume, NULL)
>  };
>
> -static const struct acpi_device_id mma9551_acpi_match[] = {
> -       {"MMA9551", 0},
> -       {},
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
> -
>  static const struct i2c_device_id mma9551_id[] = {
>         {"mma9551", 0},
>         {}
> @@ -608,7 +588,6 @@ MODULE_DEVICE_TABLE(i2c, mma9551_id);
>  static struct i2c_driver mma9551_driver = {
>         .driver = {
>                    .name = MMA9551_DRV_NAME,
> -                  .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
>                    .pm = &mma9551_pm_ops,
>                    },
>         .probe = mma9551_probe,
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index ba3ecb3b57dc..32c9a79ebfec 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1062,17 +1062,6 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
>         return IRQ_HANDLED;
>  }
>
> -static const char *mma9553_match_acpi_device(struct device *dev)
> -{
> -       const struct acpi_device_id *id;
> -
> -       id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -       if (!id)
> -               return NULL;
> -
> -       return dev_name(dev);
> -}
> -
>  static int mma9553_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -1091,8 +1080,6 @@ static int mma9553_probe(struct i2c_client *client,
>
>         if (id)
>                 name = id->name;
> -       else if (ACPI_HANDLE(&client->dev))
> -               name = mma9553_match_acpi_device(&client->dev);
>         else
>                 return -ENOSYS;
>
> @@ -1230,13 +1217,6 @@ static const struct dev_pm_ops mma9553_pm_ops = {
>                            mma9553_runtime_resume, NULL)
>  };
>
> -static const struct acpi_device_id mma9553_acpi_match[] = {
> -       {"MMA9553", 0},
> -       {},
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
> -
>  static const struct i2c_device_id mma9553_id[] = {
>         {"mma9553", 0},
>         {},
> @@ -1247,7 +1227,6 @@ MODULE_DEVICE_TABLE(i2c, mma9553_id);
>  static struct i2c_driver mma9553_driver = {
>         .driver = {
>                    .name = MMA9553_DRV_NAME,
> -                  .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
>                    .pm = &mma9553_pm_ops,
>                    },
>         .probe = mma9553_probe,
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
