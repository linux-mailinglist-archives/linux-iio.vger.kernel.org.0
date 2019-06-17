Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2B48DAF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfFQTN6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 15:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfFQTN5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jun 2019 15:13:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2637B20863;
        Mon, 17 Jun 2019 19:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560798837;
        bh=bxdIj4oZhzXoAyPDV43bDSTTIrA2bAYTv/gI2O7GXU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oKh//xU+4f7KGn6jEAMPhNRHWPWFLkX1le2j4IEJZtEu5H3wEaGvmxT445aLftyjN
         0Q/ZnyR3N/Wu8avi87z2rzfHn1dv1C/cDK1uaotjsOGwWWBbIvCrYrw46N7xAnh5w+
         HdFtKuUeN+UGAs3aKHiO8kcLQonVLAlIa7x0wl3s=
Date:   Mon, 17 Jun 2019 20:13:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Fertic <jeremyfertic@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: adt7316: use correct headers for gpio
Message-ID: <20190617201351.46537983@archlinux>
In-Reply-To: <20190617110951.2085648-1-arnd@arndb.de>
References: <20190617110951.2085648-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 13:09:20 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> When building without CONFIG_GPIOLIB, we get a compile-time failure:
> 
> drivers/staging/iio/addac/adt7316.c:947:3: error: implicit declaration of function 'gpiod_set_value' [-Werror,-Wimplicit-function-declaration]
>                 gpiod_set_value(chip->ldac_pin, 0);
>                 ^
> drivers/staging/iio/addac/adt7316.c:947:3: note: did you mean 'gpio_set_value'?
> include/linux/gpio.h:169:20: note: 'gpio_set_value' declared here
> static inline void gpio_set_value(unsigned gpio, int value)
>                    ^
> drivers/staging/iio/addac/adt7316.c:947:3: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
>                 gpiod_set_value(chip->ldac_pin, 0);
>                 ^
> drivers/staging/iio/addac/adt7316.c:1805:13: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror,-Wimplicit-function-declaration]
>         irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> 
> Include the correct headers that contain the declarations for these
> functions.
> 
> Fixes: c63460c4298f ("Staging: iio: adt7316: Use device tree data to set ldac_pin")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Sorry, this is me being exceedingly slow on getting the fix upstream.

I've just sent a pull request for the fix I've had queued up for a few weeks.

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 37ce563cb0e1..9cb3d0e42c38 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -6,7 +6,8 @@
>   */
>  
>  #include <linux/interrupt.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/irq.h>
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>

