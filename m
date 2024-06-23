Return-Path: <linux-iio+bounces-6778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 212AC913CC5
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABEEDB21B0D
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D58183063;
	Sun, 23 Jun 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL2TyUEo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6F8F5B;
	Sun, 23 Jun 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719160226; cv=none; b=pKefvf2Ias5lf+3fPed3bdkGVFUA8DuzLRmx0jolMwewo1fvaIMoypKdTz92z/nFrM91PyJQ3BOxc6OMv/IT8ptcEQgaQCuFY+NdSBXF/IflyvzKsIumSOU1CFCCwGtC2kAjyHM6xIOEQ75N1SdZ+Vtzw+Lva0L8qNwYEqsbAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719160226; c=relaxed/simple;
	bh=GpYFGPdZts7O9qMXftegdL5qHYUq/82DkYhv80PMtCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+x7SlCMFOdUbqW0k6M/1KEHmYlKQ7cv9b8QDBdT8xT1uUIBgl9+waqEfezKQtzEEnfesfdyMdDvP5fvbE2uDktLX0xeTNCbHFhIxsuNvCBuksmEUtHMjigCGU8Nza8xuaxHklzNamPBpVSQ0PnZO1ADqvDQp4VtZS4bf+E/H/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL2TyUEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A465CC2BD10;
	Sun, 23 Jun 2024 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719160225;
	bh=GpYFGPdZts7O9qMXftegdL5qHYUq/82DkYhv80PMtCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JL2TyUEoe125u3uwLbWL8FlcI+B/7LRJvn7jAWrFzQmlMFUzQ9ns8nlvV+pX7o5SF
	 SBAVpblUx7oAOxOQAm+qUloArQCUjIkzANmInr6L0zSrqrWPkP/Pku3rmAVz3mij89
	 g97ENTSdYZB6+KOcc9Q8x6nKq60ASR2IQGKR2nsaiMCPDDApyOJBeyugnd9shCC/yr
	 MRy6l41ZrLKEYV0LPYprmZ6QljJMbafgT/ZP/JKvSCuQ2HKJs1nfQ/h2CAIwuyQj4P
	 4EXSLEnnJZqR4mNgAXu/EeE5Mw+gJjfrjSt2PrErsCwzlECgO3F476eGpbn7N7r5Yo
	 AFtfZXHC3IB3w==
Date: Sun, 23 Jun 2024 17:30:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, broonie@kernel.org,
 lee@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com,
 sre@kernel.org, wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 5/8] iio: adc: axp20x_adc: add support for AXP717 ADC
Message-ID: <20240623173015.555584b6@jic23-huawei>
In-Reply-To: <20240617220535.359021-6-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
	<20240617220535.359021-6-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 17:05:32 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717 ADC. The AXP717 differs from other ADCs
> in this series by utilizing a 14 bit ADC for all channels (a full 16
> bits with the first 2 digits reserved). It also differs by lacking a
> battery discharge current channel.
> 
> Note that while the current charge channel itself is included in this
> driver for the AXP717 and listed in the datasheet, no scale or offset
> was given for this channel. For now no scale or offset is provided in
> this driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris

A few minor comments inline,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp20x_adc.c | 167 +++++++++++++++++++++++++++++++++--
>  1 file changed, 160 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index d6c51b0f48e3..f35ba2c11e1b 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -5,6 +5,7 @@
>   *	Quentin Schulz <quentin.schulz@free-electrons.com>
>   */
>  
> +#include <asm/unaligned.h>
>  #include <linux/bitfield.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
> @@ -27,6 +28,8 @@
>  
>  #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
>  
> +#define AXP717_ADC_EN1_MASK			GENMASK(5, 0)
> +
>  #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
>  #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
>  
> @@ -35,6 +38,11 @@
>  
>  #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
>  
> +#define AXP717_ADC_DATA_TS			0x00
> +#define AXP717_ADC_DATA_TEMP			0x01
> +
> +#define AXP717_ADC_DATA_MASK			0x3fff

GENMASK()

> +static int axp717_adc_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val)
> +{
> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +	u8 bulk_reg[2];
> +	int ret;
> +
> +	/*
> +	 * A generic "ADC data" channel is used for TS, tdie, vmid,
> +	 * and vbackup. This channel must both first be enabled and
> +	 * also selected before it can be read.
> +	 */
> +	switch (chan->channel) {
> +	case AXP717_TS_IN:
> +		regmap_write(info->regmap, AXP717_ADC_DATA_SEL,
> +			     AXP717_ADC_DATA_TS);
> +		break;
> +	case AXP717_DIE_TEMP_V:
> +		regmap_write(info->regmap, AXP717_ADC_DATA_SEL,
> +			     AXP717_ADC_DATA_TEMP);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * All channels are 14 bits, with the first 2 bits on the high
> +	 * register reserved and the remaining bits as the ADC value.
> +	 */
> +	ret = regmap_bulk_read(info->regmap, chan->address, bulk_reg, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = get_unaligned_be16(bulk_reg) & AXP717_ADC_DATA_MASK;

FIELD_GET() preferred as then I don't have to check if DATA_MASK includes
the 0th bit.

> +	return IIO_VAL_INT;
> +}
> +


