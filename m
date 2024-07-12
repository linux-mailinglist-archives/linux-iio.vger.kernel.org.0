Return-Path: <linux-iio+bounces-7564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC5193006E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 20:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43494B22326
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD21A28C;
	Fri, 12 Jul 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqHjmEZt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4A18C05;
	Fri, 12 Jul 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808593; cv=none; b=jj8dHIdq7BTLPkg/Z7KSLqlssIH1/Evz8zJb2jWXDM7JXOdTKn/g5WVKfJJajC4NuzNho1cSncsMUaLoLvsk1Bqbnx2Qwng3HrODYUUhjX3AF/+A3ON7emG95DC8ZeebI3dtnFHba56TbRWJMm/5ZtqfPRCduBeYfedv3+hW61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808593; c=relaxed/simple;
	bh=Z+TxIP9m7Ud+jklx9kndspNhNdQj31AH85wHorIAAuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEyy6VAnq4qVatz+nkb7QJbQEwGplhEBv0jmkF9uwQ1oSgmOqRDyvM2DDfRCVSgdxfUJn/ZNTTVdkOdzogspi9+HrVtMPsU4WUBLL9u+yMMzq9nr/PUx15YaPt2jQaYT75BCoC+xhVetpV1K0QIcULmiZCT8ZTWU+ECn2UcfsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqHjmEZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2BDC32782;
	Fri, 12 Jul 2024 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720808592;
	bh=Z+TxIP9m7Ud+jklx9kndspNhNdQj31AH85wHorIAAuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqHjmEZt5Vce3yIXpJCluqUd1suHMPVJWN2n9w4tT4iop/vVGQ1pYbG+Odcgdw+kk
	 srmPxRA3cQU1QeYXe3TLwqcEVIUapLPmIBZQFTXrYtTsVTu1jkyyPASe56W8N95ibZ
	 CooZijjQ7MJXA7/Yrbn9GluZudTIWIEOWOPOv0UoLAXKU6o6SjwsUQ364mtXEbZsa+
	 m7DcLBMVh3AlMeSNxVbuzcGvXgpb4Z8762paM3nWTsBenH5VDsInONmC9FEnhQEYop
	 7TSkJf15o/PDePUlLs8C83wPiTo/btLpr3WzT2U2DJDpp/o5EE83ARiKlkRYvc746Q
	 kQ0J8YsAPZiOg==
Date: Fri, 12 Jul 2024 12:23:11 -0600
From: Rob Herring <robh@kernel.org>
To: Dumitru Ceclan <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v7 9/9] iio: adc: ad7173: Add support for AD411x devices
Message-ID: <20240712182311.GA1454666-robh@kernel.org>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
 <20240607-ad4111-v7-9-97e3855900a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-ad4111-v7-9-97e3855900a0@analog.com>

On Fri, Jun 07, 2024 at 05:53:15PM +0300, Dumitru Ceclan wrote:
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> 
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
> 
> This family of ADCs integrates an analog front end suitable for processing
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
> 
> - All ADCs have inputs with a precision voltage divider with a division
>   ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>   shunt resistor.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

[...]

> @@ -1194,6 +1434,11 @@ static int ad7173_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id ad7173_of_match[] = {
> +	{ .compatible = "ad4111",	.data = &ad4111_device_info },
> +	{ .compatible = "ad4112",	.data = &ad4112_device_info },
> +	{ .compatible = "ad4114",	.data = &ad4114_device_info },
> +	{ .compatible = "ad4115",	.data = &ad4115_device_info },
> +	{ .compatible = "ad4116",	.data = &ad4116_device_info },

These are all missing the 'adi,' vendor prefix. Please fix.

>  	{ .compatible = "adi,ad7172-2", .data = &ad7172_2_device_info },
>  	{ .compatible = "adi,ad7172-4", .data = &ad7172_4_device_info },
>  	{ .compatible = "adi,ad7173-8", .data = &ad7173_8_device_info },

