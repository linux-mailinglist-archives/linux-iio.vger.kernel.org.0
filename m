Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C09337F7B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 22:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCKVPY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 16:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhCKVPI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 11 Mar 2021 16:15:08 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FAB364F79;
        Thu, 11 Mar 2021 21:15:07 +0000 (UTC)
Date:   Thu, 11 Mar 2021 21:15:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Remove kernel-doc keyword in file header comment
Message-ID: <20210311211503.2900df1b@archlinux>
In-Reply-To: <20210309234314.2208256-1-gwendal@chromium.org>
References: <20210309234314.2208256-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

tiOn Tue,  9 Mar 2021 15:43:14 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Remove kernel-doc keyword from function header comment.
> It fixes issues spotted by scripts/kernel-doc like:
> drivers/iio/<driver>.c:3: info: Scanning doc for function <component name>
> drivers/iio/<driver>.c:X: warning: expecting prototype for <component name>.
>   Prototype was for <function>() instead
> 
> To reproduce the errors:
> scripts/kernel-doc -v -none $(find drivers/iio/ -name \*.c \
> -exec head -2 {} \+ | grep -B2 -e '\*\*' | grep '==' | cut -d ' ' -f 2)
> 
> After, confirm these errors are gone with:
> scripts/kernel-doc -v -none $(git show --name-only  | grep -e "^driver")
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Looks like there are more issues related to kernel doc in ti-adc084s021
but as they don't fall in this particular form lets fix those separately.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma220_spi.c         | 2 +-
>  drivers/iio/accel/da280.c              | 2 +-
>  drivers/iio/accel/da311.c              | 2 +-
>  drivers/iio/accel/dmard10.c            | 2 +-
>  drivers/iio/accel/mc3230.c             | 2 +-
>  drivers/iio/accel/mma7660.c            | 2 +-
>  drivers/iio/accel/stk8312.c            | 2 +-
>  drivers/iio/accel/stk8ba50.c           | 2 +-
>  drivers/iio/adc/ti-adc084s021.c        | 2 +-
>  drivers/iio/humidity/am2315.c          | 2 +-
>  drivers/iio/light/opt3001.c            | 2 +-
>  drivers/iio/light/stk3310.c            | 2 +-
>  drivers/iio/trigger/iio-trig-hrtimer.c | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 3c9b0c6954e60..36fc9876dbcaf 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * BMA220 Digital triaxial acceleration sensor driver
>   *
>   * Copyright (c) 2016,2020 Intel Corporation.
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 4472dde6899ec..5edff9ba72da7 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * IIO driver for the MiraMEMS DA280 3-axis accelerometer and
>   * IIO driver for the MiraMEMS DA226 2-axis accelerometer
>   *
> diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
> index 3b3df620ba272..92593a1cd1aa6 100644
> --- a/drivers/iio/accel/da311.c
> +++ b/drivers/iio/accel/da311.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * IIO driver for the MiraMEMS DA311 3-axis accelerometer
>   *
>   * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
> diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
> index 90206f015857d..e84bf8db1e895 100644
> --- a/drivers/iio/accel/dmard10.c
> +++ b/drivers/iio/accel/dmard10.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * IIO driver for the 3-axis accelerometer Domintech ARD10.
>   *
>   * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 46e4283fc0375..735002b716f32 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * mCube MC3230 3-Axis Accelerometer
>   *
>   * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index b3c9136d51ec7..47f5cd66e996e 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Freescale MMA7660FC 3-Axis Accelerometer
>   *
>   * Copyright (c) 2016, Intel Corporation.
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 3b59887a8581b..1a8a1a0c3ffb4 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Sensortek STK8312 3-Axis Accelerometer
>   *
>   * Copyright (c) 2015, Intel Corporation.
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 3ead378b02c9b..7a06904455eb2 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Sensortek STK8BA50 3-Axis Accelerometer
>   *
>   * Copyright (c) 2015, Intel Corporation.
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index fb14b92fa6e71..d6e1bf3de755c 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2017 Axis Communications AB
>   *
>   * Driver for Texas Instruments' ADC084S021 ADC chip.
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index 02ad1767c845e..23bc9c784ef4b 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Aosong AM2315 relative humidity and temperature
>   *
>   * Copyright (c) 2016, Intel Corporation.
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 2d48d61909a4d..52963da401a78 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * opt3001.c - Texas Instruments OPT3001 Light Sensor
>   *
>   * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index a2827d03ab0fb..07e91846307c7 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Sensortek STK3310/STK3311 Ambient Light and Proximity Sensor
>   *
>   * Copyright (c) 2015, Intel Corporation.
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index 410de837d0417..9fbf878ad2d18 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * The industrial I/O periodic hrtimer trigger driver
>   *
>   * Copyright (C) Intuitive Aerial AB

