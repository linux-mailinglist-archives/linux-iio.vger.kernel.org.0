Return-Path: <linux-iio+bounces-11513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422AB9B3A2D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A8C1C215B1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C551E00AB;
	Mon, 28 Oct 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HZGb7ZlI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E21DFE03
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142639; cv=none; b=lznEL0UTSxHlIi9vrFSVfU2fNPX+Pe9pMDKwAUbGgMuA5DpOKU7aOWjtoDDA1bQ4MLKNUDgiNqjv5kCMfSv9NJQ5/NQE1FXVnzLqA8evzz5VaIunbn1mZ8L0xtE2J619bM5bqKssFqhuRrRYLMaFyOFrbs/8wu4jUNrI1akw8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142639; c=relaxed/simple;
	bh=eBr7O8jgvyFtqQEzlexrq1nufPpXVsF2EjcCgTai22Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdGHhHhxVv7PQEowxThMuMUJUorwFJWsC0rkVVasBZj/EOqMiB6tJv1SdKYBk3OATedXJvG795Sd2yGNvmXSikOJm6uo1nWsW5v126LDP4PKz1MjBuYlp+IoSvCK0wG4nj3BVBIltdgPxGSeGuM8AsQuHfhzGswYWb4IvtvhBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HZGb7ZlI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43159c9f617so45480625e9.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730142634; x=1730747434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L10yUofLH8XPsAS4cVJmjIfrnlUIvigu/fIf9MIkn7w=;
        b=HZGb7ZlIn3Yxtu2eZgjDeAHBfhq6BUSiTYZ04A8eyD2CWlO0hCVrCGITzAkR+5W3+S
         AsD9cCLjF1Gcrw2keh8+Gof+KqmhWa91WPUIFnuyFseKimZuuqpNMQzp7FZKHJ/IEAV+
         OmIyskdI6uegA+ec+FcL/hUmxixHSMh3Tr3p4b0Dggpa4zqDqm/i0VHKyKHX+udh/icS
         Lz8dWAkd66OkzeQCoBafOlrTOinixbSgJxbsxuMFkQ8CgNZhlbwfYiJdQWRpsrhgPLgm
         Z+DWScNwx6p3ojGELe5M7SXJ3nBiKbpf5FX6ih4vtwevUAHh4nG1HPeuwBdmBYbDTiWy
         QZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142634; x=1730747434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L10yUofLH8XPsAS4cVJmjIfrnlUIvigu/fIf9MIkn7w=;
        b=C1SEzgLblsSXkxj1oegzIqhDMV8dJ+XMPhA4aNA4++yLjqwIrrlVk5run9+VU0m0W3
         hjh2A7/xNnvnUjf/gh5FpmYXT6ygmci7mP22K2rUYqBNbRebgRSnXmGTeqPYjVeRfkFD
         oEFHZoleqh8elTx0MWCJQJFjTzf+GIbHyYm7PILLiAUxqzxIekG2ZM6MWbcsa83Sh1+A
         ckTZEYnCYxi9XfIqwSkPtklaD94obnkndqC54LEBF3fArvQ0CXsT2QvnT5BSHsWK9mZ/
         42FwbQYK2lab06wusiu0qzg3apIAM1RMM6tVcD+wF/5/PT+GRQTiD+nHu3eExkiF2Biq
         W/BA==
X-Forwarded-Encrypted: i=1; AJvYcCUDNAkrJKKAx2tZ/bfb08agzF+e4ufH2rW69gEpaS446AqS8rzmX7/wQS+inWMCHruCAzWq/9ENyqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OLF5p86EAMXAirPHfJZjD5D8GWcsbZdjRoM2dAPw6EvnsnK7
	otEIm+c6LwDjdoBapdjhxEvd0Oai1wLaFgf410UXNTonZkdR20ITLiK2NliwiDM=
X-Google-Smtp-Source: AGHT+IGTsFXvy4vJ99Z2Im7p+NClcS5udDWd+QRNpHOTV/WKmRhexgfxDcwS+NJJDls3U107YvFvMg==
X-Received: by 2002:a5d:55c4:0:b0:37d:47fe:7c59 with SMTP id ffacd0b85a97d-3806100cecemr7692737f8f.0.1730142634134;
        Mon, 28 Oct 2024 12:10:34 -0700 (PDT)
Received: from dfj (host-95-245-34-85.retail.telecomitalia.it. [95.245.34.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b48226sm10312260f8f.60.2024.10.28.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:10:33 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:09:15 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, dlechner@baylibre.com
Subject: Re: [PATCH v8 7/8] iio: dac: ad3552r: add high-speed platform driver
Message-ID: <yslngc6n36qwlxerzovim6buvn5mjvdc6jkik2by75c774n6hz@g22cqy6vflcm>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
 <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-7-74ca7dd60567@baylibre.com>
 <04e90dcf73bf87495e06639bd31160b848bde207.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04e90dcf73bf87495e06639bd31160b848bde207.camel@gmail.com>

Hi Nuno,

On 28.10.2024 14:34, Nuno Sá wrote:
> On Fri, 2024-10-25 at 11:49 +0200, Angelo Dureghello wrote:
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
> LGTM, just one question inline. If not an issue:
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 
> >  drivers/iio/dac/Kconfig      |  14 ++
> >  drivers/iio/dac/Makefile     |   1 +
> >  drivers/iio/dac/ad3552r-hs.c | 530 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iio/dac/ad3552r-hs.h |  19 ++
> >  drivers/iio/dac/ad3552r.h    |   4 +
> >  5 files changed, 568 insertions(+)
> > 
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index 26f9de55b79f..f76eaba140d8 100644
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
> > index 000000000000..97dfc598aec6
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -0,0 +1,530 @@
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
> > +	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
> > +	struct ad3552r_hs_platform_data *data;
> > +};
> > +
> > +static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> > +					u32 reg, u32 mask, u32 val,
> > +					size_t xfer_size)
> > +{
> > +	u32 rval;
> > +	int ret;
> > +
> > +	ret = st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rval = (rval & ~mask) | val;
> > +
> > +	return st->data->bus_reg_write(st->back, reg, rval, xfer_size);
> > +}
> > +
> > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2, long mask)
> > +{
> > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +	int ch = chan->channel;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		/*
> > +		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
> > +		 * considered always on (considering buffering mode always).
> > +		 */
> > +		*val = DIV_ROUND_CLOSEST(st->data->bus_sample_data_clock_hz *
> > +					 4 * 2, chan->scan_type.realbits);
> > +
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = st->data->bus_reg_read(st->back,
> > +				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> > +				val, 2);
> > +		if (ret)
> > +			return ret;
> 
> Is there any potential issue by doing a raw access when streaming?
>

seems not creating any issue, even if, on write while buffering
i get an error, that should be ok:

root@analog:~# echo 45222 > /sys/bus/iio/devices/iio\:device0/out_voltage0_raw 
-bash: echo: write error: Device or resource busy

while on raw read i always get a value of "1", not clear why.
 
Once stopped the buffering, raw read/write works back properly.

> - Nuno Sá
> 
> 
regards,
  angelo

