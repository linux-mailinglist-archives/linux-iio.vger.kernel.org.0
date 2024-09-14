Return-Path: <linux-iio+bounces-9594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C039792EF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 20:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A171F226CC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD41D222F;
	Sat, 14 Sep 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TARNF8fy"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D211D1748
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726338131; cv=none; b=SqIVx92pS7bEQtyZVe5b/4yyQDhFQyKNCBows3c0ATsQEAFsme1evKL2U7PKo25vp9kDL2oAyrikzkOqdUy3iKoVO7KNJlg3WtA4CltP93OI8BJi9uHS4RHsqDk+4yIL2HvljXKfyuSymMEyEhoSFuCNdUc/qqp1+5KPVxweXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726338131; c=relaxed/simple;
	bh=j55s553NOeci77Fom8LTNM9U0CMq/EwxScjnjpwSj6s=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=ifVFJ9M9K0fm3JjLFY1I1WwDC/Ix72IYFXfx1uAvGxEiUQli6GYdxAIx4ndsAZErAArlDwToEAF0IiP/d1KWjpb/AvVH4hEJnRi0p0XwYXne1DdGI3s77847wNUd1ogl3KJvBuJogWdcAkf5GIHrBZ6MgGfAhdnlxYBKtHI9DmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TARNF8fy; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pXPDskhYqv6ompXPEsampP; Sat, 14 Sep 2024 20:22:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726338121;
	bh=OFVbNL38l0/PGyVb7FHahbcqf/dMCKYK2Z28IptNgWQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=TARNF8fy9dkV0wQYIkEHOdKPxwQwEWBr+ZQAZFB5GFeXJgqxzw8U2tq5xQR44dACw
	 qDvRc96FXAt0Cc6hMLx27Z9AoB14LttkKQa6yq6uwUbc1X2MICg29HeYTNIRtu5clQ
	 1FW1oVPJAdcdQ04lm2NU9KIYwHJct5qidTjeO/6AcZ4w+l5avCmepRSvA3LTD9T5cg
	 LIvKn7HQ4nEsFY8gDXgLdH1tJ11H6/SqMqSKl+0ebr434y5GOGrOBuYnvwWG6SJXyN
	 jbNHSQfV9uK4++DfLkD2VXh3s8anSDTpsBfd+LDD3QDHmdJzZlLCKUDlWkQxbdIe9O
	 hrkut749LJaKg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 14 Sep 2024 20:22:01 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8f869b3b-df3f-49a9-9b6e-640697aa91dd@wanadoo.fr>
Date: Sat, 14 Sep 2024 20:21:56 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
 <20240912095435.18639-3-Mariel.Tinaco@analog.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
In-Reply-To: <20240912095435.18639-3-Mariel.Tinaco@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 11:54, Mariel Tinaco a écrit :
> The AD8460 is a “bits in, power out” high voltage, high-power,
> high-speed driver optimized for large output current (up to ±1 A)
> and high slew rate (up to ±1800 V/μs) at high voltage (up to ±40 V)
> into capacitive loads.
> 
> A digital engine implements user-configurable features: modes for
> digital input, programmable supply current, and fault monitoring
> and programmable protection settings for output current,
> output voltage, and junction temperature. The AD8460 operates on
> high voltage dual supplies up to ±55 V and a single low voltage
> supply of 5 V.
> 
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---

Hi,

...

> +#define AD8460_CHAN_EXT_INFO(_name, _what, _read, _write) {		\
> +	.name = _name,							\
> +	.read = (_read),						\
> +	.write = (_write),						\
> +	.private = (_what),						\

Why () for _read, _write, _what?
(or why no () for _name?)

> +	.shared = IIO_SEPARATE,						\
> +}
> +
> +static struct iio_chan_spec_ext_info ad8460_ext_info[] = {

I think this can be static const struct.

> +	AD8460_CHAN_EXT_INFO("raw0", 0, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw1", 1, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw2", 2, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw3", 3, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw4", 4, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw5", 5, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw6", 6, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw7", 7, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw8", 8, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw9", 9, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw10", 10, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw11", 11, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw12", 12, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw13", 13, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw14", 14, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw15", 15, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("toggle_en", 0, ad8460_read_toggle_en,
> +			     ad8460_write_toggle_en),
> +	AD8460_CHAN_EXT_INFO("symbol", 0, ad8460_read_symbol,
> +			     ad8460_write_symbol),
> +	AD8460_CHAN_EXT_INFO("powerdown", 0, ad8460_read_powerdown,
> +			     ad8460_write_powerdown),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad8460_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad8460_powerdown_mode_enum),
> +	{}
> +};

...

> +static int ad8460_probe(struct spi_device *spi)
> +{
> +	struct ad8460_state *state;
> +	struct iio_dev *indio_dev;
> +	struct device *dev;
> +	u32 tmp[2], temp;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +
> +	indio_dev->name = "ad8460";
> +	indio_dev->info = &ad8460_info;
> +
> +	state->spi = spi;
> +	dev = &spi->dev;
> +
> +	state->regmap = devm_regmap_init_spi(spi, &ad8460_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap");
> +
> +	devm_mutex_init(dev, &state->lock);
> +
> +	state->sync_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(state->sync_clk))
> +		return dev_err_probe(dev, PTR_ERR(state->sync_clk),
> +				     "Failed to get sync clk\n");
> +
> +	state->tmp_adc_channel = devm_iio_channel_get(dev, "ad8460-tmp");
> +	if (IS_ERR(state->tmp_adc_channel)) {
> +		if (PTR_ERR(state->tmp_adc_channel) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		indio_dev->channels = ad8460_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad8460_channels);
> +	} else {
> +		indio_dev->channels = ad8460_channels_with_tmp_adc;
> +		indio_dev->num_channels = ARRAY_SIZE(ad8460_channels_with_tmp_adc);
> +	}
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad8460_supplies),
> +					     ad8460_supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable power supplies\n");
> +		return ret;

Nitpick: return dev_err_probe() as done in other places?

> +	}
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refio_1p2v");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get reference voltage\n");
> +
> +	state->refio_1p2v_mv = ret == -ENODEV ? 1200 : ret / 1000;

...

CJ

