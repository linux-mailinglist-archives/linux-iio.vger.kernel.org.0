Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F312DFF6B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 19:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLUSMk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 13:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgLUSMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2020 13:12:39 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8CFC061248;
        Mon, 21 Dec 2020 10:11:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q25so12125338oij.10;
        Mon, 21 Dec 2020 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wlVf9Yi+s44ulnCEaPpfVADWeebKoRtlQF/J6QAhfuQ=;
        b=RYXV9uzo+2h4ezA8PcXuoUCFLh4fTeRS5iiXlMTQlvKnkbzVEIJI0iXSWo+i3m61xZ
         dWM995WCkBKXTry5c+vfH6ZqsHMfHvkdPLz9yqTFQvZ8cQ3XfhSr8MlnenAHkem6rhzC
         WXmsBhjjp5DnETCxjFb5mr7oxpZrVObZMj1dCYmfo7KnzVr5GsxbUh+Ari2NLT3BbwpZ
         A6F2RN+Vky26cCC8fC0fj2Jx+ZwdHc9nhJS4LBlhFQ73L2UFa0HFCDhHVUGAvPL3H6sn
         En4RtD1LZ8tDRgJVFaxvLjPScYSAW3qzJUX6JNu/rwVHkl71K/VSv0sqXn2YdQmzxLJj
         DkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wlVf9Yi+s44ulnCEaPpfVADWeebKoRtlQF/J6QAhfuQ=;
        b=j5etH2wYQf+JFyeZQlzIX/QcFoXY1MgxRumS+EHwVuyp2ujqzPfqofJiUFJHGnisZj
         WJVWB6c9b2o9TEUlEzXrInSw6xctLbMg++xHMJ2A1gYsEJs0BEFLc2+1314BMcEx8QXj
         HleoQbtv50Sr3mgA0LLNjBq+r5xXAdB2u/jJzp7o3l9QeKLmkvEoArnxw+0n70XJ1TyH
         8x4WNZ8fL/Wt+AZNezBmHi215/Q0pcnfNc6dCFIA9ajRO+nnA4XiP75EstaVMD3XUS5Z
         iUuF4Bk/G5Ont4RUbjkeK1xdeCmXATRAwl9fGZuSl8jv1VX6j4oxwjXCq/WBvPb0wjXF
         s+Gw==
X-Gm-Message-State: AOAM531TNtSeS+XCywDsfD3qOGG+2Ky8vHJHz756rbeGvvlYlv36b9N/
        rMFofbfDlgvUyAZ7MLGZlnh+/Y5wyGY=
X-Google-Smtp-Source: ABdhPJwc9o6URwlyLC3Fx+k1lO4swCeIDCQc0nS2WghwCYUm4YLwnauKORT+6dVc7tSrVlTCwnVZzw==
X-Received: by 2002:a54:470f:: with SMTP id k15mr11712749oik.137.1608567341781;
        Mon, 21 Dec 2020 08:15:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t19sm4023981otp.36.2020.12.21.08.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:15:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (ntc_thermistor): try reading processed
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
References: <20201219224143.686074-1-linus.walleij@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <6d339a6c-6f8c-4a5e-718b-c90a9fbb8c01@roeck-us.net>
Date:   Mon, 21 Dec 2020 08:15:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201219224143.686074-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/19/20 2:41 PM, Linus Walleij wrote:
> Before trying the custom method of reading the sensor
> as raw and then converting assuming 1000 scaling, just
> use iio_read_channel_processed() which first tries to
> see if the ADC can provide a processed value directly,
> else reads raw and applies scaling inside of IIO
> using the scale attributes of the ADC.
> 
> The code that hardcodes scaling to 1000 and assumes
> a 12bit ADC is very dubious. I keep it around here
> but I have a strong urge to just delete it.
> 
> This gives correct readings on the AB8500 thermistor
> inputs used in the Ux500 HREFP520 platform for reading
> battery and board temperature.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Chris Lesiak <chris.lesiak@licor.com>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/hwmon/ntc_thermistor.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 3aad62a0e661..ac0d80faddf6 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -326,18 +326,29 @@ struct ntc_data {
>  static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
>  {
>  	struct iio_channel *channel = pdata->chan;
> -	int raw, uv, ret;
> +	int uv, ret;
>  
> -	ret = iio_read_channel_raw(channel, &raw);
> +	/* A processed voltage channel will return microvolts */
> +	ret = iio_read_channel_processed(channel, &uv);
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
> +		 * FIXME: This fallback to using a raw read and then right
> +		 * out assume the ADC is 12 bits and hard-coding scale
> +		 * to 1000 seems a bit dangerous. Should it simply be
> +		 * deleted?
> +		 */

The hwmon ABI specifically supports unscaled values, which can then be
scaled in userspace using the sensors configuration file.
Given that we return the pseudo-scaled value to userspace today,
it seems to me that it would do more harm to change that instead of just
leaving it in place.

Either case, calling iio_convert_raw_to_processed() does not seem to add
value here. This is already done by iio_read_channel_processed().
The best we can do is to use the original fallback.

Guenter

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
> 

