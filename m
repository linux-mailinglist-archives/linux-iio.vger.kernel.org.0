Return-Path: <linux-iio+bounces-16569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32CBA57BDC
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEED188EC29
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BDD1E51E4;
	Sat,  8 Mar 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nO14uHBD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51581720;
	Sat,  8 Mar 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450902; cv=none; b=m89PqNg/EjjwzFwILvkfCVX4Qpz8/PHrzKnbuJmrTKJuqfu9mAR1u9oZZay9jiQun/UDA5qiMIFl3ejqsnJbm6Wq1qZqq3DZfUYt+INRKhJaIgF3U62CY5VsmomnnUUncj6OHoXd8ds7rvGi1cBSQ4RBmwVfNYONajkwpaaTr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450902; c=relaxed/simple;
	bh=kxs5tNCVzupbR+a2HYMXv9flCuEJr+0N0bQadsFG0Ms=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=cilzfkDzVld8j23YyJenXoAR0sVABhevyKT89xQVZ/o6C9YXlywgXznUQFeNrqldbJGuARTl04KBKTheDzvqrsZl3semBLCI8DV95NNVYpB9TnZ4AciydIHM2DeLfRInz54G3LySh3qcP+YyiuDvwAS2nd5xkSPptTZDyPXKocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nO14uHBD; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id qwmutkNhDPGDMqwmytIRNA; Sat, 08 Mar 2025 17:12:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741450357;
	bh=lkMkI/Q3wsGJiDCLw7+HfkXg9OghyPU1YGXGecq6QVE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=nO14uHBDYV2E5xYLoR88YkfLg09I5zLdKlxMCcqGDPbnIOiZrLWkw9u9YsOREp6hQ
	 xuWeDM33aazDcthwSNm+iyxBGx+S3PMmxLwfGSYmxjwQqzq2weBDuTw009O2QJiLuG
	 68CHqk2BR9USFdDXZ0NEE24c53PoMkrhyFrxlzwPJiZS1h3y9n83TyL2dN0cHcGm3v
	 tfe3gKSGqOPunR3wMdw7Sb578qmuBWWnIh5nv93xozxlPp772GODGQv1qvtWdrXHVm
	 +uWmESkAzl/HCsBun0nlWppXAzvdpyE3KWtxlrsPh1YbxQ+noEpsrF0s3T7HhEfsX4
	 aVqzoDL/1teHQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 08 Mar 2025 17:12:37 +0100
X-ME-IP: 90.11.132.44
Message-ID: <fe21c55f-9baf-4b3d-b1fc-a866274b6178@wanadoo.fr>
Date: Sat, 8 Mar 2025 17:12:32 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: adc: add support for ad4052
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jorge.marques@analog.com
Cc: Michael.Hennerich@analog.com, conor+dt@kernel.org, corbet@lwn.net,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-doc@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
In-Reply-To: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/03/2025 à 15:03, Jorge Marques a écrit :
> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
> successive approximation register (SAR) analog-to-digital converter (ADC)
> that enables low-power, high-density data acquisition solutions without
> sacrificing precision.
...

> +#define AD4052_CHAN(bits, grade) {							\
> +	.type = IIO_VOLTAGE,								\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
> +				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_type_available =  BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\

Nitpick: Unneeded extra space before BIT

> +	.indexed = 1,									\
> +	.channel = 0,									\
> +	.event_spec = ad4052_events,							\
> +	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
> +	.has_ext_scan_type = 1,								\
> +	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
> +	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
> +	.ext_info = grade##_ext_info,							\
> +}
> +
> +#define AD4052_OFFLOAD_CHAN(bits, grade) {						\
> +	.type = IIO_VOLTAGE,								\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
> +				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.info_mask_shared_by_type_available =  BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\

Nitpick: Unneeded extra space before BIT

> +	.indexed = 1,									\
> +	.channel = 0,									\
> +	.event_spec = ad4052_events,							\
> +	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
> +	.has_ext_scan_type = 1,								\
> +	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
> +	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
> +	.ext_info = grade##_ext_info,							\
> +}

...

> +static int ad4052_probe(struct spi_device *spi)
> +{
> +	const struct ad4052_chip_info *chip;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4052_state *st;
> +	int ret;
> +	u8 buf;
> +
> +	chip = spi_get_device_match_data(spi);
> +	if (!chip)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Could not find chip info data\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	spi_set_drvdata(spi, st);
> +	init_completion(&st->completion);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev,  PTR_ERR(st->regmap),

Nitpick: Unneeded extra space before PTR_ERR

> +				     "Failed to initialize regmap\n");
> +
> +	st->mode = AD4052_SAMPLE_MODE;
> +	st->wait_event = false;
> +	st->chip = chip;

...

CJ

