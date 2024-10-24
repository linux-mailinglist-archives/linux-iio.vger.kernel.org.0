Return-Path: <linux-iio+bounces-11137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F39AE9AA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E82282695
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E81E5735;
	Thu, 24 Oct 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DUSQTcOL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3A1B6CE2
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782206; cv=none; b=ufTiayKdDpyBmTCD8AeFw56Gh8aJIySZURzNWm3YurSIDaN+RIZsSFm8uqB3TJkj7EFrL4k/xr+LWInxvHM+hnFqLxqx7THSERKC3TU+hOU+1qZCs9azRrrW7Rvp7xTWRWrw9Y5nHfOOKyt4pSD2LHC28I7i2EAnsU9kXlVk/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782206; c=relaxed/simple;
	bh=82/MM5hf9ZEr0CJHsz8MSScVur+iod4qjTOh/MZV2UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlyRX8IgVgp5+/WI0kaA3+YoAh1b7mYYStoC8o0hURLwsre0huygxhGapCr1tFStGEmHS9kmKjdR3t710kCFUnEAUpZCy8h20GhRCXzWu+7M0+fwcvWAKcp25DVnL+w9oR1E0xiTYHKRfBm5kJ4m1BFwgfjyHiSWb6BcREbWSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DUSQTcOL; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so10852025e9.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729782199; x=1730386999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tKqYi92b+Fs0u/npvqVvdzU8rT7c0aEstmKJH9HAER4=;
        b=DUSQTcOL5f3EhsxGZVGyy5RlSj0BR2DKtAP1R5W/Cmu8q5E83RUYrz2X/6HaWMcT+K
         Vl6vn67AzUMRtLpA2jREHJlZShGfpudDz84fbdBMkGMU+7tewTk23ISKR6aBzhYAMSKa
         jHRn24UtsOX7Y9xNyWAKn5FM1ezkyI3LhmEJ6cxNmHTeuTxJbwAzdnKGqxUIa2545Dsu
         6/3/figWHOKFNpRoE0Z8qA4yJnd5CFajmg1rNSf/ShPgb+7++m0XcwjbkHznYNr9lCCg
         qXQlRSkD11PNY3iYM7ThD5Qx05OfKhPl6W1tjchozMIJXsFv5CpvEixNtjcfd9M1Se/V
         +7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782199; x=1730386999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKqYi92b+Fs0u/npvqVvdzU8rT7c0aEstmKJH9HAER4=;
        b=bOZQhlnYiSvckbI9Ob0hbXdJRTqwOcKn8P7EAKISkjN89svDRA7Cl+iMUwRw9UKMwQ
         8u5tTcuEontgoP+8f6ogD/Eyjf29PQfM2BzKhehEPVmLDvkDZnaMcnHXNmjjm2TigDyx
         wGrlWbC+6e8IAUr4CQtr2pB7xDxs+cMOjtEd96/Ms/xBq0cYnJsmuTqJGPQucZxxbAQB
         jqH+FQUfRXnqydAzU+415Uj1fIzEWV6w8sBskSGKzctBG7dWyLXFSLw5pxGJ4KD3J0Cy
         1rbPGPVSvJqgSHrESnueMKv1y46KE1Soe5w05PSf3R29CeaYKZuBBd0MMqPeip8sEjm+
         9q6g==
X-Forwarded-Encrypted: i=1; AJvYcCUbldNNNfahgAvlRk+SEWN4oTo7I9bzy9Gy3wTZjcuN6qz/opUK0cEsh7q66EmLRMMw9duRGnKyTfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDIiXa5vfpKRj4HCHI0pn1F+MM3aNnejcWu0ihqQ4s7f4NFJ6
	aXiduUdx2lwZpVwAidTAEfsmb7z6Vp+B8xxt/hRI9GF52YweTKjkzqVabwcc4GU=
X-Google-Smtp-Source: AGHT+IFbJMdDF99zThXTNyFj0ffG6BJQ1FsiXwBEGd4Tcq2EPBWcG4YumGlyxmThzlJv+3S3uMB46A==
X-Received: by 2002:a05:600c:314b:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-4318c6f14f7mr20171505e9.13.1729782197408;
        Thu, 24 Oct 2024 08:03:17 -0700 (PDT)
