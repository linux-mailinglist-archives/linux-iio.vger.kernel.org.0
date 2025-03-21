Return-Path: <linux-iio+bounces-17183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C67A6C3C3
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 127077A7BCB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7231EF090;
	Fri, 21 Mar 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfB1RpcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECE18FC75;
	Fri, 21 Mar 2025 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586809; cv=none; b=khULmtWyD/mHsB3c6/kmz+Ve+kFu6LTQ3otu1pPw2BX0rYe3GKeUAH5YHn0eqP20M9ILmfHeoC7WcIs9fSO3QKBeIrQLOvnSf6pf87nkYdQnvQw1/pFAiRmbTMcXSLxY73RUP6NsykTsz3bDs6zSiGr3crV1+Yx75r5eQuNTTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586809; c=relaxed/simple;
	bh=PepEawDlAhfft5Kfof5D4dNZild5PgEwhpRwDzrtsis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwsrGIYbQ9yluJ+8iwGjmHsvTzZhdfGuhQFKFxbP5vfz2LOOZbG7jOlxJVu2U65cQK9LsMT6NMzE+d+WBFNQ1vovGkSvNBWwEFDDEj7/HlKM73nprdHVLAk/VBXKMFgTmNwncWgXuS/sgMJgseq/kSIG5M/VAanVYufw4QC0lx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfB1RpcM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225fbdfc17dso40350935ad.3;
        Fri, 21 Mar 2025 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742586807; x=1743191607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdURz2Kaz0+qhRK8StocNSydHxInyqrwDwL12Xdfbr8=;
        b=hfB1RpcMyAR3c+Oh23L0o17gTfIAKKK3S1LOhmVwXljuiS4jEQmwRD1hejCmDWJBsj
         ZDoc2a69Q8czJjZsE9ZiK43PY6fnHW6YS7FeRjOJ/BZFatVKE5s/vz26T1oeELB+xG3f
         LwS2L7Qwd9Sib0f5X6bdbQPDf4YqtteAApotLYGNmxs7dx20NW3wygCB1zPuTRSxbyaG
         MmdL4gB5zkHB/Qf/+L3Zbo2qnQNY+/pxVPAQJLvKulTs/+0C57xS4KqQNfGie/GpTnjw
         S0d5ce2NAiZHNRG5eypoLoHyyYC8JEhBMqAo1uaxKuZqVwPDEzNGZekHVi9gzARYlokB
         LeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586807; x=1743191607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdURz2Kaz0+qhRK8StocNSydHxInyqrwDwL12Xdfbr8=;
        b=p/55yG2rqBzZXBh67Um0mJMJAW2YqfJVR8SikhPpxT+i49HPHcNZOJJ0PNv2/pzseL
         bRiSzsbMDX5OQqK2ivty5ntwASHFcuj/+5HZwgIeTa5X2KKFq/oNGJrZslX7zCqV7Kgt
         8RnazX3LSORJxN0Tia6plNs6nTrZoozDERyudxfzySpx5/s9Kuwtw1Kcw20gldycPklb
         Et8eoaTeRQGp81pYxJYaDlUxtIpRZBM8xMXhBawiU39RLSYvApyZCSPwTp9Mo87ysUaZ
         qpLCyJT+vBoMbpGxR9YtiNMDBSAvjXPCx5lXZtsFhEneN2ExPPj1aDOgcXxDN9Nk90PB
         RU0g==
X-Forwarded-Encrypted: i=1; AJvYcCUIHohQYfEsKd2415XfV7cy2JoGBkix7aZBm9T3KPOqDa/HK07NX+cto9dezFhXJUwXoLR0kTDORvM=@vger.kernel.org, AJvYcCUnCZUm/747rXJTeg/mBRXOL3Cu2YJrfzC2ahOLiWlbbGtOWCGqoDfWj5SI6Wc7YbqfikbTSkSXK8sWPpTx@vger.kernel.org, AJvYcCWTn3CwUP1/i6wrxN7gIySxxCEK+ry97ZA6Wgj+7I4DntWkIZzdWkX0pNwYya3VZERide+5sjUTE1M2@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3l1vrQzf6hH7YhFnOtHP6HJ3XaY+pfuP5eGn/NvU9uzofRXs
	EH1Y8i2gHj67xiaGaOx64bxdzcvdeqDyxI/xpBGPoK561vMAlluU
