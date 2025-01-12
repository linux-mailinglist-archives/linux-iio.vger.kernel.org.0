Return-Path: <linux-iio+bounces-14213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53FA0AA18
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8133816530A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9BB1B4258;
	Sun, 12 Jan 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI/1z7wd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680731953A1;
	Sun, 12 Jan 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736692584; cv=none; b=SLCOIbXBnBS4YQOWnbaht2iCc4/rZIpI5lTaYcGe5aGPuYrF5cg2sAb58mXq1UVs5kDi12SZ3p2qAGYOrjnHTB7Mh+qH0e1HG6OJO8U1ji7J5pOnDek1VrW/Nbi+wO879bAJrkqQTrw8Djx6gtyoSNym8sD3WK0zt9vXBa+f7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736692584; c=relaxed/simple;
	bh=vzK9QohRwE2QmKfYJrP4lmr/Wsa6GpO9EHvgTMqvJjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvF4k0K5XS0qjBLAtHpNfT8et5cpGq04WoK3ywX6J8qFsBnS/E7AQnY7hnvq9Jg+ci8ZveduCLxgg5Wzd/f2QspKaFHlSSjse0U8tr5zKtIF0DnxETv+8U6JjdgSATSx3L0wK4ir7E4HWjgKZtDajblW6/YBA4toM2FCRXlJbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI/1z7wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7179FC4CEDF;
	Sun, 12 Jan 2025 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736692584;
	bh=vzK9QohRwE2QmKfYJrP4lmr/Wsa6GpO9EHvgTMqvJjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GI/1z7wdO5u5dqHc9kw9GhI523lZ8tWFHCqIdTCP2rMB0vx2gud1+KLdHex2E7I6P
	 tJuk0X5A3Nh7ofysyuOINpFkJKpuodl7rx5jwmLwNRNWHk1yqgZMmtdA/uOBjq3NXh
	 D9kiw1LPKc/dr3wMYcG7kRpP6tfjY8x8pDsckE9QjdylZTQweDDYmnPtFgzn09aEbe
	 xTiDG1o7qAv9+9ACgN13eUOeVcAN7ky3rMICyx3dEDUyuwf0Vlx5/O+/Ls/2s3Zv+W
	 +3i9fQW6ma1cibKJM8Z0U69mUSk5Inz56EOLYhK9AXbg33bW3QvQ5sSJnA7rVv4Mrh
	 aMpR1NTSfkFMQ==
Date: Sun, 12 Jan 2025 14:36:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
Message-ID: <20250112143614.732e53ca@jic23-huawei>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-8-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
	<20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-8-2dac02f04638@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jan 2025 18:29:22 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> A new fpga HDL has been developed from ADI to support ad354xr
> devices.
> 
> Add support for ad3541r and ad3542r with following additions:
> 
> - use common device_info structures for hs and non hs drivers,
> - DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
> - change samplerate to respect number of lanes.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

One question inline.  I also wonder if you can easily add checks
that mean any spurious (bug) read in DDR mode would get an error
print to tell who ever triggered it what went wrong.

Jonathan

> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index bfb6228c9b9b..5995bab6a9b1 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c

> +
> +static int ad3552r_hs_set_target_io_mode_hs(struct ad3552r_hs_state *st)
> +{
> +	int mode_target;
> +
> +	/*
> +	 * Best access for secondary reg area, QSPI where possible,
> +	 * else as DSPI.
> +	 */
> +	if (st->model_data->num_spi_data_lanes == 4)
> +		mode_target = AD3552R_QUAD_SPI;
> +	else
> +		mode_target = AD3552R_DUAL_SPI;
> +
> +	/*
> +	 * Better to not use update here, since generally it is already
> +	 * set as DDR mode, and it's not possible to read in DDR mode.
> +	 */
> +	return st->data->bus_reg_write(st->back,
> +				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> +					   mode_target) |
> +				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> +}

> @@ -319,6 +479,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  	if (ret)
>  		return ret;
>  
> +	/* HDL starts with DDR enabled, disabling it. */
>  	ret = iio_backend_ddr_disable(st->back);
>  	if (ret)
>  		return ret;
> @@ -352,6 +513,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
>  			 id, st->model_data->chip_id);
>  
> +	dev_info(st->dev, "chip id %s detected", st->model_data->model_name);
> +
>  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
>  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
>  				      AD3552R_MASK_RESET_STATUS, 1);
> @@ -364,14 +527,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
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
This is the call you just added to ensure we end up in instruction mode.
I'm not seeing another place it is now called so is this an accidental revert?
If it is intentional then break out a patch that deals with that change
before the addition of new parts.

I was expecting to see a call to _set_target_io_mode_hs.



>  	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
>  	if (ret)
>  		return ret;
> @@ -528,6 +683,9 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
>  }

