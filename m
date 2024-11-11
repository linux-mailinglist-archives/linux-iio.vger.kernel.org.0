Return-Path: <linux-iio+bounces-12174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B59C49C8
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 00:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE74B286FE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C4D1AE014;
	Mon, 11 Nov 2024 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQK8Bf52"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698F15887C;
	Mon, 11 Nov 2024 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368048; cv=none; b=GN5NVUkMMjKJhnjIBJUo4ZKrVTDQbZxo3zRQH/DMU37ly7VWfQn0xERSFTaouwG+PwieYkMRya6ZA/D80jw/KUMspSBBlys9iIMga1Rlfk5+K71eS+QfnOjnCDcn0pO8bVPTTfs0WTHrO3dxVHDjlpaXM8Di/peLEOSQ8zmHgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368048; c=relaxed/simple;
	bh=3OvAaToqOPCvi/dLS+2sNWJpxBe+wzD1Ttf6Zn7Zo6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN3hlgzqfwoHDXd6i1/HW27jis5eAGOsRqACKWMOunBtnJA7SEjvBOXjji4VvwILki2Gm9uMyRd8CuzHuH55M7DDqfEu7Oe14s2j8dXmEDEjvh8peSQmQ5o8vVZY9FfNE11EvVPx91uMaNcIFtZ4Bgc5hYMeBN0QRbIn7ImZ094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQK8Bf52; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso3794948a91.1;
        Mon, 11 Nov 2024 15:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731368046; x=1731972846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyz9YnL8JQ8CcaKccCYaQlhEH98w9W4nVFTm7U0nGws=;
        b=cQK8Bf52xTv0H9ttanqKXUA1fCWjETJgjrEszgEObQ/akxzsjb9HaOPo2OqvgtNGog
         Bye/QjfFjMf63nW2MLqRDe8TeG0TEqwtNT2EY1Hd9Jq0zu4RI4WNV2GEfXFHGanj5VIY
         T/0rfSr2DQMPny95gwQ1M8eSoP1mZJoF+yu3p30KFyn8o5oYFh2GuvXGeY7OnECGyAy3
         viZuohmtTwFFackK2vWehJlbbMCXQbaUuxax7HdQB5yge18KrB+burvPM1Ck0z4H+9uI
         c/GSv9WlU1fMXC7/TWKSdEi8Ksw166kNfASbKfLN+lvEPYxlEoWITCslWcneoIT/PG3w
         s0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368046; x=1731972846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyz9YnL8JQ8CcaKccCYaQlhEH98w9W4nVFTm7U0nGws=;
        b=ejrVtnTEugtXA3lu/Pidci0Wg5o7HtE1ImC9s/jXq9Y+jOPfQhcoGSwvJejtZh7NeD
         5qtQKAHG0BmkeaOLHr22/Vp+2oSffPWsBZtvyR8D3xv2hxBnFR1PKFVSE4RdLl9r4Rzp
         MQpZBiBZRXHqq2hKfwUXgIWezxRtVror9HidpVYECSRrd9KiWfikDwnuSZ6Jt9E+zn0A
         jYMJ1qGy/iQM9akcHIM6UlsUYjM+q/kMA6FuuOJmxb5a9xqI476JcwYcSV95m4yUWkav
         BLjDfmEZLqYRoXanKLInPLBtnpB7FPy4MrN2hRleQCOKWAOlcLywGYJCuseccvQ2s+2/
         nkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAv4vVJAyP22HEy0zh3u1lulFMsAZr6dlSIsav4sHsbQ3SjT1f4vBTEKYPUcc36iWLfV/reRBv7apa@vger.kernel.org, AJvYcCVRQFQcCt/NjFLGzRGccWAHF8J6udFJAoyFfWbMXH9GpQjb/X8F3q51MspRpGDfeBpMVFIDfiF1A/kL9WIh@vger.kernel.org, AJvYcCX7icR4uBXKrGrqHHo4wM++EX7xQ0fLvYiveY0L1Iu8tMUlRU0YmvJArt3ExnO7KnnBkG66YUHVSyNJXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2wcDpliQle1q4DOvUex2INtOZ2oSylrtZO45VtcknCRF0LVD
	FSyCleYHS6KgeWhdb2j2tlYzpVN9xCzn3jYKsYzPlLGJcur425lW