X-Gm-Gg: ASbGncvxdgTmnud3YE81sidVir6pWpnlpYHUnTddsb/EA5v72P0UQv2WWpnaItY13jN
	o2ppjSBnAqZocGlpWGQQdyQDIA5dDBNP6cx9Bo/ahK9r9lfxhNshwmsn1lXhBtUSNsKHUP3iPTl
	RjR/vKH7m1e+6BohjyjYg9L18wL/3g8E59nSHhNUyVfTUyLeOgcWk8Ma7yFAWjqQCz/pFLuRU+E
	CRsD8gXKnoAKYDPsPqmIeGRzR85cLaSUeX6a92K+TsazRFu4PtS0l/JFoe5abdvNc9hGma/EEGT
	M/Dx38yzgvug0o/1niJukSHnTbIgExWiVkOZOyzswCe04os9dQhESw==
X-Google-Smtp-Source: AGHT+IEqg4QZll0BAfnRMKMrmYtfWUSyYS56GiG56j8wxsdpir1mb5UrPwN+3AyiY/rxW3evEQvxRg==
X-Received: by 2002:a05:6a21:6e01:b0:1f3:3804:9740 with SMTP id adf61e73a8af0-1fe42f2ccb6mr7994025637.15.1742586806541;
        Fri, 21 Mar 2025 12:53:26 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a27ff1efsm2235011a12.18.2025.03.21.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:53:25 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:54:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	corbet@lwn.net
Subject: Re: [PATCH v2 2/5] iio: adc: ad4000: Add support for SPI offload
Message-ID: <Z93D8CAmgKSO-Ta6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <84843837a2acab58f8853152ecaa67c79b9a9666.1742394806.git.marcelo.schmitt@analog.com>
 <c449fff5-ef23-4094-8306-0a6b27a22c1c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c449fff5-ef23-4094-8306-0a6b27a22c1c@baylibre.com>

On 03/20, David Lechner wrote:
> On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> > FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> > The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> > SPI-Engine to execute transfers to poll data from the ADC. That allows data
> > to be read at the maximum sample rates. Also, it is possible to set a
> > specific sample rate by setting the proper PWM duty cycle and related state
> > parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> > trigger) is used in combination with SPI-Engine.
> > 
> > Add support for SPI offload.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> 
> I'm surprised I'm not on the CC for this series. scripts/get_maintainer.pl should
> have picked me up due to K: spi_offload which matches this patch.

get_maintainers doesn't list you if run over ad4000.c.
If run over the patch file, get_maintainers lists many developers. Some of them
don't seem to be related to this series, so I cropped the list to avoid churn.
Will CC you on the next versions.

> 
> > Instead of changing bits_per_word according to buffer endianness, I set
> > bits_per_word for other SPI transfers and updated IIO channels to always use CPU
> > endianness (the first patch in the series). With that, bits_per_word no longer
> > needs be updated according to buffer endianness or, in other words, buffer
> > endianness is no longer related to bits_per_word.
> 
> As mentioned in my reply to the previous patch, this is a breaking change, so
> probably not the best choice.
Ack

> 
> > 
> >  drivers/iio/adc/Kconfig  |   7 +-
> >  drivers/iio/adc/ad4000.c | 491 ++++++++++++++++++++++++++++++++-------
> >  2 files changed, 419 insertions(+), 79 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index b7ae6e0ae0df..1cfa3a32f3a7 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -25,10 +25,15 @@ config AD4000
> >  	tristate "Analog Devices AD4000 ADC Driver"
> >  	depends on SPI
> >  	select IIO_BUFFER
> > +	select IIO_BUFFER_DMAENGINE
> >  	select IIO_TRIGGERED_BUFFER
> > +	select SPI_OFFLOAD
> >  	help
> >  	  Say yes here to build support for Analog Devices AD4000 high speed
> > -	  SPI analog to digital converters (ADC).
> > +	  SPI analog to digital converters (ADC). If intended to use with
> > +	  SPI offloading support, it is recommended to enable
> > +	  CONFIG_SPI_AXI_SPI_ENGINE, CONFIG_PWM_AXI_PWMGEN, and
> > +	  CONFIG_SPI_OFFLOAD_TRIGGER_PWM.
> 
> I guess this is fine here, but people might be more likely to see it on the
> ADI wiki where the HDL project that has these requirements is described.

I don't see any word about that at
https://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
If no one opposes to that, I'd like to keep the piece of advice.

> 
> >  
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called ad4000.
> > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > index 19bc021e1b5d..b3f4d215cad4 100644
> > --- a/drivers/iio/adc/ad4000.c
> > +++ b/drivers/iio/adc/ad4000.c
> > @@ -21,9 +21,12 @@
> >  #include <linux/iio/iio.h>
> >  
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/buffer-dmaengine.h>
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  
> > +#include <linux/spi/offload/consumer.h>
> 
> Why not before #include <linux/spi/spi.h> ?

Okay, will put it there.

