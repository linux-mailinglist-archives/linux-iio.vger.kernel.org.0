Return-Path: <linux-iio+bounces-12056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305799C2871
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 00:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA7F1C22222
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F1C1F582B;
	Fri,  8 Nov 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUOcwIqj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC41E3DDB;
	Fri,  8 Nov 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110147; cv=none; b=dln1CuNwCLsqVIhtDCPqyAKoHk1qa30FZwNdxin/Ebte9SmLGDjtrDdZad5sDPGo3F9ItOyw3HnjRa4/3iAj4O5aIf4f2rE9P+4t1zql8IgYD+lS5qtZVh6JjU6TS+KHAJdHtmnkNAIabkXIBqVnBJev5YOxuij3aX2/2GGnjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110147; c=relaxed/simple;
	bh=bvxtS1ZGnwWsMES63azj/84ceClMn6FxwZEVj7m6+go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMMgxw8M+B1rM9cSh6BSWvNAkpRWL6NUyqw6xwR2VBn+Wd42srzRtntpX7Ce1G4OEbMt5SKCIUEmsvdxQQlinrMWhWsiHXhdEinHKc94Se2jhewiU1LOm7cLgAChGHIvRLQxTbt7tnM4cHgIdJxdiJlqjgDjU4M0/0W72X7eBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUOcwIqj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso2382265b3a.2;
        Fri, 08 Nov 2024 15:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731110144; x=1731714944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YDNI3QDwWxgmxejo6jXXE94KMUDPX67xnOmgp5Nl8dg=;
        b=gUOcwIqjmsXqhu4O9tKbVYZ+53MGjjo5YaAzqWPyujY4LcCBoNl81MLmMLcVTKubJy
         NvFzvj2fnO4GpXHLs8cXcnk10caA2KzM8OukYAYYgXG/25evMt4PKd1h/fkwUwHvFzkI
         koghPLWXw4Crmt2+DxfHA6FnNGr/Vfm4gKS+UveCOCzLmpLtbKFntNRjzz4PdXyvLroJ
         bHXL92xgfsHZl9Pbz4oR0Apzuel5vKececeS30Nl+QDIQSHzXmzfFUcv9kyRktyV4bt/
         vvdMQmvVrjPleiXypitT8tTpWm0AsVTbSp7E/wtgE247jd7kbAG8cQgbXXxfgvo4QEBo
         BLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731110144; x=1731714944;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDNI3QDwWxgmxejo6jXXE94KMUDPX67xnOmgp5Nl8dg=;
        b=Uo3UYBj/pIh9ZwUXcQlyYWzGbw8rpiwZcHaGbnga5ZgYN7OPqPY+UgpqVsGa5Mv2WK
         DktwD1uCm7pVWgNTz/8UsarR1DNymLMTZVyLbfkgIBuNbv5fXHQNICB9Twci6MLS5UBW
         ILcqxMyik9oQaecwa0Vy7zI/z2YT8FrCx9UrwGxbmszHvt2TbHZGkx0UZewQseHuI7dh
         AFwID7O8Iw3boftK2v+dFi7vAiHHXQXi2QU/3xT2HSxJto65jGK+vZLwKWHVsQ6z4CsD
         /nJye6fbKfX0yX15hmUif2ACgr06IQ6d0tDnwWuLVA26FZNyCW1C04siFE8blxEp4l28
         wrLw==
X-Forwarded-Encrypted: i=1; AJvYcCVsoYKbPKjbyCsxQYeJPlEJFrgMy3riSKwih3tBwt4+l2oHIwkXYMoTc2cpE/2zl10k74eim8E6/3dkRA==@vger.kernel.org, AJvYcCWn3gihWUHVitRkeeqk22ANT8VS4DUyBxyHZcAykdCu2+VIGb5Yc1hEweM/lQISD6hRxiwqKpqsgSgB@vger.kernel.org, AJvYcCXWS/LtfmGPKwsoIwRv9VRZuegDdTvrzTX7BXwrVrKAFRibwFQA9/CT6oZEDnHTZUb8I3oxrXHVp0MyDYbr@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxiowoNIXCZNCeo6GMcGpIJNnUbHSdU7S/0kbx5zoZsfNg6qh
	gjEde7lDGN1gUChIeDH0qDA6DP+I7EyEHJZ8LctwvgZd/Qiipv0X
