Return-Path: <linux-iio+bounces-23991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E52B53C37
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333EB5A613A
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77925CC74;
	Thu, 11 Sep 2025 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1CXa+mxI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487025C6EE
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618626; cv=none; b=jLhQubWhD70reKz0yt/aap+p8xUC4gjQuG90y0aOAaK3verK8E7w741qGmhRd9Q+NfEwbBYu7z/T8hmX6OVhsIeW1D23S7dSUX844jxuPW2KDTmTM8MOM7HPC9JIjpP8KVAUYvaVtOlTsbGm4QSES+gx9iFvGs234atq0EpLW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618626; c=relaxed/simple;
	bh=kqxEeAV/Q5vnPKtNOnXmo6QFdVOxZgmFTCeqJRfcni8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhC1/TLIh5kUV5pZ7BbvEY7pRfaFyih7BHLF60VodYsRiuwFJpcP2XS1Lvjd5M3bf/a/9o4SrhtZc2tjdTGlYsPasfj5DSZDLaQSRsKy8JD2idO5lq251IgmZbaVP5iFzMDKFCMc5sGko48ION9PRqUnvn0muqD60rA5dS7wq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1CXa+mxI; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6219257cb0fso217662eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757618623; x=1758223423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoWX1q46dXn9Euy8n66ZzUrEnt7VeRMdWOnlV4ydzlM=;
        b=1CXa+mxIZ6wqOrugfNNwRbysHoK2GRyyct7bj2WgZ7WY7Ay6YHJD6Wspoqn1GdSehP
         pol0BmSCInZTE8Osbx7N58r/8Y593Oyu0rRslYLP+Ncl9gj5HMU1k8ivVwq/9VKmBajm
         f2On1QciRFcilAg0jyjBER5BAXw3PLuj1qTVg7gDOiLhl6fTX9AVSDUzju67HV+8ZZqd
         QyBD0/d6cwuFX6h1jnhgV24JfhfajIU7+F4AjTsII42zs8jhfkcXaIwPjr1PlUpEFiuf
         7tfeUV7azf/E+jlrk1rMLTnk+qiQWXnhvtD4ivaX7im7q4u4psMJ8EEgf8ENRA24HOPh
         o8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618623; x=1758223423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoWX1q46dXn9Euy8n66ZzUrEnt7VeRMdWOnlV4ydzlM=;
        b=YmEY7UCX/H+Ev/coJqiK5kWF2khUGwW4W7ldjI+rUKMw499dGSXxYTJFX4+Rs+bXXk
         +PyUkhYCOLfJb4YLBlyv7pLCEvX+A/JMdCjxw2vP/82ssiZezkz9FzPUPdosC1VyIMOV
         qVjNi5g9/VDMd5IzxSa7tR1fXHtCOrsvE0UpOjrIULz6Dd2ZE6/q/mU60c6+V25PnRkX
         dm3TnxS3u2RwJBSKIhUH/JlTYFI6D5HvUEght9noTT1PZa0Smc75CkG04FetzJyCBSyl
         OdCDSKrF9oVd+vwpnenCKoH45ar9S8PD3wbVqSzt2kQ7U7iI1tDx+k7yNbFWrrVZca/h
         F2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFt9xwx/ADDKOD9suJfedG4iIue8TEJiIQ+sMGK7BYl59CZxSCUqzqWFHdkqXH16ACUKN8XaLBeoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydigww1ZK9t/0ngZcjgbpNJ2K6tbIp/yoS9I/vC+xljNPKg8X+
	zwKPJpF+ty8tuYMsoOzYLSNUB7NHdW2AAEZ79o7VG+zJL+Ow9rJnEQYRLVV0JXgK7qnADgOESC0
	9J/pEDP4=
X-Gm-Gg: ASbGnct7bRRqPTycfLcEVByn1tGI3LRFSe2OLbrFx+Ku5htUdoXfhDJhiIHUGlbLZug
	iQLQDg6PLWoPQCsXT8hBMRDcgUQXROw3j746rDfSU4uzcpoL1/kw51YbLlxS8HwNvI9Dg+xFCt5
	s4q6wriQVpYMmlTYkc0J3ZObWn6G0l3DHMJ1sYE8i7ViCI3JUFyjpuN5ME7w3pfJRH6So2yJjhe
	pkZe+54W7HqFVBTEEC5d8/yoZr9Q1aHVsQYl6jkylFYMG+uSiV2ZVldqYiW0cXGP7S2u5tjKwib
	cLzvSJ6tBWsxti5IYbXe0J+HNY1EoZ9R88RdtSsxOgagwXwe9DKlOC61yNoz0yg62GNrDREq84d
	zqKcvsN8ZgWHfNNB4M+cQs9vJxi8EVKWlg3qaOL+KJuCXYmBsBSyObp0q+r6QQXykOHyn6kQwzJ
	NLT9OFrvhyJg==
