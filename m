Return-Path: <linux-iio+bounces-8391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E394DBFA
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 11:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B8B1C205E1
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7315217F;
	Sat, 10 Aug 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZhs+gzi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0793D43ACB;
	Sat, 10 Aug 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282548; cv=none; b=CBGyy0kfpJ9MdeSpXDF5/ODoUqLB47BmoOsa5z430VGULgmiV7YA0bgSwnccKr+5xmqR9eIS/cp7BfPb2hAQ4WE5p1XRCGL77HqWKfwvRakyBD47BLRA8sYmOGmT8AKO6ywJEVn7xSw8u8KqKpPpcDGABqC9E4tHfpGCFLoYR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282548; c=relaxed/simple;
	bh=LJKrvdisHKRPIlJ/9MEfbKehx7YGUJSAL0PubB2SuJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoD3UHAHgIO5PFK/tMhR5NHwV0Noy2dX75AQH895Y8tx2lShvPdYqiR/y1uetbVVDGa70oJee+Crc2YtkfN7aXV6G3EbLsqWGXo6km/1lFEjjLEeRF/X8iV/IN3fkONzEmZ6nT32DhUry+rFG6MhDZicrdCb0trwOD4iy8bIRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZhs+gzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A59CC32781;
	Sat, 10 Aug 2024 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723282547;
	bh=LJKrvdisHKRPIlJ/9MEfbKehx7YGUJSAL0PubB2SuJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DZhs+gziSdBTD429Nkpi7QU0R2jGBXFykapqzDi9/xGJWHQuUr1ChZYOusM//Bd7i
	 gpo32ByxOaS7JzPtwUbofiXFN/ZEbBCUfyVNinqKTLZSesD444QoXFo9pVRiirSlnI
	 1UHKa3Ri+ncKUdhhiZ2A4JnQZXxK7Lr9rThoB/T3sroRgkaeEyuJeQmigmOtgAks7c
	 eFuRO6VEOQhhJ2Tsl+ub9k98nDDva6nJOKbAXTxEuPLsCp1GQbRF1WnuWvbZSCZBCe
	 3v5Smy0lJv2+9IWcqE4VptY9xZSgMCdJLaKIEa/WOSJNRsAe39LWhYUZ/nFLcOQqx9
	 /ELuft4yrFBbw==
Date: Sat, 10 Aug 2024 10:35:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
Message-ID: <20240810103540.03e758a5@jic23-huawei>
In-Reply-To: <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
References: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
	<20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 15:02:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This implements buffered reads for the ad4695 driver using the typical
> triggered buffer implementation, including adding a soft timestamp
> channel.
> 
> The chip has 4 different modes for doing conversions. The driver is
> using the advanced sequencer mode since that is the only mode that
> allows individual configuration of all aspects each channel (e.g.
> bipolar config currently and oversampling to be added in the future).
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Main thing in here is I think you can use available_scan_masks
to avoid the need for the error path on just the temperature channel
being enabled.

Jonathan

