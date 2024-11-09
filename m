Return-Path: <linux-iio+bounces-12058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD949C2899
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 01:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03432828A6
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F277ECF;
	Sat,  9 Nov 2024 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUTwJtMx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D171186A;
	Sat,  9 Nov 2024 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111016; cv=none; b=MjB//0jC/0mJw9q0quPrRO0SYECKPaznpz7N5NLALdNbZw0iCiSMgZmU5b2F7UU028GYVSNfSBwB/EeYtXlp6kFohnfrhiJubJpPZe2yZYA1s1AOe55x7s0+kEl6A+cUHEZDjZbROV42byWIQgPoTf0CJxJWTTvu8BzoDtbyprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111016; c=relaxed/simple;
	bh=Rq5/UEu0gOVxKSYuydXs4m6hSlqhobcG+iKkGrIrTKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXfe4feeGWeKwKh2ZLRJqI1+pnBxL183mAjgn91jVpPTd9r8sCCZjeinaXuil5Qffb95VqUgtKhi0CV0xCakGg50TjMwFjSQ3GTzA1XwSP04hLjRnj7fRxwBCURpwqAKR5k+AYA64fxvzMIA/1Y096bHa6YnWRfMjjEJgQEilzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUTwJtMx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso2987840a91.1;
        Fri, 08 Nov 2024 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111014; x=1731715814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qkuxRBhUdrMqZHEYYqrRzS7syIb4x9GA940/XJZey40=;
        b=jUTwJtMxn7IqVIjLu8R9zPd+gv1KlAtrQE9QPmA60iyIsyi5fYoXtbfYwMqreWK6u1
         zVyXafwj8/BMML0PB3FabZm9IG70ssS+Qrg3PJIxPxqlKspqsAJhRS097PzD9cvQ21aF
         xk3pLV01bnSVhgIphowpcdzmBDHs/DPiQpCocxNOiG2I7QjalMkCODcrVvA/ZG6BA9m+
         hEJ5PXDYBvhSqCluMmi5rWX0CEiKuQopw7ypUP7YCz1gw39OuPBiHtbh+LqVfDItNTnP
         9x+NGxGqOPZ+igoVjqAOVKVHPf8H3pPFVe2JmOPmVC13HeXI3li7WqNxbZzNQEm0b3+1
         LdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111014; x=1731715814;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkuxRBhUdrMqZHEYYqrRzS7syIb4x9GA940/XJZey40=;
        b=oZllpnbqYW8D8lqMdQHvimECwokXOmoWYzqqgQjUviqJunLCEzmu8okOfC5O1omev5
         I3tSXQg+VABra/cgkOvLPjkGHFw7lwxE6zophg26DVSKXH7w2SvdjJ14LoJzmhkazOa+
         pCZJuJ3Vez0EM/TsObREgWK2zCRmTaIEf+aTZ5yCh5Uov7uk7grUUlCvKc4sB24IuaEt
         6/Nhx6KGJqPw6P6WsA5w+xszJ241K3owGOA7jt0+MxWzHe4cx/IuXK+y25LpPqaCdQBl
         nRZ5ijZd3l4zxVxpP+bpe4wP5vwaGmg8xVWAvn5tvh1oRWb2ZiuywWqvXvNIOUGZ58CC
         zktA==
X-Forwarded-Encrypted: i=1; AJvYcCUjIxDd+k9JGE+YbeMrY86S0sUda957NXwOlHtqwaVFzJTeYNkUUzQcg0P1pJZ7b0KbZE2Kw+3NMN7BQA==@vger.kernel.org, AJvYcCVhPxxQgcWEGSn+l1xQZjMqHmERHLvX0UqJ16E7ot/MdUnEwFyxaxbsFxXr3v4OpaFe2ip1RPoc1Nsd@vger.kernel.org, AJvYcCWnI78eLID9iXRbZ5dTLEI424BVEst+sFjI0ButdzViB0Y0E3jfsRT4Pg1F1yEi2HPpbR+p/ZZJWPidMJtk@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiYxLADM1DQ8ZrOfJfTYT2NLb8kkHQ28csrxPiL5SpDye02Ih
	fiy+41v4CemYpYPlWF2pWOWgqJpFY0NS6z2Ntg6vM0QXSxXGOUoa
X-Google-Smtp-Source: AGHT+IHIJjoErnvnQ8M35ks2Kzb8DXfptuyNI+D7IwxYCzr2yibZDe70aA2CeUtxRv8l9Gw9P306pg==
X-Received: by 2002:a17:90b:4b0f:b0:2e9:20d8:414c with SMTP id 98e67ed59e1d1-2e9b0a30173mr7016077a91.5.1731111014538;
        Fri, 08 Nov 2024 16:10:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9be866bdasm415822a91.16.2024.11.08.16.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 16:10:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <805495d8-b1d0-4258-8f86-35c92b2b0e61@roeck-us.net>
Date: Fri, 8 Nov 2024 16:10:12 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hwmon: tmp108: Add support for I3C device
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
 <20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 14:26, Frank Li wrote:
> Add support for I3C device in the tmp108 driver to handle the P3T1085
> sensor. Register the I3C device driver to enable I3C functionality for the
> sensor.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> index bfbea6349a95f..83d6847cb542c 100644
> --- a/drivers/hwmon/tmp108.c
> +++ b/drivers/hwmon/tmp108.c
> @@ -13,6 +13,8 @@
>   #include <linux/mutex.h>
>   #include <linux/of.h>
>   #include <linux/i2c.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
>   #include <linux/init.h>
>   #include <linux/jiffies.h>
>   #include <linux/regmap.h>
> @@ -442,6 +444,35 @@ static struct i2c_driver tmp108_driver = {
>   
>   module_i2c_driver(tmp108_driver);
>   
> +#ifdef CONFIG_REGMAP_I3C

REGMAP_I3C needs to be selected in Kconfig. Maybe with "select REGMAP_I3C if I3C" or
similar, but we'll also need to cover situations where I2C=y and I3C=n. That means
that an additional "depends on I3C || I3C=n" may be necessary. In summary,

	config SENSORS_TMP108
         tristate "Texas Instruments TMP108 and P3T1085"   <--
         depends on I2C
	select REGMAP_I2C
	depends on depends on I3C || I3C=n                <--
	select REGMAP_I3C if I3C                          <--
         help
           If you say yes here you get support for Texas Instruments TMP108
           and compatible sensor chips.                    <--

           This driver can also be built as a module. If so, the module
           will be called tmp108.

Thanks,
Guenter

> +static const struct i3c_device_id p3t1085_i3c_ids[] = {
> +	I3C_DEVICE(0x011b, 0x1529, NULL),
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
> +
> +static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +				     "Failed to register i3c regmap\n");
> +
> +	return tmp108_common_probe(&i3cdev->dev, regmap, "p3t1085_i3c");
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


