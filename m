Return-Path: <linux-iio+bounces-13226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102399E8689
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62181884C0C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BE176ABA;
	Sun,  8 Dec 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCFnZrUS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE8170A15;
	Sun,  8 Dec 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675669; cv=none; b=XF/ldID36McxFhNVrIpGUNGGBbpgdIgDL4sfpnWAeiTKM1ksduqCJEgfW49GL51PZxlhsILTgaAxXh6H+2MaLhXECbHXy+yVgldOfoQWhlfjKjVnCg5RZypom8JkyoLrPUxZAsxK/8ihtMTNBeyXpBT8wkcWILm8DWPLeOyywQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675669; c=relaxed/simple;
	bh=xbOYZZgbv6qPWKRxN5H5W0CMPbDsRfeUKp672+VsrG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eg3uqfE5FciwR84g/ELvZ8X45yUqpliAe5rhaxkMnwGhI+0NLt8EcVeWsMKnqsM+d6f+i/K3ca4Sv9NoP4C/GFT6p0vlfYQG3utKIDUHKkpqi3LLVTKeuXoY0HUrFdZRw0rrNkYSiQv/P5w5n7AzysY7+JUZsLPeHbxJe1y9ZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCFnZrUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C77C4CEE2;
	Sun,  8 Dec 2024 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733675668;
	bh=xbOYZZgbv6qPWKRxN5H5W0CMPbDsRfeUKp672+VsrG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCFnZrUSgyWP0xB0Txl9MIpwB/E0sxUOro9Yv6mbEDOo0+aT9pscuAqvZMED0adCI
	 lnxzCbUMs24iYoLi3eqRWJ8k2xWOQjExKTyxIMGRkZlNA/gmXEsl2wBxVqsIQmGVtK
	 A1N8KoTM/yZQfRTtM4jSJ3FLOnG+ZfK5QJrhZYsz7/xz756cj5fB5ibuZYWWfej0et
	 MtGjNVtSTTz+dCVj0q58NB9mDnuIOYganIcrIk4PIUHbCj5L4LbxZl3rc7Uwqq4p72
	 phhzseJnxWvrQkgFaz4KE834n/SAP/hQrd8KkArHb53UxtawDCVRK7ENLY32Uxm4Cb
	 mszlc4Y80CLuA==
Date: Sun, 8 Dec 2024 16:34:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 10/10] iio: accel: adxl345: add FIFO with watermark
 events
Message-ID: <20241208163418.2d57f185@jic23-huawei>
In-Reply-To: <20241205171343.308963-11-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:43 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a basic setup for FIFO with configurable watermark. Add a handler
> for watermark interrupt events and extend the channel for the
> scan_index needed for the iio channel. The sensor is configurable to use
> a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode now
> a watermark can be configured, or disabled by setting 0. Further features
> require a working FIFO setup.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Various comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 300 +++++++++++++++++++++++++++++++
>  1 file changed, 300 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 3067a70c54e..58ed82d66dc 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -15,15 +15,28 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>

I'm not seeing any use of this header yet.  Bring it in when you need it.

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
>  struct adxl345_state {
>  	int irq;
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> +	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE];
>  	bool fifo_delay; /* delay: delay is needed for SPI */
>  	u8 intio;
> +	u8 int_map;
> +	u8 watermark;
> +	u8 fifo_mode;
>  };
>  
>  #define ADXL345_CHANNEL(index, reg, axis) {					\
> @@ -36,6 +49,13 @@ struct adxl345_state {
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
>  	.scan_index = (index),				\
> +	.scan_type = {					\
> +		.sign = 's',				\
> +		.realbits = 13,				\
> +		.storagebits = 16,			\
> +		.shift = 0,				\

No need to specify shift of 0. It's the 'obvious' default and C will set it to 0
for you anyway.

> +		.endianness = IIO_LE,			\
> +	},						\
>  }
>  
>  enum adxl345_chans {
> @@ -48,6 +68,25 @@ static const struct iio_chan_spec adxl345_channels[] = {
>  	ADXL345_CHANNEL(2, chan_z, Z),
>  };
>  
> +static int adxl345_set_interrupts(struct adxl345_state *st)
> +{
> +	int ret;
> +	unsigned int int_enable = st->int_map;
> +	unsigned int int_map;
> +
> +	/* Any bits set to 0 in the INT map register send their respective

	/*
	 * Any bits....


> +	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
> +	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
> +	 */
> +	int_map = 0xFF & (st->intio ? st->int_map : ~st->int_map);
> +
> +	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
> +}


> +/**
> + * adxl345_get_samples() - Read number of FIFO entries.
> + * @st: The initialized state instance of this driver.
> + *
> + * The sensor does not support treating any axis individually, or exclude them
> + * from measuring.
> + *
> + * Return: negative error, or value.
> + */
> +static int adxl345_get_samples(struct adxl345_state *st)
> +{
> +	unsigned int regval = 0;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_FIFO_STATUS, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0x3f & regval;
FIELD_GET() for all stuff like this with appropriate #define for the mask.

> +}
> +
> +/**
> + * adxl345_fifo_transfer() - Read samples number of elements.
> + * @st: The instance of the state object of this sensor.
> + * @samples: The number of lines in the FIFO referred to as fifo_entry,
> + * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes each.
> + *
> + * It is recommended that a multiple-byte read of all registers be performed to
> + * prevent a change in data between reads of sequential registers. That is to
> + * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.

Doesn't match the code which is reading just one register lots of times.

> + *
> + * Return: 0 or error value.
> + */
> +static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
> +{
> +	size_t count;
> +	int i, ret;
> +
> +	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
> +	for (i = 0; i < samples; i++) {
> +		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
> +				st->fifo_buf + (i * count / 2), count);
> +		if (ret < 0)
> +			return ret;

This is where I'd expect to see the delay mentioned below.

> +	}
> +	return ret;
> +}
> +