X-Google-Smtp-Source: AGHT+IEHn7LvKyz4qiE1kjywUOaxbLk9LaMdw4OZkuMYZImvcCX2vvxzceeB2V3jYqAdtqDqMOyhJw==
X-Received: by 2002:a05:6a00:99b:b0:71e:4c86:659a with SMTP id d2e1a72fcca58-7241328ea12mr5446159b3a.9.1731110143875;
        Fri, 08 Nov 2024 15:55:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078aaa21sm4398854b3a.51.2024.11.08.15.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 15:55:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c1b77ef0-f01b-4926-8259-e387166d0750@roeck-us.net>
Date: Fri, 8 Nov 2024 15:55:40 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hwmon: tmp108: Add help function
 tmp108_common_probe()
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
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
 <20241108-p3t1085-v2-2-6a8990a59efd@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241108-p3t1085-v2-2-6a8990a59efd@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 14:26, Frank Li wrote:
> Add help function tmp108_common_probe() to pave road to support i3c for

help -> helper

> P3T1085(NXP) chip.
> 
> Using dev_err_probe() simple code.

Use dev_err_probe() to simplify the code.

> 
> Add compatible string "nxp,p3t1085".
> 

This is borderline and problematic. First, it is the one functional change,
and second, that functional change is not mentioned in the subject. At the very
least it needs to be mentioned in the subject. I would, however, prefer two
separate patches, even if that is just a one-liner.

Also, the key change is preparation for i3c support, not that a helper function
is added. The subject should be something like "Prepare for adding I3C support",
and the description should then mention the added helper function.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> dev_err_probe() have not involve addition diff change. The difference
> always list these code block change regardless use dev_err_probe().
> ---
>   drivers/hwmon/tmp108.c | 40 ++++++++++++++++++++++------------------
>   1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> index a82bbc959eb15..bfbea6349a95f 100644
> --- a/drivers/hwmon/tmp108.c
> +++ b/drivers/hwmon/tmp108.c
> @@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_config = {
>   	.use_single_write = true,
>   };
>   
> -static int tmp108_probe(struct i2c_client *client)
> +static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *name)
>   {
> -	struct device *dev = &client->dev;
>   	struct device *hwmon_dev;
>   	struct tmp108 *tmp108;
> -	int err;
>   	u32 config;
> -
> -	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_WORD_DATA)) {
> -		dev_err(dev,
> -			"adapter doesn't support SMBus word transactions\n");
> -		return -ENODEV;
> -	}
> +	int err;
>   
>   	tmp108 = devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
>   	if (!tmp108)
>   		return -ENOMEM;
>   
>   	dev_set_drvdata(dev, tmp108);
> -
> -	tmp108->regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
> -	if (IS_ERR(tmp108->regmap)) {
> -		err = PTR_ERR(tmp108->regmap);
> -		dev_err(dev, "regmap init failed: %d", err);
> -		return err;
> -	}
> +	tmp108->regmap = regmap;
>   
>   	err = regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
>   	if (err < 0) {
> @@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
>   		return err;
>   	}
>   
> -	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, name,
>   							 tmp108,
>   							 &tmp108_chip_info,
>   							 NULL);
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>   
> +static int tmp108_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "adapter doesn't support SMBus word transactions\n");
> +
> +	regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
> +
> +	return tmp108_common_probe(dev, regmap, client->name);
> +}
> +
>   static int tmp108_suspend(struct device *dev)
>   {
>   	struct tmp108 *tmp108 = dev_get_drvdata(dev);
> @@ -420,6 +423,7 @@ MODULE_DEVICE_TABLE(i2c, tmp108_i2c_ids);
>   
>   #ifdef CONFIG_OF

It might also make sense to get rid of this conditional and of the
of_match_ptr() below to enable instantiation through ACPI.
That should be a separate patch, though.

Thanks,
Guenter

>   static const struct of_device_id tmp108_of_ids[] = {
> +	{ .compatible = "nxp,p3t1085", },
>   	{ .compatible = "ti,tmp108", },
>   	{}
>   };
> 


