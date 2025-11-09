Return-Path: <linux-iio+bounces-26098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF0C442D9
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 601D9346F47
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0D302743;
	Sun,  9 Nov 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKqLlFY6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB541AA7BF;
	Sun,  9 Nov 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707063; cv=none; b=nmsJVbdR1VKN+KsBlS0b+JeaVfMhRndYxVsQY+CTRJo0d9Xz7rY7EvRb56SLrCFpH0rJUvIQ83B32RBy6/IwknNBWrtfZwUxCRhT1i714B7t2oSgCwCMcO5h7xOjosRBjObv6VAIhb+tgEYY21t7+7qLh1pugFx/IpbHk6PGlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707063; c=relaxed/simple;
	bh=kh2HcZWxFtQ1ynTFpWR+bGwBRk8sdEv+XtPgpWe+6ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhh5mvnvjnkchDmnfvXXiHnn9Nd6AjqJHptJ+5o0Efsiq95S7Nqv6qfvhJgT+uJmP8pE88GK0persFSDqi9l8iHVHMcx8A2lr9pQzciCHMf0LOr7rwwaMC7mTBB7LEDKMRJ/lhMgs5hieJ/aLlB0gy08eNkmVmWAs+R79d4U6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKqLlFY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277BEC4AF09;
	Sun,  9 Nov 2025 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762707062;
	bh=kh2HcZWxFtQ1ynTFpWR+bGwBRk8sdEv+XtPgpWe+6ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sKqLlFY6Cylhra5n55FxnldeN/3y1Mxn/b2Q/VBLJumDFH5Hx8r2VThpYW7gmgho/
	 fEsy+VPAzfXdkm3O/JbWl+nRG21gXfcRMFo1TyMqxgd8imKc/isrRqL9CflcIQUatV
	 rxeAOlvM0jQAdDNVypIc+TZ9XInUCS57cf8iWjrQy0tfqTHMQh6NPN12+P3QVEE1U8
	 QI9s4mdupLwBaW4QDuybhoZTQ9ecisJNMh446Xv+GpEkBIFmeWUpbfAtP2LZVFITb4
	 ZaRdoOTYmeqjb2sbawCkGaIG+uj95hJpS6eIF0a3wBC+UtdgLNMYwx8E1oOh/ex2i0
	 oloS8upfu7OZw==
Date: Sun, 9 Nov 2025 16:50:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: adxl380: add support for ADXL318 and
 ADXL319
Message-ID: <20251109165055.404d0417@jic23-huawei>
In-Reply-To: <7d990c72acca31b2fe6c7685fd13ef5284c7646f.1762281527.git.Jonathan.Santos@analog.com>
References: <2b8fc2ea006d06660c83f1e9e1ccfc865803dafb.1762281527.git.Jonathan.Santos@analog.com>
	<7d990c72acca31b2fe6c7685fd13ef5284c7646f.1762281527.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 09:40:34 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The ADXL318 and ADXL319 are low noise density, low power, 3-axis
> accelerometers based on ADXL380 and ADXL382, respectively. The main
> difference between the new parts and the existing ones are the absence
> of interrupts and events like tap detection, activity/inactivity, and
> free-fall detection.
> 
> Other differences in the new parts are fewer power modes, basically
> allowing only idle and measurement modes, and the removal of the 12-bit
> SAR ADC path for the 3-axis signals (known as lower signal chain),
> being excluisive for the temperature sensor in the ADXL318/319.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Only comments are about numeric order, similar to the comments on
the dt-binding.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl380.c     | 134 ++++++++++++++++++++++----------
>  drivers/iio/accel/adxl380.h     |   4 +
>  drivers/iio/accel/adxl380_i2c.c |   4 +
>  drivers/iio/accel/adxl380_spi.c |   4 +
>  4 files changed, 107 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 0cf3c6815829..7733a0902afa 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -27,6 +27,8 @@
>  
>  #define ADXL380_ID_VAL				380
>  #define ADXL382_ID_VAL				382
> +#define ADXL318_ID_VAL				380
> +#define ADXL319_ID_VAL				382

Similar to the binding.  Sort these by number.

>  
>  #define ADXL380_DEVID_AD_REG			0x00
>  #define ADLX380_PART_ID_REG			0x02
> @@ -178,41 +180,6 @@ enum adxl380_tap_time_type {

> +
> +const struct adxl380_chip_info adxl382_chip_info = {
> +	.name = "adxl382",
> +	.chip_id = ADXL382_ID_VAL,
> +	.scale_tbl = {
> +		[ADXL382_OP_MODE_15G_RANGE] = { 0, 4903325 },
> +		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
> +		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
> +	},
> +	.samp_freq_tbl = { 16000, 32000, 64000 },
> +	/*
> +	 * The datasheet defines an intercept of 570 LSB at 25 degC
> +	 * and a sensitivity of 10.2 LSB/C.
> +	 */
> +	.temp_offset =  25 * 102 / 10 - 570,
> +	.has_low_power = true,
> +	.info = &adxl380_info,
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl382_chip_info, "IIO_ADXL380");
> +
> +const struct adxl380_chip_info adxl318_chip_info = {
> +	.name = "adxl318",
> +	.chip_id = ADXL318_ID_VAL,
> +	.scale_tbl = {
> +		[ADXL380_OP_MODE_4G_RANGE] = { 0, 1307226 },
> +		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
> +		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
> +	},
> +	.samp_freq_tbl = { 8000, 16000, 32000 },
> +	/*
> +	 * The datasheet defines an intercept of 550 LSB at 25 degC
> +	 * and a sensitivity of 10.2 LSB/C.
> +	 */
> +	.temp_offset =  25 * 102 / 10 - 550,
> +	.info = &adxl318_info,
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl318_chip_info, "IIO_ADXL380");
> +
> +const struct adxl380_chip_info adxl319_chip_info = {
Numeric order preferred for these structures as well.
There might have been some argument for grouping by ID but that
doesn't seem to be the case either here.

> +	.name = "adxl319",
> +	.chip_id = ADXL319_ID_VAL,
> +	.scale_tbl = {
> +		[ADXL382_OP_MODE_15G_RANGE] = { 0, 4903325 },
> +		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
> +		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
> +	},
> +	.samp_freq_tbl = { 16000, 32000, 64000 },
> +	/*
> +	 * The datasheet defines an intercept of 550 LSB at 25 degC
> +	 * and a sensitivity of 10.2 LSB/C.
> +	 */
> +	.temp_offset =  25 * 102 / 10 - 550,
> +	.info = &adxl318_info,
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl319_chip_info, "IIO_ADXL380");

> diff --git a/drivers/iio/accel/adxl380.h b/drivers/iio/accel/adxl380.h
> index a683625d897a..5d88c111d616 100644
> --- a/drivers/iio/accel/adxl380.h
> +++ b/drivers/iio/accel/adxl380.h

>  
>  extern const struct adxl380_chip_info adxl380_chip_info;
>  extern const struct adxl380_chip_info adxl382_chip_info;
> +extern const struct adxl380_chip_info adxl318_chip_info;
> +extern const struct adxl380_chip_info adxl319_chip_info;
Sort numerically.