> +static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->int_map = 0x00;
> +
> +	ret = adxl345_set_interrupts(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->fifo_mode = ADXL345_FIFO_BYPASS;
> +	return adxl345_set_fifo(st);
I'd normally expect order in predisable to be reverse of that in postenable.
Why isn't it?  That is why is the set_fifo here after set_interrupts and
not before it.  Add a comment.

> +}
> +
> +static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
> +	.postenable = adxl345_buffer_postenable,
> +	.predisable = adxl345_buffer_predisable,
> +};
> +
> +static int adxl345_get_status(struct adxl345_state *st)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (0xff & regval);

No brackets needed.

> +}
> +
> +static int adxl345_fifo_push(struct iio_dev *indio_dev,
> +				  int samples)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	if (samples <= 0)
> +		return -EINVAL;
> +
> +	ret = adxl345_fifo_transfer(st, samples);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ADXL345_DIRS * samples; i += ADXL345_DIRS) {
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
> +		if (st->fifo_delay && (samples > 1))
> +			udelay(3);

I'm not following why a delay here helps.  At this point you're read masses of
data from the fifo without the delays you mention.

> +
> +		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * adxl345_event_handler() - Handle events of the ADXL345.

Up to you but...
Given it's an IIO driver and that we have a very specific meaning
for events, maybe just call this adxl345_irq_handler()?

> + * @irq: The irq being handled.
> + * @p: The struct iio_device pointer for the device.
> + *
> + * Return: The interrupt was handled.
> + */
> +static irqreturn_t adxl345_event_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	u8 int_stat;
> +	int samples;
> +
> +	int_stat = adxl345_get_status(st);
> +	if (int_stat < 0)
> +		return IRQ_NONE;
> +
> +	if (int_stat == 0x0)
Doesn't this correspond to 'not our interrupt'?
If that's the case return IRQ_NONE is the right way to go and not reset the
interrupt.  You have registered it as maybe shared, and if it is, then this
is a common thing to happen as interrupt from another device.

> +		goto err;
> +
> +	if (int_stat & ADXL345_INT_OVERRUN)
> +		goto err;
> +
> +	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {

I think you only ever enable the INT_WATERMARK?  If so does it
make sense to check for DATA_READY as well?

> +		samples = adxl345_get_samples(st);
> +		if (samples < 0)
> +			goto err;
> +
> +		if (adxl345_fifo_push(indio_dev, samples) < 0)
> +			goto err;
> +
> +	}
> +	return IRQ_HANDLED;
> +
> +err:
> +	adxl345_fifo_reset(st);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info adxl345_info = {
>  	.attrs		= &adxl345_attrs_group,
>  	.read_raw	= adxl345_read_raw,
>  	.write_raw	= adxl345_write_raw,
>  	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
> +	.hwfifo_set_watermark = adxl345_set_watermark,
>  };
>  
>  /**
> @@ -222,6 +499,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
> +	u8 fifo_ctl;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -293,6 +571,28 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
>  
> +	if (st->irq > 0) {
> +		dev_dbg(dev, "initialize for FIFO_STREAM mode\n");
> +
> +		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(dev, st->irq, NULL, &adxl345_event_handler,
> +				IRQF_SHARED | IRQF_ONESHOT,
> +				indio_dev->name, indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
> +
> +	} else {
> +		dev_dbg(dev, "initialize for FIFO_BYPASS mode (fallback)\n");
> +
Given you haven't removed this code from elsewhere, was the driver relying
on the defaults after reset before this patch? 

I don't mind having this branch as a form of documentation even if that's
true but maybe add a note to the patch description.

> +		fifo_ctl = ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
> +
> +		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
> +		if (ret < 0)
> +			return ret;
> +	}
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);


