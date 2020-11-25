Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A372C3E8A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgKYKyO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 05:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYKyN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 05:54:13 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3BC0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:54:13 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id v21so2139630pgi.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrRG/lraF0a4QJdaQNShmMTumbl4W31NPwrebOn9Jdk=;
        b=nsYTcIuCD7ivxJb3e1q7k6Yns9u/0aaLL7ZUyZkkvpD5XEMk1PSZjqZaQDKaX3ciV/
         k6FjJt9/BHTh1+ED/+kXJ/3+WutXiDOdGwh+W8VykMn0Du1mklWwNyHtbr4kT6JUiHju
         JoJVdkGhwf5P2h2BTvQxN7nhusHoJsQip9L1xFKNSxoNJBF0yLa2Da7lOJ2VThhQwRZD
         8uLG78fmJ53JDKZH/g0bZguxQCR5JL64LV+sNl6vpTZwqagw5szziz68MS2S2WvCUi+c
         3jqXW2qOcDd53V67AovXcq79+rZ6i2l5WDdhYKY4uuTXpD4ts5qPrXP/bK/WGNQZ0c40
         HjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrRG/lraF0a4QJdaQNShmMTumbl4W31NPwrebOn9Jdk=;
        b=p9EMjtYdQTtt5mIZQZXZSU7sdKF/drr4eN3E8n3lS5nuhC8ZeP40F8wWSHOlGANOG4
         q+p14zpUfpOfVufAjH1SuuNhdNT4SUrD396oRayMoPdi0qDstoVKkJRzWttVUrIg8LwW
         XRnUN6m+hj5YQPC387bsT0V+yGMO1ZmBpC7czEaaoqTVho6Ol3VB2HnFRkAnSs0bwExK
         Jmk76twcFjYI1zBf5uRTmol10mgaqvKGSolRIJamJHsDOpFXteKJMaSbI+vmcgHR8bpA
         fjaApFKpYc5zYY9W/Qrrj+ibtieb9EdXm8mS154Zblh4iDq/MnJNYJ4tvAY1p0gx+hd6
         YTog==
X-Gm-Message-State: AOAM533K0jwHuxKM/nii9Ov61J0L464AChtbGODikkWLXFnEXTUMhp5I
        Ahod26b33WYOc4q4tg6MEcNkQy1pDhVw9VkdBJY=
X-Google-Smtp-Source: ABdhPJy9VUI60ZjczM1l6n43SIpgtNqa4gKTZ+DK0aG3gZ5goFM4C6gVo1ypYXqEuIPI4lDiFg1+p1F3U2aYRyYhz6U=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr3473915pjv.129.1606301652573;
 Wed, 25 Nov 2020 02:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20201125083618.10989-1-hdegoede@redhat.com> <20201125083618.10989-3-hdegoede@redhat.com>
In-Reply-To: <20201125083618.10989-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 12:55:01 +0200
Message-ID: <CAHp75VcZQ1duxHnUTD9ewRhWxoHay8S6AQaEK3v3jJr+oQcbDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> From: Jeremy Cline <jeremy@jcline.org>
>
> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
> device. Normally we would handle this by letting the special
> drivers/platform/x86/i2c-multi-instantiate.c driver handle the BOSC0200
> ACPI id and let it instantiate 2 bmc150_accel type i2c_client-s for us.
>
> But doing so changes the modalias for the first accelerometer
> (which is already supported and used on many devices) from
> acpi:BOSC0200 to i2c:bmc150_accel. The modalias is not only used
> to load the driver, but is also used by hwdb matches in
> /lib/udev/hwdb.d/60-sensor.hwdb which provide a mountmatrix to
> userspace by setting the ACCEL_MOUNT_MATRIX udev property.
>
> Switching the handling of the BOSC0200 over to i2c-multi-instantiate.c
> will break the hwdb matches causing the ACCEL_MOUNT_MATRIX udev prop
> to no longer be set. So switching over to i2c-multi-instantiate.c is
> not an option.

I'm wondering if we can meanwhile update hwdb to support
i2c-multi-instantiate cases in the future and in a few years switch to
it.

> Changes by Hans de Goede:
> -Add explanation to the commit message why i2c-multi-instantiate.c
>  cannot be used
> -Also set the dev_name, fwnode and irq i2c_board_info struct members
>  for the 2nd client

...

> +       ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq, name, block_supported);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
> +        * device, try instantiating a second i2c_client for an I2cSerialBusV2
> +        * ACPI resource with index 1. The !id check avoids recursion when
> +        * bmc150_accel_probe() gets called for the second client.
> +        */

> +       if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {

> +               struct i2c_board_info board_info = {
> +                       .type = "bmc150_accel",
> +                       /* The 2nd accel sits in the base of 2-in-1s */

> +                       .dev_name = "BOSC0200:base",

Hmm... Can we use '.' (dot) rather than ':' (colon) to avoid confusion
with ACPI device naming schema? (Or was it on purpose?)
And this seems to be the only device in the system, second as this is
not allowed as far as I understand. Right? But theoretically I can
create an ACPI SSDT with quite similar excerpt and sensor and
enumerate it via ConfigFS (I understand that is quite unlikely).

> +                       .fwnode = client->dev.fwnode,
> +                       .irq = -ENOENT,
> +               };
> +               struct i2c_client *second_dev;
> +
> +               second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
> +               if (!IS_ERR(second_dev))
> +                       bmc150_set_second_device(second_dev);
> +       }

...

>  static int bmc150_accel_remove(struct i2c_client *client)
>  {
> +       struct i2c_client *second_dev = bmc150_get_second_device(client);

> +       if (second_dev)

Redundant.

> +               i2c_unregister_device(second_dev);
> +
>         return bmc150_accel_core_remove(&client->dev);
>  }

-- 
With Best Regards,
Andy Shevchenko
