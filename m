Return-Path: <linux-iio+bounces-3883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794C89032B
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA15293781
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3B12F5B2;
	Thu, 28 Mar 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObwMSR1Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731032C92;
	Thu, 28 Mar 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640158; cv=none; b=q1fyLI8RQqYOL25lbqjcl0nsEB/l24yHxHDoRLp5yXa2ChTE1nBAHAjg1NeLSkmxyQq34HHrgfBGcKG4yib62ntQwj+BdI0VOU66nB66kVBp8LOb05Qe5iMvlIPVaZsySuipiEsUhtUzbwuAlpF8EGbX4TstzHRpmbSDHPZ/CQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640158; c=relaxed/simple;
	bh=sXB+7F4XXRpdbPTK7HeGR8q7l0GJ15LLgUihn+lpo84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpEU8yCYI3zflNz5xG86GJ9FsZFyObXQ4bZCyAsgsoM+sS+n7KPu5Yk4AxnHr71ud9MSKYDMX4DR5oELRXCLN23cu+LTgMb1ZzFFZCA3A0zjqbcg0BnwFdck3c3ISYq5/Zfw+VgklLHaNaSSJdB9LVCxt7Jza+NLWbKv8jz9Xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObwMSR1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4920C43399;
	Thu, 28 Mar 2024 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640157;
	bh=sXB+7F4XXRpdbPTK7HeGR8q7l0GJ15LLgUihn+lpo84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObwMSR1YjVvpEYqNsGoGnwg/yZUC6AsbdUlaOFLQJMQlfJ1rGOvxWBQZxV1jez3Vb
	 bGda4l+zxdXjvrhIlOR8AAAqEyvbn536Sv7jt9D26FIOiDaGvJ5Mcj3xNcJba4W5Li
	 lpVJRfUsgUPL04lEexYZ9oNxQfAeA8qx34+zHutzUM+3ivne0wvoZccxQgG5RNe4fn
	 1EbLOYqDrge1oObQPMaA5qDK6qzdm7ZVscuad8cwR6aXnzIvcGzqxNplg4j0t2KsTw
	 ZS8gmsSeqKzds7eYT1o9d/gPWCRWKuQqG9CIdioddlMdTgqam4eCK1MRcix4cBsbA7
	 EcyzT0JugXN7g==
Date: Thu, 28 Mar 2024 15:35:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 09/10] iio: dac: add support for AXI DAC IP core
Message-ID: <20240328153542.7ddb897c@jic23-huawei>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-9-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	<20240328-iio-backend-axi-dac-v1-9-afc808b3fde3@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 14:22:33 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Support the Analog Devices Generic AXI DAC IP core. The IP core is used
> for interfacing with digital-to-analog (DAC) converters that require either
> a high-speed serial interface (JESD204B/C) or a source synchronous parallel
> interface (LVDS/CMOS). Typically (for such devices) SPI will be used for
> configuration only, while this IP core handles the streaming of data into
> memory via DMA.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>


A few minor things inline, but mostly seems fine to me.

Jonathan


...

> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> new file mode 100644
> index 000000000000..0022ecb4e4bb
> --- /dev/null
> +++ b/drivers/iio/dac/adi-axi-dac.c


> +
> +enum {
> +	AXI_DAC_FREQ_TONE_1,
> +	AXI_DAC_FREQ_TONE_2,
> +	AXI_DAC_SCALE_TONE_1,
> +	AXI_DAC_SCALE_TONE_2,
> +	AXI_DAC_PHASE_TONE_1,
> +	AXI_DAC_PHASE_TONE_2,
> +};
> +
> +static int __axi_dac_frequency_get(struct axi_dac_state *st, unsigned int chan,
> +				   unsigned int tone, unsigned int *freq)
> +{
> +	u32 reg, raw;
> +	int ret;
> +
> +	if (!st->dac_clk) {
> +		dev_err(st->dev, "Sampling rate is 0...\n");
> +		return -EINVAL;
> +	}
> +
> +	if (tone == AXI_DAC_FREQ_TONE_1)

Given this is matching 2 out of enum with other values, it would be more
locally readable as a switch statement with an error returning default.
Then we wouldn't need to look at the caller.

Or at the caller convert from the enum to 0,1 for all these functions.



> +		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan);
> +	else
> +		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan);
> +
> +	ret = regmap_read(st->regmap, reg, &raw);
> +	if (ret)
> +		return ret;
> +
> +	raw = FIELD_GET(AXI_DAC_FREQUENCY, raw);
> +	*freq = DIV_ROUND_CLOSEST_ULL(raw * st->dac_clk, BIT(16));
> +
> +	return 0;
> +}

...