Received: from dfj (host-79-41-194-153.retail.telecomitalia.it. [79.41.194.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d02dd84sm58669735e9.0.2024.10.24.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:03:16 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:02:00 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 7/8] iio: dac: ad3552r: add high-speed platform driver
Message-ID: <wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
 <9f00e86e8a7d8f821cdb79d5b083235daec481a9.camel@gmail.com>
 <exprb7zhsr5qbpjdhbxisodmm4pf74hwl7ijql5o6zyuc3assg@sf53j42lzurf>
 <14d0f5fb4240a7e0c3665d4ffc128117c5515ac6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14d0f5fb4240a7e0c3665d4ffc128117c5515ac6.camel@gmail.com>

Hi Nuno,

On 24.10.2024 15:05, Nuno Sá wrote:
> On Tue, 2024-10-22 at 18:40 +0200, Angelo Dureghello wrote:
> > Hi Nuno,
> > 
> > On 22.10.2024 14:28, Nuno Sá wrote:
> > > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > 
> > > > Add High Speed ad3552r platform driver.
> > > > 
> > > > The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> > > > through the current AXI backend, or similar alternative IIO backend.
> > > > 
> > > > Compared to the existing driver (ad3552r.c), that is a simple SPI
> > > > driver, this driver is coupled with a DAC IIO backend that finally
> > > > controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> > > > maximum transfer rate of 33MUPS using dma stream capabilities.
> > > > 
> > > > All commands involving QSPI bus read/write are delegated to the backend
> > > > through the provided APIs for bus read/write.
> > > > 
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > >  drivers/iio/dac/Kconfig      |  14 ++
> > > >  drivers/iio/dac/Makefile     |   1 +
> > > >  drivers/iio/dac/ad3552r-hs.c | 547
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/iio/dac/ad3552r-hs.h |  18 ++
> > > >  drivers/iio/dac/ad3552r.h    |   4 +
> > > >  5 files changed, 584 insertions(+)
> > > > 
> > > > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > > > index fa091995d002..fc11698e88f2 100644
> > > > --- a/drivers/iio/dac/Kconfig
> > > > +++ b/drivers/iio/dac/Kconfig
> > > > @@ -6,6 +6,20 @@
> > > >  
> > > >  menu "Digital to analog converters"
> > > >  
> > > > +config AD3552R_HS
> > > > +	tristate "Analog Devices AD3552R DAC High Speed driver"
> > > > +	select ADI_AXI_DAC
> > > > +	help
> > > > +	  Say yes here to build support for Analog Devices AD3552R
> > > > +	  Digital to Analog Converter High Speed driver.
> > > > +
> > > > +          The driver requires the assistance of an IP core to operate,
> > > > +          since data is streamed into target device via DMA, sent over a
> > > > +	  QSPI + DDR (Double Data Rate) bus.
> > > > +
> > > > +	  To compile this driver as a module, choose M here: the
> > > > +	  module will be called ad3552r-hs.
> > > > +
> > > >  config AD3552R
> > > >  	tristate "Analog Devices AD3552R DAC driver"
> > > >  	depends on SPI_MASTER
> > > > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > > > index c92de0366238..d92e08ca93ca 100644
> > > > --- a/drivers/iio/dac/Makefile
> > > > +++ b/drivers/iio/dac/Makefile
> > > > @@ -4,6 +4,7 @@
> > > >  #
> > > >  
> > > >  # When adding new entries keep the list in alphabetical order
> > > > +obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o ad3552r-common.o
> > > >  obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
> > > >  obj-$(CONFIG_AD5360) += ad5360.o
> > > >  obj-$(CONFIG_AD5380) += ad5380.o
> > > > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > > > new file mode 100644
> > > > index 000000000000..27bdc35fdc29
> > > > --- /dev/null
> > > > +++ b/drivers/iio/dac/ad3552r-hs.c
> > > > @@ -0,0 +1,547 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Analog Devices AD3552R
> > > > + * Digital to Analog converter driver, High Speed version
> > > > + *
> > > > + * Copyright 2024 Analog Devices Inc.
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/iio/backend.h>
> > > > +#include <linux/iio/buffer.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/property.h>
> > > > +#include <linux/units.h>
> > > > +
> > > > +#include "ad3552r.h"
> > > > +#include "ad3552r-hs.h"
> > > > +
> > > > +struct ad3552r_hs_state {
> > > > +	const struct ad3552r_model_data *model_data;
> > > > +	struct gpio_desc *reset_gpio;
> > > > +	struct device *dev;
> > > > +	struct iio_backend *back;
> > > > +	bool single_channel;
> > > > +	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
> > > > +	struct ad3552r_hs_platform_data *data;
> > > > +};
> > > > +
> > > > +static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> > > > +					u32 reg, u32 mask, u32 val,
> > > > +					size_t xfer_size)
> > > > +{
> > > > +	u32 rval;
> > > > +	int ret;
> > > > +
> > > > +	ret = st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	rval = (rval & ~mask) | val;
> > > > +
> > > > +	return st->data->bus_reg_write(st->back, reg, rval, xfer_size);
> > > > +}
> > > > +
> > > > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > > > +			       struct iio_chan_spec const *chan,
> > > > +			       int *val, int *val2, long mask)
> > > > +{
> > > > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > > > +	int ret;
> > > > +	int ch = chan->channel;
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > > +		int sclk;
> > > > +
> > > > +		ret = iio_backend_read_raw(st->back, chan, &sclk, 0,
> > > > +					   IIO_CHAN_INFO_FREQUENCY);
> > > > +		if (ret != IIO_VAL_INT)
> > > > +			return -EINVAL;
> > > > +
> > > 
> > > I just saw you had some questions on v6 that everyone failed to see. See my
> > > reply to David here:
> > > 
> > > https://lore.kernel.org/linux-iio/61cf3072af74a8b2951c948ddc2383ba1e55954d.camel@gmail.com/
> > > 
> > > It should be easy and it's something that makes sense (at least to me :))
> > > 
> > 
> > I understood that we would improve things later in case.
> > 
> > Could we maybe stay with IIO_CHAN_INFO_FREQUENCY ? It doesn't seems to me
> > so out of scope. Sorry but i am trying to finalize someway this job,
> > so i am trying to conatain changes now at v7, if code is not really 
> > totally wrong.
> 
> I think you're trying to rush in the series. I can understand your frustration but
> believe me that v7 (or v8) is not so bad :).
> 
> David already raised concerns about using IIO_CHAN_INFO_FREQUENCY. I'm also not a fan
> of it and gave you another option that should be trivial and makes sense (given that
> bus_read and write are already being done through the platform_data interface). So
> no, I don't think we're going to accept "is not really totally wrong.". IOW, We want
> it to be totally right - if such a thing exists :).
> 
> > 

