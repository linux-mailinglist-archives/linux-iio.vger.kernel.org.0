Return-Path: <linux-iio+bounces-9333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3281970871
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEAA28205C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC7173345;
	Sun,  8 Sep 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW6sPzGF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13B167296;
	Sun,  8 Sep 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810168; cv=none; b=NCMnkb/PY9ApBzTPp/qmzcB3452PVCrs4MjdpGfE4la5RnuW0JbyZDvGT/hpo/DNYb/sSw4CPNSHzT0aF8ARebXTvBPBfQjg6QlwQSPKVyg2Ug1K0lQ6qoCb70+qg3X3ONAMb9Zn8a40VhMya5vUEQL4hkOA1EylAVJzBLY01YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810168; c=relaxed/simple;
	bh=OfKFBk9EbxBKw9SqKEGld73aPwiBRsbXXiV2RzrFBog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5x/Z7bQUgWT9IbP/Rs5Od2iuuLEeb2DZX+h9hBH60xwYdBLDflYBJ75orIP2ns04eo8Xlm18VpausIdbhrK3dgoO4IMekgJOU6vT6/YIYbth0oibMPQIFDsDc6oOPROkkHvGTOL2z6iThiFiT6H2u1/NPtrsbvo+LGcnAU0f/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW6sPzGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5751C4CEC3;
	Sun,  8 Sep 2024 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725810168;
	bh=OfKFBk9EbxBKw9SqKEGld73aPwiBRsbXXiV2RzrFBog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bW6sPzGF8Wq86sZTBlw3D6f0J88TbUxQOmzxzolBHNewEsG+cqPJyU3wK4WimaGlk
	 GncYraX1f7bEaxvoNR0xhFHxG7NLSXpehfLZ1U41nddcgD/gPX7v4DEM39p5KckXe1
	 j+6x3wnuqWzcEbSWYPg2gFKgpDVwWkBpKkMWHNwHgQ0xPntORnO+ADNB/sCmFuXBkz
	 Em51yxXku5ZccQPojKVlvciS4fesFpcqURZbRX48n1NWR4NDg3o/TVcsWI4O3Ke10V
	 2MVsxR8oTErcYRBAZNnN2h3qyccNa5TGJRYr8fWiw5SXiQvrNR3zbjbIhM9Kkqybvq
	 9Nc078Y6sEbhg==
Date: Sun, 8 Sep 2024 16:42:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 7/9] iio: dac: ad3552r: extract common code (no
 changes in behavior intended)
Message-ID: <20240908164240.1b98620e@jic23-huawei>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-7-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-7-87d669674c00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Sep 2024 17:17:37 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extracting common code, to share common code to be used later
> by the AXI driver version (ad3552r-axi.c).
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Looks like a few arrays are now duplicated that probably shouldn't be.
Otherwise, just trivial comments inline.

Jonathan


> ---
>  drivers/iio/dac/Makefile         |   2 +-
>  drivers/iio/dac/ad3552r-common.c | 163 +++++++++++++++++++++++
>  drivers/iio/dac/ad3552r.c        | 276 ++++-----------------------------------
>  drivers/iio/dac/ad3552r.h        | 199 ++++++++++++++++++++++++++++
>  4 files changed, 389 insertions(+), 251 deletions(-)
> 
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 2cf148f16306..56a125f56284 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> -obj-$(CONFIG_AD3552R) += ad3552r.o
> +obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o
>  obj-$(CONFIG_AD5421) += ad5421.o
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> new file mode 100644
> index 000000000000..c8ccfbe2e95e
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright (c) 2010-2024 Analog Devices Inc.
> +// Copyright (c) 2024 Baylibre, SAS
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "ad3552r.h"
> +
> +static const s32 ad3552r_ch_ranges[][2] = {
> +	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},

Please add spaces after { and before } given the code
is moving anyway and that's my preferred style (I'm getting fussier
about it over time :)


> +	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
> +	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000},
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= {-10000, 10000}
> +};
> +
> +static const s32 ad3542r_ch_ranges[][2] = {
> +	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
> +	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= {0, 3000},
> +	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
> +	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= {-2500, 7500},
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000}
> +};
> +
> +void ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs, u16 *reg)

return a u16 instead of passing it in as a pointer.
Fits better with how it is used I think.

