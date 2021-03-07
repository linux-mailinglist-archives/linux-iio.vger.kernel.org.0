Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1873B32FF38
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 07:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCGGDE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 01:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhCGGDE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 01:03:04 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4065EC06174A;
        Sat,  6 Mar 2021 22:03:04 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id b8so6055440oti.7;
        Sat, 06 Mar 2021 22:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7sWkHvepJU82exq5mGHxadvTrEj6FzoVHN4NGEZgpkk=;
        b=o1+aZ5hmI55zLzHWwfFtZuS8Lvqexqp9U7OSpikhKlX2/aRZbSMcb6SOwIV/M92csk
         hwRoGAMVZ+wxVxGbc2OsBx0HkJ7KtvKeFJMtY4ZKlbtFTbuB1NdHQsgb7FUP2ZnOla0i
         6UFZ+MEkSg+Hd4Tk78AmgVbPyYtrMRjEdMt6q+AqwDNWvYUvL8IL8Dr5uEH/xo7HtBis
         OHx5zLD7JIyEi2YhJymkebpFKvukSLhz/m5ZQ+wJizBDZ9uGWJN8oceEmpIEccRa2Nrp
         trhvFZMWetWzx+0cd0GWTEt9iD1fd7UGjWBzY3oSww4A152zrDuD7kUnDpYVLOLh3bRm
         Anpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7sWkHvepJU82exq5mGHxadvTrEj6FzoVHN4NGEZgpkk=;
        b=l4Bi9uy6bMbxfKSL26jmheprG/X5V/qtuTq3xNIV8DN7VevIe/5XLd+7PuazhJaT44
         oNSyOKR2LO7A6H+GZAjkrgkz+IC7GgKTonInSzN+cd2JuPZXxCZrCFyFuZfItoqyO0lo
         sVk4MkcQU2NRZEn0rSLc8hrvTq6sOXM80bn/il9XX72cvL3Bl5BwH7MC1U3elaCmkLdz
         79W12xmmt1Fzb5wQg/0wFpWw2xGWFOuhLEfT2MT12ADXh3pDQks1quXNdhEgj9i/LXoL
         GUsGi1O8ULf7CaEud23wIWGrwl5DMvi/4zihFrmFgkibLPv6YK66xUdjIDbGgrKD74YI
         BS0g==
X-Gm-Message-State: AOAM530o6rDyNukhgVS3dPcoZdfN268SkCb+jwnnheiLzh2rrIq0vHNq
        0nORflaCsmQGsIZ1rArg/R4=
X-Google-Smtp-Source: ABdhPJy4OmX4dS07zPaGC9xZYyVVwuFSahdZly2zAedU3RnDCSxgYudSQCVepQZx0A+Yxo1HWLRwjQ==
X-Received: by 2002:a05:6830:158c:: with SMTP id i12mr14301709otr.7.1615096983414;
        Sat, 06 Mar 2021 22:03:03 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6sm1605690ooa.40.2021.03.06.22.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Mar 2021 22:03:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 6 Mar 2021 22:03:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        linux-hwmon@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (ntc_thermistor): try reading processed
Message-ID: <20210307060301.GA41122@roeck-us.net>
References: <20210306232004.2400379-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306232004.2400379-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 07, 2021 at 12:20:04AM +0100, Linus Walleij wrote:
> Before trying the custom method of reading the sensor
> as raw and then converting, we want to use
> iio_read_channel_processed() which first tries to
> see if the ADC can provide a processed value directly,
> else reads raw and applies scaling inside of IIO
> using the scale attributes of the ADC. We need to
> multiply the scaled value with 1000 to get to
> microvolts from millivolts which is what processed
> IIO channels returns.
> 
> Since the old iio_read_channel_processed() would
> lose precision if we fall back to reading raw and
> scaling, we introduce a new API that will pass in
> the scale factor, iio_read_channel_processed_scale(),
> as part of this patch.
> 
> Keep the code that assumes 12bit ADC around as a
> fallback.
> 
> This gives correct readings on the AB8500 thermistor
> inputs used in the Ux500 HREFP520 platform for reading
> battery and board temperature.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Chris Lesiak <chris.lesiak@licor.com>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: linux-iio@vger.kernel.org
> Link: https://lore.kernel.org/linux-iio/20201224011607.1059534-1-linus.walleij@linaro.org/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - After discussion about v2 we concludes that
>   iio_read_channel_processed() could loose precision
>   so we introduce a new API to read processed and
>   scale.
> - Include a link to the v2 discussion for reference.
> - For ease of applying to the hwmon tree, keep it all
>   in one patch.
> - This needs Jonathans ACK to be merged through hwmon.
> ChangeLog v1->v2:
> - Fix the patch to multiply the processed value by
>   1000 to get to microvolts from millivolts.
> - Fix up the confusion in the commit message.
> - Drop pointless comments about the code, we keep the
>   original code path around if processed reads don't
>   work, nothing bad with that.
> ---
>  drivers/hwmon/ntc_thermistor.c | 27 ++++++++++++++++++---------
>  drivers/iio/inkern.c           | 15 +++++++++++++--
>  include/linux/iio/consumer.h   | 15 +++++++++++++++