i changed this way, using platform_data:

static int axi_dac_bus_clok(struct iio_backend *back)
{
	struct axi_dac_state *st = iio_backend_get_priv(back);

	/*
	 * Returning here always the maximum (buffering mode)
	 * clock rate.
	 */
	return st->dac_clk_rate;
}

And, on ad3552r-hs.c

static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
			       struct iio_chan_spec const *chan,
			       int *val, int *val2, long mask)
{
	struct ad3552r_hs_state *st = iio_priv(indio_dev);
	int ret;
	int ch = chan->channel;

	switch (mask) {
	case IIO_CHAN_INFO_SAMP_FREQ:
		/*
		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
		 * considered always on (considering buffering mode always).
		 */
		*val = DIV_ROUND_CLOSEST(st->data->bus_clock(st->back) * 4 * 2,
					 chan->scan_type.realbits);

		return IIO_VAL_INT;

	case IIO_CHAN_INFO_RAW:


Let me know if you see any issue.


> > > > +		/*
> > > > +		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
> > > > +		 * considered always on (considering buffering mode always).
> > > > +		 */
> > > > +		*val = DIV_ROUND_CLOSEST(sclk * 4 * 2,
> > > > +					 chan->scan_type.realbits);
> > > > +
> > > > +		return IIO_VAL_INT;
> > > > +	}
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		ret = st->data->bus_reg_read(st->back,
> > > > +				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> > > > +				val, 2);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		return IIO_VAL_INT;
> > > > +	case IIO_CHAN_INFO_SCALE:
> > > > +		*val = st->ch_data[ch].scale_int;
> > > > +		*val2 = st->ch_data[ch].scale_dec;
> > > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > > +	case IIO_CHAN_INFO_OFFSET:
> > > > +		*val = st->ch_data[ch].offset_int;
> > > > +		*val2 = st->ch_data[ch].offset_dec;
> > > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
> > > > +				struct iio_chan_spec const *chan,
> > > > +				int val, int val2, long mask)
> > > > +{
> > > > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > > > +			return st->data->bus_reg_write(st->back,
> > > > +				    AD3552R_REG_ADDR_CH_DAC_16B(chan-
> > > > > channel),
> > > > +				    val, 2);
> > > > +		}
> > > 
> > > Maybe we'll get the new stuff in time for this :)
> > > 
This is not clear, sorry.

 > > ...
