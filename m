Return-Path: <linux-iio+bounces-26241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62171C609C2
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7D4E35CB6E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51592FFF87;
	Sat, 15 Nov 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGeCTzav"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2A21C9FD;
	Sat, 15 Nov 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763229850; cv=none; b=WiO5fEsTyCSU/J4P9eoTPRlIwb1EBW6BpgJaWtqaVPPPkDp8qQmlvLqGIE2EGP/riy86V3bpEomG88cHuXVnngyB//ONnvg12cVABfTi+sAxjLtMwM97m0ZPDMMzbkjz2wKJaeY/r8EOHb4WTOeMIcjiEshp8aQcH+ovtppfyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763229850; c=relaxed/simple;
	bh=Kyr+IiTySTxukBJcJ4D0IzjYF11Q0iPx1Eu2Rf10J58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1CDSCLzgztNVszyh7UwhVrLaDf5kZuPPCPrVyDMAOZHcxj6xkC4VdTWQZ5r/0rHfQXhrlNNvYM0qHb2lYfZ+ngjUtbSNmBS5CNJsWZwvJJ3uhgFrQZ/b/yq1j2eeoVmTjHT760iCa3283Lp7xhbkcmN8B44Bczr12gefaLL/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGeCTzav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9E7C116D0;
	Sat, 15 Nov 2025 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763229848;
	bh=Kyr+IiTySTxukBJcJ4D0IzjYF11Q0iPx1Eu2Rf10J58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGeCTzav3IACPtIGKaCH3qCGTU3ZtdTXQPvwe9xxyVayS42vYX1zNcueS5u5TV5z6
	 13HP1OR2b+m5VeBDAzdRu6T4/nep/CwQHoD2be3AU1uU3ksHJEOyX0rFXUXA4/ZW8k
	 FgI1SQ+X/wa0MQtRLoXp9o5ZeNFQQPAtZW2jKyCaP372uSawuxU3CUH++gUUsb0CPm
	 13AMylVWBtd9VDTOXVZTFayovKqypzTEWHCt2P0h2li9ncGAS5ud3qfRTN+iowyPfO
	 OLFMQ6ChUbHMb7GW3BMkH1FEveu6S1v6ZfYnJn3gwFhUh8QZyU0f/MfTxgdXku1OAq
	 0rCuq4dngvV0A==
Date: Sat, 15 Nov 2025 18:04:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Jander <david@protonic.nl>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <20251115180402.13820576@jic23-huawei>
In-Reply-To: <20251114092000.4058978-3-o.rempel@pengutronix.de>
References: <20251114092000.4058978-1-o.rempel@pengutronix.de>
	<20251114092000.4058978-3-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 10:20:00 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> From: David Jander <david@protonic.nl>
> 
> Add a new IIO ADC driver for Texas Instruments ADS131M0x devices
> (ADS131M02/03/04/06/08). These are 24-bit, up to 64 kSPS, simultaneous-
> sampling delta-sigma ADCs accessed via SPI.
> 
> Highlights:
> - Supports 2/3/4/6/8-channel variants with per-channel RAW and SCALE.
> - Implements device-required full-duplex fixed-frame transfers.
> - Handles both input and output CRC
> 
> Note: Despite the almost identical name, this hardware is not
> compatible with the ADS131E0x series handled by
> drivers/iio/adc/ti-ads131e08.c.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Hi.

A few additional comments from me - might well be some duplication
with those from other reviewers (though I didn't comment on anything I remembered
others having covered!).

Jonathan


> diff --git a/drivers/iio/adc/ti-ads131m02.c b/drivers/iio/adc/ti-ads131m02.c
> new file mode 100644
> index 000000000000..fdd3bc536cb3
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads131m02.c

