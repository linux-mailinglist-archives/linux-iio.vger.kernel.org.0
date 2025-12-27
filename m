Return-Path: <linux-iio+bounces-27379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49903CE003A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0604F3021E6A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7831A577;
	Sat, 27 Dec 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cno6JRCK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D992BAF7;
	Sat, 27 Dec 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855942; cv=none; b=MhMP5hbO7U7VmsMibyRyxsj4aU9uDK20xvivBhWgEpF/SAZZn+NhKPhDpdVm8dMVNJTHlYTHs6u53I/kes0XqkQ2b5OUDWlf9Sh361pyHPEgBeM/dnZRlheG43PJiXReuzTIUskKpKdXg9UKR+6ymyIWus1zLD8GwcsPX9IzNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855942; c=relaxed/simple;
	bh=GTK0czgPMgvbKrEcKKKWzCPyOf2LeVnHgV2YChJ0Ysk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IybdlNGoSzljEKHn7CoNWx1PjjjUsqnvN8nh3ToxdrGDdCeW4XxmRdel+0TpWbhlvLXO+EOVMt3sk0hJw1yOuKKRP7ND3Ss2+rvQCEyGrEb9cc/5wrPzuwORm1jPtPLqFkXaSC3htXOnNHm7R7VzlyzU24IN/+QBVOPWZIlmsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cno6JRCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A90C4CEF1;
	Sat, 27 Dec 2025 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766855941;
	bh=GTK0czgPMgvbKrEcKKKWzCPyOf2LeVnHgV2YChJ0Ysk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cno6JRCKW8Jz8W0YqlNyEpZ+uvi+f8B4xH/PwHeNV9t5k6wVUZgoOQK2iHJOGW+ef
	 ey5mihGUPaBG20tkJ7NA8hqL/L1nUK9Cdco5eMNHDTF+ulUVAMyqR4S2FIoKQxiscf
	 Zx1fu0XwNheZTC9f6hF1YHxlLQJuk1zT1xmxbts6lyVx4DImP71XQ677m5DdxDfwTd
	 d494tj7YxAPU5g83prKa0rDX7uBnPHMGOOAUsNWVQafXB4JUuJX7qXbXZv4VXPQPhU
	 vmPwvtrLZOtpKjXBrfJpvy6yIvjQU6prqCLJ2nUWjASUI4/sJqHn4uhzQgVOmit04G
	 MMM/XakhLh8FA==
Date: Sat, 27 Dec 2025 17:18:50 +0000
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
Subject: Re: [PATCH v4 3/9] spi: support controllers with multiple data
 lanes
Message-ID: <20251227171850.0c93c1c9@jic23-huawei>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-3-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
	<20251219-spi-add-multi-bus-support-v4-3-145dc5204cd8@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 15:32:11 -0600
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
>  drivers/spi/spi.c       | 114 +++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/spi/spi.h |  22 ++++++++++
>  2 files changed, 134 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e25df9990f82..9caa22583b8f 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2370,7 +2370,52 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		spi->mode |= SPI_CS_HIGH;
>  
>  	/* Device DUAL/QUAD mode */
> -	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
> +
> +	rc = of_property_read_u32_array(nc, "spi-tx-lane-map", spi->tx_lane_map,
> +					ARRAY_SIZE(spi->tx_lane_map));

Why must there always be a fixed number of these?  Isn't it meant to be
one per lane in use? Or at least to me that seems reasonable assumption?
Maybe use of_property_read_variable_u32_array() which takes min and max sizes
and returns (on success) how many were there.



> +	if (rc == -EINVAL) {
> +		/* Default lane map */
> +		for (idx = 0; idx < ARRAY_SIZE(spi->tx_lane_map); idx++)
> +			spi->tx_lane_map[idx] = idx;

Having this fixed in size is fine even if we only use first few elements.

> +	} else if (rc < 0) {
> +		dev_err(&ctlr->dev,
> +			"failed to read spi-tx-lane-map property: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = of_property_count_u32_elems(nc, "spi-tx-bus-width");
> +	if (rc < 0 && rc != -EINVAL) {
> +		dev_err(&ctlr->dev,

...

> @@ -2394,7 +2439,61 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		}
>  	}
>  
> -	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
> +	for (idx = 0; idx < spi->num_tx_lanes; idx++) {
> +		if (spi->tx_lane_map[idx] >= spi->controller->num_data_lanes) {
> +			dev_err(&ctlr->dev,
> +				"spi-tx-lane-map has invalid value %d (num_data_lanes=%d)\n",
> +				spi->tx_lane_map[idx],
> +				spi->controller->num_data_lanes);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	rc = of_property_read_u32_array(nc, "spi-rx-lane-map", spi->rx_lane_map,
> +					ARRAY_SIZE(spi->rx_lane_map));

Similar to above. Not obvious to me why this is fixed size read.


> +	if (rc == -EINVAL) {
> +		/* Default lane map */
> +		for (idx = 0; idx < ARRAY_SIZE(spi->rx_lane_map); idx++)
> +			spi->rx_lane_map[idx] = idx;
...
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cb2c2df31089..7aff60ab257e 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
...

> +/* Max no. of data lanes supported per spi device */

