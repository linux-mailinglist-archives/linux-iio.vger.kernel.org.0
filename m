Return-Path: <linux-iio+bounces-13667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E30099F814F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BA87A046E
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E82B19CC06;
	Thu, 19 Dec 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDjcc3Z1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C819AA5D;
	Thu, 19 Dec 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628096; cv=none; b=aBiYmMLrfFs9IUTn8yfwOMbn/wsu9jzzcZmqyklZQihhHpRQ/guDhyQgFu9lxCQ4YHO0Cxfa/z+0RVcxuYIjnd0w7aQ08U97SuyGm4Kds+QTD/5jAOpNDr8xjKZ54s6hHsCtJwlxYOr1kJx8LQSsC7cz+gkj+vAuDJUIhfTox1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628096; c=relaxed/simple;
	bh=QRf2zHNhSSvlnOUqs4vb1eWIdNwe6VJQhKPacP3zKMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv7Z8honfpF3jGpv8VsYj1sxdLR0NaqXBrRhS92KQvC04GM6kk24C19fbulSqetAoZxJ98KRCacyfiuV34ZT8ltRnfPHqXAWtpLQ4c6nu2AN0Z/lXKH1MprNkWiLufU953dNl/uyqlwGkt/YUUBzLcGDXhnu36jF6QzVHL9xk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDjcc3Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4F6C4CED0;
	Thu, 19 Dec 2024 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734628096;
	bh=QRf2zHNhSSvlnOUqs4vb1eWIdNwe6VJQhKPacP3zKMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oDjcc3Z1eZJwYXIojPorjj6R61VRCu67E6ZWvupXOIi7uqMTLdXSlj8UvcL85pHfC
	 sU4oMagd0uOPR+jx2Li495fAeAjw7gQzzYPBMDXQXauoo1nHgezFm0kTgMkN94gJNK
	 9EZ7WkNkOS87L9gc+KUZemk1LtRipVPhQBg8V+R6xUnDAQ1nff5ksEFgzrZyp0yfgA
	 ae5p0GgddHf/yq1R8rZvm95mX6/KjKUp0X4cnvtwXSKurYsUckxYohuFUK5JyXPdlu
	 CNHFPsJKl4RyGjVOIKe5bw3BdKhyjblMh3Q2yMYPMq0BVeBNy/JItojZEojEMQ6Gye
	 rDRTuKecSHTaQ==
Date: Thu, 19 Dec 2024 17:08:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] iio: dac: ad3552r-hs: add ad3541/2r support
Message-ID: <20241219170807.4137f4ea@jic23-huawei>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-7-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
	<20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-7-856ff71fc930@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 21:36:27 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> A new fpga HDL has been developed from ADI to support ad354xr
> devices.
> 
Hi Angelo,

A few comments inline, but mostly / I think this could do with breaking
up into several patches. Particularly as that instruction mode
one sounds like it may turn out to be a fix we need to backport at
some point if problems are seen with previous approach.

There is also a move / consolidation of structures that could be a trivial
precursor and make the final patch simpler.

> Add support for ad3541r and ad3542r with following additions:
> 
> - use common device_info structures for hs and non hs drivers,
> - DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
> - use DAC "instruction mode" when backend is not buffering, suggested
>   from the ADI HDL team as more proper configuration mode to be used
>   for all ad35xxr devices,
Perhaps that change should be a precursor patch? 

> - change samplerate to respect number of lanes.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

> ---
>  drivers/iio/dac/ad3552r-common.c |  44 +++++++
>  drivers/iio/dac/ad3552r-hs.c     | 262 ++++++++++++++++++++++++++++++++-------
>  drivers/iio/dac/ad3552r.c        |  36 ------
>  drivers/iio/dac/ad3552r.h        |   8 ++
>  4 files changed, 270 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> index 03e0864f5084..2a0dd18ca906 100644
> --- a/drivers/iio/dac/ad3552r-common.c
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -47,6 +47,50 @@ u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
>  }
>  EXPORT_SYMBOL_NS_GPL(ad3552r_calc_custom_gain, "IIO_AD3552R");
>  
> +const struct ad3552r_model_data ad3541r_model_data = {
> +	.model_name = "ad3541r",
> +	.chip_id = AD3541R_ID,
> +	.num_hw_channels = 1,
> +	.ranges_table = ad3542r_ch_ranges,
> +	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
> +	.requires_output_range = true,
> +	.num_spi_data_lanes = 2,
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
> +	.num_spi_data_lanes = 2,
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
> +	.num_spi_data_lanes = 4,
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
> +	.num_spi_data_lanes = 4,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");

Maybe move these in a precursor patch . That will make it obvious
that you are also squashing a duplicate.

> +
>  static void ad3552r_get_custom_range(struct ad3552r_ch_data *ch_data,
>  				     s32 *v_min, s32 *v_max)
>  {
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index e613eee7fc11..58c8661f483b 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -19,6 +19,31 @@

...

> @@ -304,10 +481,18 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  	if (ret)
>  		return ret;
>  
> +	/* HDL starts with DDR enabled, disabling it. */

Seems obvious. Does the comment add anything?

>  	ret = iio_backend_ddr_disable(st->back);
>  	if (ret)
>  		return ret;
>  
> +	ret = st->data->bus_reg_write(st->back,
> +				      AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> +				      AD3552R_MASK_SINGLE_INST |
> +				      AD3552R_MASK_SHORT_INSTRUCTION, 1);
> +	if (ret)
> +		return ret;
> +
>  	ret = ad3552r_hs_scratch_pad_test(st);
>  	if (ret)
>  		return ret;
> @@ -330,6 +515,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  				     "chip id error, expected 0x%x, got 0x%x\n",
>  				     st->model_data->chip_id, id);
>  
> +	dev_info(st->dev, "chip id %s detected", st->model_data->model_name);

dev_dbg().  We have to much noise in the kernel log already! With dynamic debug
it is easy for people to turn this on if they want it.

> +
>  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
>  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
>  				      AD3552R_MASK_RESET_STATUS, 1);
> @@ -342,14 +529,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  	if (ret)
>  		return ret;
>  
> -	ret = st->data->bus_reg_write(st->back,
> -				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> -				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> -					   AD3552R_QUAD_SPI) |
> -				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);

> -	if (ret)
> -		return ret;
> -
>  	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
>  	if (ret)
>  		return ret;
> @@ -505,15 +684,10 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(&pdev->dev, indio_dev);


