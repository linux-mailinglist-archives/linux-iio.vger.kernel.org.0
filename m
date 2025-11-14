Return-Path: <linux-iio+bounces-26228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550EEC5EC60
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578603A25F1
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 18:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF52D6604;
	Fri, 14 Nov 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uGkeZ4Nf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B632D372E
	for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143374; cv=none; b=Yqv7tVPYHxd1IXHX3L3vTclOgWIjk6euewH7zG0AKKTeBpJhi6mQlay3+xeClLNN5iL3Q2uAWw/0XvSyN0o2dppIfbyguDmOqTV1Ev54NxtwEhNqCGEXONt686UZckijKRXNsP6u8e5N1VEKf8y/C1Jkzfl9GDGGfVUb2OAZRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143374; c=relaxed/simple;
	bh=J63Lz8V1/LNhcHMlxueAA2ZbOWV0xIkeyywaV7cN/6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQnMQKOwA/kT/vr7rNvPzccVqZj1BrACWirdd3W6fwpR1h1AuK5mBsLem4J/h0F7w3pBUcKSHR65w5akqhgLAkUnJtkatkUcfxwA3W24DtCC0ogHa3Q6djaC4KJFVMXTzVXLKqOYV7cMjrVvxZ07YFvbMMUXAWZFsnZjlW8e8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uGkeZ4Nf; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c28ff7a42eso834163a34.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763143371; x=1763748171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TT18A5UjUONyKSzh9y+sG6jAJxSt69SLNOoB+xza7p8=;
        b=uGkeZ4NfRf55xsnYqsL7b8/pjLU+XcRyz5M+k20AnzhqKQby8Rz8mSK2FbypSbSpUP
         f01mTGxSKfoo2k6BTRJ/fbevHu5e8mwS6HiyFNK5YLHfvWTs30ba1dcIxIPxfWrTBaOD
         Ewhk84ornjVU9yBkBAhom8KYSBMg8Lm8zCxa+q6kmbABYFDduRExJ1X+h96KMJlS7f+W
         y/JusWzjPmof3dfQGJx4FlKI/z6ApBotTDGYFAL1p7MdgPdHAbCu+dnNmWQiFogjRm8+
         qJMoACWFOWyDxrxTIxlzUWAGoAaoOneF2cxtjc4nGaxsqnsWufwt0iFGO1EJ2oGKs1b6
         T4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143371; x=1763748171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT18A5UjUONyKSzh9y+sG6jAJxSt69SLNOoB+xza7p8=;
        b=vseBlLxnyTMrPpLKspyG+n1NtEHYUoimSHpasfqy4smZhkMUUIg/kI0TKu5KbVvJtv
         ylhVleXGb52iqIKZq7KQXG7kmd7VTuA1Eu+nN5C0q7WhK+DM6e+xA/13Awxfx5qmpLT4
         dyJgGWhizjDgx5z2k+Tyk6ngkqpgyUHgZjKbMeVxREyIT62uKcmxgRqymSP0utZPR5gq
         SEiDuik960OaFlK8m3+7elGHBM0hJ2TryjasGHfFfJZDmInG7GZTO/u/aIxfiKxh3/y3
         J+1FAfYbZMRnTtdYCoSRNOP93sb/nhaYfRvLkbAhYmxbM78utwoTp7VWJDp2f/o4r9FD
         8hjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6djJpWKAylwspOyoBJ6li1X6nGsVWFaJ6/PFLy+xXTo8vLMPuTMoAHXnRietSHFAEpUstXApFXL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGR30mDAEPB9JsvufFN0WFZKEM3UvTfwuoIXO6jS0IRRTT2nuf
	P16iV39mI53BTtTR8SiX0CDym3AH0rJ3H+RCSWG9l/6oRcR4vs4/pmQMdtrioNE9x9Y=
X-Gm-Gg: ASbGncs/YLx5KC9rtQjcWX8Am9Vq9zLaLoMzJpBjCCEI8IRFP+5YqopbbOg3oveWhBy
	oKu6XjRyNzkQMhgMDHmW7f1q/V+wGUbBEV7S/RvTBzmo0d6jh/o6X0Wc0X5mSYBwMzTiSMaY+5R
	AU0sj3xQaS64+8Q60+GwZczRYVFuqCJBPz36mJ+ffGtcuwNvIbpSMqBaSVMTaQWkOZAhhFbcfPV
	wlwkyt0imouVQoDyIlVpHS3JwSmQ5XRNtdJFhZAhvX2tG9y+kAoVHqs3wgL3Gt4EtkykpxotzTr
	LMGw0V5LUJ4AX1jj7sS8ridMiOqQo0Kb9Y+19egBZ9+Eu19LyDyCvsRHAEaz/jX8wRC3abJVx2x
	Ol1Sm8l88OTE1bz3bpIKDuE8eMEyNBcFJRxooFXgQsnjelgO9sdMR7uOOUdxrghI6YjmxnxVMR9
	37GCAqtL3LnbOyefRdNSL44ht9mBIduJhivlL9nlyyof+3ebi6UtnnEdqzSA==
