Return-Path: <linux-iio+bounces-14794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD1A2448A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 22:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632773A7BCD
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03291F3D4C;
	Fri, 31 Jan 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ckqMLqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A691586CF
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738358272; cv=none; b=k4WOZ1TMkOjf9kNUF6L6O5w7boNPHC9uSGgU94T+klQq/Edzf6xRSf5LarvHG7SWCJ3Z64Dt60hpOgayEa3/Gsu4uASmhFEXS8eK+aUZEZlhigDR3opVcQM0XQlTwbUKKeKryJeiATJiC1cfWasTtFlqt+r0HGDg9fTKa8twtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738358272; c=relaxed/simple;
	bh=RJj7dZb8gyW654D+rJ6e2y1KhBEtUNF31Xmf58GDCZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRr01r9f0NSYUjomHN91nIQ86QoETNJazhYlkhWrDvNtWwuBBoOw/LDCxyWVrNKd8YoKcYDn2j7sRmMTm66/TC5tA6362CIOhdsDhzEGJrVavYWcyTevXk2hChIWaRkDiZKK530zqEjZt0PX9z75RgWzqO2puMIlodBhRYK9x9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0ckqMLqr; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2a8690dcb35so794007fac.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 13:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738358269; x=1738963069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brqlpe8Bil+BEsD0jDMi0JFo+Qy1ZFNnw5Q/poa/ve4=;
        b=0ckqMLqrFyYx3vqVK7yQSeb1KoJ3+54P/SRxKQgKoyDEYxWn/ZY4Hcd9wGzasqU8mK
         N2CjsXQtRNJWPmlT0ZNPFV+VGvJjf2eqG+4pn121YgxIe62xM8Rbl9LQy0pxX1EK4hzl
         HXXkEGKr0i+O2Csf2gXOEa2DwcHja2i6qv+LAJAiF+TX0NEtIm5VMjsV+V02gM6vJiHV
         L//EbtBQAzhcBa3mkuWUdJs8llm2oBxP/37S3IyXoCIXYtxjXIc5eBgpW2G/KYy4aEfl
         untQUHaX1FqS8X3K+R3slvIVYNruNFHnTLuGKbcqVmTgSXeAC+0IJ5c/Hypi/4a9vR+S
         BC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738358269; x=1738963069;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brqlpe8Bil+BEsD0jDMi0JFo+Qy1ZFNnw5Q/poa/ve4=;
        b=hgFkfAkiC4xbXBMKCgdOCex3vXDkl4MWsz4uN/SWixojlwAgI1JxiZnlax/d1SZhl0
         wC5NupLvirshhqytY0oeKx3VuvihRUzgx5xNaKmvejSNw/3WkkKWuAG2I9ojeuSzKNK1
         C3WcmlQEj9EXVcxtqVSZ71pCVy97bDHziQBXNcaf/rxwwFfvyDQ5+CpWAKtdQAeu5S/c
         VggSEGqBm6b3I5CowhY2qYlM5LIJHhKN1g9LfMXgDWWlnxkaeKccXyIWfZx0afQbvr/i
         AgZ+2r8erypCbzVmJ484WyRcnvl39t3HVHCsai2xJm2OyVLPozdPvbm6jKRT0/k/l49Y
         lrnA==
X-Forwarded-Encrypted: i=1; AJvYcCVVsdp1/2svP4epcdezdeYLn1bKp3b7Kslwmr42Yw9bISFnIYn17H8sdyzSLxLIFPcvOB7XbmXXUCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3phqpbr/Msm60JC00NXPbYqVb4koUhMBwBF8aD8i1eJB3uF+
	oq6sSiNArbJz847R3fQfOV9OstDrBsA2c0yu5AgLACGzgEs1A3uQs2h+J3dWkgk=
X-Gm-Gg: ASbGncs7i/9Lx7DmdXyiz9/33OwvDWCbJuHexrypSmv6xZ8chBQbpUqLyFtwEqxW2dL
	4xwaP86I5AZUA31wIo2HuLrnjvOnZU66hDOj8pCZ7vp1XF/km5rr6RWEzdLT2bRd8KqGECkuF63
	c9zD1PvUj8OJgxnexYrSczG4EH8WuiWgxjfh3laH2lPl5BU5H+nMSjf/xqfa0jwMKX5TY6C1+XD
	vvPqw6gOmiLIm5Mn6gU5F271UCmqduxdySAlRJ2X7QEMn54WVUCkaCe9IVJDAjF38dUCs7y8le7
	79TrVGhFCbqTv/XsOp8aA357hXrW3IJik+wAS37H9ioHxwByXAjj
X-Google-Smtp-Source: AGHT+IHECT8zvEJVI9YUDs1WJh+Z/WDaKadpS/3YEjMtKOcRNgdPb/MAgb7dvRju169foHILtVccKA==
X-Received: by 2002:a05:6871:538b:b0:288:5ae1:7318 with SMTP id 586e51a60fabf-2b32f133e68mr7747775fac.22.1738358268760;
        Fri, 31 Jan 2025 13:17:48 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104b3193sm1069309eaf.7.2025.01.31.13.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 13:17:47 -0800 (PST)
Message-ID: <f4403b78-0d5d-484d-8c8a-812363ff4aa0@baylibre.com>
Date: Fri, 31 Jan 2025 15:17:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] iio: adc: adi-axi-adc: add platform children
 support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandru Ardelean <aardelean@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guillaume Stols <gstols@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
 <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-6-c3aec77c0ab7@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-6-c3aec77c0ab7@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/25 5:03 AM, Angelo Dureghello wrote:
> From: Guillaume Stols <gstols@baylibre.com>
> 
> This is a preparation for the next commit adding support for register
> read and write functions on AD7606.
> Since sometimes a bus will be used, it has been agreed during ad3552's
> driver implementation that the device's driver bus is the backend, whose
> device node will be a child node.
> To provide the special callbacks for setting the register, axi-adc needs
> to pass them to the child device's driver through platform data.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/adc/ad7606_bus_iface.h | 16 ++++++++
>  drivers/iio/adc/adi-axi-adc.c      | 84 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 91 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606_bus_iface.h b/drivers/iio/adc/ad7606_bus_iface.h
> new file mode 100644
> index 000000000000..d8d39822e2a9
> --- /dev/null
> +++ b/drivers/iio/adc/ad7606_bus_iface.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2010-2024 Analog Devices Inc.
> + * Copyright (c) 2024 Baylibre, SAS

Should update the copyright date to 2025.

> + */
> +#ifndef __LINUX_PLATFORM_DATA_AD7606_H__
> +#define __LINUX_PLATFORM_DATA_AD7606_H__
> +
> +struct iio_backend;
> +
> +struct ad7606_platform_data {
> +	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val);
> +	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val);
> +};
> +
> +#endif /* __LINUX_PLATFORM_DATA_AD7606_H__ */
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index c7357601f0f8..0923565cf5bb 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -80,7 +80,18 @@
>  	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
>  	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
>  
> +struct axi_adc_info {
> +	unsigned int version;
> +	const struct iio_backend_info *backend_info;
> +	bool bus_controller;
> +	const void *pdata;
> +	unsigned int pdata_sz;
> +};
> +
>  struct adi_axi_adc_state {
> +	/* Target ADC platform device */
> +	struct platform_device *adc_pdev;
> +	const struct axi_adc_info *info;
>  	struct regmap *regmap;
>  	struct device *dev;
>  	/* lock to protect multiple accesses to the device registers */
> @@ -325,6 +336,38 @@ static const struct regmap_config axi_adc_regmap_config = {
>  	.reg_stride = 4,
>  };
>  
> +static void axi_adc_child_remove(void *data)
> +{
> +	platform_device_unregister(data);
> +}
> +
> +static int axi_adc_create_platform_device(struct adi_axi_adc_state *st,
> +					  struct fwnode_handle *child)
> +{
> +	struct platform_device_info pi = {
> +		.parent = st->dev,
> +		.name = fwnode_get_name(child),
> +		.id = PLATFORM_DEVID_AUTO,
> +		.fwnode = child,
> +		.data = st->info->pdata,
> +		.size_data = st->info->pdata_sz,
> +	};
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_register_full(&pi);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	ret = devm_add_action_or_reset(st->dev, axi_adc_child_remove, pdev);
> +	if (ret)
> +		return ret;
> +
> +	st->adc_pdev = pdev;

st->adc_pdev is written but not read, so I think we can remove that field.

> +
> +	return 0;
> +}
> +
>  static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.enable = axi_adc_enable,
>  	.disable = axi_adc_disable,
> @@ -348,7 +391,6 @@ static const struct iio_backend_info adi_axi_adc_generic = {
>  
>  static int adi_axi_adc_probe(struct platform_device *pdev)
>  {
> -	const unsigned int *expected_ver;
>  	struct adi_axi_adc_state *st;
>  	void __iomem *base;
>  	unsigned int ver;
> @@ -370,8 +412,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
>  				     "failed to init register map\n");
>  
> -	expected_ver = device_get_match_data(&pdev->dev);
> -	if (!expected_ver)
> +	st->info = device_get_match_data(&pdev->dev);
> +	if (!st->info)
>  		return -ENODEV;
>  
>  	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> @@ -391,12 +433,13 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
> +	    ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
>  		dev_err(&pdev->dev,
>  			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> -			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> +			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> +			ADI_AXI_PCORE_VER_MINOR(st->info->version),
> +			ADI_AXI_PCORE_VER_PATCH(st->info->version),
>  			ADI_AXI_PCORE_VER_MAJOR(ver),
>  			ADI_AXI_PCORE_VER_MINOR(ver),
>  			ADI_AXI_PCORE_VER_PATCH(ver));
> @@ -408,6 +451,26 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "failed to register iio backend\n");
>  
> +	if (st->info->bus_controller) {
> +		device_for_each_child_node_scoped(&pdev->dev, child) {
> +			int val;
> +
> +			/* Processing only reg 0 node */
> +			ret = fwnode_property_read_u32(child, "reg", &val);
> +			if (ret || val != 0)
> +				continue;
> +
> +			ret = fwnode_property_read_u32(child, "io-backends",
> +						       &val);

This one is a phandl array. But since val isn't used, I'm guessing that this
should be fwnode_property_present().

Although, I'm not really sure we need this check at all since the driver for
the child node will be checking it.

> +			if (ret)
> +				continue;
> +
> +			ret = axi_adc_create_platform_device(st, child);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
>  		 ADI_AXI_PCORE_VER_MAJOR(ver),
>  		 ADI_AXI_PCORE_VER_MINOR(ver),
> @@ -416,11 +479,14 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static unsigned int adi_axi_adc_10_0_a_info = ADI_AXI_PCORE_VER(10, 0, 'a');
> +static const struct axi_adc_info adc_generic = {
> +	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
> +	.backend_info = &adi_axi_adc_generic,
> +};
>  
>  /* Match table for of_platform binding */
>  static const struct of_device_id adi_axi_adc_of_match[] = {
> -	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
> +	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
>  	{ /* end of list */ }
>  };
>  MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
> 


