Return-Path: <linux-iio+bounces-16971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B4A655C1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52CE7A7F5F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F78924DFEF;
	Mon, 17 Mar 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZZ7PEYK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F493248891;
	Mon, 17 Mar 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225437; cv=none; b=uXJGomg5Dsh7ENYzmzGhITVH2ZHwo4w7hhfIEmXF6JcLhAGh2ZbN8ZY/nvkwjnJPE3wNn5+xuXcaVGJsrPfEMJV3KsljT0+y/WK4sMWV9PsFb7cWr/KEjbxoaGif6eWD1AX5UDX949KmMKwG5TIkIlllMkIbf0bucFoA77H7qBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225437; c=relaxed/simple;
	bh=C+W3kd4+v5TVLwjpGOynMcqkXwzK5jGbOBiTl1R5l/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3nU8rTQwozReTQE901UKIx/u4Ht5wV+J1B2yeAcsFiyzIL5FAO+I0WSqkPv2tjHjd+EyY5y05zrbNNeIOWR1+9XiYej8WTVqZqhS/XOuYKUOOmBLWiJn2SYgohToQQFMclsirVTNV7TgZgknExS/mYI5VtUovU2XF+1CFHpyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZZ7PEYK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso20437435ad.0;
        Mon, 17 Mar 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742225433; x=1742830233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5gJh5Eadmca86/ej6h5ytEhpVhFbI54t41u4rv/hs4=;
        b=FZZ7PEYKpzeh3hX7NRwtAMRrOqRG4xd89vXOaIbSYmuJ0A8m65I12L9ZCFh5bTUiL+
         SMjIDkPd8gnY5E1o4oR2JRkCqq8MUWmm5YaDSvxlh08Y3lhv0k0FSDlJlb/MD8AkwyIF
         Ss92ykWgdE//DQYb1o99+dNgZ1NK3ZUYHtFpYoFupGTusBayNRrspDrt0dz3mfkDz9DR
         6QMaz2PMl6fIY6jskipxm85f5URYd6DjIrr7c1cggHui4StbpJyYyVwsp2HXWyKRIJf2
         LEma+3etArc7MSmNWt3YfMoKD5DMiIV2E+Ynvq+qcO4woSnkHbSa/QEdo3JcNyiZ6qMr
         xn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225433; x=1742830233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5gJh5Eadmca86/ej6h5ytEhpVhFbI54t41u4rv/hs4=;
        b=PkLMlPICrNGtmQekzpRRsrV+pAZxvF85G23U7cSRC1g3IYXk1PNQ5K0STM/tRQxKRe
         +q72FuGyzOaPU7B6k6ntMM/byE9vDEb1uV5Z+MaN4oiLuAbYIP7PM1bbZ1TYc+5mXGkj
         XW0vsLqzR2DTHWz6Yo9pxDnHNhVq0OPQquKJijuwS2XmXd2ja0PtCGX3BEX+drGEO7b1
         wX0pr9SXSr05xkYVhINY6Hu5ThoWwU5TkLBV5sX8NcsYkRIkCUVh3o+XraeImRTqHLOL
         VtGZhMWbJuhVGT9OGX2nmTXOj8f8rvAD+hocl5mtX6R8Mg1GSs5gq67YJP+pOAr8AlOi
         SBYA==
X-Forwarded-Encrypted: i=1; AJvYcCV6RqSEj5sY2Rt1r/lWh1pPpMxJZiA7qSQ9Up9Ejt9d0tmFtHizv4dgqQrc2YF+i6kbSr7wdbiRglH0d6XM@vger.kernel.org, AJvYcCWYI1wi8FSWcEUb67n/UrefxqXifxH3E48BCQ+IDNzZwXQx7vr66JWxyP+bm6Ml5DAzE1YlQDRi8shd@vger.kernel.org, AJvYcCXM+dodJYEsuVvYkNYdHe+2LjBpYTSyA6Hcc6G00i/n5UzO4HIMxrowpLB+ng/PY6NbiWrh/VRh0rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXtM/VcjQ6Kv+AHAVoxZLIw2BknSz20yTwdIH6hm4N5tocsjM
	/MKAQYaaIxF6LKVElO1zsuM9Fxko/qyhjvcojqbbnyPdMv4bpgpO
X-Gm-Gg: ASbGncthaTeNz2sqZrKNOfMISu4TkSy0LZtrxpvPDjTGwIXekuQAwVN/mxrW8RkFTve
	+IZgIIYHR/bJl/9g9sRzZM7HnWwg6QrQFwniJh/698drUZxG7Yegkwzq5BygwHM/93oSkCenCVE
	syvCDi2MXmAdAU4UeuX+/GtEV2dTvp61Qm02MDbFpCNq22iaV8CUJTd5T8AHRxuQOVAARoCS16i
	chWnov8EuYpXXX0WymHM6vGmXkLDdjHuHfYw7b3R218jLCYaWxDOPBdz0s2malIJSBSgiaHhH3e
	PJOENKWlP7O7kmfOvqcRp9EKXOfGdWc6Mb9TGd/ymyiOtuCR0Pj+pA==
X-Google-Smtp-Source: AGHT+IHCE2g1unOOKhest7l0/SVHeZt3puUsiLsau9c4ECUa088fp1tCbdUjpDJ/ca4QLxUiFLAA8Q==
X-Received: by 2002:a17:902:e806:b0:224:78e:4ebe with SMTP id d9443c01a7336-225e0aeea0cmr161127745ad.33.1742225433341;
        Mon, 17 Mar 2025 08:30:33 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6ba6a38sm76423745ad.108.2025.03.17.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:30:32 -0700 (PDT)
