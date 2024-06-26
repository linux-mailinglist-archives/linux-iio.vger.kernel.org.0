Return-Path: <linux-iio+bounces-6951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2A91821F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46931F24837
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CF1836E8;
	Wed, 26 Jun 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP5p0HGq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5E25740;
	Wed, 26 Jun 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407754; cv=none; b=c4HEljyS3wjDYXw55BCfmKvCnIR9nm5IIS/enLmCbC+ZuKminmRrWGHPjURu2WzAVkJTsskXuihhkkILZoSi18zozq36lDpdjztyjHeLrBh/dlZVuqacfw7NP6nzQbJZUCADe2LFJ1EfMqaub9u1a5rlWlRHF7DV+raCRzDLrds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407754; c=relaxed/simple;
	bh=aBiLyGmr5388uSmYWF8VVmif0VRS3W9++LAPMTqPgT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWksn9NleS/rx62QHeBbEUtvThLO0nU4S46BdfKZ6YsjyFAlCzSg2Py4b1KPjSNXwRLWf2u8Cva8BDmClB2ptvTO9gWIT6LRBgkVIyL/rKc6ReEs6GTCGl1AbbJSp6780ltpoQmgts53vR7T5oVXfZGcJP34AwfZvPtw1WaMowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP5p0HGq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa75f53f42so11295325ad.0;
        Wed, 26 Jun 2024 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407752; x=1720012552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJrMKQD3mEF1cmX3ZtYVSt2tsOp4XGsteyFtxkneBXs=;
        b=KP5p0HGqdHvQbV136s3himD9mGz5yJXgfUyXF3PIPhs7kZ4tXkKuoCMeeCJxoGd4He
         SeYtQzHo7mDC8OEFeyn4Mf8KzZM2oP7p+9pm9yoMZY0R2C1yNtDUI4aa8zjhXts/tC4M
         4ekh6IsJemofBy7z9WIucJnFHJk+8qn5QC9jMd2tPOums84jg3Lw4LXEXYS5Qg686idW
         SAPS7QKpwEZ2Nr9YL/PEpw0mw/byEzGJft460hgOacbbXJIw8f6rrnNuq/0jK7WXk1jl
         UFp7P7WmV0AFMJACLjfSV5WXAqRDpWtBTlc7BbkfmCdWWZqcFcv5qATGmze7Uxe7a9YD
         NI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407752; x=1720012552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJrMKQD3mEF1cmX3ZtYVSt2tsOp4XGsteyFtxkneBXs=;
        b=FcJwDDHdCDDsRA+x8nfAlU7V47kSFxJlov+XiNspqg/QFKYoojrfyg4dDvp1rb9/I7
         TB5YmYpk7mmyTZA5TIAMZ+l8LaHyqUwTiDOU+Wxfb8qK842v9x8hErjo0SZoqJgt7sUa
         R2IdFl1GEYXmcROBboCzxTPLz5RSglyyzN1zRX+KwuPwjPULFJ4+yTvfBd6BxoroeDGN
         1ckYXHxsl0luwWMM/W2TOxQLp0wDSH7JyqDleAQ5l8llNcJI1CPcZaH/eZJgXq3jrp5d
         odtbv/p4eTfAFJh7UqzNkAqftT3lZwRm6u9HhJwTAdq0VRUJa0C0XPYL5iLYIoefPnHP
         ZW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUfBhNU3W81dgdPuW2Pl1oWFe+I8URzmAX+NXipgM0ChLLPOLNeskOOGFbrJjO5ZP9rpJayxjyf6m/HgxiGZ7GsrEuh5jMLy3DDSTlI+eweIiVs/5Q/fbN+aBp1Vuaf3YN1cuLUBfaxcQawYH+hYn379Q2Ezntq0/wqUzR+HhUl6CvidahynNBc/tnD7EBJQbfF16pkup7I1cYZQmO7yqJkmS59KqyNOU9T2oTk/NvSpm9M1gY4Ka0tg==
X-Gm-Message-State: AOJu0Ywje/9ClrkwAHeNnHg3eJMu2WRHB7kDuUP082KvZap9qh11zYBQ
	qPzJrZNVT/Pq3VXmPwEB2JgDiSeI437hlkvG4a1i5gJU3SINSWSX