> +{
> +	*reg = FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
> +	*reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p);
> +	*reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n);
> +	*reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs((s32)goffs) >> 8);
> +	*reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)goffs < 0);
> +}
> +
> +int ad3552r_get_ref_voltage(struct device *dev, u32 *val)
> +{
> +	int voltage, delta = 100000;

Trivial: Don't mix declarations with assignment and ones with out on same line.
It's slightly trickier to read.  This driver currently does this
a lot but lets not introduce more cases.


> +
> +	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (voltage < 0 && voltage != -ENODEV)
> +		return dev_err_probe(dev, voltage,
> +				     "Error getting vref voltage\n");
> +
> +	if (voltage == -ENODEV) {
> +		if (device_property_read_bool(dev, "adi,vref-out-en"))
> +			*val = AD3552R_INTERNAL_VREF_PIN_2P5V;
If val fits nicely into 31 bits and hence the positive values, I'd
return it as then these all become
			return AD...

> +		else
> +			*val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
> +	} else {
and this else is then unnecessary.

> +		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> +			dev_warn(dev, "vref-supply must be 2.5V");
> +			return -EINVAL;
> +		}
> +		*val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
> +	}
> +
> +	return 0;
> +}
> +
> +int ad3552r_get_drive_strength(struct device *dev, u32 *val)
> +{
> +	int err;
> +
> +	err = device_property_read_u32(dev, "adi,sdo-drive-strength", val);
> +	if (!err && *val > 3) {
> +		dev_err(dev,
> +			"adi,sdo-drive-strength must be less than 4\n");
> +		return -EINVAL;
	if (err)
		return err;

	if (*val > 3) {
		dev_err(dev,
			"adi,sdo-drive-strength must be less than 4\n");
		return -EINVAL;
	}
	
	return 0;

is a bit longer but keeps the error handling well separated from the
good path.

> +	}
> +
> +	return err;
> +}
> +

> +int ad3552r_get_output_range(struct device *dev, enum ad3552r_id chip_id,
> +			     struct fwnode_handle *child, u32 *val)
> +{
> +	int ret;
> +	s32 vals[2];
> +
> +	if (!fwnode_property_present(child, "adi,output-range-microvolt"))
> +		return -ENOENT;

Maybe add a comment that this property is optional, so we want to distinguish
this particular reason for failure.  Took me a few mins to figure out why
we needed this check.


> +
> +	ret = fwnode_property_read_u32_array(child,
> +					     "adi,output-range-microvolt",
> +					     vals, 2);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"invalid adi,output-range-microvolt\n");
> +
> +	ret = ad3552r_find_range(chip_id, vals);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"invalid adi,output-range-microvolt value\n");
> +
> +	*val = ret;
> +
> +	return 0;
> +}
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index d867de7c90d1..c149be9c8c7d 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -11,153 +11,9 @@

