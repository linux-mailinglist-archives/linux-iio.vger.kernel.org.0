Return-Path: <linux-iio+bounces-13452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B969F1E8D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1144167708
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C0191F9E;
	Sat, 14 Dec 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZshCCvED"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3442A99;
	Sat, 14 Dec 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179811; cv=none; b=VqwI7YkyKcXNkzq74jmaslroW6id2oL8wlScInFXgJJgDhsYt1mKL6MCuAH1++0NurOVVpgpVZP/BQL33cYcaTJhMySuQ0/TZ3qXvVB/kE+uCDfwChKuKOHkwpem+BoeMN7jOQUhleWJ9RXmNZqRCEn/eXJYeZlKKnbrNWKSKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179811; c=relaxed/simple;
	bh=iJkWexO+c6fd8qHwLMbKGzqr1jQ4wTinHRscOJfZiJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ4TuG7IwPqhfkcdQrGWa3Rcfoi+yRnxZOPmzZsm6I6mZRPNs65PcAPpkxrixZFU0hvOxVIFZU2sS9y3ndDWBIvNrgfi9RAiALT+vS6nF93zlebdB1NenjGu8p39SzyWvbfDMNtplNPoQuGPlNOiQP3PykVCe2M3TeGQaSeyhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZshCCvED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C03C4CED1;
	Sat, 14 Dec 2024 12:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734179810;
	bh=iJkWexO+c6fd8qHwLMbKGzqr1jQ4wTinHRscOJfZiJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZshCCvEDjcrv1qai3L7hA2LU/lVfveTIMBIDcJNpVwy7j4PN2KsIoAAqekPyuPn2o
	 XKssVBrjDKENB2RuzLAHckBRXpZTH0h2sGeNQCmyyTjftoVJjfLySFEG3EvBecHBtQ
	 9kZRxuCH2jM6kXSKNwgMTWXQbRngfOpwd1dcCduzTBTd0C5bG2FdtK2qVArM6Y1IUm
	 rFR6V1G0RcmwC1NQSzex6xxTBsDOH5HCSPCdouz5goRErL7kjJIJ9TbbFUx3BHOh23
	 xlEoiemiCT8cO8wi0004Z1O/YzgfJCO3Aut+cDIsbPqKTw6RamvkWOSf0qEQTo0GeM
	 TeKVgMcP0MjyQ==
Date: Sat, 14 Dec 2024 12:36:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 6/7] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <20241214123641.6ab3e4c4@jic23-huawei>
In-Reply-To: <20241213211909.40896-7-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 21:19:08 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a basic setup for FIFO with configurable watermark. Add a handler
> for watermark interrupt events and extend the channel for the
> scan_index needed for the iio channel. The sensor is configurable to use
> a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode now
> a watermark can be configured, or disabled by setting 0. Further features
> require a working FIFO setup.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I missed a theoretical bug around the dma buffer in previous reviews.
A few other minor things inline.

Thanks,

Jonathan

>  /*
>   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index fc4f89f22..e31a7cb3f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -15,9 +15,17 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
>  
>  #include "adxl345.h"
>  
> +#define ADXL345_FIFO_BYPASS	0
> +#define ADXL345_FIFO_FIFO	1
> +#define ADXL345_FIFO_STREAM	2
> +
> +#define ADXL345_DIRS 3
> +
>  #define ADXL345_INT_NONE		0xff
>  #define ADXL345_INT1			0
>  #define ADXL345_INT2			1
> @@ -26,27 +34,68 @@ struct adxl345_state {
>  	int irq;
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> +	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1];

Ah.  The old corner case (sorry I missed this in earlier reviews!)

In theory at least regmap makes no additional guarantees on how it uses buffers
on top of those provided by the underlying busses.
So we need to treat bulk reads the same way we do for those buses.
That means we need to allow for direct DMA writes into the buffers
we pass to bulk read.  For that to be safe on all architectures (and not
accidentally overwrite stuff in the same cacheline) we need to use
what is known as a DMA safe buffer.
Long ago we contrived the data layout in IIO to make that easy to
do.  Just move it down to the end of this structure as...


>  	bool fifo_delay; /* delay: delay is needed for SPI */
>  	u8 intio;
> +	u8 int_map;
> +	u8 watermark;
> +	u8 fifo_mode;
this
	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);

This structure already has the appropriate alignment (there is padding inserted
in the allocation to make that true) so by doing this for the element we
ask the compiler to make sure it adds sufficient padding before this element
to ensure nothing else is in the same cacheline (if required by a particular
architecture).   C also guarantees that the structure itself is large enough
to ensure padding is added after this element such that the overall structure
size is a multiple of it's most aligned element (this one).
Thus we end up with the buffer in it's own cacheline and none of the mess
of non coherent DMA can cause us problems. 

If interested in learning more look for Wolfram's talk at ELCE a number
of years back on trying to do DMA into the buffers passed to I2C calls.

The 'in theory' bit is because last time I checked regmap is always bounce
buffering the data but there are obvious optimizations that could be made
so it didn't bounce. A long back we asked the maintainer about this and he
said definitely don't assume it won't use the buffers directly.

Note on arm64 for instance there is magic code that bounces all small
DMA transfers, but that is not enabled on all architectures yet.

>  };

>  
> +static const unsigned long adxl345_scan_masks[] = {
> +	BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
> +	0,

Trivial but drop that trailing comma. It's a terminator so we don't want to make it
easy for anyone to accidentally put anything after it!

> +};

>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -132,6 +181,25 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	unsigned int fifo_mask = 0x1F;
> +	int ret;
> +
> +	if (value > ADXL345_FIFO_SIZE)
> +		value = ADXL345_FIFO_SIZE - 1;

	value = min(value, AD345_FIFO_SIZE - 1);

Shorter and maybe a tiny bit more readable. (trivial comment!)

> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_FIFO_CTL, fifo_mask, value);
> +	if (ret)
> +		return ret;
> +
> +	st->watermark = value;
> +	st->int_map |= ADXL345_INT_WATERMARK;
> +
> +	return 0;
> +}



>  /**
> @@ -222,6 +499,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  					 ADXL345_DATA_FORMAT_JUSTIFY |
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
> +	u8 fifo_ctl;

Might as well make this declaration local to where it's used.

>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -242,6 +520,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl345_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> +	indio_dev->available_scan_masks = adxl345_scan_masks;
>  
>  	if (setup) {
>  		/* Perform optional initial bus specific configuration */
> @@ -292,6 +571,25 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  			st->intio = ADXL345_INT_NONE;
>  	}
>  
> +	if (st->intio != ADXL345_INT_NONE) {
> +		/* FIFO_STREAM mode is going to be activated later */
> +		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(dev, st->irq, NULL, &adxl345_irq_handler,
> +				IRQF_SHARED | IRQF_ONESHOT,
> +				indio_dev->name, indio_dev);
		ret = devm_request_threaded_irq(dev, st->irq, NULL,
						&adxl345_irq_handler,
						IRQF_SHARED | IRQF_ONESHOT,
						indio_dev->name, indio_dev);

All under 80 chars (still the preference when no reason to do otherwise) and
aligned with opening bracket which is preferred kernel style when there
is no reason to do otherwise.

If you weren't going to be doing a v8 anyway I'd just tweak this whilst applying
but seeing as you are... :)


> +		if (ret)
> +			return ret;
> +	} else {
> +		/* FIFO_BYPASS mode */
> +		fifo_ctl = ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
> +		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);