> 
...
> >  
> > -#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
> > +#define AD4000_TQUIET1_NS		190
> > +#define AD4000_TQUIET2_NS		60
> > +#define AD4000_TCONV_NS			320
> 
> Does this actually work for every single chip? For example, the AD7983 datasheet
> give the max as 500 ns for this timing parameter. Might need to put this in the
> chip_info to account for differences.
> 
> Also AD7983 doesn't have any quite time in the datasheet, so those might not be
> needed in some cases?

I've tested the series with AD7687 and ADAQ4003 and got good readings.
I'll check the timing specifications again and provide a delay long enough
for AD7983 and any other device with longer TCONV.

> 
...
> > -#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access)			\
> > +#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access, _offl)		\
> 
> We always pass 0 to _offl here, so we can leave out this parameter and just
> hard-code the 0 below. We will never have a case with offload + soft timestamp.

Good catch. Will apply the simplification.

> 
...
> > -#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)\
> > +#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits,		\
> > +				     _reg_access, _offl)			\
> >  {										\
> >  	.type = IIO_VOLTAGE,							\
> >  	.indexed = 1,								\
> >  	.channel = 0,								\
> >  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> >  			      BIT(IIO_CHAN_INFO_SCALE) |			\
> > -			      BIT(IIO_CHAN_INFO_OFFSET),			\
> > -	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
> > +			      BIT(IIO_CHAN_INFO_OFFSET) |			\
> > +			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
> > +	.info_mask_separate_available = (_reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0),\
> 
> Unrelated change (adding braces)?

Oops, will undo.

> 
> Also, could be nice to have sampling_frequency_available so that userspace can
> discover the max sample rate.

I don't think we should have sampling_frequency_available in this case because
there is no clear list of sample frequency values nor they can always be
expressed as "[min step max]" triad.
https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio?h=testing#n121

> 
...
> > -#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access)		\
> > +#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access, _offl)	\
> 
> ditto about hard-coding _offl here
Ack

> 
...
> >  static const struct ad4000_chip_info ad7983_chip_info = {
> >  	.dev_name = "ad7983",
> > -	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
> > +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
> > +	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
> >  	.time_spec = &ad7983_t_spec,
> > +	.max_rate_hz = 1330 * KILO,
> 
> This is actually 752 ns period when 750 is allowed. Could make it 1 * MEGA + 333
> * KILO + 333 or 1333333.
Ack

> 
> >  };
> >  
> >  static const struct ad4000_chip_info ad7984_chip_info = {
> >  	.dev_name = "ad7984",
> > -	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
> > +	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
> > +	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
> >  	.time_spec = &ad7983_t_spec,
> > +	.max_rate_hz = 1330 * KILO,
> 
> ditto
Ack

> 
...
> > +static const struct iio_buffer_setup_ops ad4000_offload_buffer_setup_ops = {
> > +	.postenable = &ad4000_offload_buffer_postenable,
> > +	.postdisable = &ad4000_offload_buffer_postdisable,
> 
> Needs to be predisable to correctly balance postenable.
Ack

> 
...
> > +static int ad4000_prepare_offload_turbo_message(struct ad4000_state *st,
> > +						const struct iio_chan_spec *chan)
> > +{
> > +	struct spi_transfer *xfers = st->offload_xfers;
> > +
> > +	/* Have to do a short CS toggle to trigger conversion. */
> > +	xfers[0].cs_change = 1;
> > +	xfers[0].cs_change_delay.value = AD4000_TQUIET1_NS;
> > +	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> > +	xfers[0].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> 
> There is no data transferred in this xfer, so we don't need to set this flag.
Ack

> 
...
> >  	case AD4000_SDI_VIO:
> > -		indio_dev->info = &ad4000_info;
> > -		indio_dev->channels = chip->chan_spec;
> > +		if (st->using_offload) {
> > +			indio_dev->info = &ad4000_offload_info;
> > +			indio_dev->channels = &chip->offload_chan_spec;
> > +			indio_dev->num_channels = 1;
> > +
> > +			spi->cs_hold.value = AD4000_TCONV_NS;
> > +			spi->cs_hold.unit = SPI_DELAY_UNIT_NSECS;
> 
> Modifying spi is suspicious. Normally, this would come from the devicetree. And
> this isn't used by all SPI drivers - notably the AXI SPI Engine ignores it.
> Better to just handle this in individual spi xfer structs.
Will try that.

> 
> > +			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret,
> > +						     "Failed to optimize SPI msg\n");
> > +		} else {
> > +			indio_dev->info = &ad4000_info;
> > +			indio_dev->channels = chip->chan_spec;
> > +			indio_dev->num_channels = ARRAY_SIZE(chip->chan_spec);
> > +		}
> 
> nit: add extra blank line here
Ack

> 
> >  		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
> >  		if (ret)
> > -			return ret;
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to optimize SPI msg\n");
> >  
> >  		break;
> 

