Return-Path: <linux-iio+bounces-14042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E6A06718
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 22:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A36188AB6B
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2A204087;
	Wed,  8 Jan 2025 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fkBCr66L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A415E8B
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371157; cv=none; b=Pef9GDn14wvZg52l8mB6Ux56X1h85AjzhA8KCmf3jl2SfxLGZuJFJLLtOkffKFXJyAzDboztsLXTY8lipUgQ/l8RFkl/2GykXvwhwXEHc+8uEYdCr9Tae5f+BQrG2JB0ipDDRkkVm6nDBHzICfdmTeSLuGLjncrYdvDKCMlswlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371157; c=relaxed/simple;
	bh=pQZ8R+7otkzS9nDX+Ah2NyaWYrO2/GKUWsJD+tyR10s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbmuUYpA0ciJUGeif57mnpGqT4e8r4+8aktIsAI5HPhsknNxI/F+4pBwR4rtWGQcMm3/NEpdyVdoSY46iyPAsrGt+s3U2KYBJiUwUuyb98gCFsRDdW7Gng8CQCuOqQdRh0gXeTtvJCXuQRbZc99wpswBLO9uE+wxYLaqEut373Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fkBCr66L; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f2d8f62290so130192eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 13:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736371155; x=1736975955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLDcwgmqsaoUcP2xhVT+h7Hfk2S8bv8IKPM+a422eP4=;
        b=fkBCr66LebrExw3JrvKFIC+yAdqAWMfSRXBHp5JC+x5bGg+N02XPC0ArfpxTyaRT3p
         4x/2dGzZvST60HKfiBjPGI580HKSTDd+kdnik1kGi6u0d9UBaHfIcZq/eD91XnoXDPMX
         CqNvlp+RtKSMRS97xG1xFnxJl6JtSGqyxJigI4AI4AgPdZFr4YDy4sEBvWuJBfbjmWkT
         MHM3B6HNbSxXwR+RWVlBWe9XvK6jQnoiZ5Seg2MzH9rBlSY1pIRsuXgglFJISAXP1jgV
         4slMSDlGL2feV94g4384VR7YJjQvBx/l4K5oVzh3Esev2NDavM/clxlDLyTAQY24kkQK
         hWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736371155; x=1736975955;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLDcwgmqsaoUcP2xhVT+h7Hfk2S8bv8IKPM+a422eP4=;
        b=vRY1gMlfAwVckMnIwDQOb8fxckcGnmbx3VkFPDgj31lKXeGJPBPkV6dEPbrQbgfUh8
         FilmNMnxrBd/srkGNgj4vSxLvXGG44rpPwoW70SzXqkkNtr8n8L+0uzqOhrAAUSmVI0+
         ct/kq8BMRR2Qkx1yxJM+VtWhysP3pP/9e5ISCBXhw5/eGVEUi+WmiMlvR7XV4aG82CL/
         wo0jDRpZBJvlLI1ckT/yyMjpm/JTLhnlQE1yFHZszOJtdyV2vNQqSZmtPbtVDRFnEE5/
         ME6hwKkFhX6YBhqwWQj5Stg1owEnkBXKPVVBrX7kuDjHuLok82Kump1clsGFrsaMkn+d
         Qxpw==
X-Forwarded-Encrypted: i=1; AJvYcCWNBEO1o9L4hN6pYnSeVv7s6yvKLlDFOyYl8fo8FXlThjvSNQsufgpwpMtG2m08bJrjrPKkgRiUT8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oy9HuBQYYQPqQJx8qXhT3tGED8O4DizXit2ERoNeXL3MTEAg
	dyKLIRRqd6QzusXM5ByBIkurmhRpdagKnTls36G3tPWeXgUKyXnlQ1sX1ZkFmfjxzjj6OSaeuJ6
	a
X-Gm-Gg: ASbGncsh1tdCIOSA8y1BoFifSKrCP04gH9BxdNSsspQKyALPhhgOS/OGtazQcQwAI2v
	Gl6AYvon3xlsqA+lGcsnDttJpecvJJ9M/xIhjSaumKz3BYvSfWAwtdInT2Z49BNVJn90TeyXg8N
	yAT/exLI7CI+igIHWoibsnRvzUEJSy2BzGW9n8n4v7pTXTnwxu3lmsyUnOTdJEsGKUtgYDPo+vs
	NElUSThYCCSUy9AHxkfMgjwTYNiNoRCzb1SUtrzI5sY+tY5JKijMHL+0J4+OCPRpc6iZgJOM+Cd
	uLmXauUJ8i3jce93eg==
X-Google-Smtp-Source: AGHT+IF2/MdUOWn08Bt7PqSysTSRtQIOieZyU0jrlocE0o2G64qmq1aZEX9KC1vdkqtokY0vpf4e+g==
X-Received: by 2002:a05:6871:a0c8:b0:29e:68ba:7156 with SMTP id 586e51a60fabf-2aa0668aac4mr1995048fac.13.1736371154886;
        Wed, 08 Jan 2025 13:19:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d757ea45sm13836927fac.32.2025.01.08.13.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:19:13 -0800 (PST)
