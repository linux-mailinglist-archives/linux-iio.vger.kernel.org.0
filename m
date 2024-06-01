Return-Path: <linux-iio+bounces-5584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E198D7192
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C078D1C20B0A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD17154453;
	Sat,  1 Jun 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmV8Z6uv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4E4690;
	Sat,  1 Jun 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717267780; cv=none; b=AHJlB3LH6i9+fO93MNX9f0U0nRt2K05dihLunXsuUMcQohvXY3zXJ+RFyCuvwOLxDML561VXbPc8pHstNY/atZoCef/W46kITsMHG745kkaeaediRCKfYue9n/4bJbg8CYf34l6bPFJQtWs0SYkNVWjW97PYX9Sc7cVE/Ecg5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717267780; c=relaxed/simple;
	bh=DDsWNt2m7KUOT4U5Ey1mB4GLi104GZ28vd+GFesdJOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m71Gidbpm6f83gtCDpg+Pv6iTVktr4zXpg9TMPvhl8SSqDxPqpfzf1x1sloI6cuRZLXmyph4XUHXp4+WrkXgs7gNqqSkmoiQGstmUOdFgL9j4/vTRNSrHeUgARRIRTrl0t4LYW2kiFQSXRskAybGE33j+2v1tt5KUcfxn/yW8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmV8Z6uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDA5C116B1;
	Sat,  1 Jun 2024 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717267779;
	bh=DDsWNt2m7KUOT4U5Ey1mB4GLi104GZ28vd+GFesdJOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmV8Z6uv82CppwOvw0YDAy4wtdPjTYAnUgCmiVuw7MNAwtP8+CtuAspZ2uawrVFfM
	 YPDletFfAfTgEPX9SuzSPqB4xopQ54ZJhkOZW9aKbtmluSrBnr1SouYLTs1AeKMYAw
	 OPDjKuVftw+IHVHVSzHsh2QTkJgOzu1guX7amdt5plvznKknrhKzXzJrItJ4LVEeaC
	 oLCxRaoblt5/gCt/Py+IvdNlsS3n+axiIVRiiUAlrQXmrPGPHOjO4hmOMDNAI5l30n
	 o/VE7Ai8Rw1cO0btGfog5/C5m78z3IOsn3o1N8QV2Qx6akdA2Xh+0FzSHmPAGd6NDM
	 Dszb/l+oYdv1Q==
Date: Sat, 1 Jun 2024 19:49:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v4 3/6] iio: adc: ad7173: refactor ain and vref
 selection
Message-ID: <20240601194925.23123071@jic23-huawei>
In-Reply-To: <20240531-ad4111-v4-3-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-3-64607301c057@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 22:42:29 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Move validation of analog inputs and reference voltage selection to
> separate functions to reduce the size of the channel config parsing
> function and improve readability.
> Add defines for the number of analog inputs in a channel.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  drivers/iio/adc/ad7173.c | 71 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 6e249628bc64..a20831d99aa5 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -60,6 +60,7 @@
>  #define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
>  #define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
>  
> +#define AD7173_NO_AINS_PER_CHANNEL	2
>  #define AD7173_CH_ADDRESS(pos, neg) \
>  	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
>  	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> @@ -623,6 +624,7 @@ static int ad7173_setup(struct iio_dev *indio_dev)
>  static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
>  						 u8 reference_select)
>  {
> +	struct device *dev = &st->sd.spi->dev;
>  	int vref;
>  
>  	switch (reference_select) {
> @@ -646,9 +648,11 @@ static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
>  		return -EINVAL;
>  	}
>  
> -	if (vref < 0)
> +	if (vref < 0) {
> +		dev_err(dev, "Cannot use reference %u. Error:%d\n",
> +			reference_select, vref);
>  		return vref;
> -
> +	}
>  	return vref / (MICRO / MILLI);
>  }
>  
> @@ -905,13 +909,50 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
>  					   &st->int_clk_hw);
>  }
>  
> +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> +					      const unsigned int ain[AD7173_NO_AINS_PER_CHANNEL])
I was late to the game in replying to previous thread.

This is neater without the loop and with 2 parameters.  Anyhow see reply to v3.

If you end up respining for other reasons consider doing that as well.
Maybe keep the struct device *dev though which I suggested dropping as
looking at the full patch it is more consistent to keep that.

> +{
> +	struct device *dev = &st->sd.spi->dev;
> +
> +	for (int i = 0; i < AD7173_NO_AINS_PER_CHANNEL; i++) {
> +		if (ain[i] < st->info->num_inputs)
> +			continue;
> +
> +		return dev_err_probe(dev, -EINVAL,
> +			"Input pin number out of range for pair (%d %d).\n",
> +			ain[0], ain[1]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
> +{
> +	struct device *dev = &st->sd.spi->dev;
> +	int ret;
> +
> +	if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF && !st->info->has_int_ref)
> +		return dev_err_probe(dev, -EINVAL,
> +			"Internal reference is not available on current model.\n");
> +
> +	if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
> +		return dev_err_probe(dev, -EINVAL,
> +			"External reference 2 is not available on current model.\n");
> +
> +	ret = ad7173_get_ref_voltage_milli(st, ref_sel);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7173_channel *chans_st_arr, *chan_st_priv;
>  	struct ad7173_state *st = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
>  	struct iio_chan_spec *chan_arr, *chan;
> -	unsigned int ain[2], chan_index = 0;
> +	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
>  	int ref_sel, ret, num_channels;
>  
>  	num_channels = device_get_child_node_count(dev);
> @@ -965,11 +1006,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		if (ret)
>  			return ret;
>  
> -		if (ain[0] >= st->info->num_inputs ||
> -		    ain[1] >= st->info->num_inputs)
> -			return dev_err_probe(dev, -EINVAL,
> -				"Input pin number out of range for pair (%d %d).\n",
> -				ain[0], ain[1]);
> +		ret = ad7173_validate_voltage_ain_inputs(st, ain);
> +		if (ret)
> +			return ret;
>  
>  		ret = fwnode_property_match_property_string(child,
>  							    "adi,reference-select",
> @@ -980,19 +1019,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		else
>  			ref_sel = ret;
>  
> -		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
> -		    !st->info->has_int_ref)
> -			return dev_err_probe(dev, -EINVAL,
> -				"Internal reference is not available on current model.\n");
> -
> -		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
> -			return dev_err_probe(dev, -EINVAL,
> -				"External reference 2 is not available on current model.\n");
> -
> -		ret = ad7173_get_ref_voltage_milli(st, ref_sel);
> -		if (ret < 0)
> -			return dev_err_probe(dev, ret,
> -					     "Cannot use reference %u\n", ref_sel);
> +		ret = ad7173_validate_reference(st, ref_sel);
> +		if (ret)
> +			return ret;
>  
>  		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
>  			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
> 