> +
> +/**
> + * ads131m_verify_output_crc - Verifies the CRC of the received SPI frame.
> + * @priv: Device private data structure.
> + *
> + * This function calculates the CRC-16-CCITT (Poly 0x1021, Seed 0xFFFF) over
> + * the received response and channel data, and compares it to the CRC word
> + * received at the end of the SPI frame.
> + *
> + * Return: 0 on success, -EIO on CRC mismatch.
> + */
> +static int ads131m_verify_output_crc(struct ads131m_priv *priv)
> +{
> +	struct iio_dev *indio_dev = priv->indio_dev;
> +	struct device *dev = &priv->spi->dev;
> +	u16 calculated_crc;
> +	u16 received_crc;

Might as well share a line for those two.

> +	size_t data_len;
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	/*
> +	 * Frame: [Response][Chan 0]...[Chan N-1][CRC Word]
> +	 * Data for CRC: [Response][Chan 0]...[Chan N-1]
> +	 * Data length = (N_channels + 1) * 3 bytes (at 24-bit word size)
> +	 */
> +	data_len = ADS131M_FRAME_BYTES(indio_dev->num_channels) - 3;
> +	calculated_crc = ads131m_crc_calculate(priv->rx_buffer, data_len);
> +
> +	/*
> +	 * The received 16-bit CRC is MSB-aligned in the last 24-bit word.
> +	 * We extract it from the first 2 bytes (BE) of that word.
> +	 */
> +	received_crc = get_unaligned_be16(&priv->rx_buffer[data_len]);
> +	if (calculated_crc != received_crc) {
> +		dev_err_ratelimited(dev, "Output CRC error. Got %04x, expected %04x\n",
> +				    received_crc, calculated_crc);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ads131m_adc_read - Reads channel data, checks input and output CRCs.
> + * @priv: Device private data structure.
> + * @channel: The channel number to read.
> + * @val: Pointer to store the raw 24-bit value.
> + *
> + * This function sends a NULL command (with Input CRC) to retrieve data.
> + * It checks the received STATUS word for any Input CRC errors from the
> + * previous command, and then verifies the Output CRC of the current
> + * data frame.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_adc_read(struct ads131m_priv *priv, u8 channel, s32 *val)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	u16 status;
> +	int ret;
> +	u8 *buf;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	/* Send NULL command + Input CRC, and receive data frame */
> +	ret = ads131m_rx_frame_unlocked(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Check STATUS word (Word 0) for an Input CRC Error from the
> +	 * previous SPI frame.

Wrap closer to 80 chars. previous fits on the previous line.
However I'm not sure the comment helps much given the well named
define makes it pretty obvious what is going on.

> +	 */
> +	status = get_unaligned_be16(&priv->rx_buffer[0]);
> +	if (status & ADS131M_STATUS_CRC_ERR) {
> +		dev_err_ratelimited(dev, "Previous input CRC Error reported in STATUS (0x%04x)\n",
> +				    status);
> +	}
> +
> +	/*
> +	 * Validate the output CRC on the current data frame to ensure
> +	 * data integrity.
> +	 */

This is another comment that feels like more info than we need give
the name of the function conveys it very well.

> +	ret = ads131m_verify_output_crc(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf = &priv->rx_buffer[ADS131M_CHANNEL_INDEX(channel)];
> +	*val = sign_extend32(get_unaligned_be24(buf), 23);
> +
> +	return 0;
> +}
> +
> +static int ads131m_read_scale(struct ads131m_priv *priv, int *val, int *val2)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	int vref_uV;
> +	int ret;
> +
> +	/* This driver assumes default PGA gain of 1 */
> +	if (IS_ERR_OR_NULL(priv->refin_supply)) {
> +		/*
> +		 * Internal 1.2V reference.
> +		 * Scale = 1200mV / 2^23
> +		 */
> +		*val = ADS131M_VREF_INTERNAL_mV;
> +		*val2 = ADS131M_RESOLUTION_BITS - 1;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	ret = regulator_get_voltage(priv->refin_supply);

Do you have a usecase for runtime changes in reference input voltage?
Generally we've gone away from doing this in drivers because it is much
easier to just query it at a boot.  These things are almost always
fed from fixed precision references or a other fixed regulators.

Back in my idealistic youth I thought we should support this flexibility
but in reality it was never used and added code complexity.

> +	if (ret < 0) {
> +		dev_err_ratelimited(dev, "failed to get refin voltage: %pe\n",
> +				    ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	vref_uV = ret;
> +
> +	/*
> +	 * External reference.
> +	 * Scale(mV) = (vref_uV * 0.96) / (1000 * 2^(CODE_BITS))
> +	 */
> +	*val = div_s64((s64)vref_uV * ADS131M_EXTREF_SCALE_NUM, 1000);
> +	*val2 = ADS131M_EXTREF_SCALE_DEN * BIT(ADS131M_CODE_BITS);
> +
> +	return IIO_VAL_FRACTIONAL;
> +}

> +
> +#define ADS131M_VOLTAGE_CHANNEL(num)	\
> +	{ \
> +		.type = IIO_VOLTAGE, \
> +		.indexed = 1, \
> +		.channel = (num), \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_SCALE), \
Why per channel scales given that code doesn't get passed anything about
the channel being queried so must be a single value for all channels.
I'd expect that to be in info_mask_shared_by_type probably.

If you expect to add per channel scaling as part of some extra feature
then maybe it's fine to have it separate here, but I'd expect a comment on why.

> +	}


> +/*
> + * This is a local helper to be passed to devm_add_action_or_reset.
> + * It mimics the non-exported regulator_action_disable() from devres.c.
Probably overkill to describe this.  Easy to see where it is used.

> + */
> +static void ads131m_regulator_disable_action(void *data)
> +{
> +	struct regulator *regulator = data;
> +
> +	regulator_disable(regulator);

	regulator_disable(data);
is fine here given it's pretty obvious we are treating data as
a regulator pointer from how it's used so the local variable
isn't adding much value.

> +}
> +
> +/**
> + * ads131m_power_init - Get and enable regulators.
> + * @priv: Device private data structure.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_power_init(struct ads131m_priv *priv)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	static const char * const supply_ids[] = { "avdd", "dvdd" };
> +	int ret;
> +
> +	/* Get and enable the mandatory supplies */
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supply_ids), supply_ids);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to enable regulators\n");
> +
> +	/* If the model doesn't support extref, we're done. */
> +	if (!priv->config->supports_extref)
> +		return 0;
> +
> +	/*
> +	 * Get the optional external reference. This schedules regulator_put()
> +	 * automatically.

I'd drop the last bit.  No need to explain what devm_ does

> +	 */
> +	priv->refin_supply = devm_regulator_get_optional(dev, "refin");
> +	ret = PTR_ERR_OR_ZERO(priv->refin_supply);
> +	if (ret == -ENODEV)
> +		priv->refin_supply = NULL;
> +	else if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get refin regulator\n");
> +
> +	/* If the regulator was not found, we're done. */
> +	if (!priv->refin_supply)
> +		return 0;
> +
> +	/*
> +	 * We need to store the regulator pointer for scaling, but
> +	 * devm_regulator_get_enable_optional() doesn't return it.
> +	 * We must use devm_regulator_get_optional(), manually enable,
> +	 * and schedule the disable action.
> +	 */

Whilst all true, I'd not bother stating it.  The use of storage
in priv is enough to make people go look if they are wondering
why this is done.

> +	ret = regulator_enable(priv->refin_supply);
> +	if (ret) {
> +		/*
> +		 * Enable failed. devm_regulator_put() is already scheduled,
> +		 * so we just return the error.

I think this is also too much as fairly standard code flow and you
are talking about what the calls you are making do internally
rather than stuff that is particularly specific to this call.

> +		 */
> +		return dev_err_probe(dev, ret, "failed to enable refin regulator\n");
> +	}
> +
> +	/*
> +	 * Schedule our local ads131m_regulator_disable_action() helper
> +	 * to be called on driver unload.
> +	 */

This one is definitely overkill.  No need for any comment here.

> +	return devm_add_action_or_reset(dev, ads131m_regulator_disable_action,
> +					priv->refin_supply);
> +}
> +
> +/**
> + * ads131m_hw_init - Initialize the ADC hardware.
> + * @priv: Device private data structure.
> + * @is_xtal: True if 'clock-names' is "xtal", false if "clkin".
> + *
> + * This function performs the hardware-specific initialization sequence:
> + * - Issues a software RESET command to clear FIFOs and defaults.
> + * - Configures the MODE register to clear RESET, set CCITT CRC,
> + * and enable Input CRC checking.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_hw_init(struct ads131m_priv *priv, bool is_xtal)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	u16 mode_clear, mode_set;
> +	int ret;
> +
> +	/*
> +	 * Issue a software RESET to ensure device is in a known state.
> +	 * This clears the 2-deep FIFO and resets all registers to default.
> +	 */
> +	ret = ads131m_reset(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Configure CLOCK register (0x03) based on DT properties.
> +	 * This register only needs configuration for 32-pin (M06/M08)
> +	 * variants, as the configurable bits (XTAL_DIS, EXTREF_EN)
> +	 * are reserved on 20-pin (M02/M03/M04) variants.
> +	 */
> +	if (priv->config->supports_xtal || priv->config->supports_extref) {
> +		u16 clk_set = 0;
> +
> +		if (priv->config->supports_xtal && !is_xtal)
> +			clk_set |= ADS131M_CLOCK_XTAL_DIS;
> +
> +		if (priv->config->supports_extref && priv->refin_supply)
> +			clk_set |= ADS131M_CLOCK_EXTREF_EN;
> +
> +		ret = ads131m_rmw_reg(priv, ADS131M_REG_CLOCK,
> +				      ADS131M_CLOCK_EXTREF_EN | ADS131M_CLOCK_XTAL_DIS, clk_set);

Whilst we are a bit flexible around line lengths, preference is to go longer
than 80 chars only when it really helps readability.  This would be fine

		ret = ads131m_rmw_reg(priv, ADS131M_REG_CLOCK,
				      ADS131M_CLOCK_EXTREF_EN | ADS131M_CLOCK_XTAL_DIS,
				      clk_set);

> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to configure CLOCK register\n");
and this as
			return dev_err_probe(dev, ret,
					     "Failed to configure CLOCK register\n");

> +	}
> +
> +	/*
> +	 * The RESET command sets all registers to default, which means:
> +	 * 1. The RESET bit (Bit 10) in MODE is set to '1'.
> +	 * 2. The CRC_TYPE bit (Bit 11) in MODE is '0' (CCITT).
> +	 * 3. The RX_CRC_EN bit (Bit 12) in MODE is '0' (Disabled).
> +	 *
> +	 * We must:
> +	 * 1. Clear the RESET bit.
> +	 * 2. Enable Input CRC (RX_CRC_EN).
> +	 * 3. Explicitly clear the ANSI CRC bit (for certainty).
> +	 */
> +	mode_clear = ADS131M_MODE_CRC_TYPE_ANSI | ADS131M_MODE_RESET_FLAG;
> +	mode_set = ADS131M_MODE_RX_CRC_EN;
> +
> +	ret = ads131m_rmw_reg(priv, ADS131M_REG_MODE, mode_clear, mode_set);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to configure MODE register\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * ads131m_parse_clock - enable clock and detect "xtal" selection
> + * @priv: Device private data structure.
> + * @is_xtal: result flag (true if "xtal", false if default "clkin")
> + *
> + * Return: 0 on success, negative errno on real error.
> + */
> +static int ads131m_parse_clock(struct ads131m_priv *priv, bool *is_xtal)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	int ret;
> +
> +	priv->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "clk get enabled failed\n");
> +
> +	ret = device_property_match_string(dev, "clock-names", "xtal");
> +	if (ret == 0) {
> +		if (!priv->config->supports_xtal)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "'xtal' clock not supported on this device");
> +		*is_xtal = true;
> +
> +		return 0;

Already returned. No need for else after this.  The comment in another review
about handling error paths first is definitely my preference.

> +	} else if (ret > 0) {
> +		return dev_err_probe(dev, -EINVAL, "'xtal' must be the only or first clock name");

Definitely wrap this line. 

> +	} else if (ret == -ENODATA) {
> +		*is_xtal = false;
> +
> +		return 0;
> +	}
> +
> +	return dev_err_probe(dev, ret, "failed to read 'clock-names' property");
> +}