No matter which branch this is merged through, it should be several
patches, one to introduce the API and one to start using it.

Guenter

>  3 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 3aad62a0e661..8587189c7f15 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -326,18 +326,27 @@ struct ntc_data {
>  static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
>  {
>  	struct iio_channel *channel = pdata->chan;
> -	int raw, uv, ret;
> +	int uv, ret;
>  
> -	ret = iio_read_channel_raw(channel, &raw);
> +	ret = iio_read_channel_processed_scale(channel, &uv, 1000);
>  	if (ret < 0) {
> -		pr_err("read channel() error: %d\n", ret);
> -		return ret;
> -	}
> +		int raw;
>  
> -	ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
> -	if (ret < 0) {
> -		/* Assume 12 bit ADC with vref at pullup_uv */
> -		uv = (pdata->pullup_uv * (s64)raw) >> 12;
> +		/*
> +		 * This fallback uses a raw read and then
> +		 * assumes the ADC is 12 bits, scaling with
> +		 * a factor 1000 to get to microvolts.
> +		 */
> +		ret = iio_read_channel_raw(channel, &raw);
> +		if (ret < 0) {
> +			pr_err("read channel() error: %d\n", ret);
> +			return ret;
> +		}
> +		ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
> +		if (ret < 0) {
> +			/* Assume 12 bit ADC with vref at pullup_uv */
> +			uv = (pdata->pullup_uv * (s64)raw) >> 12;
> +		}
>  	}
>  
>  	return uv;
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index db77a2d4a56b..6a842c6b6705 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -688,7 +688,8 @@ int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
>  }
>  EXPORT_SYMBOL_GPL(iio_read_channel_offset);
>  
> -int iio_read_channel_processed(struct iio_channel *chan, int *val)
> +int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
> +				     unsigned int scale)
>  {
>  	int ret;
>  
> @@ -701,11 +702,14 @@ int iio_read_channel_processed(struct iio_channel *chan, int *val)
>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>  		ret = iio_channel_read(chan, val, NULL,
>  				       IIO_CHAN_INFO_PROCESSED);
> +		if (!ret)
> +			*val *= scale;
>  	} else {
>  		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  		if (ret < 0)
>  			goto err_unlock;
> -		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val, 1);
> +		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val,
> +							    scale);
>  	}
>  
>  err_unlock:
> @@ -713,6 +717,13 @@ int iio_read_channel_processed(struct iio_channel *chan, int *val)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(iio_read_channel_processed_scale);
> +
> +int iio_read_channel_processed(struct iio_channel *chan, int *val)
> +{
> +	/* This is just a special case with scale factor 1 */
> +	return iio_read_channel_processed_scale(chan, val, 1);
> +}
>  EXPORT_SYMBOL_GPL(iio_read_channel_processed);
>  
>  int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 0a90ba8fa1bb..5fa5957586cf 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -241,6 +241,21 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
>   */
>  int iio_read_channel_processed(struct iio_channel *chan, int *val);
>  
> +/**
> + * iio_read_channel_processed_scale() - read and scale a processed value
> + * @chan:		The channel being queried.
> + * @val:		Value read back.
> + * @scale:		Scale factor to apply during the conversion
> + *
> + * Returns an error code or 0.
> + *
> + * This function will read a processed value from a channel. This will work
> + * like @iio_read_channel_processed() but also scale with an additional
> + * scale factor while attempting to minimize any precision loss.
> + */
> +int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
> +				     unsigned int scale);
> +
>  /**
>   * iio_write_channel_attribute() - Write values to the device attribute.
>   * @chan:	The channel being queried.
> -- 
> 2.29.2
> 