Date: Mon, 17 Mar 2025 12:31:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, corbet@lwn.net
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <Z9hAUs1wPOIAo2nt@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
 <301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>
 <20250317102751.5702fb82@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317102751.5702fb82@jic23-huawei>

...
> > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > index 4fe8dee48da9..6c9b71e7a2fb 100644
> > --- a/drivers/iio/adc/ad4000.c
> > +++ b/drivers/iio/adc/ad4000.c
> 
> > +
> > +static int ad4000_offload_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4000_state *st = iio_priv(indio_dev);
> > +
> > +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> 
> Trivial. Prefer a blank line before a 'simple return' like this one.
> 
Ack

> > +	return 0;
> > +}
> 
> 
...
> > +/*
> > + * This executes a data sample transfer when using SPI offloading for when the
> > + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
> > + * tree property is set to "high". In this connection mode, the ADC SDI pin is
> > + * connected to VIO and ADC CNV pin is connected to a SPI controller CS (it
> > + * can't be connected to a GPIO).
> > + *
> > + * In order to achieve the maximum sample rate, we only do one transfer per
> > + * SPI offload trigger. This has the effect that the first sample data is not
> > + * valid because it is reading the previous conversion result. We also use
> 
> Say what happens to that invalid sample.  Is it dropped or provided to userspace
> as if it were valid?  (I hope dropped!)

TL;DR: The invalid sample goes into the buffer as a valid one.

In AD4000 '3-wire' mode, data capture has a latency (delay) of one sample.

The ADC begins sampling data N at CNV rising edge
          |   +-- CNV (usually SPI CS) is brought low to begin reading the data
          |   |                                +-- Data N + 1 that will be read
          |   |                                |   on the next transfer starts 
          v   v                                v   being sampled at end of transfer N.
           ___                                  ____            
CNV  _____/   \________________________________/    \_____
                    _     _             _
SCLK ______________/ \___/ \_ ...   ___/ \_______________
                   ___   ___           ___
SDO  _____________/___\_/___\ ...   __/___\_______________
                    ^
                    |
             Data from conversion N is output from here on

A better drawing can be found in datasheet page 29, Figure 57.
https://www.analog.com/media/en/technical-documentation/data-sheets/ADAQ4003.pdf

In sum, we're always reading a conversion that started at the end of the
previous SPI transfer or, in other words, the data comes out with a latency
(delay) of one read.

Datasheet somehow mentions that by saying
	When turbo mode is enabled, the conversion result read on SDO corresponds to
	the result of the previous conversion.

I think I can do a dummy SPI transfer on buffer preenable so at least the
first data is not invalid. Would that be better?

> 
> > + * bits_per_word to ensure the minimum of SCLK cycles are used. And a delay is
> > + * added to make sure we meet the minimum quiet time before releasing the CS
> > + * line. Plus the CS change delay is set to ensure that we meet the minimum
> > + * conversion time before asserting CS again.
> > + *
> > + * This timing is only valid if turbo mode is disabled (reading during acquisition).
> > + */
> > +static int ad4000_prepare_offload_message(struct ad4000_state *st,
> > +					  const struct iio_chan_spec *chan)
> > +
> 
...
> > +		xfers[1].bits_per_word = chan->scan_type.realbits;
> >  	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
> >  	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
> >  
> > @@ -719,7 +1007,9 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
> >  	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> >  
> >  	xfers[1].rx_buf = &st->scan.data;
> > -	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> > +	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
> > +	if (chan->scan_type.endianness != IIO_BE)
> 
> This is odd enough to require a comment.  Why is endianness relevant?

When using SPI offloading (at least with PULSAR-ADC HDL project [1]), ADC data
is read by SPI controller and pushed to DMA memory in CPU endianness. I don't
know exactly where data gets rearranged in the data path (whether SPI-Engine,
the DMA controller, or something else rearranges ADC data into CPU endianess).
But I know, from testing with these ADCs and HDL project, that data is correct
when read in CPU endianness because it converts back to expected mV values.
When IIO buffers were set to IIO_BE and SPI offloading is used, data just looked
weird and didn't convert to expected values in mV.

[1]: https://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html

Other IIO drivers also set IIO_CPU buffer endianness when using offload support,
e.g. ad7944, ad7380.

They only say buffer would use 32 storagebits when using SPI offload.
https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-10-e48a489be48c@baylibre.com/
https://lore.kernel.org/linux-iio/20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com/#t

I also didn't expect to find out HDL support for 16-bit data width was removed.
We used to have a build parameter for 16-bit precision ADCs.
https://github.com/analogdevicesinc/hdl/commit/b2dc91b30dae891b6319d88e083f26e726f43ba0#diff-1117c2618353232e5f22aa6a12e8ae976757fa897b3425f470a12123cae26535L13

Would something like 'because SPI offloading leads to data being pushed to
memory in CPU endianness' be a reasonable comment?

...
> 
> > +		if (st->using_offload) {
> > +			indio_dev->channels = &chip->reg_access_offload_chan_spec;
> Set num_channels here
Ack for all these

> > +			ret = ad4000_prepare_offload_turbo_message(st, indio_dev->channels);
...
> 
> Also set size here.  Obviously this means a little duplication but still good
> to keep them together.
Okay, sounds reasonable.

> 
> 
> > +		}
> 
> >  	case AD4000_SDI_GND:
> > @@ -830,7 +1175,10 @@ static int ad4000_probe(struct spi_device *spi)
> >  	}
> >  
> >  	indio_dev->name = chip->dev_name;
> > -	indio_dev->num_channels = 2;
> > +	if (st->using_offload)
> > +		indio_dev->num_channels = 1;
> > +	else
> > +		indio_dev->num_channels = 2;
> 
> Move this up to where you set channels so that the array
> and size are set together.
Acknowledged as all the above cases.

Thanks,
Marcelo

