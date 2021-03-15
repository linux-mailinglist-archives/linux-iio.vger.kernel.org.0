Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4CC33AA62
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 05:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCOEYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 00:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhCOEXk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 00:23:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07741C061574;
        Sun, 14 Mar 2021 21:23:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id o3so1110210pfh.11;
        Sun, 14 Mar 2021 21:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzFGBE2+09eyXyHLr1yrv7BpqyrQLI4+YGuifelVQf8=;
        b=mIHGR7WS8/2q/n7luQK80YBNgoIjDLmOybxYr7kPSswr6zWh2Y0MeWNGl/zIdHXd6b
         yIaZwAAthAM9+Z0i6tFffOBuJeFqr8nYeihMTQx0BTBeSk1gjAC72FOKs6PMSYkjATau
         UO5JJmebnQeZAV9JSVfE4PHV0QmMTYZ9BWsYhEpK5edDwjSjK3vSqBhjV8ONL0jKof+/
         9w5ff3Wz0ncfdTlgE7jfTYjbhfl4rRqclUFxYFy1tKdhCQx2ezsI2iD4cLpF421Hl09j
         pGlO7ycGo9ikoPGLhImnYvKOoIuNHoUQFwERYvnNtRwSzmhwnA6xVoI09H51hpsSUVDx
         CT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzFGBE2+09eyXyHLr1yrv7BpqyrQLI4+YGuifelVQf8=;
        b=qMnUoKHFwrFwJJOdH5j09qErIb92QK+q4frHhPcPhgORKtAq0w+MVNZTmkECA63xW3
         seAtOiqu961tRF4vUWUcdHsLySywFZ7uebXvJERsmpkcGfPr5OGMSFx0AANei4tIzma2
         A6beDv+3AOUy7z7XeqVPv7JCyHiOXyGFWTgMODMh4hGZEn3sxDN9+FqEJ+G8ITBP41RV
         YjYRwlU2ZXwg1Dd0y2K3JQ5+VEBHjW2+ozEZf0w+LCA10aHJOLKWmi/lc5b/7tKYyiwC
         FisHr94GxUtIAteEZkE+aUS3VipmQs/jAMdd3U31B0hnkheyVs0lzJnOFPcbUVkft7uR
         elkA==
X-Gm-Message-State: AOAM532T8kqpHq48jF/NyKd53Td/BiyGB1EkDpFYUfP6ZvAfQeW3ZlHr
        X/tWjYV3kcYN2Aw8kh2izfMm48pAqrfKvA==
X-Google-Smtp-Source: ABdhPJx2Ky1s18hOXuMB6LZKsPGiZ/tRRYFEGJ5elaUz42JNmTBYt7QHOmgUcdmxYvxlsuvs2iMssA==
X-Received: by 2002:a62:344:0:b029:1fd:6817:42a with SMTP id 65-20020a6203440000b02901fd6817042amr8908682pfd.41.1615782219496;
        Sun, 14 Mar 2021 21:23:39 -0700 (PDT)
Received: from thinkpad ([2409:4072:209:be46:8bdc:6612:532b:6413])
        by smtp.gmail.com with ESMTPSA id s62sm12184353pfb.148.2021.03.14.21.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 21:23:38 -0700 (PDT)
Date:   Mon, 15 Mar 2021 09:53:32 +0530
From:   Manivannan Sadhasivam <manivannanece23@gmail.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, linux@deviqon.com
Subject: Re: [PATCH] iio: temperature: tmp007: use device-managed functions
 in probe
Message-ID: <20210315042332.GA81300@thinkpad>
References: <20210310093800.45822-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310093800.45822-1-aardelean@deviqon.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 10, 2021 at 11:38:00AM +0200, Alexandru Ardelean wrote:
> This change converts the driver to use device-managed functions in the
> probe function. The power-down call is handled now via a
> devm_add_action_or_reset() hook, and then devm_iio_device_register() can be
> used to register the IIO device.
> 
> The final aim here would be for IIO to export only the device-managed
> functions of it's API. That's a long way to go and this a small step in
> that direction.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Manivannan Sadhasivam <manivannanece23@gmail.com>

Thanks,
Mani

> ---
>  drivers/iio/temperature/tmp007.c | 36 +++++++++++++-------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
> index ad2b35c65548..b422371a4674 100644
> --- a/drivers/iio/temperature/tmp007.c
> +++ b/drivers/iio/temperature/tmp007.c
> @@ -439,6 +439,13 @@ static bool tmp007_identify(struct i2c_client *client)
>  	return (manf_id == TMP007_MANUFACTURER_MAGIC && dev_id == TMP007_DEVICE_MAGIC);
>  }
>  
> +static void tmp007_powerdown_action_cb(void *priv)
> +{
> +	struct tmp007_data *data = priv;
> +
> +	tmp007_powerdown(data);
> +}
> +
>  static int tmp007_probe(struct i2c_client *client,
>  			const struct i2c_device_id *tmp007_id)
>  {
> @@ -489,6 +496,10 @@ static int tmp007_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&client->dev, tmp007_powerdown_action_cb, data);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Only the following flags can activate ALERT pin. Data conversion/validity flags
>  	 * flags can still be polled for getting temperature data
> @@ -502,7 +513,7 @@ static int tmp007_probe(struct i2c_client *client,
>  
>  	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
>  	if (ret < 0)
> -		goto error_powerdown;
> +		return ret;
>  
>  	data->status_mask = ret;
>  	data->status_mask |= (TMP007_STATUS_OHF | TMP007_STATUS_OLF
> @@ -510,7 +521,7 @@ static int tmp007_probe(struct i2c_client *client,
>  
>  	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK, data->status_mask);
>  	if (ret < 0)
> -		goto error_powerdown;
> +		return ret;
>  
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
> @@ -519,27 +530,11 @@ static int tmp007_probe(struct i2c_client *client,
>  				tmp007_id->name, indio_dev);
>  		if (ret) {
>  			dev_err(&client->dev, "irq request error %d\n", -ret);
> -			goto error_powerdown;
> +			return ret;
>  		}
>  	}
>  
> -	return iio_device_register(indio_dev);
> -
> -error_powerdown:
> -	tmp007_powerdown(data);
> -
> -	return ret;
> -}
> -
> -static int tmp007_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct tmp007_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	tmp007_powerdown(data);
> -
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -582,7 +577,6 @@ static struct i2c_driver tmp007_driver = {
>  		.pm	= &tmp007_pm_ops,
>  	},
>  	.probe		= tmp007_probe,
> -	.remove		= tmp007_remove,
>  	.id_table	= tmp007_id,
>  };
>  module_i2c_driver(tmp007_driver);
> -- 
> 2.29.2
> 