X-Google-Smtp-Source: AGHT+IEb642+ye6eewoycP+AZQpkw6bjDRO6NprAIwTkGriIXvIldoN3qr2cjaJycu/5EIszRsk0yQ==
X-Received: by 2002:a17:902:9302:b0:1f7:3163:831e with SMTP id d9443c01a7336-1fa23f610fbmr81272255ad.32.1719407751389;
        Wed, 26 Jun 2024 06:15:51 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb9c1a88sm98808625ad.238.2024.06.26.06.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:15:50 -0700 (PDT)
Date: Wed, 26 Jun 2024 10:17:16 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
Message-ID: <ZnwU3MovTWfrovrE@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
 <f6dc458f759c47154eee16354c807c020028512e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6dc458f759c47154eee16354c807c020028512e.camel@gmail.com>

On 06/26, Nuno Sá wrote:
> On Tue, 2024-06-25 at 18:55 -0300, Marcelo Schmitt wrote:
> > Add support for AD4000 series of low noise, low power, high speed,
> > successive approximation register (SAR) ADCs.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  MAINTAINERS              |   1 +
> >  drivers/iio/adc/Kconfig  |  12 +
> >  drivers/iio/adc/Makefile |   1 +
> >  drivers/iio/adc/ad4000.c | 711 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 725 insertions(+)
> >  create mode 100644 drivers/iio/adc/ad4000.c
> > 
...
> ...
> 
> > +
> > +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> > +{
> > +	struct spi_transfer t = {
> > +		.tx_buf = st->tx_buf,
> > +		.rx_buf = st->rx_buf,
> > +		.len = 2,
> > +	};
> > +	int ret;
> > +
> > +	st->tx_buf[0] = AD4000_READ_COMMAND;
> > +	ret = spi_sync_transfer(st->spi, &t, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = st->tx_buf[1];
> 
> I'm puzzled... tx_buf?
> 
Oh my, I must have messed up when changing to array buffers.
Looks like v6 will be coming :)

> > +	return ret;
> > +}
> > +
> > +/*
> > + * This executes a data sample transfer for when the device connections are
> > + * in "3-wire" mode, selected when the adi,sdi-pin device tree property is
> > + * absent or set to "high". In this connection mode, the ADC SDI pin is
> > + * connected to MOSI or to VIO and ADC CNV pin is connected either to a SPI
> > + * controller CS or to a GPIO.
> > + * AD4000 series of devices initiate conversions on the rising edge of CNV
> > pin.
> > + *
> > + * If the CNV pin is connected to an SPI controller CS line (which is by
> > default
> > + * active low), the ADC readings would have a latency (delay) of one read.
> > + * Moreover, since we also do ADC sampling for filling the buffer on
> > triggered
> > + * buffer mode, the timestamps of buffer readings would be disarranged.
> > + * To prevent the read latency and reduce the time discrepancy between the
> > + * sample read request and the time of actual sampling by the ADC, do a
> > + * preparatory transfer to pulse the CS/CNV line.
> > + */
> > +static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
> > +					     const struct iio_chan_spec
> > *chan)
> > +{
> > +	unsigned int cnv_pulse_time = st->turbo_mode ? AD4000_TQUIET1_NS
> > +						     : AD4000_TCONV_NS;
> > +	struct spi_transfer *xfers = st->xfers;
> > +
> > +	xfers[0].cs_change = 1;
> > +	xfers[0].cs_change_delay.value = cnv_pulse_time;
> > +	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> > +
> > +	xfers[1].rx_buf = &st->scan.data;
> > +	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> > +	xfers[1].delay.value = AD4000_TQUIET2_NS;
> > +	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> > +
> > +	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> > +
> > +	return devm_spi_optimize_message(st->spi, &st->msg);
> > +}
> > +
> > +/*
> > + * This executes a data sample transfer for when the device connections are
> > + * in "4-wire" mode, selected when the adi,sdi-pin device tree property is
> > + * set to "cs". In this connection mode, the controller CS pin is connected
> > to
> > + * ADC SDI pin and a GPIO is connected to ADC CNV pin.
> > + * The GPIO connected to ADC CNV pin is set outside of the SPI transfer.
> > + */
> > +static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
> > +					     const struct iio_chan_spec
> > *chan)
> > +{
> > +	unsigned int cnv_to_sdi_time = st->turbo_mode ? AD4000_TQUIET1_NS
> > +						      : AD4000_TCONV_NS;
> > +	struct spi_transfer *xfers = st->xfers;
> > +
> > +	/*
> > +	 * Dummy transfer to cause enough delay between CNV going high and
> > SDI
> > +	 * going low.
> > +	 */
> > +	xfers[0].cs_off = 1;
> > +	xfers[0].delay.value = cnv_to_sdi_time;
> > +	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> > +
> > +	xfers[1].rx_buf = &st->scan.data;
> > +	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> > +
> > +	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> > +
> > +	return devm_spi_optimize_message(st->spi, &st->msg);
> > +}
> 
> nit: you could reduce the scope of the above prepare functions...

