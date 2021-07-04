Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037913BADC3
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhGDQOW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 12:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhGDQOW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 12:14:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0EE61363;
        Sun,  4 Jul 2021 16:11:44 +0000 (UTC)
Date:   Sun, 4 Jul 2021 17:14:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ntc_thermistor): Use library interpolation
Message-ID: <20210704171406.61235987@jic23-huawei>
In-Reply-To: <20210703180131.4036589-1-linus.walleij@linaro.org>
References: <20210703180131.4036589-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  3 Jul 2021 20:01:31 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> The kernel has a helper function for linear interpolation so
> use it. It incidentally makes the code easier to read as well.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Chris Lesiak <chris.lesiak@licor.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Potential precision problem because the multiplication by 1000 is now done
post division whereas before it was before it?

I'm only eyeballing the code so no idea if it makes a practical difference.

> ---
>  drivers/hwmon/ntc_thermistor.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 8587189c7f15..61bd0e074ec9 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/fixp-arith.h>
>  
>  #include <linux/platform_data/ntc_thermistor.h>
>  
> @@ -557,10 +558,12 @@ static int get_temp_mc(struct ntc_data *data, unsigned int ohm)
>  		/* Unable to use linear approximation */
>  		temp = data->comp[low].temp_c * 1000;
>  	} else {
> -		temp = data->comp[low].temp_c * 1000 +
> -			((data->comp[high].temp_c - data->comp[low].temp_c) *
> -			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
> -			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
> +		temp = fixp_linear_interpolate(data->comp[low].ohm,
> +					       data->comp[low].temp_c,
> +					       data->comp[high].ohm,
> +					       data->comp[high].temp_c,
> +					       ohm);
> +		temp *= 1000;
>  	}
>  	return temp;
>  }