> -enum ad3552r_ch_output_range {
> -	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
> -	AD3552R_CH_OUTPUT_RANGE_0__2P5V,
> -	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
> -	AD3552R_CH_OUTPUT_RANGE_0__5V,
> -	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
> -	AD3552R_CH_OUTPUT_RANGE_0__10V,
> -	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
> -	AD3552R_CH_OUTPUT_RANGE_NEG_5__5V,
> -	/* Range from -10 V to 10 V. Requires Rfb4x connection  */
> -	AD3552R_CH_OUTPUT_RANGE_NEG_10__10V,
> -};
> +#include "ad3552r.h"
>  
>  static const s32 ad3552r_ch_ranges[][2] = {

This exists now in ad3552-common.c as well as here which seems unlikely to be
what you want.

>  	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
> @@ -167,21 +23,6 @@ static const s32 ad3552r_ch_ranges[][2] = {
>  	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= {-10000, 10000}
>  };
>  
> -enum ad3542r_ch_output_range {
> -	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
> -	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
> -	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
> -	AD3542R_CH_OUTPUT_RANGE_0__3V,
> -	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
> -	AD3542R_CH_OUTPUT_RANGE_0__5V,
> -	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
> -	AD3542R_CH_OUTPUT_RANGE_0__10V,
> -	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
> -	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
> -	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
> -	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
> -};
> -
>  static const s32 ad3542r_ch_ranges[][2] = {

Isn't this in the new location above?

>  	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
>  	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= {0, 3000},
> @@ -733,72 +574,32 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
>  	dac->ch_data[ch].offset_dec = div_s64(tmp, span);
>  }
>  

>  static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
>  					 struct fwnode_handle *child,
>  					 u32 ch)
>  {
>  	struct device *dev = &dac->spi->dev;
> -	u32 val;
>  	int err;
>  	u8 addr;
> -	u16 reg = 0, offset;
> -
> -	struct fwnode_handle *gain_child __free(fwnode_handle)
> -		= fwnode_get_named_child_node(child,
> -					      "custom-output-range-config");
> -	if (!gain_child)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "mandatory custom-output-range-config property missing\n");
> -
> -	dac->ch_data[ch].range_override = 1;
> -	reg |= FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
> -
> -	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
> -	if (err)
> -		return dev_err_probe(dev, err,
> -				     "mandatory adi,gain-scaling-p property missing\n");
> -	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, val);
> -	dac->ch_data[ch].p = val;
> +	u16 reg = 0;
>  
> -	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
> +	err = ad3552r_get_custom_gain(dev, child,
> +				      &dac->ch_data[ch].p,
> +				      &dac->ch_data[ch].n,
> +				      &dac->ch_data[ch].rfb,
> +				      &dac->ch_data[ch].gain_offset);
>  	if (err)
> -		return dev_err_probe(dev, err,
> -				     "mandatory adi,gain-scaling-n property missing\n");
> -	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, val);
> -	dac->ch_data[ch].n = val;
> -
> -	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
> -	if (err)
> -		return dev_err_probe(dev, err,
> -				     "mandatory adi,rfb-ohms property missing\n");
> -	dac->ch_data[ch].rfb = val;
> +		return err;
>  
> -	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
> -	if (err)
> -		return dev_err_probe(dev, err,
> -				     "mandatory adi,gain-offset property missing\n");
> -	dac->ch_data[ch].gain_offset = val;
> +	dac->ch_data[ch].range_override = 1;
>  
> -	offset = abs((s32)val);
> -	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, (offset >> 8));
> +	ad3552r_calc_custom_gain(dac->ch_data[ch].p, dac->ch_data[ch].n,
> +				 dac->ch_data[ch].gain_offset, &reg);
>  
> -	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)val < 0);
>  	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
>  	err = ad3552r_write_reg(dac, addr,

Given you now have the calculation of reg nice and compact, I'd move that after
this call.  It's odd to calculate a value first then not use it whilst
doing some other stuff.

> -				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
> +				abs((s32)dac->ch_data[ch].gain_offset) &
> +				AD3552R_MASK_CH_OFFSET_BITS_0_7);
>  	if (err)
>  		return dev_err_probe(dev, err, "Error writing register\n");
>  
> @@ -812,30 +613,17 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
>  static int ad3552r_configure_device(struct ad3552r_desc *dac)
>  {
>  	struct device *dev = &dac->spi->dev;
> -	int err, cnt = 0, voltage, delta = 100000;
> -	u32 vals[2], val, ch;
> +	int err, cnt = 0;
> +	u32 val, ch;
>  
>  	dac->gpio_ldac = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
>  	if (IS_ERR(dac->gpio_ldac))
>  		return dev_err_probe(dev, PTR_ERR(dac->gpio_ldac),
>  				     "Error getting gpio ldac");
>  
> -	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
> -	if (voltage < 0 && voltage != -ENODEV)
> -		return dev_err_probe(dev, voltage, "Error getting vref voltage\n");
> -
> -	if (voltage == -ENODEV) {
> -		if (device_property_read_bool(dev, "adi,vref-out-en"))
> -			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
> -		else
> -			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
> -	} else {
> -		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> -			dev_warn(dev, "vref-supply must be 2.5V");
> -			return -EINVAL;
> -		}
> -		val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
> -	}
> +	err = ad3552r_get_ref_voltage(dev, &val);
> +	if (err)
> +		return err;
With suggestion above,
	err = ad3552_get_ref_voltage(dev);
	if (err)
		return err;

	val = err;

>  
>  	err = ad3552r_update_reg_field(dac,
>  				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
...

> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> new file mode 100644
> index 000000000000..cada1f12f000
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -0,0 +1,199 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * AD3552R Digital <-> Analog converters common header
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Author: Angelo Dureghello <adureghello@baylibre.com>

It's all code lifted from elsewhere, so keep the original 
2021 date as well.  2021-2024 would be fine.

> + */
...



