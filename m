Return-Path: <linux-iio+bounces-14232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7FA0AABE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CDF7A4107
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45D1BD00C;
	Sun, 12 Jan 2025 16:07:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E31BBBFE
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698033; cv=none; b=I4433gBLCcSzaQFlwkm+khHTJHJHjTN/mPauFI4JXhKKEzj7Qq4UwFhJFo/Ut6PimyYwhyS6hi7feopoBeUBx+gEeBYo2IJZhKIT0Dne0wP7KgFp9yeMDddPut44YztRaMkWby59MwP5OGBNzrpCmdJXj1UvdHtMQ1bVSKCtepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698033; c=relaxed/simple;
	bh=xFDZOEsdJij55vPLUIoFb2+OePlK0+efq4pZ9gMxG28=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDfVnOQNK4MAD26bAsfFvsf3Sq5DyPfGfwnwEzgqJsBA47rCm90zgmibsXvdvuguhJAQWDZah24EKosmDHHB4jiei7rfWD/+HbcG/y3epgdolV+Op2jgsNufAZ4sD/nG4ZREin/nCvHrT84tmrNwdRJZEy6K56YIl/6n9Frts/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 1be29296-d0ff-11ef-a20f-005056bdfda7;
	Sun, 12 Jan 2025 18:05:57 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 18:05:57 +0200
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v9 3/4] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <Z4PoZTV4VbmzXnVd@surfacebook.localdomain>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
 <20241228232949.72487-4-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228232949.72487-4-l.rubusch@gmail.com>

Sat, Dec 28, 2024 at 11:29:48PM +0000, Lothar Rubusch kirjoitti:
> Add a basic setup for FIFO with configurable watermark. Add a handler
> for watermark interrupt events and extend the channel for the
> scan_index needed for the iio channel. The sensor is configurable to use
> a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode now
> a watermark can be configured, or disabled by setting 0. Further features
> require a working FIFO setup.

...

>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>

Why not keep it ordered?

...

> +static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	unsigned int fifo_mask = 0x1F;

GENMASK() ?
(BIT(5) - 1) ? 

> +	int ret;
> +
> +	value = min(value, ADXL345_FIFO_SIZE - 1);
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

...

> +	int i, ret = 0;

Why is i signed?

> +
> +	/* count is the 3x the fifo_buf element size, hence 6B */
> +	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
> +	for (i = 0; i < samples; i++) {
> +		/* read 3x 2 byte elements from base address into next fifo_buf position */
> +		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
> +				       st->fifo_buf + (i * count / 2), count);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * To ensure that the FIFO has completely popped, there must be at least 5
> +		 * us between the end of reading the data registers, signified by the
> +		 * transition to register 0x38 from 0x37 or the CS pin going high, and the
> +		 * start of new reads of the FIFO or reading the FIFO_STATUS register. For
> +		 * SPI operation at 1.5 MHz or lower, the register addressing portion of the
> +		 * transmission is sufficient delay to ensure the FIFO has completely
> +		 * popped. It is necessary for SPI operation greater than 1.5 MHz to
> +		 * de-assert the CS pin to ensure a total of 5 us, which is at most 3.4 us
> +		 * at 5 MHz operation.
> +		 */
> +		if (st->fifo_delay && samples > 1)
> +			udelay(3);
> +	}

MIssed blank line.

> +	return ret;

...

> +static int adxl345_fifo_push(struct iio_dev *indio_dev,
> +			     int samples)

This can be effectively a single line.

> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int i, ret;

> +	if (samples <= 0)
> +		return -EINVAL;

This is strange. Why the heck somebody could translate the input parameter to
an error? Can't the function simply take the positive input only? Otherwise,
what is the meaning of the samples < 0 ?

> +	ret = adxl345_fifo_transfer(st, samples);
> +	if (ret)
> +		return ret;

> +	for (i = 0; i < ADXL345_DIRS * samples; i += ADXL345_DIRS)

Why doing mulpiplication here and step != 1 there instead of just one
multiplication...

> +		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);

...in the above line?

> +	return 0;
> +}

...

> +/**
> + * adxl345_irq_handler() - Handle irqs of the ADXL345.
> + * @irq: The irq being handled.
> + * @p: The struct iio_device pointer for the device.
> + *
> + * Return: The interrupt was handled.
> + */
> +static irqreturn_t adxl345_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int int_stat;
> +	int samples;
> +
> +	int_stat = adxl345_get_status(st);
> +	if (int_stat <= 0)
> +		return IRQ_NONE;
> +
> +	if (int_stat & ADXL345_INT_OVERRUN)
> +		goto err;
> +
> +	if (int_stat & ADXL345_INT_WATERMARK) {
> +		samples = adxl345_get_samples(st);
> +		if (samples < 0)
> +			goto err;

You already seem to guarantee no negative samples, and TBH this has to be

		ret = ...
		...

		samples = ret;

which will make more sense and better types.


> +		if (adxl345_fifo_push(indio_dev, samples) < 0)
> +			goto err;
> +	}
> +	return IRQ_HANDLED;
> +
> +err:
> +	adxl345_fifo_reset(st);
> +
> +	return IRQ_HANDLED;
> +}

...

> +	if (st->intio != ADXL345_INT_NONE) {

What's wrong with positive conditional?
Negative is slightly harder to read and parse at a glance.

> +		/* FIFO_STREAM mode is going to be activated later */
> +		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(dev, st->irq, NULL,
> +						&adxl345_irq_handler,
> +						IRQF_SHARED | IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* FIFO_BYPASS mode */
> +		fifo_ctl = ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
> +		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
> +		if (ret < 0)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko



