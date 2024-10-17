Return-Path: <linux-iio+bounces-10674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A19A1BB5
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 09:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC41C21F54
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12131D0178;
	Thu, 17 Oct 2024 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OyzhyW5i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170211CDFA3
	for <linux-iio@vger.kernel.org>; Thu, 17 Oct 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150157; cv=none; b=XMks1A2YSxvM3HYP5cZ93c3XyDiXSsNwtcVWeghGS8ob1waU/aedhyN+Vc2KpdXYEm9g2bDG/74dmExSBBdxhOMg4KWFzzWebtIL7tfoTTzqljuM1RQabR5BOC1Rwib/P/7rctoUTM9Lg5frUT2A6izQKL1YlTU8BK5X3LRyiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150157; c=relaxed/simple;
	bh=ossDaNiGh5ZyK0hvtucZcrvlFJylkycEd3FSa7HSp/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRtuFG3swVb1GCPdGKUWwtklkbjyodC2ujSYScatkie0igrlG7oW51TxQYiVp9aAP7nnK9/86b9fPzE+lo9hz98vc5vbdnvc/up9e7LBKgmepngvTH6Dt4LbHkrmex/kX7fB1drPaiBqYzxIAhm6bN0hTYPCOSE5KnIRG0Ac2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OyzhyW5i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d808ae924so400220f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Oct 2024 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729150151; x=1729754951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=seV/NH5xCQrFU3sCq8A226JOEp39+iAiZbuksFSfXek=;
        b=OyzhyW5i5eUiFHT/DovGOECEtWwfldPDq1ptqqNTBjupn8jr67dnCIVUTV8QkTPDoW
         pwuz5McDs8abD1LTQhQsumrmACv10tV3iBL6jobgDcFZPQNBEMcDdqKjNDP/jRxVaVVZ
         MdSVpETrLLAJqj0SHBxtBkEqibgUgBv/VOnF+/7YtNAvwWXtfUHbkjo9SWc9K+XLXdsU
         zZ4mXrzF0lr1w6VAQvTXJmKnxwOqsCi5huGU6WeMBxCTEQQMbZbNJfRo1Z+3u55YNGmy
         WzfkIq+c1n2Xh+Fn+69oWw7poVXmpT82o8gpNmMA+VlLfkXWEmimKDWw7Hpoeb/KfzsW
         hxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150151; x=1729754951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seV/NH5xCQrFU3sCq8A226JOEp39+iAiZbuksFSfXek=;
        b=a99XJHamAAubSWGDz4WVO34A4WFKBHna/vSsrCRlFYmQFSikIRG1g+TemM6q3Sr8UF
         sUI7aPrv0gfwFo9Y9g/YfCZf8XUXzIvMFVQKw1WlVEeCHp2umvU8knfzKRmjte5ue84g
         6QAwbW71mY3E517EQVtAHZba+iut4mh1tLiKognS9SbwZ4arsFM2JuizBwCYFAR2bPpL
         M31VCuqWQBzLr7IeaMRKyQ5ap62JED9k3xBO/4bsMy27wMyDAnq6Kr/5VGmUuAJNS7V7
         kSrtAE75WyI2UZR+5ktJUbhnSAGh03Gov5pyDD3j5CqjPUt8zn5FsNw54sGB5Bj4Bbv9
         OL5A==
X-Forwarded-Encrypted: i=1; AJvYcCWVEmQ0Ew7NqC34cOYGWgQNGfm/QcK3g/Fpu0OU9y5JHSol8npBNYlweLmpr56K87kXv9qOuBiLAvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTojSZo0GqAq3xlV0cMNJP3Fgz9Q8w6mIMPCXIkQsz4AZztuU8
	9D28vOzu+Y54EcyrDgAdBf03BZ+TnQ8hRrJm1tfbP5I8A/r1SzB7aQqltyH6daQ=
X-Google-Smtp-Source: AGHT+IFida7c4VQypSZlZf1Wq5un5xL87xAcrBsbfcX+XYPjuJ3EysbWGp96PlFit1CyLJLpAm79ag==
X-Received: by 2002:adf:a3ca:0:b0:378:e8cd:71fa with SMTP id ffacd0b85a97d-37d86d3c5e6mr4168593f8f.39.1729150151168;
        Thu, 17 Oct 2024 00:29:11 -0700 (PDT)
