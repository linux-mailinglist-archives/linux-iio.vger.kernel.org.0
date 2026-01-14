Return-Path: <linux-iio+bounces-27715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2203BD1D632
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F5993045741
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49FC199D8;
	Wed, 14 Jan 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfm2PHPo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E118B0F;
	Wed, 14 Jan 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381518; cv=none; b=iZBl46+uBXbIcSZSxv17e9PUNuTqknNCh8aecwsarbdx/MM/UrsyEevW6cYCipZTuDKSESlWyZACuATTZNg3FUic9pSo/D8VholBAbvkD4Ye08eFPyI0418SyFOVSHo5pRXi3VAorOdVQt+kVvWRvCGW7t7IEVTpFoNuO7DJwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381518; c=relaxed/simple;
	bh=ESHQksRovUrweSbNK4qiBPoivNpYzBG+Qh83awItVSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEb+uEcD/X4LB+M4ywWYq+5pEx1y82nY/K7FwNu6xa1lVcFs8FladfGnEOwa8YWFavZq3QNCpMbcKC+UJ38SEkLQpeOs9B4s9eNDNLtl3Terh62o5tld/dyM/KsyOFnyxhAgBcQMyZOWaJ+axhcUpLpAK1uEmvshcmwHwtAMVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfm2PHPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFB9C4CEF7;
	Wed, 14 Jan 2026 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381518;
	bh=ESHQksRovUrweSbNK4qiBPoivNpYzBG+Qh83awItVSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tfm2PHPo7/5fB24TyLjScylCvvI8OrYye7sAslynKdixe05PDCYkdhMSk0aOGJV9h
	 dcPaOI0P97iEr3Ebj3U2/LObpI1acBMOWH3c3VWBU54LHZpVzeC5RlZDdIr4G03HJN
	 LpwjbY5cavSmHNMOGzDLkJjhzKo7UFmBCT/3YCUhvp0kuXUtqIgIbE5nOx/J1mH5IK
	 QIx4XUxKDqqybx1sAhpi7va9X5/GRjgN4AtFSQfZ9dDbwvrB8z2vyxeG92tvo5N2GJ
	 7av6xD5/CWs9+b+qhJvDmxfZy1cfxmKcl86tc7yLffYLfcr1A3soTsMTLOR9BWiZAs
	 CdAOZ2Q0hos1g==
Date: Wed, 14 Jan 2026 09:05:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/9] spi: support controllers with multiple data
 lanes
Message-ID: <20260114090508.3ebef716@jic23-huawei>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
	<20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 11:45:21 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add support for SPI controllers with multiple physical SPI data lanes.
> (A data lane in this context means lines connected to a serializer, so a
> controller with two data lanes would have two serializers in a single
> controller).
> 
> This is common in the type of controller that can be used with parallel
> flash memories, but can be used for general purpose SPI as well.
> 
> To indicate support, a controller just needs to set ctlr->num_data_lanes
> to something greater than 1. Peripherals indicate which lane they are
> connected to via device tree (ACPI support can be added if needed).
> 
> The spi-{tx,rx}-bus-width DT properties can now be arrays. The length of
> the array indicates the number of data lanes, and each element indicates
> the bus width of that lane. For now, we restrict all lanes to have the
> same bus width to keep things simple. Support for an optional controller
> lane mapping property is also implemented.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes:
> - Use of_property_read_variable_u32_array() for lane maps.
For this, I think you need to check for short maps.
> 
> v4 changes:
> - Update for changes in devicetree bindings.
> - Don't put new fields in the middle of CS fields.
> - Dropped acks since this was a significant rework.
> 
> v3 changes:
> * Renamed "buses" to "lanes" to reflect devicetree property name change.
> 
> This patch has been seen in a different series [1] by Sean before:
> 
> [1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-4-sean.anderson@linux.dev/
> 
> Changes:
> * Use u8 array instead of bitfield so that the order of the mapping is
>   preserved. (Now looks very much like chip select mapping.)
> * Added doc strings for added fields.
> * Tweaked the comments.
> ---
>  drivers/spi/spi.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/spi/spi.h |  22 +++++++++
>  2 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e25df9990f82..5c3f9ba3f606 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2370,7 +2370,53 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		spi->mode |= SPI_CS_HIGH;
>  
>  	/* Device DUAL/QUAD mode */
> -	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
> +
> +	rc = of_property_read_variable_u32_array(nc, "spi-tx-lane-map",
> +						 spi->tx_lane_map, 1,
> +						 ARRAY_SIZE(spi->tx_lane_map));

This reads 'up to' the ARRAY_SIZE(spi->tx_lane_map)
If it is short, what is the right thing to do?  I'd either expect a check
for that or for rc to be stashed somewhere if positive for later use.
If the intent is for short the default of 0 is fine, then if it's a lot
short we'll end up with repeated mappings to 0 which makes little sense.


> +	if (rc == -EINVAL) {
> +		/* Default lane map */
> +		for (idx = 0; idx < ARRAY_SIZE(spi->tx_lane_map); idx++)
> +			spi->tx_lane_map[idx] = idx;
> +	} else if (rc < 0) {
> +		dev_err(&ctlr->dev,
> +			"failed to read spi-tx-lane-map property: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = of_property_count_u32_elems(nc, "spi-tx-bus-width");
> +	if (rc < 0 && rc != -EINVAL) {
> +		dev_err(&ctlr->dev,
> +			"failed to read spi-tx-bus-width property: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (rc == -EINVAL) {
> +		/* Default when property is not present. */
> +		spi->num_tx_lanes = 1;
> +	} else {
> +		u32 first_value;
> +
> +		spi->num_tx_lanes = rc;
> +
> +		for (idx = 0; idx < spi->num_tx_lanes; idx++) {
> +			of_property_read_u32_index(nc, "spi-tx-bus-width", idx,
> +						   &value);

Probably want a sanity check on return value of that even though we are fairly sure
it won't fail.

> +
> +			/*
> +			 * For now, we only support all lanes having the same
> +			 * width so we can keep using the existing mode flags.
> +			 */
> +			if (!idx)
> +				first_value = value;
> +			else if (first_value != value) {
> +				dev_err(&ctlr->dev,
> +					"spi-tx-bus-width has inconsistent values: first %d vs later %d\n",
> +					first_value, value);
> +				return -EINVAL;
> +			}
> +		}