Not sure I got what you mean with this comment Nuno.
Would it be preferable to prepare the 3-wire/4-wire transfers within the switch
cases in probe?

> 
> > +
> > +static int ad4000_convert_and_acquire(struct ad4000_state *st)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * In 4-wire mode, the CNV line is held high for the entire
> > conversion
> > +	 * and acquisition process. In other modes, the CNV GPIO is optional
> > +	 * and, if provided, replaces controller CS. If CNV GPIO is not
> > defined
> > +	 * gpiod_set_value_cansleep() has no effect.
> > +	 */
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> > +	ret = spi_sync(st->spi, &st->msg);
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> > +				    const struct iio_chan_spec *chan, int
> > *val)
> > +{
> > +	struct ad4000_state *st = iio_priv(indio_dev);
> > +	u32 sample;
> > +	int ret;
> > +
> > +	ret = ad4000_convert_and_acquire(st);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (chan->scan_type.storagebits > 16)
> > +		sample = be32_to_cpu(st->scan.data.sample_buf32);
> 
> Just a minor note regarding your comment in the cover. FWIW, I prefer you leave
> it like this. Yes, with 24 bits you save some space but then you need an
> unaligned access... To me that space savings are really a micro optimization so
> I would definitely go with the simpler form.
> 
I'm no expert on this. Will go with what maintainers say.

> > +	else
> > +		sample = be16_to_cpu(st->scan.data.sample_buf16);
> > +
> > +	sample >>= chan->scan_type.shift;
> > +
> > +	if (chan->scan_type.sign == 's')
> > +		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
...
> > +static int ad4000_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int val, int
> > val2,
> > +			    long mask)
> > +{
> > +	struct ad4000_state *st = iio_priv(indio_dev);
> > +	unsigned int reg_val;
> > +	bool span_comp_en;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> 
> iio_device_claim_direct_scoped()?

I had iio_device_claim_direct_scoped() in v4 but was asked to use a local
lock to protect the read modify write cycle here.
> 
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		mutex_lock(&st->lock);
> 
> guard()?

This guard() stuff is somewhat new to me.
Will check out if can use it here.

> 
> > +		ret = ad4000_read_reg(st, &reg_val);
> > +		if (ret < 0)
> > +			goto err_unlock;
> > +
> > +		span_comp_en = val2 == st->scale_tbl[1][1];
> > +		reg_val &= ~AD4000_CFG_SPAN_COMP;
> > +		reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> > +
> > +		ret = ad4000_write_reg(st, reg_val);
> > +		if (ret < 0)
> > +			goto err_unlock;
> > +
> > +		st->span_comp = span_comp_en;
> > +err_unlock:
> > +		iio_device_release_direct_mode(indio_dev);
> > +		mutex_unlock(&st->lock);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
...
> > +
> > +static int ad4000_probe(struct spi_device *spi)
> > +{
> > +	const struct ad4000_chip_info *chip;
> > +	struct device *dev = &spi->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct ad4000_state *st;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	chip = spi_get_device_match_data(spi);
> > +	if (!chip)
> > +		return -EINVAL;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->spi = spi;
> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable VDD
> > supply\n");
> > +
> > +	ret = devm_regulator_get_enable(dev, "vio");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable VIO
> > supply\n");
> 
> devm_regulator_bulk_get_enable()? Do we have any ordering constrains?

No ordering constraints, but vdd and vio are optional while ref is required and
we need to get the voltage of ref.
devm_regulator_bulk_get_enable_read_voltage()? and discard vdd and vio voltages?

> 
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to get ref regulator
> > reference\n");
> > +	st->vref_mv = ret / 1000;
> > +
> > +	st->cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->cnv_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> > +				     "Failed to get CNV GPIO");
> > +
> > +	ret = device_property_match_property_string(dev, "adi,sdi-pin",
> > +						    ad4000_sdi_pin,
> > +						   
> > ARRAY_SIZE(ad4000_sdi_pin));
> > +	if (ret < 0 && ret != -EINVAL)
> > +		return dev_err_probe(dev, ret,
> > +				     "getting adi,sdi-pin property
> > failed\n");
> > +
> > +	/* Default to usual SPI connections if pin properties are not present
> > */
> > +	st->sdi_pin = ret == -EINVAL ? AD4000_SDI_MOSI : ret;
> > +	switch (st->sdi_pin) {
> > +	case AD4000_SDI_MOSI:
> > +		indio_dev->info = &ad4000_reg_access_info;
> > +		indio_dev->channels = &chip->reg_access_chan_spec;
> > +
> > +		/*
> > +		 * In "3-wire mode", the ADC SDI line must be kept high when
> > +		 * data is not being clocked out of the controller.
> > +		 * Request the SPI controller to make MOSI idle high.
> > +		 */
> > +		spi->mode |= SPI_MOSI_IDLE_HIGH;
> > +		ret = spi_setup(spi);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = ad4000_prepare_3wire_mode_message(st, indio_dev-
> > >channels);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = ad4000_config(st);
> > +		if (ret < 0)
> > +			dev_warn(dev, "Failed to config device\n");
> > +
> 
> Should this be a warning? Very suspicious :)

This devices have some many possible wiring configurations.
I didn't want to fail just because reg access fail.
Maybe ADC SDI was wired to VIO but dt don't have adi,sdi-pin = "high".
Reg access will fail but sample read should work.

> 
> > +		break;
> > +	case AD4000_SDI_VIO:
> > +		indio_dev->info = &ad4000_info;
> > +		indio_dev->channels = &chip->chan_spec;
> > +		ret = ad4000_prepare_3wire_mode_message(st, indio_dev-
> > >channels);
> > +		if (ret)
> > +			return ret;
> > +
> > +		break;
> > +	case AD4000_SDI_CS:
> > +		indio_dev->info = &ad4000_info;
> > +		indio_dev->channels = &chip->chan_spec;
> > +		ret = ad4000_prepare_4wire_mode_message(st, indio_dev-
> > >channels);
> > +		if (ret)
> > +			return ret;
> > +
> > +		break;
> > +	default:
> > +		return dev_err_probe(dev, -EINVAL, "Unrecognized connection
> > mode\n");
> > +	}
> > +
> > +	indio_dev->name = chip->dev_name;
> > +	indio_dev->num_channels = 1;
> > +
> > +	devm_mutex_init(dev, &st->lock);
> > +
> > +	st->gain_milli = 1000;
> > +	if (chip->has_hardware_gain) {
> > +		if (device_property_present(dev, "adi,gain-milli")) {
> > +			ret = device_property_read_u16(dev, "adi,gain-milli",
> > +						       &st->gain_milli);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret,
> > +						     "Failed to read gain
> > property\n");
> > +		}
> > 
> 
> the above looks odd. Why not?
> 
> ret = device_property_read_u16(dev, "adi,gain-milli", &st->gain_milli);
> if (!ret) {
> 	...
> }

I wanted to be more protective in case anything strange comes from dt.

> 
> Note that you're also allowing any value for gain_milli when we just allow some
> of them (according to the bindings). Hence you should make sure we get supported
> values from FW.

Yes, but anything different from what is specified in the binding should make
dtbs_check fail, no?
can use device_property_match_property_string() so we assure only supported
gain-milli values in the driver as well.

> 
> - Nuno Sá