> +/**
> + * ad4695_enter_advanced_sequencer_mode - Put the ADC in advanced sequencer mode
> + * @st: The driver state
> + * @n: The number of slots to use - must be >= 2, <= 128
> + *
> + * As per the datasheet, to enable advanced sequencer, we need to set
> + * STD_SEQ_EN=0, NUM_SLOTS_AS=n-1 and CYC_CTRL=0 (Table 15). Setting SPI_MODE=1
> + * triggers the first conversion using the channel in AS_SLOT0.
> + *
> + * Return: 0 on success, a negative error code on failure
> + */
> +static int ad4695_enter_advanced_sequencer_mode(struct ad4695_state *st, u32 n)
> +{
> +	u32 mask, val;
> +	int ret;
> +
> +	mask = AD4695_REG_SEQ_CTRL_STD_SEQ_EN;
> +	val = FIELD_PREP(AD4695_REG_SEQ_CTRL_STD_SEQ_EN, 0);
> +
> +	mask |= AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS;
> +	val |= FIELD_PREP(AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS, n - 1);
> +
> +	ret = regmap_update_bits(st->regmap, AD4695_REG_SEQ_CTRL, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	mask = AD4695_REG_SETUP_SPI_MODE;
> +	val = FIELD_PREP(AD4695_REG_SETUP_SPI_MODE, 1);
> +
> +	mask |= AD4695_REG_SETUP_SPI_CYC_CTRL;
> +	val |= FIELD_PREP(AD4695_REG_SETUP_SPI_CYC_CTRL, 0);

I'd just combine the two parts of mask and val.  If it were a long
complex list then fair enough to keep them as individual parts, but
not needed for 2 items.

> +
> +	return regmap_update_bits(st->regmap, AD4695_REG_SETUP, mask, val);
> +}
> +
> +/**
> + * ad4695_exit_conversion_mode - Exit conversion mode
> + * @st: The AD4695 state
> + *
> + * Sends SPI command to exit conversion mode.
> + *
> + * Return: 0 on success, a negative error code on failure
> + */
> +static int ad4695_exit_conversion_mode(struct ad4695_state *st)
> +{
> +	struct spi_transfer xfer = { };
	struct spi_transfer xfer = {
		.tx_buf = &st->cnv_cmd2,
		.len = 1,
		.delay.value ...

	};

Might as well fill it in from the start.
Doesn't matter that the data is filled in just after this even if
that doesn't feel quite right, the code is so close I don't think
it will confuse readers and it's a common pattern.

> +
> +	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
> +	xfer.tx_buf = &st->cnv_cmd2;
> +	xfer.len = 1;
> +	xfer.delay.value = AD4695_T_REGCONFIG_NS;
> +	xfer.delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}
> +
>  static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)
>  {
>  	u8 val;
> @@ -296,6 +371,147 @@ static int ad4695_write_chn_cfg(struct ad4695_state *st,
>  				  mask, val);
>  }
>  
> +static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4695_state *st = iio_priv(indio_dev);
> +	struct spi_transfer *xfer;
> +	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
> +	bool temp_chan_en = false;
> +	u32 reg, mask, val, bit, num_xfer, num_slots;
> +	int ret;
> +
> +	/*
> +	 * We are using the advanced sequencer since it is the only way to read
> +	 * multiple channels that allows individual configuration of each
> +	 * voltage input channel. Slot 0 in the advanced sequencer is used to
> +	 * account for the gap between trigger polls - we don't read data from
> +	 * this slot. Each enabled voltage channel is assigned a slot starting
> +	 * with slot 1.
> +	 */
> +	num_slots = 1;
> +
> +	memset(st->buf_read_xfer, 0, sizeof(st->buf_read_xfer));
> +
> +	/* First xfer is only to trigger conversion of slot 1, so no rx. */
> +	xfer = &st->buf_read_xfer[0];
> +	xfer->cs_change = 1;
> +	xfer->delay.value = AD4695_T_CNVL_NS;
> +	xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
> +	xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
> +	xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +	num_xfer = 1;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		xfer = &st->buf_read_xfer[num_xfer];
> +		xfer->bits_per_word = 16;
> +		xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
> +		xfer->len = 2;
> +		xfer->cs_change = 1;
> +		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
> +		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +		if (bit == temp_chan_bit) {
> +			temp_chan_en = true;
> +		} else {
> +			reg = AD4695_REG_AS_SLOT(num_slots);
> +			val = FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit);
> +
> +			ret = regmap_write(st->regmap, reg, val);
> +			if (ret)
> +				return ret;
> +
> +			num_slots++;
> +		}
> +
> +		num_xfer++;
> +	}
> +
> +	/*
> +	 * Don't keep CS asserted after last xfer. Also triggers conversion of
> +	 * slot 0.
> +	 */
> +	xfer->cs_change = 0;
> +
> +	/**
> +	 * The advanced sequencer requires that at least 2 slots are enabled.
> +	 * Since slot 0 is always used for other purposes, we need only 1
> +	 * enabled voltage channel to meet this requirement. This error will
> +	 * only happen if only the temperature channel is enabled.
> +	 */
> +	if (num_slots < 2) {

Can you use available_scanmasks to let the IIO core figure out it needs
to enable (and then hide) an extra channel?

Either that or spin up a channel to meet the requirement, just don't
capture it - Given this is an unlikely case, better to leave it to the
IIO core buffer demux handling than to bother handling locally.


> +		dev_err_ratelimited(&indio_dev->dev,
> +			"Buffered read requires at least 1 voltage channel enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Temperature channel isn't included in the sequence, but rather
> +	 * controlled by setting a bit in the TEMP_CTRL register.
> +	 */
> +
> +	reg = AD4695_REG_TEMP_CTRL;
> +	mask = AD4695_REG_TEMP_CTRL_TEMP_EN;
> +	val = FIELD_PREP(mask, temp_chan_en ? 1 : 0);
This is the line the bot didn't like. The local variables reg and
mask don't add anything anyway, so get rid of them and use the
values inline.

> +
> +	ret = regmap_update_bits(st->regmap, reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	spi_message_init_with_transfers(&st->buf_read_msg, st->buf_read_xfer,
> +					num_xfer);
> +
> +	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
> +	if (ret)
> +		return ret;
> +
> +	/* This triggers conversion of slot 0. */
> +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
> +	if (ret) {
> +		spi_unoptimize_message(&st->buf_read_msg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}