Message-ID: <3803a348-d713-4859-ac52-dbb123a69804@baylibre.com>
Date: Wed, 8 Jan 2025 15:19:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] iio: dac: ad3552r: share model data structures
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-7-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-7-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Preparing for new parts to be added also in the hs driver,
> set model data structures in ad3552r-common.c, to be accessible
> from both -hs and non hs driver.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-common.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/dac/ad3552r-hs.c     |  8 --------
>  drivers/iio/dac/ad3552r.c        | 36 ------------------------------------
>  drivers/iio/dac/ad3552r.h        |  5 +++++
>  4 files changed, 45 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> index 03e0864f5084..36920ec95836 100644
> --- a/drivers/iio/dac/ad3552r-common.c
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -37,6 +37,46 @@ static const s32 gains_scaling_table[] = {
>  	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
>  };
>  
> +const struct ad3552r_model_data ad3541r_model_data = {
> +	.model_name = "ad3541r",
> +	.chip_id = AD3541R_ID,
> +	.num_hw_channels = 1,
> +	.ranges_table = ad3542r_ch_ranges,
> +	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
> +	.requires_output_range = true,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
> +
> +const struct ad3552r_model_data ad3542r_model_data = {
> +	.model_name = "ad3542r",
> +	.chip_id = AD3542R_ID,
> +	.num_hw_channels = 2,
> +	.ranges_table = ad3542r_ch_ranges,
> +	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
> +	.requires_output_range = true,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
> +
> +const struct ad3552r_model_data ad3551r_model_data = {
> +	.model_name = "ad3551r",
> +	.chip_id = AD3551R_ID,
> +	.num_hw_channels = 1,
> +	.ranges_table = ad3552r_ch_ranges,
> +	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
> +	.requires_output_range = false,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
> +
> +const struct ad3552r_model_data ad3552r_model_data = {
> +	.model_name = "ad3552r",
> +	.chip_id = AD3552R_ID,
> +	.num_hw_channels = 2,
> +	.ranges_table = ad3552r_ch_ranges,
> +	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
> +	.requires_output_range = false,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
> +
>  u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
>  {
>  	return FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1) |
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 991b11702273..bfb6228c9b9b 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -527,14 +527,6 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  
> -static const struct ad3552r_model_data ad3552r_model_data = {
> -	.model_name = "ad3552r",
> -	.chip_id = AD3552R_ID,
> -	.num_hw_channels = 2,
> -	.ranges_table = ad3552r_ch_ranges,
> -	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
> -};
> -
>  static const struct of_device_id ad3552r_hs_of_id[] = {
>  	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
>  	{ }
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index e7206af53af6..9d28e06b80c0 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -649,42 +649,6 @@ static int ad3552r_probe(struct spi_device *spi)
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> -static const struct ad3552r_model_data ad3541r_model_data = {
> -	.model_name = "ad3541r",
> -	.chip_id = AD3541R_ID,
> -	.num_hw_channels = 1,
> -	.ranges_table = ad3542r_ch_ranges,
> -	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
> -	.requires_output_range = true,
> -};
> -
> -static const struct ad3552r_model_data ad3542r_model_data = {
> -	.model_name = "ad3542r",
> -	.chip_id = AD3542R_ID,
> -	.num_hw_channels = 2,
> -	.ranges_table = ad3542r_ch_ranges,
> -	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
> -	.requires_output_range = true,
> -};
> -
> -static const struct ad3552r_model_data ad3551r_model_data = {
> -	.model_name = "ad3551r",
> -	.chip_id = AD3551R_ID,
> -	.num_hw_channels = 1,
> -	.ranges_table = ad3552r_ch_ranges,
> -	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
> -	.requires_output_range = false,
> -};
> -
> -static const struct ad3552r_model_data ad3552r_model_data = {
> -	.model_name = "ad3552r",
> -	.chip_id = AD3552R_ID,
> -	.num_hw_channels = 2,
> -	.ranges_table = ad3552r_ch_ranges,
> -	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
> -	.requires_output_range = false,
> -};
> -
>  static const struct spi_device_id ad3552r_id[] = {
>  	{
>  		.name = "ad3541r",
> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index 4b5581039ae9..23f038464a0c 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -137,6 +137,11 @@
>  extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
>  extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];

Do the ranges still need to be extern now or can we make them static in
ad3552r-common.c?

>  
> +extern const struct ad3552r_model_data ad3541r_model_data;
> +extern const struct ad3552r_model_data ad3542r_model_data;
> +extern const struct ad3552r_model_data ad3551r_model_data;
> +extern const struct ad3552r_model_data ad3552r_model_data;
> +
>  enum ad3552r_id {
>  	AD3541R_ID = 0x400b,
>  	AD3542R_ID = 0x4009,
> 


