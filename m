Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35BD332D03
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 18:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCIRPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 12:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhCIRPF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 12:15:05 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF6C06174A;
        Tue,  9 Mar 2021 09:15:03 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id w65so15723153oie.7;
        Tue, 09 Mar 2021 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1GVN7mp8PcXHPfTAjEsD1qYTJr+/P/RGYc/HQZUIFw=;
        b=SAh5KFXi23IJgX4b0nMp5yk8MeckrqLEG3dS1rhwAbKux4qo7bByLqVtuS1d/gj+Yi
         HWF8FMxRRkl3Y2Lz7DXu6XV2EwQoVNYXQ6Kx/8RprXcxJZPJxta9E0/W4xK1dc6Dihp0
         golvcR5+Def4rqcBYrOf939EIg/1fxIs0cZ9Z0pbcHWuUEZOJU3b6cqHJp1bMhTn5P2e
         BBXv/iFlZPRTwTD5fHshxUvMgPYtAWjBa+0uvpsDkifUUL+LphYuYC8RdSuUVTH/uAX1
         hGAK57QhnHF/e+NI2ui8HZh4+hTH7++dMys4Gqr0vG5jTtA34Qx92MknJm5B5crGC3+A
         T+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1GVN7mp8PcXHPfTAjEsD1qYTJr+/P/RGYc/HQZUIFw=;
        b=BZy8Cd4MmtJClP8wDYHDQCTqzdFoX3j0cUzMnVoyYoDAt0mML2VIti42vqhoeJY61J
         F2zK9fgvsbxUfbVeKJimZc43LRfnrBBRaCEMhibk67CM/GNzFc8ddSvhhFHima9DbwEA
         XE3agQXqb1SPLQkARQ5O1GCvK4AvzepcgNsvWjRcfwqwdko0AuD+fqbVb17U4AHSMG/7
         KboOiSpEHsYgD5xjmdwOUaFAlC99TBKZgybIHt4fWzJYfH+r0WXXIs4ktsUhoqE+CqWo
         UE3CWL+QsSX45TihDhCwPyYjnbLcPp0pmZeZXKOByQxRmiZm4crviZj5wiSI2H4omoPr
         pqMg==
X-Gm-Message-State: AOAM531whUENo0jpX2wa1UgJlN+bTFc7IaNxbPBktlu2b5dtutl1zrQT
        Bs8YoJbZZ8X2MTgmviMxQdEOzHfE4ts=
X-Google-Smtp-Source: ABdhPJzBV3jI0+Gtlls6YDIvuUz2OMKaoa/l1O/NRo+7WEsTDlgTo/s92GLsCe15G4CgygWkjSULDg==
X-Received: by 2002:aca:1818:: with SMTP id h24mr3822826oih.44.1615310102779;
        Tue, 09 Mar 2021 09:15:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2sm3510067oti.8.2021.03.09.09.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Mar 2021 09:15:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Mar 2021 09:15:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-hwmon@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2 v4] hwmon: (ntc_thermistor): try reading processed
Message-ID: <20210309171501.GB172171@roeck-us.net>
References: <20210308100219.2732156-1-linus.walleij@linaro.org>
 <20210308100219.2732156-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308100219.2732156-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 08, 2021 at 11:02:19AM +0100, Linus Walleij wrote:
> Before trying the custom method of reading the sensor
> as raw and then converting, we want to use
> iio_read_channel_processed_scale() which first tries to
> see if the ADC can provide a processed value directly,
> else reads raw and applies scaling inside of IIO
> using the scale attributes of the ADC. We need to
> multiply the scaled value with 1000 to get to
> microvolts from millivolts which is what processed
> IIO channels returns.
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
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Link: https://lore.kernel.org/linux-iio/20201224011607.1059534-1-linus.walleij@linaro.org/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Up to Jonathan to decide if he wants to take both patches.

Thanks,
Guenter

> ---
> ChangeLog v3->v4:
> - Split out the new iio_read_channel_processed_scale()
>   API addition to a separate patch.
> - My suggestion is to apply both patches to the hwmon
>   tree.
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
>  1 file changed, 18 insertions(+), 9 deletions(-)
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
> -- 
> 2.29.2
> 
