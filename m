Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22203E63D7
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfJ0P4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 11:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfJ0P4I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 11:56:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B25D220873;
        Sun, 27 Oct 2019 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572191767;
        bh=Pgz2qi0WgZfVfbFx8PUgtXYuCY6X49z/ckhZKod0qMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JFoiMzyoBsKgj1EwwoSEnclXuVlDOty2A3/vnZpGWnC466KZhZr0sX/V+cOOE59/Z
         9as0h2t6FBlEpwGoDiYBXy3vUWWuSUeNlDqzfDIWJiRnyB8jlrmHz0YkGnFgSfoZF0
         uXszHWJYgP45JF2w4XnPidnIcgvafTLvXvmXnXVU=
Date:   Sun, 27 Oct 2019 15:56:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: st: Drop GPIO include
Message-ID: <20191027155600.6869be8a@archlinux>
In-Reply-To: <20191023084702.22969-1-linus.walleij@linaro.org>
References: <20191023084702.22969-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Oct 2019 10:47:02 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> None of the ST sensor drivers use any symbols from
> <linux/gpio.h>, just drop the include from all of them.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/st_accel_core.c       | 1 -
>  drivers/iio/gyro/st_gyro_core.c         | 1 -
>  drivers/iio/magnetometer/st_magn_core.c | 1 -
>  drivers/iio/pressure/st_pressure_core.c | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 2e37f8a6d8cf..7b837641f166 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -15,7 +15,6 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index c0acbb5d2ffb..57be68b291fa 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -14,7 +14,6 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index a3a268ee2896..e68184a93a6d 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -14,7 +14,6 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index ca6863b32a5f..bd972cec4830 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -14,7 +14,6 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>

