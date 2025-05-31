Return-Path: <linux-iio+bounces-20083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12666AC9BF4
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFEC17C924
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736616DEB1;
	Sat, 31 May 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJgEF4I4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CFCD299;
	Sat, 31 May 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748712040; cv=none; b=CiXuR7yuP0THD27sMKFQgQHOpaU034QqQ/d6lOmOxa762gX1tI16N5CB8vC/cHYLvhA3/erMuH1Mn8ibaii6nkUb8q26o5gK7Dq7oz+3eGKbEgHXLSZjisKz/Gz6kqpiWYtKCk7D+KGErY8SCtJiDSme09jCgvIlaFa+9glT+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748712040; c=relaxed/simple;
	bh=1EDss7/Ay/i1p27ZciMHXO4Rvu9BaVSbs48i//gkFgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGkgpb8cVcSxyO7TFy4WCAS3SDUhV7QA5xgWXSMWOlZ2TljAtdyQwQ2vFZ2cZYHFENXfNINQz0c/jW+5CKLPkpPR2YzvcFbwAG6lFVTT4wN5Nr9R7il2lMKxrm9uCf2QFWOIjtBbIVFK81e791UZsYX2g31PTcXMJ0OhOtyTlzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJgEF4I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF31C4CEF1;
	Sat, 31 May 2025 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748712040;
	bh=1EDss7/Ay/i1p27ZciMHXO4Rvu9BaVSbs48i//gkFgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJgEF4I4K68oYDlLRwi0ws0xjYgVej9CL94HG2mmcH90WoNkZtUuJerFwDEcpPXX9
	 gMhvyvuA+w52V88lzV7XK2PhA35C0AWvLeC86LIIlRsFAAnV+VWFjWgWXqbdOPVDSM
	 lFTY2lV86tx6J5yDNVpv8Xl1/rVNB3b9hzum8NYcizR7uceM2k78WcX+ygUnr0D4u0
	 YsywmgL/JFBAhGh0kvEzKOZItAe+I3COS15tRqGJRr8HiX3vhKIOgkRz7CktTlKVvk
	 46A9j8DG60i5RKfHZlJo/aU4rJHhz7QJAjfDoMs88yVkSjG6UU7pHDAePi+EBDZgV0
	 cVvmKNcYL0w6Q==
Date: Sat, 31 May 2025 18:20:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
 andriy.shevchenko@linux.intel.com, arthur.becker@sentec.com,
 perdaniel.olsson@axis.com, mgonellabolduc@dimonoff.com,
 muditsharma.info@gmail.com, clamor95@gmail.com, emil.gedenryd@axis.com,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <20250531182031.453ca161@jic23-huawei>
In-Reply-To: <20250526085041.9197-3-ak@it-klinger.de>
References: <20250526085041.9197-1-ak@it-klinger.de>
	<20250526085041.9197-3-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 10:50:40 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hi Andreas,

I missed a channel type issue. See below.

> diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml6046x00.c
> new file mode 100644
> index 000000000000..9972eeb57fd2
> --- /dev/null
> +++ b/drivers/iio/light/veml6046x00.c
> @@ -0,0 +1,1007 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML6046X00 High Accuracy RGBIR Color Sensor
> + *
> + * Copyright (c) 2025 Andreas Klinger <ak@it-klinger.de>
> + */

> +static const struct iio_chan_spec veml6046x00_channels[] = {
> +	{
> +		.type = IIO_LIGHT,

Sorry - I've been half asleep on earlier versions or maybe we discussed this
before and I've forgotten.  IIO_LIGHT is for illuminance with units of lux.

How does that apply to a colour channel given it's a measure of a specific
sensitivity curve for the human eye and such a thing only applies to 'whiteish'
light.

Normally we cover colour channels as IIO_INTENSITY which doesn't have
strong rules for scaling - so lets us get away with the many weird and wonderful
ideals different sensor manufacturers have of what RED / GREEN / BLUE
mean.  (There is an oddity for historical reasons IIRC of an IR light channel
but don't use that for new code).

So basically the request is to use .type = IIO_INTENSITY for these

> +		.address = VEML6046X00_REG_R,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_RED,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = VEML6046X00_SCAN_R,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.address = VEML6046X00_REG_G,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_GREEN,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = VEML6046X00_SCAN_G,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.address = VEML6046X00_REG_B,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BLUE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = VEML6046X00_SCAN_B,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.address = VEML6046X00_REG_IR,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = VEML6046X00_SCAN_IR,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(VEML6046X00_SCAN_TIMESTAMP),
> +};