X-Google-Smtp-Source: AGHT+IHWzyamDp9VZwzJ4yeEVNsE1Cm+88m1UEAFij0EOMFZSTnZSxjGgXMvpplyXnRyoc6NL995sQ==
X-Received: by 2002:a05:6830:40c4:b0:7ab:e111:1a57 with SMTP id 46e09a7af769-7c74455634emr3066225a34.31.1763143370516;
        Fri, 14 Nov 2025 10:02:50 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8a43:8337:f820:b43? ([2600:8803:e7e4:500:8a43:8337:f820:b43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a392f65sm2795917a34.17.2025.11.14.10.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 10:02:49 -0800 (PST)
Message-ID: <c332b8eb-b4a5-48b2-a7ac-8211f3007058@baylibre.com>
Date: Fri, 14 Nov 2025 12:02:46 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS131M0x ADC driver
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: David Jander <david@protonic.nl>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20251114092000.4058978-1-o.rempel@pengutronix.de>
 <20251114092000.4058978-3-o.rempel@pengutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251114092000.4058978-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 3:20 AM, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Add a new IIO ADC driver for Texas Instruments ADS131M0x devices
> (ADS131M02/03/04/06/08). These are 24-bit, up to 64 kSPS, simultaneous-
> sampling delta-sigma ADCs accessed via SPI.
> 

...

> +struct ads131m_priv {
> +	struct iio_dev *indio_dev;
> +	struct spi_device *spi;
> +	struct clk *clk;

clk isn't used outside of probe, so can be removed from this struct
and turned into a local variable in the relavent function.

> +	const struct ads131m_configuration *config;
> +	struct gpio_desc *reset_gpio;
> +
> +	struct regulator *refin_supply;
> +
> +	struct spi_transfer xfer;
> +	struct spi_message msg;
> +
> +	/*
> +	 * Protects the shared tx_buffer and rx_buffer. More importantly,
> +	 * this serializes all SPI communication to ensure the atomicity
> +	 * of multi-cycle command sequences (like WREG, RREG, or RESET).
> +	 */
> +	struct mutex lock;
> +
> +	/*
> +	 * DMA-safe buffers are placed at the end of the struct.
> +	 * This prevents the compiler from inserting large, wasteful
> +	 * padding blocks between non-aligned fields.
> +	 *
> +	 * Both buffers require alignment, as the size of tx_buffer (30 bytes)
> +	 * is not a multiple of typical DMA alignment values.
> +	 */
> +	u8 tx_buffer[ADS131M_FRAME_BYTES(ADS131M_MAX_CHANNELS)]
> +		__aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buffer[ADS131M_FRAME_BYTES(ADS131M_MAX_CHANNELS)]
> +		__aligned(IIO_DMA_MINALIGN);

Drop this 2nd __aligned(IIO_DMA_MINALIGN). It isn't needed.

> +};
> +
> +/**
> + * ads131m_crc_calculate - CRC-16 for ADS131M SPI frames (CCITT, MSB-first)
> + * @buffer: data buffer
> + * @len:    buffer length in bytes
> + *
> + * ADS131M0x devices require CRC-16-CCITT with polynomial 0x1021,
> + * MSB-first (non-reflected) processing, and initial value 0xFFFF.
> + *
> + * The kernel helper crc_itu_t() implements this CCITT variant.
> + * Do not use crc_ccitt(), which is the reflected (LSB-first) variant and
> + * yields different results for the same input.
> + *
> + * Return: 16-bit CRC over @buffer.
> + */
> +static u16 ads131m_crc_calculate(const u8 *buffer, size_t len)
> +{
> +	return crc_itu_t(0xffff, buffer, len);

I would just call crc_itu_t() directly and avoid the wrapper.

> +}
> +

...

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
> +	ret = ads131m_verify_output_crc(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf = &priv->rx_buffer[ADS131M_CHANNEL_INDEX(channel)];
> +	*val = sign_extend32(get_unaligned_be24(buf), 23);

Use ADS131M_CODE_BITS instead of 23?

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

Why not ADS131M_CODE_BITS here since we have that macro?

(Although my personal prefence would be to drop the ADS131M_CODE_BITS macro
and just use ADS131M_RESOLUTION_BITS - 1 where appropriate since that is the
more common pattern in IIO.)

> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	ret = regulator_get_voltage(priv->refin_supply);
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

This could be simplified by doing the math to compute the numerator during
probe so that it only has to be done once.

> +	 */
> +	*val = div_s64((s64)vref_uV * ADS131M_EXTREF_SCALE_NUM, 1000);
> +	*val2 = ADS131M_EXTREF_SCALE_DEN * BIT(ADS131M_CODE_BITS);
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int ads131m_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *channel,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ads131m_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ads131m_adc_read(priv, channel->channel, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return ads131m_read_scale(priv, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define ADS131M_VOLTAGE_CHANNEL(num)	\
> +	{ \
> +		.type = IIO_VOLTAGE, \

These are differential inputs, so we should set `.differential = 1,` here.

If we add support for the multiplexer later, it will be important to be
able to distiguish between the differential inputs and the single-ended
inputs.

> +		.indexed = 1, \
> +		.channel = (num), \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_SCALE), \
> +	}
> +

...

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
> +	 */
> +	priv->refin_supply = devm_regulator_get_optional(dev, "refin");

Typically, we use devm_regulator_get_enable_read_voltage() to simpilfy it to just
a few lines like this:

	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
	if (ret < 0 && ret != -ENODEV)
		return dev_err_probe(dev, ret, ...);

	*is_ext_ref = ret != -ENODEV;

	/*
 	 * For internal reference, FSR = V_REF. For external reference,
	 * FSR = 0.96 * V_REF.
	 */
	priv->fsr_mv = *is_ext_ref ? ret / 1041 : ADS131M_INTERNAL_REF_MV;

Then priv->fsr_mv can be used directly in the scale function to simpilify it
as well.

bool *is_ext_ref would be an output parameter to pass to ads131m_hw_init()
like we already do with is_xtal.

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
> +	ret = regulator_enable(priv->refin_supply);
> +	if (ret) {
> +		/*
> +		 * Enable failed. devm_regulator_put() is already scheduled,
> +		 * so we just return the error.
> +		 */
> +		return dev_err_probe(dev, ret, "failed to enable refin regulator\n");
> +	}
> +
> +	/*
> +	 * Schedule our local ads131m_regulator_disable_action() helper
> +	 * to be called on driver unload.
> +	 */
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

Could also be a hardware reset if gpio is wired up.

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
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to configure CLOCK register\n");
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
> +	} else if (ret > 0) {

else is not needed after return.

> +		return dev_err_probe(dev, -EINVAL, "'xtal' must be the only or first clock name");
> +	} else if (ret == -ENODATA) {
> +		*is_xtal = false;
> +
> +		return 0;
> +	}
> +
> +	return dev_err_probe(dev, ret, "failed to read 'clock-names' property");

In the IIO subsystem, we like to always have the error paths handled first.
Something like:

	ret = ...;
	if (ret > 0)
		return dev_err_probe(dev, -EINVAL, ...);
	if (ret < 0 && ret != -ENODATA)
		return dev_err_probe(dev, ret, ...);
	
	*is_xtal = ret == 0;

	if (*is_xtal && !priv->config->supports_xtal)
		return dev_err_probe(dev, -EINVAL, ...);

	return 0;

> +}
> +
> +static int ads131m_probe(struct spi_device *spi)
> +{
> +	const struct ads131m_configuration *config;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads131m_priv *priv;
> +	bool is_xtal;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->indio_dev = indio_dev;
> +	priv->spi = spi;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads131m_info;
> +
> +	config = spi_get_device_match_data(spi);
> +	if (!config)
> +		return dev_err_probe(dev, -EINVAL, "No device configuration data found\n");
> +
> +	priv->config = config;
> +	indio_dev->name = config->name;
> +	indio_dev->channels = config->channels;
> +	indio_dev->num_channels = config->num_channels;
> +
> +	ret = ads131m_parse_clock(priv, &is_xtal);

Is it safe to apply power to the clock pin before turing on the
power supplies to the chip? If no or unsure, this should be moved
after ads131m_power_init().

> +	if (ret < 0)
> +		return ret;
> +
> +	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);

Usually, we do this with GPIOD_OUT_HIGH so that the device starts out in
reset, then we just have to deassert later to take it out of reset.

> +	if (IS_ERR(priv->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> +				     "Failed to get reset GPIO\n");
> +
> +	ret = devm_mutex_init(dev, &priv->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ads131m_prepare_message(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ads131m_power_init(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ads131m_hw_init(priv, is_xtal);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ads131m_of_match[] = {
> +	{ .compatible = "ti,ads131m02", .data = &ads131m02_config },
> +	{ .compatible = "ti,ads131m03", .data = &ads131m03_config },
> +	{ .compatible = "ti,ads131m04", .data = &ads131m04_config },
> +	{ .compatible = "ti,ads131m06", .data = &ads131m06_config },
> +	{ .compatible = "ti,ads131m08", .data = &ads131m08_config },
> +	{ } /* Fixed sentinel */

This pattern is common enough that the comment isn't really needed.
(Just like below.)

> +};
> +MODULE_DEVICE_TABLE(of, ads131m_of_match);
> +
> +static const struct spi_device_id ads131m_id[] = {
> +	{ "ads131m02", (kernel_ulong_t)&ads131m02_config },
> +	{ "ads131m03", (kernel_ulong_t)&ads131m03_config },
> +	{ "ads131m04", (kernel_ulong_t)&ads131m04_config },
> +	{ "ads131m06", (kernel_ulong_t)&ads131m06_config },
> +	{ "ads131m08", (kernel_ulong_t)&ads131m08_config },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ads131m_id);
> +

