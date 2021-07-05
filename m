Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499033BC247
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhGER34 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGER34 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 13:29:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08CC061574;
        Mon,  5 Jul 2021 10:27:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s24so6418774oiw.2;
        Mon, 05 Jul 2021 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ua8aVhFSui7G1CyS6GAefRwrM5riv0Skd4YlAgOT16Q=;
        b=l2dX9nazMOEZeo10Zi/0uPfJFFvceTHMN8aC5iOaL8MAwkY+0beZxW722TMCdAbFO2
         MedKTP6R+aGJfIK+28zUbAMoypMUpiBZ0+Oefu5UUagVFHthlIc3vPYuF33G2RPzoK0i
         /X4DZgRIoGB2JQFTKnVkE9hMHJGrLndyxdKg8xeV7jB7Dx4R4gU3A5jFTAuutxWemOTk
         +jfwdKGlB52QCPSawfI+k4JtWhL4MiHpQ9RDwTUBv9+U1sZA4bAiX19tYekQ2qPXPOL2
         Y4vx6eZoiNGc7kuxcUpmeUL8c2iM98hwXAXyUKt/Iuke8j3M9rp1CVz3SSuy+j1ao8CM
         9z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ua8aVhFSui7G1CyS6GAefRwrM5riv0Skd4YlAgOT16Q=;
        b=i+2bTLE498owTtpOeZN0PI6uirXGfmkh4nK76q35LNuVq0rRsxYxfeWh7FZ1m5OUEd
         vCmzesV9Qh3p/6nd6SJVsS7Ui98aM/WSBU4Ooi9sWcD6vMrAxJX/l7ZRE7p4dADcz0BY
         q2sCXD4sIuhKEgo/WvT9lAKjR4LzQUxXqoCqS7AlxXGycR4O9WwPHQKlfdICzKDEhao8
         eYEqN0gxQMCBve4MhS0Bz6Z3pNTv2FellWESWXkbIAtrbAcD2kzMK9pXoWheh6JtRkwH
         r7x+QM0JdKoecT2tdfIls7OTeJe6ni6jOxwih5+5VyRgIEs/cwpNBe8F2PxZx7rwXvDt
         JNOA==
X-Gm-Message-State: AOAM532gsprNi9OB6kOBXBTPuu4FOk3AgUyhjjiluLomncFH9JX2mHOj
        PcDz2TR6eVJDGYn6paqyqY4=
X-Google-Smtp-Source: ABdhPJw38bLW7qI7p7gvlPSSox++C8SVEwo7w/6CQZymDiYbga5ixekTEjPq0s6GDd1/ynigh57bJQ==
X-Received: by 2002:a05:6808:10c7:: with SMTP id s7mr10929434ois.122.1625506037515;
        Mon, 05 Jul 2021 10:27:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm2701822otu.76.2021.07.05.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 10:27:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Jul 2021 10:27:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): Use library interpolation
Message-ID: <20210705172715.GA253538@roeck-us.net>
References: <20210704222014.12058-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704222014.12058-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 05, 2021 at 12:20:14AM +0200, Linus Walleij wrote:
> The kernel has a helper function for linear interpolation so
> use it. It incidentally makes the code easier to read as well.
> 
> Tested on the ST-Ericsson HREFv60plus hardware reference design
> with two thermistors forming a thermal zone.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Chris Lesiak <chris.lesiak@licor.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied.

Thanks,
Guenter

> ---
> ChangeLog v1->v2:
> - Drop the check for low == high as the linear interpolation
>   library function does this for us.
> - Multiply the temperatures in the table with 1000 *before*
>   interpolating instead of *after* so we increase precision
>   in the interpolation.
> ---
>  drivers/hwmon/ntc_thermistor.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 8587189c7f15..4c26db6738f9 100644
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
> @@ -553,15 +554,16 @@ static int get_temp_mc(struct ntc_data *data, unsigned int ohm)
>  	int temp;
>  
>  	lookup_comp(data, ohm, &low, &high);
> -	if (low == high) {
> -		/* Unable to use linear approximation */
> -		temp = data->comp[low].temp_c * 1000;
> -	} else {
> -		temp = data->comp[low].temp_c * 1000 +
> -			((data->comp[high].temp_c - data->comp[low].temp_c) *
> -			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
> -			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
> -	}
> +	/*
> +	 * First multiplying the table temperatures with 1000 to get to
> +	 * millicentigrades (which is what we want) and then interpolating
> +	 * will give the best precision.
> +	 */
> +	temp = fixp_linear_interpolate(data->comp[low].ohm,
> +				       data->comp[low].temp_c * 1000,
> +				       data->comp[high].ohm,
> +				       data->comp[high].temp_c * 1000,
> +				       ohm);
>  	return temp;
>  }
>  