Received: from dfj (host-82-61-199-234.retail.telecomitalia.it. [82.61.199.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a1c8sm6283782f8f.21.2024.10.17.00.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:29:10 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:27:56 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
Message-ID: <i3mksgfcza26zbixghsfk2avvxheb32ig6wsqz4zuuqezbok4z@l2rwxoabjkgs>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
 <549566b00524c0230a6a970b74a38dbe58e2589d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <549566b00524c0230a6a970b74a38dbe58e2589d.camel@gmail.com>

Hi Nuno,

On 15.10.2024 09:15, Nuno Sá wrote:
> On Mon, 2024-10-14 at 12:08 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add High Speed ad3552r platform driver.
> > 
> > The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> > through the current AXI backend, or similar alternative IIO backend.
> > 
> > Compared to the existing driver (ad3552r.c), that is a simple SPI
> > driver, this driver is coupled with a DAC IIO backend that finally
> > controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> > maximum transfer rate of 33MUPS using dma stream capabilities.
> > 
> > All commands involving QSPI bus read/write are delegated to the backend
> > through the provided APIs for bus read/write.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> 
> Hi Angelo,
> 
> Some more questions from me on top of David's review...
> 
> >  drivers/iio/dac/Kconfig      |  14 ++
> >  drivers/iio/dac/Makefile     |   1 +
> >  drivers/iio/dac/ad3552r-hs.c | 526 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iio/dac/ad3552r-hs.h |  18 ++
> >  drivers/iio/dac/ad3552r.h    |   7 +
> >  5 files changed, 566 insertions(+)
> > 
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index fa091995d002..fc11698e88f2 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -6,6 +6,20 @@
> >  
> >  menu "Digital to analog converters"
> >  
> > +config AD3552R_HS
> > +	tristate "Analog Devices AD3552R DAC High Speed driver"
> > +	select ADI_AXI_DAC
> > +	help
> > +	  Say yes here to build support for Analog Devices AD3552R
> > +	  Digital to Analog Converter High Speed driver.
> > +
> > +          The driver requires the assistance of an IP core to operate,
> > +          since data is streamed into target device via DMA, sent over a
> > +	  QSPI + DDR (Double Data Rate) bus.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ad3552r-hs.
> > +
> >  config AD3552R
> >  	tristate "Analog Devices AD3552R DAC driver"
> >  	depends on SPI_MASTER
> > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > index c92de0366238..d92e08ca93ca 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >  
> >  # When adding new entries keep the list in alphabetical order
> > +obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o ad3552r-common.o
> >  obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
> >  obj-$(CONFIG_AD5360) += ad5360.o
> >  obj-$(CONFIG_AD5380) += ad5380.o
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > new file mode 100644
> > index 000000000000..cb29a600e141
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -0,0 +1,526 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices AD3552R
> > + * Digital to Analog converter driver, High Speed version
> > + *
> > + * Copyright 2024 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/backend.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/units.h>
> > +
> > +#include "ad3552r.h"
> > +#include "ad3552r-hs.h"
> > +
> > +struct ad3552r_hs_state {
> > +	const struct ad3552r_model_data *model_data;
> > +	struct gpio_desc *reset_gpio;
> > +	struct device *dev;
> > +	struct iio_backend *back;
> > +	bool single_channel;
> > +	struct ad3552r_hs_platform_data *data;
> > +	bool ddr_mode;
> > +};
> > +
> > +static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> > +					u32 reg, u32 mask, u32 val,
> > +					size_t xfer_size)
> > +{
> > +	u32 rval;
> > +	int err;
> 
> Be consistent. You have a mixture of err and ret. Personally, slight preference for
> 'ret'.
> 
> > +
> > +	err = st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
> > +	if (err)
> > +		return err;
> > +
> > +	rval &= ~mask;
> > +	rval |= val;
> > +
> 
> nit: can be done in one liner...
> 
> > +	return st->data->bus_reg_write(st->back, reg, rval, xfer_size);
> > +}
> > +
> > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2, long mask)
> > +{
> > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > +		int sclk;
> > +
> > +		ret = iio_backend_read_raw(st->back, chan, &sclk, 0,
> > +					   IIO_CHAN_INFO_FREQUENCY);
> > +		if (ret != IIO_VAL_INT)
> > +			return -EINVAL;
> > +
> > +		/* Using 4 lanes (QSPI) */
> > +		*val = DIV_ROUND_CLOSEST(sclk * 4 * (1 + st->ddr_mode),
> > +					 chan->scan_type.storagebits);
> 
> If we assume ddr always on, don't forget to put that in a comment. In fact, please
> say that the sampling frequency is only about stream mode (buffering) on.
> 
> > +
> > +		return IIO_VAL_INT;
> > +	}
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = st->data->bus_reg_read(st->back,
> > +				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> > +				val, 2);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT;
> 
> Hmm, I think there's an important question here. How useful it is to have "just" raw
> writes? I don't think there's anything preventing us from supporting SCALE and OFFSET
> as the SPI driver? Those are important pieces for useland to be able to compute the
> peak voltage level, right? Or am I missing something?
> 
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int val, int val2, long mask)
> > +{
> > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +			return st->data->bus_reg_write(st->back,
> > +				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> > +				    val, 2);
> > +		}
> > +		unreachable();
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > +	struct iio_backend_data_fmt fmt = {
> > +		.type = IIO_BACKEND_DATA_UNSIGNED
> > +	};
> > +	int loop_len, val, err;
> > +
> > +	/* Inform DAC chip to switch into DDR mode */
> > +	err = ad3552r_qspi_update_reg_bits(st,
> > +					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +					   AD3552R_MASK_SPI_CONFIG_DDR,
> > +					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Inform DAC IP to go for DDR mode from now on */
> > +	err = iio_backend_ddr_enable(st->back);
> > +	if (err) {
> > +		dev_warn(st->dev, "could not set DDR mode, not streaming");
> 
> To me, this is an error so I would treat it as such. dev_err()
> 
> > +		goto exit_err;
> > +	}
> > +
> > +	st->ddr_mode = true;
> > +
> > +	switch (*indio_dev->active_scan_mask) {
> > +	case AD3552R_CH0_ACTIVE:
> > +		st->single_channel = true;
> > +		loop_len = 2;
> > +		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
> > +		break;
> > +	case AD3552R_CH1_ACTIVE:
> > +		st->single_channel = true;
> > +		loop_len = 2;
> > +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> > +		break;
> > +	case AD3552R_CH0_CH1_ACTIVE:
> > +		st->single_channel = false;
> > +		loop_len = 4;
> > +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> > +		break;
> > +	default:
> > +		err = -EINVAL;
> > +		goto exit_err_ddr;
> > +	}
> > +
> > +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> > +				      loop_len, 1);
> > +	if (err)
> > +		goto exit_err_ddr;
> > +
> > +	err = iio_backend_data_transfer_addr(st->back, val);
> > +	if (err)
> > +		goto exit_err_ddr;
> > +
> > +	err = iio_backend_data_format_set(st->back, 0, &fmt);
> > +	if (err)
> > +		goto exit_err_ddr;
> > +
> > +	err = iio_backend_data_stream_enable(st->back);
> > +	if (err)
> > +		goto exit_err_ddr;
> > +
> > +	return 0;
> > +
> > +exit_err_ddr:
> > +	iio_backend_ddr_disable(st->back);
> > +
> > +exit_err:
> > +	ad3552r_qspi_update_reg_bits(st,
> > +				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +				     AD3552R_MASK_SPI_CONFIG_DDR,
> > +				     0, 1);
> > +
> > +	iio_backend_ddr_disable(st->back);
> > +
> > +	st->ddr_mode = false;
> 
> 'ddr_mode' is pretty much used for the sampling freq, right? If we go the way of just
> reporting the buffering sampling freq, I guess you can drop this variable.
> 
> > +
> > +	return err;
> > +}
> > +
> > +static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > +	int err;
> > +
> > +	err = iio_backend_data_stream_disable(st->back);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Inform DAC to set in SDR mode */
> > +	err = ad3552r_qspi_update_reg_bits(st,
> > +					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +					   AD3552R_MASK_SPI_CONFIG_DDR,
> > +					   0, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	err = iio_backend_ddr_disable(st->back);
> > +	if (err)
> > +		return err;
> > +
> > +	st->ddr_mode = false;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
> > +				       unsigned int mode)
> > +{
> > +	return ad3552r_qspi_update_reg_bits(st,
> > +				AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> > +				AD3552R_MASK_CH_OUTPUT_RANGE,
> > +				FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode) |
> > +				FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode),
> > +				1);
> 
> I think you only call this function once, right? I would do this inline FWIW...
> 
> > +}
> > +
> > +static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> > +{
> > +	int err;
> > +
> > +	st->reset_gpio = devm_gpiod_get_optional(st->dev,
> > +						 "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->reset_gpio))
> > +		return PTR_ERR(st->reset_gpio);
> > +
> 
> I suspect you actually want GPIOD_OUT_HIGH? Assuming the reset is active low, you
> need to properly set it as such in DT. Then gpiolib will take care of things for you.
> Note that, GPIOD_OUT_HIGH means "give me the pin in the asserted state". So if it's
> active low, then it will be effectively be low.
> 
> > +	if (st->reset_gpio) {
> > +		fsleep(10);
> > +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> 
> Here you want to bring it out of reset and so de-assert the pin:
> 
> gpiod_set_value_cansleep(st->reset_gpio, 0);
> 
> Again, as long as you set the pin as active low in DT, gpiolib will negate the value
> for you internally.
> 

fixed all the rest. And added scale and offset (now readable from sysfs)
for the 2 channels, tested that using different ranges on the 2 channels works,
including custom ranges.

On this point i decided to use the active-high logic (active-low as negated reset
was more correct) becouse ad3552r.c is doing the same.
I can use the correct active-low logic here anyway.

> > +	} else {
> > +		err = ad3552r_qspi_update_reg_bits(st,
> > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > +					AD3552R_MASK_SOFTWARE_RESET,
> > +					AD3552R_MASK_SOFTWARE_RESET, 1);
> > +		if (err)
> > +			return err;
> > +	}
> > +	msleep(100);
> 
> nit: fsleep()
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_hs_scratch_pad_test(struct ad3552r_hs_state *st)
> > +{
> > +	int err, val;
> > +
> > +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > +				      AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > +				     &val, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL1) {
> > +		dev_err(st->dev,
> > +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> > +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
> > +		return -EIO;
> 
> This is in probing right? dev_err_probe()
> 
> > +	}
> > +
> > +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > +				      AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > +				     &val, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL2) {
> > +		dev_err(st->dev,
> > +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> > +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
> > +		return -EIO;
> 
> ditto
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
> > +					u16 gain, u16 offset)
> > +{
> > +	int err;
> > +
> > +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_OFFSET(0),
> > +				      offset, 1);
> > +	if (err)
> > +		return dev_err_probe(st->dev, err, "Error writing register\n");
> > +
> > +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_OFFSET(1),
> > +				      offset, 1);
> > +	if (err)
> > +		return dev_err_probe(st->dev, err, "Error writing register\n");
> > +
> > +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(0),
> > +				      gain, 1);
> > +	if (err)
> > +		return dev_err_probe(st->dev, err, "Error writing register\n");
> > +
> > +	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(1),
> > +				      gain, 1);
> > +	if (err)
> > +		return dev_err_probe(st->dev, err, "Error writing register\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> > +{
> > +	u8 gs_p, gs_n;
> > +	s16 goffs;
> > +	u16 id, rfb;
> > +	u16 gain = 0, offset = 0;
> > +	u32 val, range;
> > +	int err;
> > +
> > +	err = ad3552r_hs_reset(st);
> > +	if (err)
> > +		return err;
> > +
> > +	err = iio_backend_ddr_disable(st->back);
> > +	if (err)
> > +		return err;
> > +
> > +	err = ad3552r_hs_scratch_pad_test(st);
> > +	if (err)
> > +		return err;
> > +
> > +	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
> > +				     &val, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	id = val;
> > +
> > +	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
> > +				     &val, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	id |= val << 8;
> > +	if (id != st->model_data->chip_id)
> > +		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
> > +			 AD3552R_ID, id);
> > +
> > +	err = st->data->bus_reg_write(st->back,
> > +				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > +				      0, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	err = st->data->bus_reg_write(st->back,
> > +				      AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > +				      AD3552R_MASK_QUAD_SPI |
> > +				      AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	err = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> > +	if (err)
> > +		return err;
> > +
> > +	err = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> > +	if (err)
> > +		return err;
> > +
> > +	err = ad3552r_get_ref_voltage(st->dev);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	val = err;
> 
> Then, 'err' is not an error. I don't really like of mixing return values (errors)
> with values. Please pass the value as a pointer argument to the function.
> 
> > +
> > +	err = ad3552r_qspi_update_reg_bits(st,
> > +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> > +				val, 1);
> > +	if (err)
> > +		return err;
> > +
> > +	err = ad3552r_get_drive_strength(st->dev, &val);
> > +	if (!err) {
> > +		err = ad3552r_qspi_update_reg_bits(st,
> > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> > +					val, 1);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	struct fwnode_handle *child __free(fwnode_handle) =
> > +				device_get_named_child_node(st->dev, "channel");
> > +	if (!child)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * One of "adi,output-range-microvolt" or "custom-output-range-config"
> > +	 * must be available in fdt.
> > +	 */
> > +	err = ad3552r_get_output_range(st->dev, st->model_data, child, &range);
> > +	if (!err)
> > +		return ad3552r_hs_set_output_range(st, range);
> > +	if (err != -ENOENT)
> > +		return err;
> 
> It seems to me you're already getting the span values so it should be possible to
> export them via sysfs as the spi driver, right?
> 
> > +
> > +	err = ad3552r_get_custom_gain(st->dev, child, &gs_p, &gs_n, &rfb,
> > +				      &goffs);
> > +	if (err)
> > +		return err;
> > +
> > +	gain = ad3552r_calc_custom_gain(gs_p, gs_n, goffs);
> > +	offset = abs(goffs);
> > +
> > +	return ad3552r_hs_setup_custom_gain(st, gain, offset);
> > +}
> > +
> > +static const struct iio_buffer_setup_ops ad3552r_hs_buffer_setup_ops = {
> > +	.postenable = ad3552r_hs_buffer_postenable,
> > +	.predisable = ad3552r_hs_buffer_predisable,
> > +};
> > +
> > +#define AD3552R_CHANNEL(ch) { \
> > +	.type = IIO_VOLTAGE, \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > +	.output = 1, \
> > +	.indexed = 1, \
> > +	.channel = (ch), \
> > +	.scan_index = (ch), \
> > +	.scan_type = { \
> > +		.sign = 'u', \
> > +		.realbits = 16, \
> > +		.storagebits = 16, \
> > +		.endianness = IIO_BE, \
> > +	} \
> > +}
> > +
> > +static const struct iio_chan_spec ad3552r_hs_channels[] = {
> > +	AD3552R_CHANNEL(0),
> > +	AD3552R_CHANNEL(1),
> > +};
> > +
> > +static const struct iio_info ad3552r_hs_info = {
> > +	.read_raw = &ad3552r_hs_read_raw,
> > +	.write_raw = &ad3552r_hs_write_raw,
> > +};
> > +
> > +static int ad3552r_hs_probe(struct platform_device *pdev)
> > +{
> > +	struct ad3552r_hs_state *st;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->dev = &pdev->dev;
> > +
> > +	st->data = pdev->dev.platform_data;
> > +	if (!st->data)
> > +		dev_err_probe(st->dev, -ENODEV, "No platform data !");
> 
> return dev_err_probe()
> 
> > +
> > +	st->back = devm_iio_backend_get(&pdev->dev, NULL);
> > +	if (IS_ERR(st->back))
> > +		return PTR_ERR(st->back);
> > +
> > +	ret = devm_iio_backend_enable(&pdev->dev, st->back);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->model_data = device_get_match_data(&pdev->dev);
> 
> error handling...
> 
> if (!st->model_data)
> 	return -ENODEV; (or -EINVAL) - it seems there's no consensus in what to
> return here.
> 
> - Nuno Sá
> 

