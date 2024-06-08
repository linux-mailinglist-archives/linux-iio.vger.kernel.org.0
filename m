Return-Path: <linux-iio+bounces-6057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C544C90122D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6DA1F21CDA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A0159209;
	Sat,  8 Jun 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfyOzotg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB22557A;
	Sat,  8 Jun 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717858676; cv=none; b=NdVxXyLMeAW3lSNC2FF3TdfIrCL5Z2YPToDeYKkSdPrO86xIIJjYKzx9XnTmnaXDwdJ8IzQ+5gXXo/MMh4Ao7xusV7GOHk1QZCM5WBZ75I4u7FmEyE25mA3557jhckne3hRePs5/nwkpzBfCD900jHU1MVImCqKcdabBsXlXCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717858676; c=relaxed/simple;
	bh=frMwjzfh+7i2E8OKbq8u5BCqItbvZYQf9PPxBKISSoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oH4HhlXFHH3Q2oVIJxaGnMQhVjFs3yUeNHLlfZJZ1wN1rLQtNhdiV89BilX2QXH8kqahFzzxHi8wM095U8uau7eRQIG733BFcQs9XpW6luIveAIWampUjueuXbtuPBdyFcr30bL5XvHgDRCSZaDQsKnUTyh+lXH9uE8/LViuZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfyOzotg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A6CC2BD11;
	Sat,  8 Jun 2024 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717858676;
	bh=frMwjzfh+7i2E8OKbq8u5BCqItbvZYQf9PPxBKISSoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VfyOzotgw/ND6GpJDzDvEnmhf3q8s6Jo3/iH2sp5IIvS9AlGa1eBmsD3yPfBbOWCt
	 quYTbRd4E0ut09BrSQMor9itFmROzjXuu6HhIg93MaicDtMvBD1MurLpjfLy/tQRbY
	 UgBn2GBTiFdMn3HW9coQ2eoI06DC+08dc5Fl7FHi7qZWNieSHAxG5zvDv2xBjc8Iza
	 3wZDyAle1xbF+f6psxkRC3fLoECkvCs0dKMe+tw05Wpxl/xVDgxf86VQsN5oVbuIqw
	 MPlOKHF3XlFDk5wFe2ocujcxgMGmbonsfEBYjbLEHeWN42Im4k1qz0u3MxsT6LoJ5c
	 q6aQYbDol8SUg==
Date: Sat, 8 Jun 2024 15:57:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael Hennerich"
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v3 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Message-ID: <20240608155746.06bddfdc@jic23-huawei>
In-Reply-To: <20240603012200.16589-6-kimseer.paller@analog.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
	<20240603012200.16589-6-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 09:22:00 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 16 bit Current Output Softspan DAC
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405241141.kYcxrSem-lkp@intel.com/
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

A few minor things from me to add to the more detailed comments from Nuno and David.

> +static int ltc2664_dac_code_write(struct ltc2664_state *st, u32 chan, u32 input,
> +				  u16 code)
> +{
> +	struct ltc2664_chan *c = &st->channels[chan];
> +	int ret, reg;
> +
> +	guard(mutex)(&st->lock);
> +	/* select the correct input register to write to */
> +	if (c->toggle_chan) {
> +		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
> +				   input << chan);
> +		if (ret)
> +			return ret;
> +	}
> +	/*
> +	 * If in toggle mode the dac should be updated by an
> +	 * external signal (or sw toggle) and not here.
> +	 */
> +	if (st->toggle_sel & BIT(chan))
> +		reg = LTC2664_CMD_WRITE_N(chan);
> +	else
> +		reg = LTC2664_CMD_WRITE_N_UPDATE_N(chan);
> +
> +	ret = regmap_write(st->regmap, reg, code);
> +	if (ret)
> +		return ret;
> +
> +	c->raw[input] = code;
> +
> +	if (c->toggle_chan) {
> +		ret = regmap_write(st->regmap, LTC2664_CMD_TOGGLE_SEL,
> +				   st->toggle_sel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;

return 0; you won't get here otherwise, and making that explicit
gives more readable code.

> +}
> +
> +static int ltc2664_dac_code_read(struct ltc2664_state *st, u32 chan, u32 input,
> +				 u32 *code)
> +{
> +	guard(mutex)(&st->lock);
> +	*code = st->channels[chan].raw[input];
> +
> +	return 0;
> +}
> +
> +static const int ltc2664_raw_range[] = {0, 1, U16_MAX};
{ 0, 1, U16_MAX };
preferred (extra spaces)


> +
> +static const struct ltc2664_chip_info ltc2664_chip = {
> +	.id = LTC2664,
> +	.name = "ltc2664",
> +	.scale_get = ltc2664_scale_get,
> +	.offset_get = ltc2664_offset_get,
> +	.measurement_type = IIO_VOLTAGE,
> +	.num_channels = ARRAY_SIZE(ltc2664_channels),
> +	.iio_chan = ltc2664_channels,
> +	.span_helper = ltc2664_span_helper,
> +	.num_span = ARRAY_SIZE(ltc2664_span_helper),
> +	.internal_vref = 2500,
> +	.manual_span_support = true,
> +	.rfsadj_support = false,
> +};
> +
> +static const struct ltc2664_chip_info ltc2672_chip = {
> +	.id = LTC2672,

As below.  Seeing an id in here made me wonder what was going on given
we don't have a whoami register on these.  Please remove it as that
model of handling chip specific stuff always bites us in complexity
and lack of flexibility as we expand the parts supported by a driver.

> +	.name = "ltc2672",
> +	.scale_get = ltc2672_scale_get,
> +	.offset_get = ltc2672_offset_get,
> +	.measurement_type = IIO_CURRENT,
> +	.num_channels = ARRAY_SIZE(ltc2672_channels),
> +	.iio_chan = ltc2672_channels,
> +	.span_helper = ltc2672_span_helper,
> +	.num_span = ARRAY_SIZE(ltc2672_span_helper),
> +	.internal_vref = 1250,
> +	.manual_span_support = false,
> +	.rfsadj_support = true,
> +};
> +
> +static int ltc2664_set_span(const struct ltc2664_state *st, int min, int max,
> +			    int chan)
> +{
> +	const struct ltc2664_chip_info *chip_info = st->chip_info;
> +	const int (*span_helper)[2] = chip_info->span_helper;
> +	int span, ret;
> +
> +	st->iio_channels[chan].type = chip_info->measurement_type;
> +
> +	for (span = 0; span < chip_info->num_span; span++) {
> +		if (min == span_helper[span][0] && max == span_helper[span][1])
> +			break;
> +	}
> +
> +	if (span == chip_info->num_span)
> +		return -EINVAL;
> +
> +	ret = regmap_write(st->regmap, LTC2664_CMD_SPAN_N(chan),
> +			   (chip_info->id == LTC2672) ? span + 1 : span);
Make this specific data, not id based.

The reasoning of there being a magic value (offmode) as 0 is a bit obscure
so maybe a callback is best plan.

Or... put a 0,0 entry in span_helper[] and check for that + ignore it or
error out if anyone tries to use it.

Drop that id in the chip_info structure as well as having it there
will make people not consider if their 'code' should be 'data' in future
cases similar to this.

> +	if (ret)
> +		return ret;
> +
> +	return span;
> +}
> +