X-Google-Smtp-Source: AGHT+IEBEN07QRmj1/6V2YlTqYhYgXmVCJ6qRkj6CfF4fpM1qtcfdWgtW459UBV2iO984U0Ky8/ZvA==
X-Received: by 2002:a05:6870:788b:b0:302:523a:1799 with SMTP id 586e51a60fabf-32e552aa273mr147762fac.11.1757618618034;
        Thu, 11 Sep 2025 12:23:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d33452e9fsm624768fac.11.2025.09.11.12.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:23:36 -0700 (PDT)
Message-ID: <a69192a1-68cb-4c24-abe6-09534df0ba98@baylibre.com>
Date: Thu, 11 Sep 2025 14:23:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] iio: accel: bma220: add i2c module
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-9-e23f4f2b9745@subdimension.ro>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bma220_improvements-v2-9-e23f4f2b9745@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 2:57 AM, Petre Rodan wrote:
> Add the bma220_i2c module.
> 
> Note that this kernel module transparently shifts all register addresses
> 1 bit to the left, so all functions will operate based on the SPI memory
> map.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> no change
> ---
>  drivers/iio/accel/Kconfig       |  9 +++++-
>  drivers/iio/accel/Makefile      |  1 +
>  drivers/iio/accel/bma220.h      |  1 +
>  drivers/iio/accel/bma220_core.c | 18 ++++++++++++
>  drivers/iio/accel/bma220_i2c.c  | 61 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 9b6c35b759481df5ff3c91856f8783357d25de80..b3c5b0b7a406ec0cec531a122af424cb8ec57703 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -221,6 +221,7 @@ config BMA220

	depends I2C || SPI

>  	select REGMAP
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select BMA220_I2C if I2C
>  	select BMA220_SPI if SPI
>  	help
>  	  Say yes here to add support for the Bosch BMA220 triaxial
> @@ -228,7 +229,13 @@ config BMA220
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma220_core and you will also get
> -	  bma220_spi if SPI is enabled.
> +	  bma220_i2c if I2C is enabled and bma220_spi if SPI is
> +	  enabled.
> +
> +config BMA220_I2C
> +	tristate
> +	select REGMAP_I2C
> +	depends on BMA220
>  
>  config BMA220_SPI
>  	tristate
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 56a9f848f7f913633bc2a628c1ac5c9190774b9d..fa440a85928398fee927081f605595ba9fbc4ad9 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_ADXL380_I2C) += adxl380_i2c.o
>  obj-$(CONFIG_ADXL380_SPI) += adxl380_spi.o
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_core.o
> +obj-$(CONFIG_BMA220_I2C) += bma220_i2c.o
>  obj-$(CONFIG_BMA220_SPI) += bma220_spi.o
>  obj-$(CONFIG_BMA400) += bma400_core.o
>  obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
> diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
> index f9f4fa3daf33665f07f8bf073468dff070b46d74..384557d10d5613b7d829c6666f3da06de219277a 100644
> --- a/drivers/iio/accel/bma220.h
> +++ b/drivers/iio/accel/bma220.h
> @@ -12,6 +12,7 @@
>  #include <linux/regmap.h>
>  
>  extern const struct regmap_config bma220_spi_regmap_config;
> +extern const struct regmap_config bma220_i2c_regmap_config;

Up to now, i2c is before spi. So would be consistent to keep
doing that.

>  extern const struct dev_pm_ops bma220_pm_ops;
>  
>  int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq);
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 4d8b65ea737a2d5fe74f98da13a582a80874a5af..191074d8618ea2638f69283781b8677921876681 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -175,6 +175,24 @@ const struct regmap_config bma220_spi_regmap_config = {
>  };
>  EXPORT_SYMBOL_NS_GPL(bma220_spi_regmap_config, "IIO_BOSCH_BMA220");
>  
> +/*
> + * Based on the datasheet the memory map differs between the SPI and the I2C
> + * implementations. I2C register addresses are simply shifted to the left
> + * by 1 bit yet the register size remains unchanged.
> + * This driver employs the SPI memory map to correlate register names to
> + * addresses regardless of the bus type.
> + */
> +
> +const struct regmap_config bma220_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_shift = -1,
> +	.max_register = BMA220_REG_SOFTRESET,
> +	.cache_type = REGCACHE_NONE,
> +	.writeable_reg = bma220_is_writable_reg,
> +};
> +EXPORT_SYMBOL_NS_GPL(bma220_i2c_regmap_config, "IIO_BOSCH_BMA220");
> +
>  static irqreturn_t bma220_trigger_handler(int irq, void *p)
>  {
>  	int ret;
> diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2b63949ea64ee11421e76a2e7c868a922d1f9a12
> --- /dev/null
> +++ b/drivers/iio/accel/bma220_i2c.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Bosch triaxial acceleration sensor
> + *
> + * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA220.pdf
> + * I2C address is either 0x0b or 0x0a depending on CSB (pin 10)
> + */
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>

It doesn't look like the iio header is used. Maybe not device.h either.

> +
> +#include "bma220.h"
> +

