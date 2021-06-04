Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D41A39B3A1
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFDHQG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 03:16:06 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:54808 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhFDHQG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 03:16:06 -0400
Received: by mail-pj1-f49.google.com with SMTP id g24so5056928pji.4
        for <linux-iio@vger.kernel.org>; Fri, 04 Jun 2021 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8WzMP/8RgLyJFf5iELmniSk1G5TAUlv2DL8Fti8eAA=;
        b=VpvfULYodvk7LlOtYEUBMEp9SV/vszr+8LQrjx62pB495A8FEGc6auUIXaJn/uHa3l
         XAv6Wi42BxCMi15a/cjZamY6kOSGp5Jb5w+GepRRw3vECzwBimpoz81rMbnK8VnafWoM
         WJaKOXEW+/Mmjqmo9T30c3xUm8DFkKuRNQ6YQF4KjYEVxncA/vM47GhQ7ZSYTc16nwdo
         1v/L3Sl7X2nktpu4CzdTXLKlgeJ/NDCxsOJHcyVODtlus2FPcixaN8Vj492IBlaYXsw3
         uMZrG+nHhJeaEqJrwC8Fc8T8Dt40elj5ISSE8To3iEjfe1tuTXkkYCUKJgQupyDSRbPI
         JZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8WzMP/8RgLyJFf5iELmniSk1G5TAUlv2DL8Fti8eAA=;
        b=ly3J5qd0/zaAN5h0O3dTCaqcARbjX0fR5BknL4+1+KOgI1R+I0WJvgL/WdryrEDb99
         ydPnYKaZJm8dR7DE8mI2bC1OF3jVh0ymVHzNSPdFNZlNTY033bLEI9qBzk3aGVRbOYa5
         aK+P/CbJoYeI4LcOZaBxZ3qlr3NUceEH/i62xaE/ERZsn3qHFMBhK4AysydLE3ra5M7I
         Eo84OeGh+IL6Q5AFVwxWCp2RwmQ0Dk7k9vSvrIfIGyzJVL9gMiy/aGULXQ+DG691mMty
         2MuZA2pDTahESKG3xlB4fd5/4f9XylBfGxcmiThvk1T1ar6OiwO3Fi5DEgNYuPhTTmrH
         8QGw==
X-Gm-Message-State: AOAM533eeOn6h1GyxrBPCa7n2SBWAvc7wPu0tj7DZxqZJdfQq0VGbdrN
        Mc1dKwdhW9kP0YdKBroe1F6iL1EJstH52Dyx1CdPLHhd3sg=
X-Google-Smtp-Source: ABdhPJwY94zUF0G7qXvPziBVRxL2ERN0l/mYBtagRqIPuX0SZylqd1WsbqFhpKJBZ3EVvfFmvAkihVyBip8+RCLtYVk=
X-Received: by 2002:a17:90b:350a:: with SMTP id ls10mr3493062pjb.181.1622790784815;
 Fri, 04 Jun 2021 00:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210603193616.3708447-1-jic23@kernel.org>
In-Reply-To: <20210603193616.3708447-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 4 Jun 2021 10:12:53 +0300
Message-ID: <CA+U=Dsrep+tQKsXQLCX5piJFpO1fZu3=mSe2W8620-iJsT8wgQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adis: Cleanout unused headers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 3, 2021 at 10:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> 0-day recently added the include-what-you-use header checker and
> it gave a warning on an adis patch.  As such I decided to
> run it on all the adis drivers and see if it made sensible suggestions.
>
> Note this doesn't represent a complete list of what it suggested changing
> as I filtered out a few on the basis they are standard headers used to
> effectively include a bunch of other headers.
>
> Could split this into a patch per driver if people prefer.
>
> Note to anyone else trying this tool is that it is somewhat
> of a loose cannon so you will be wanting to carefully check any
> suggestions before proposing patches!
>
> I thought about also reorganising the headers whilst here, but
> that would make this patch harder to read, or lead to another rather
> noisy patch across most of the files.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/adis16201.c         | 3 ---
>  drivers/iio/accel/adis16209.c         | 3 ---
>  drivers/iio/gyro/adis16136.c          | 5 -----
>  drivers/iio/gyro/adis16260.c          | 5 -----
>  drivers/iio/imu/adis.c                | 4 ----
>  drivers/iio/imu/adis16400.c           | 7 -------
>  drivers/iio/imu/adis16460.c           | 1 -
>  drivers/iio/imu/adis16475.c           | 1 -
>  drivers/iio/imu/adis16480.c           | 6 ------
>  drivers/staging/iio/accel/adis16203.c | 6 ------
>  drivers/staging/iio/accel/adis16240.c | 6 ------
>  11 files changed, 47 deletions(-)
>
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index fe225990de24..7a434e2884d4 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -8,10 +8,7 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/slab.h>
>  #include <linux/spi/spi.h>
> -#include <linux/sysfs.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/imu/adis.h>
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index 6c2d4a967de7..ac08e866d612 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -7,11 +7,8 @@
>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/imu/adis.h>
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index d248c8a4a924..36879f01e28c 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -6,19 +6,14 @@
>   *   Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
>
> -#include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/module.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>
>  #include <linux/debugfs.h>
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index 56f930bbd341..66b6b7bd5e1b 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -5,17 +5,12 @@
>   * Copyright 2010 Analog Devices Inc.
>   */
>
> -#include <linux/interrupt.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/sysfs.h>
>  #include <linux/module.h>
>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>
>  #define ADIS16260_STARTUP_DELAY        220 /* ms */
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 319b64b2fd88..a5b421f42287 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -12,14 +12,10 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/module.h>
>  #include <asm/unaligned.h>
>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>
>  #define ADIS_MSC_CTRL_DATA_RDY_EN      BIT(2)
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index cb8d3ffab6fc..641b4f7d066d 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -10,22 +10,15 @@
>   * Copyright (c) 2011 Analog Devices Inc.
>   */
>
> -#include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/debugfs.h>
>  #include <linux/bitops.h>
>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/imu/adis.h>
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 73bf45e859b8..ba373d7aaa2b 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -5,7 +5,6 @@
>   * Copyright 2019 Analog Devices Inc.
>   */
>
> -#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 5654c0c15426..d0e84e5dee6c 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -14,7 +14,6 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/imu/adis.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/irq.h>
>  #include <linux/lcm.h>
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index a9c21a5ae05a..9ec0e61b484f 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -9,24 +9,18 @@
>  #include <linux/bitfield.h>
>  #include <linux/of_irq.h>
>  #include <linux/interrupt.h>
> -#include <linux/delay.h>
>  #include <linux/math.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/module.h>
>  #include <linux/lcm.h>
>  #include <linux/swab.h>
>  #include <linux/crc32.h>
>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>
>  #include <linux/debugfs.h>
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index b68304da288b..1d3026dae827 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -5,20 +5,14 @@
>   * Copyright 2010 Analog Devices Inc.
>   */
>
> -#include <linux/delay.h>
>  #include <linux/device.h>
>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/imu/adis.h>
> -#include <linux/iio/sysfs.h>
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/slab.h>
>  #include <linux/spi/spi.h>
> -#include <linux/sysfs.h>
>
>  #define ADIS16203_STARTUP_DELAY 220 /* ms */
>
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 8d3afc6dc755..2a8aa83b8d9e 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -5,20 +5,14 @@
>   * Copyright 2010 Analog Devices Inc.
>   */
>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>
>  #define ADIS16240_STARTUP_DELAY        220 /* ms */
> --
> 2.31.1
>