> > > 
> > > > +
> > > > +static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * Using inverted "active-high" logic here, since ad3552r classic-spi
> > > > +	 * fdt node (and driver) is using the same logic.
> > > > +	 */
> > > > +
> > > 
> > > I don't understand this. This is a new device with a different compatible. Why
> > > keeping the wrong logic? AFAICT, there's nothing in the bindings about the pin
> > > polarity.
> > > 
> > 
> > ad3552r.c uses same compatible (adi,ad3552r), and in the code it implements 
> > this same inverted logic. So i thought to use the same logic.
> > I can anyway change to the correct active-low logic for this driver, 
> > but would honestly not enter in fixing old code now at v7. 
> > Happy to do such fix on ad3552r.c later on.
> 
> Ok, bad example from me with the compatible. The point is this is a different device.
> It's a platform device while the other one is a spi device. So why doing it wrong in
> here? Not saying to change the other device logic, just not doing it deliberately
> wrong in a new device.

Ok, i'll use active-low so.

> 
> For the old device, we can't likely change it as we could break current users who
> just adapted their DTs to conform to the driver logic.
> 
> > 
> > > > +	st->reset_gpio = devm_gpiod_get_optional(st->dev,
> > > > +						 "reset", GPIOD_OUT_LOW);
> > > > +	if (IS_ERR(st->reset_gpio))
> > > > +		return PTR_ERR(st->reset_gpio);
> > > > +
> > > > +	if (st->reset_gpio) {
> > > > +		fsleep(10);
> > > > +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> > > > +	} else {
> > > > +		ret = ad3552r_qspi_update_reg_bits(st,
> > > > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > > > +					AD3552R_MASK_SOFTWARE_RESET,
> > > > +					AD3552R_MASK_SOFTWARE_RESET, 1);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +	msleep(100);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ad3552r_hs_scratch_pad_test(struct ad3552r_hs_state *st)
> > > > +{
> > > > +	int ret, val;
> > > > +
> > > > +	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > > > +				      AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > > > +				     &val, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL1)
> > > > +		return dev_err_probe(st->dev, -EIO,
> > > > +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read
> > > > 0x%x\n",
> > > > +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
> > > > +
> > > > +	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > > > +				      AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> > > > +				     &val, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL2)
> > > > +		return dev_err_probe(st->dev, -EIO,
> > > > +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read
> > > > 0x%x\n",
> > > > +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
> > > > +					int ch, u16 gain, u16 offset)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = st->data->bus_reg_write(st->back,
> > > > AD3552R_REG_ADDR_CH_OFFSET(ch),
> > > > +				      offset, 1);
> > > > +	if (ret)
> > > > +		return dev_err_probe(st->dev, ret, "Error writing
> > > > register\n");
> > > > +
> > > > +	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(ch),
> > > > +				      gain, 1);
> > > > +	if (ret)
> > > > +		return dev_err_probe(st->dev, ret, "Error writing
> > > > register\n");
> > > > +
> > > > +	return 0;
> > > 
> > > nit: Not a big fan of these logs on read/write registers functions... Also seems
> > > that you're not being consistent (either you have them or not). FWIW, I would
> > > simplify and drop them. That would allow to do
> > > 
> > > return st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(ch), gain, 1);
> > > 
> > 
> > Used dev_err_probe on quite all probe functions.
> > I don't see nothing really wrong on this codem except maybe a more meaningful
> > message.
> 
> No, you're not being consistent. You have another calls (example: st->data-
> >bus_reg_rea()) where no log is being given. 
>


 
> > 
> > > > +}
> > > > +
> > > > +static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> > > > +{
> > > > +	s16 goffs;
> > > > +	u16 id;
> > > > +	u16 gain = 0, offset = 0;
> > > > +	u32 ch, val, range;
> > > > +	int ret;
> > > > +
> > > > +	ret = ad3552r_hs_reset(st);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = iio_backend_ddr_disable(st->back);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = ad3552r_hs_scratch_pad_test(st);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
> > > > +				     &val, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	id = val;
> > > > +
> > > > +	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
> > > > +				     &val, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	id |= val << 8;
> > > > +	if (id != st->model_data->chip_id)
> > > > +		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read
> > > > 0x%x\n",
> > > > +			 AD3552R_ID, id);
> > > > +
> > > > +	ret = st->data->bus_reg_write(st->back,
> > > > +				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > > > +				      0, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = st->data->bus_reg_write(st->back,
> > > > +				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > > > +				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> > > > +					   AD3552R_QUAD_SPI) |
> > > > +				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = ad3552r_get_ref_voltage(st->dev, &val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	val = ret;
> > > > +
> > > > +	ret = ad3552r_qspi_update_reg_bits(st,
> > > > +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > > > +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> > > > +				val, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = ad3552r_get_drive_strength(st->dev, &val);
> > > > +	if (!ret) {
> > > > +		ret = ad3552r_qspi_update_reg_bits(st,
> > > > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > > > +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> > > > +					val, 1);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > > +	device_for_each_child_node_scoped(st->dev, child) {
> > > > +		ret = fwnode_property_read_u32(child, "reg", &ch);
> > > > +		if (ret)
> > > > +			return dev_err_probe(st->dev, ret,
> > > > +					     "reg property missing\n");
> > > > +
> > > > +		ret = ad3552r_get_output_range(st->dev, st->model_data,
> > > > child,
> > > > +					       &range);
> > > > +		if (!ret) {
> > > > +			st->ch_data[ch].range = range;
> > > > +
> > > > +			ret = ad3552r_hs_set_output_range(st, ch, range);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +
> > > > +		} else if (ret == -ENOENT) {
> > > > +			ret = ad3552r_get_custom_gain(st->dev, child,
> > > > +						&st->ch_data[ch].p,
> > > > +						&st->ch_data[ch].n,
> > > > +						&st->ch_data[ch].rfb,
> > > > +						&st-
> > > > > ch_data[ch].gain_offset);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +
> > > > +			gain = ad3552r_calc_custom_gain(st->ch_data[ch].p,
> > > > +						st->ch_data[ch].n,
> > > > +						st->ch_data[ch].gain_offset);
> > > > +			offset = abs(goffs);
> > > > +
> > > > +			st->ch_data[ch].range_override = 1;
> > > > +
> > > > +			ret = ad3552r_hs_setup_custom_gain(st, ch, gain,
> > > > +							   offset);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +		} else {
> > > > +			return ret;
> > > > +		}
> > > 
> > > Just personal preference... I think this would be neater:
> > > if (ret && ret != ENOENT)
> > > 	return ret;
> > > if (ret == -ENOENT) {
> > > 	...
> > > } else {
> > > 	...
> > > }
> > > 
> > > Advantage is that it also handles errors first (which is the typical pattern)
> > 
> > I tested this code, would not change possibly now at this stage,
> > unless another version should be sent.
> 
> Not sure if we'll need another but personally I cannot ack this one as it stands...
> sorry.
> 
> >  
> > > 
> > > > +
> > > > +		ad3552r_calc_gain_and_offset(&st->ch_data[ch], st-
> > > > > model_data);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct iio_buffer_setup_ops ad3552r_hs_buffer_setup_ops = {
> > > > +	.postenable = ad3552r_hs_buffer_postenable,
> > > > +	.predisable = ad3552r_hs_buffer_predisable,
> > > > +};
> > > > +
> > > > +#define AD3552R_CHANNEL(ch) { \
> > > > +	.type = IIO_VOLTAGE, \
> > > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> > > > +			      BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > > > +			      BIT(IIO_CHAN_INFO_SCALE) | \
> > > > +			      BIT(IIO_CHAN_INFO_OFFSET), \
> > > > +	.output = 1, \
> > > > +	.indexed = 1, \
> > > > +	.channel = (ch), \
> > > > +	.scan_index = (ch), \
> > > > +	.scan_type = { \
> > > > +		.sign = 'u', \
> > > > +		.realbits = 16, \
> > > > +		.storagebits = 16, \
> > > > +		.endianness = IIO_BE, \
> > > > +	} \
> > > > +}
> > > > +
> > > > +static const struct iio_chan_spec ad3552r_hs_channels[] = {
> > > > +	AD3552R_CHANNEL(0),
> > > > +	AD3552R_CHANNEL(1),
> > > > +};
> > > > +
> > > > +static const struct iio_info ad3552r_hs_info = {
> > > > +	.read_raw = &ad3552r_hs_read_raw,
> > > > +	.write_raw = &ad3552r_hs_write_raw,
> > > > +};
> > > > +
> > > > +static int ad3552r_hs_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct ad3552r_hs_state *st;
> > > > +	struct iio_dev *indio_dev;
> > > > +	int ret;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	st = iio_priv(indio_dev);
> > > > +	st->dev = &pdev->dev;
> > > > +
> > > > +	st->data = pdev->dev.platform_data;
> > > 
> > > dev_get_platdata()
> > > 
> > 
> > pdev->dev.platform_data seems correct to me, used in a lot of places
> > in the driver framework. Can we stay with it ?
> > 
> 
> It is correct but if we an helper, why not using it? It may be used in a lot of
> places just because the helper was added afterwards...
> 

> - Nuno Sá
> > 