X-Google-Smtp-Source: AGHT+IG9ySGad1eHdQXp8A01AVJ4oBG066aIkqdlV81tYJjacM4Jfd+cxJ+lIqY+DKLiM04Mxk+Vpw==
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id 98e67ed59e1d1-2e9b172005emr21600604a91.16.1731368046258;
        Mon, 11 Nov 2024 15:34:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd3c65sm9176678a91.35.2024.11.11.15.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:34:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <47f113db-162e-4476-984a-52a81e915009@roeck-us.net>
Date: Mon, 11 Nov 2024 15:34:03 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hwmon: tmp108: Add support for I3C device
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-hwmon@vger.kernel.org
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
 <20241111-p3t1085-v3-4-bff511550aad@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241111-p3t1085-v3-4-bff511550aad@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/24 09:32, Frank Li wrote:
> Add support for I3C device in the tmp108 driver to handle the P3T1085
> sensor. Register the I3C device driver to enable I3C functionality for the
> sensor.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v2 to v3
> - change kconfig to select REGMAP_I3C if enable i3c
> - remove i3c/master.h
> - remove , after {}
> - use #ifdef CONFIG_I3C about i3c register code
> 
> I2C    I3C
> Y       Y       support both
> Y       N       i3c part code will not be compiled
> N       Y       whole TPM108 will not be compiled
> N       N       whole TPM108 will not be compiled
> ---
>   drivers/hwmon/Kconfig  |  1 +
>   drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index d43ca7aa4a548..9579db7849e1f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2298,6 +2298,7 @@ config SENSORS_TMP108
>   	tristate "Texas Instruments TMP108"
>   	depends on I2C
>   	select REGMAP_I2C
> +	select REGMAP_I3C if I3C
>   	help
>   	  If you say yes here you get support for Texas Instruments TMP108
>   	  sensor chips and NXP P3T1085.
> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> index bfbea6349a95f..deb1505321335 100644
> --- a/drivers/hwmon/tmp108.c
> +++ b/drivers/hwmon/tmp108.c
> @@ -13,6 +13,7 @@
>   #include <linux/mutex.h>
>   #include <linux/of.h>
>   #include <linux/i2c.h>
> +#include <linux/i3c/device.h>
>   #include <linux/init.h>
>   #include <linux/jiffies.h>
>   #include <linux/regmap.h>
> @@ -442,6 +443,36 @@ static struct i2c_driver tmp108_driver = {
>   
>   module_i2c_driver(tmp108_driver);
>   
> +#ifdef CONFIG_I3C
> +static const struct i3c_device_id p3t1085_i3c_ids[] = {
> +	I3C_DEVICE(0x011b, 0x1529, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
> +
> +static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev = i3cdev_to_dev(i3cdev);
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);

It is a bit kludgy, but maybe

#ifdef REGMAP_I3C
	regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
#else
	regmap = ERR_PTR(-ENODEV);
#endif

and then using module_i3c_i2c_driver() would work.

Guenter

> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to register i3c regmap\n");
> +
> +	return tmp108_common_probe(dev, regmap, "p3t1085_i3c");
> +}
> +
> +static struct i3c_driver p3t1085_driver = {
> +	.driver = {
> +		.name = "p3t1085_i3c",
> +	},
> +	.probe = p3t1085_i3c_probe,
> +	.id_table = p3t1085_i3c_ids,
> +};
> +module_i3c_driver(p3t1085_driver);
> +#endif
> +
>   MODULE_AUTHOR("John Muir <john@jmuir.com>");
>   MODULE_DESCRIPTION("Texas Instruments TMP108 temperature sensor driver");
>   MODULE_LICENSE("GPL");
> 