> +static int axi_dac_scale_set(struct axi_dac_state *st,
> +			     const struct iio_chan_spec *chan,
> +			     const char *buf, size_t len, unsigned int tone)
> +{
> +	int integer, frac, scale;
> +	u32 raw = 0, reg;
> +	int ret;
> +
> +	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
> +	if (ret)
> +		return ret;
> +
> +	scale = integer * MEGA + frac;
> +	if (scale <= -2 * (int)MEGA || scale >= 2 * (int)MEGA)
> +		return -EINVAL;
> +
> +	/*  format is 1.1.14 (sign, integer and fractional bits) */
> +	if (scale < 0) {
> +		raw = FIELD_PREP(AXI_DAC_SCALE_SIGN, 1);
> +		scale *= -1;
> +	}
> +
> +	raw |= div_u64((u64)scale * AXI_DAC_SCALE_INT, MEGA);
> +
> +	if (tone == AXI_DAC_SCALE_TONE_1)
> +		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
> +	else
> +		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
> +
> +	guard(mutex)(&st->lock);
> +	ret = regmap_write(st->regmap, reg, raw);
> +	if (ret)
> +		return ret;
> +
> +	/* synchronize channels */
> +	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static int axi_dac_phase_set(struct axi_dac_state *st,
> +			     const struct iio_chan_spec *chan,
> +			     const char *buf, size_t len, unsigned int tone)
> +{
> +	int integer, frac, phase;
> +	u32 raw, reg;
> +	int ret;
> +
> +	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);

> +	if (ret)
> +		return ret;
> +
> +	phase = integer * MEGA + frac;
> +	if (phase < 0 || phase > AXI_DAC_2_PI_MEGA)
> +		return -EINVAL;
> +
> +	raw = DIV_ROUND_CLOSEST_ULL((u64)phase * U16_MAX, AXI_DAC_2_PI_MEGA);
> +
> +	if (tone == AXI_DAC_PHASE_TONE_1)
Preference for a switch so it's clear there are only 2 choices.
> +		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
> +	else
> +		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
> +
> +	guard(mutex)(&st->lock);
> +	ret = regmap_update_bits(st->regmap, reg, AXI_DAC_PHASE,
> +				 FIELD_PREP(AXI_DAC_PHASE, raw));
> +	if (ret)
> +		return ret;
> +
> +	/* synchronize channels */
> +	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static int axi_dac_ext_info_set(struct iio_backend *back, uintptr_t private,
> +				const struct iio_chan_spec *chan,
> +				const char *buf, size_t len)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	switch (private) {
> +	case AXI_DAC_FREQ_TONE_1:
> +	case AXI_DAC_FREQ_TONE_2:

Same as the get path - convert to which tone here so that the enum becomes
a tone index for the functions called and the mapping to that single enum
is kept clear of the lower level code.

> +		return axi_dac_frequency_set(st, chan, buf, len, private);
> +	case AXI_DAC_SCALE_TONE_1:
> +	case AXI_DAC_SCALE_TONE_2:
> +		return axi_dac_scale_set(st, chan, buf, len, private);
> +	case AXI_DAC_PHASE_TONE_1:
> +	case AXI_DAC_PHASE_TONE_2:
> +		return axi_dac_phase_set(st, chan, buf, len, private);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int axi_dac_ext_info_get(struct iio_backend *back, uintptr_t private,
> +				const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	switch (private) {
> +	case AXI_DAC_FREQ_TONE_1:
> +	case AXI_DAC_FREQ_TONE_2:
> +		return axi_dac_frequency_get(st, chan, buf, private);
I'd break out private as an unsigned int here and then - AXI_DAC_FREQ_TONE_1
so that it is just which tone for all the calls made from here.
Similar for the following ones.

> +	case AXI_DAC_SCALE_TONE_1:
> +	case AXI_DAC_SCALE_TONE_2:
> +		return axi_dac_scale_get(st, chan, buf, private);
> +	case AXI_DAC_PHASE_TONE_1:
> +	case AXI_DAC_PHASE_TONE_2:
> +		return axi_dac_phase_get(st, chan, buf, private);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct iio_chan_spec_ext_info axi_dac_ext_info[] = {
> +	IIO_BACKEND_EX_INFO("frequency0", IIO_SEPARATE, AXI_DAC_FREQ_TONE_1),
> +	IIO_BACKEND_EX_INFO("frequency1", IIO_SEPARATE, AXI_DAC_FREQ_TONE_2),
> +	IIO_BACKEND_EX_INFO("scale0", IIO_SEPARATE, AXI_DAC_SCALE_TONE_1),
> +	IIO_BACKEND_EX_INFO("scale1", IIO_SEPARATE, AXI_DAC_SCALE_TONE_2),
> +	IIO_BACKEND_EX_INFO("phase0", IIO_SEPARATE, AXI_DAC_PHASE_TONE_1),
> +	IIO_BACKEND_EX_INFO("phase1", IIO_SEPARATE, AXI_DAC_PHASE_TONE_2),
> +	{}
> +};
> +
> +static int axi_dac_extend_chan(struct iio_backend *back,
> +			       struct iio_chan_spec *chan)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	if (chan->type != IIO_ALTVOLTAGE)
> +		return -EINVAL;
> +	if (st->reg_config & AXI_DDS_DISABLE)
> +		/* nothing to extend */
> +		return 0;
> +
> +	chan->ext_info = axi_dac_ext_info;
> +
> +	return 0;
> +}

> +static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
> +				   u64 sample_rate)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +	unsigned int freq;
> +	int ret, tone;
> +
> +	if (!sample_rate)
> +		return -EINVAL;
> +	if (st->reg_config & AXI_DDS_DISABLE)
> +		/* nothing to care if DDS is disabled */
Rephrase this.  Is the point that the sample rate has no meaning without DDS or
that it has meaning but nothing to do here?
> +		return 0;
> +
> +	guard(mutex)(&st->lock);
> +	/*
> +	 * If dac_clk is 0 then this must be the first time we're being notified
> +	 * about the interface sample rate. Hence, just update our internal
> +	 * variable and bail... If it's not 0, then we get the current DDS
> +	 * frequency (for the old rate) and update the registers for the new
> +	 * sample rate.
> +	 */
> +	if (!st->dac_clk) {
> +		st->dac_clk = sample_rate;
> +		return 0;
> +	}
> +
> +	for (tone = 0; tone <= AXI_DAC_FREQ_TONE_2; tone++) {
> +		ret = __axi_dac_frequency_get(st, chan, tone, &freq);
> +		if (ret)
> +			return ret;
> +
> +		ret = __axi_dac_frequency_set(st, chan, sample_rate, tone, freq);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->dac_clk = sample_rate;
> +
> +	return 0;
> +}


