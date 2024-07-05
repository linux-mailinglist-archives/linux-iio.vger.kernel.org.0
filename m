Return-Path: <linux-iio+bounces-7336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639192854E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D9FB250B5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD51474A7;
	Fri,  5 Jul 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCvFILF1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA614146A9B;
	Fri,  5 Jul 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172432; cv=none; b=fMc+Wk2bKEqTKaLcpf1BolaHl4GCg6OI5OszdurvKPEEhjs0gOwgOH7RWsdb/dFSJ7crAnajbiF3uivt9OC1jRuslmSK4nSnRuOUUS/nbbyo4RDGFVtIN20ccG3VHXt2cz98geKyMVE6vm/sXkjG8kX+/9FdrnDQP1AmSjh9Lt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172432; c=relaxed/simple;
	bh=aNrZlmnjPrqLBOJBPDREEHQflgAaZRC3XHxn1YSWfkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mofeqW5iwL44fBeVCMZE1RlZtiGDHKaHeexDC+C8n0lPd6srz2yuNpjAA9hAYTF1z9vL0T9ezHzcAp+5cGwqSSZQBJ02mozCtjympWawcQJAfWPz7dNpNConjJ+9/iDuJ1w0P4O5z7dm/slGZ7h9Tv1j3XasfGW9ttqouS60KUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCvFILF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5127FC116B1;
	Fri,  5 Jul 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720172432;
	bh=aNrZlmnjPrqLBOJBPDREEHQflgAaZRC3XHxn1YSWfkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VCvFILF1eirkIXXuepCGsE+lPelDZN+n9dchjih6o7F+tMPEYiTh3soLzFM5sMd9T
	 Svw6GF91Und9kEN06O1CDv4w0Nfi7usYPO+03ifF5sYWMmDzxhkH5L7Wy2MWoTNeSV
	 eFp9QZ2kDENG9sM3wLS1M5ft8udysjw3eszr8gpVwp7d5P8+LoZptB4ikWL9ehnz0L
	 wOlC27t55HDHwyxTPxsLJPJcff0FkThBQwyfF0a2xtVJhXQ5AXkYZaZGHVzgdoNtyV
	 ZU4Z69JD8lpyrI4PZXc/MqpagKQKFbLinyLkkAf+g6H/2dm/2mh44QBHqfTb6tAD4a
	 3cMr9hETEZd5Q==
Message-ID: <b794ed7c-d3b2-4fcd-94fb-de499de89804@kernel.org>
Date: Fri, 5 Jul 2024 11:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: ltrf216a: Add LTR-308 support
To: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Shreeya Patel <shreeya.patel@collabora.com>, devicetree@vger.kernel.org
References: <20240705091222.86916-1-marex@denx.de>
 <20240705091222.86916-2-marex@denx.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240705091222.86916-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 11:11, Marek Vasut wrote:
> Add LiteOn LTR-308 support into LTR-F216A kernel driver.
> 
> The two devices seem to have almost identical register map, except that
> the LTR-308 does not have three CLEAR_DATA registers, which are unused
> by this driver. Furthermore, LTR-308 and LTR-F216A use different lux
> calculation constants, 0.6 and 0.45 respectively. Both differences are
> handled using chip info data.
> 
> https://optoelectronics.liteon.com/upload/download/DS86-2016-0027/LTR-308ALS_Final_%20DS_V1%201.pdf
> https://optoelectronics.liteon.com/upload/download/DS86-2019-0016/LTR-F216A_Final_DS_V1.4.PDF
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

...

>  	mutex_init(&data->lock);
>  
> @@ -520,15 +537,27 @@ static int ltrf216a_runtime_resume(struct device *dev)
>  static DEFINE_RUNTIME_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_runtime_suspend,
>  				 ltrf216a_runtime_resume, NULL);
>  
> +struct ltr_chip_info ltr308_chip_info = {

static const

> +	.has_clear_data		= false,
> +	.lux_multiplier		= 60,
> +};
> +
> +struct ltr_chip_info ltrf216a_chip_info = {

static const


> +	.has_clear_data		= true,
> +	.lux_multiplier		= 45,
> +};
> +
>  static const struct i2c_device_id ltrf216a_id[] = {
> -	{ "ltrf216a" },
> +	{ "ltr308", .driver_data = (kernel_ulong_t)&ltr308_chip_info },
> +	{ "ltrf216a", .driver_data = (kernel_ulong_t)&ltrf216a_chip_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>  
>  static const struct of_device_id ltrf216a_of_match[] = {
> -	{ .compatible = "liteon,ltrf216a" },
> -	{ .compatible = "ltr,ltrf216a" },
> +	{ .compatible = "liteon,ltr308", .data = &ltr308_chip_info },
> +	{ .compatible = "liteon,ltrf216a", .data = &ltrf216a_chip_info },
> +	{ .compatible = "ltr,ltrf216a", .data = &ltrf216a_chip_info },

Drop this one. You cannot have undocumented compatibles - and checkpatch
tells you this - and we do not want to accept stuff just because someone
made something somewhere (e.g. ACPI, out of tree junk etc). There was
similar effort in the past and we made it clear.

Best regards,
Krzysztof


