Return-Path: <linux-iio+bounces-20316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85DAD1311
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC387A3824
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA351624CE;
	Sun,  8 Jun 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0rGlAHh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3D8633F;
	Sun,  8 Jun 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397466; cv=none; b=dERtBbxuj31YfSasH81Kxw9Psbmoi5fJyU/B2fza81xF7yG/UeOAQg6TsS5Z15bNr1r/s/WKrR5niGb1hHkahV6unx/0XXXAHqBW+O3vrqgjrJ9t4QULRX9yy4QM8o730hXGwKtHlxPCFjhHY/Id5zU9tci74nHj2L4l2FfNFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397466; c=relaxed/simple;
	bh=ns9qBcVaLvzcW1rZWYw11XjuIVyaBRpd9FC2YddBlOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5KJ4OaEFGnJ/jjj07ZsGpoepGcnWLRne5JP5jlCs3W3SOtQGwGzIZNmoCwzUiV0IxIESlPBWkSVftHNudJw8wrX0xHPRgprCCCoi5Dya3EJShLbH7VdCSn2DE5FTZ2z8//Ew5JlF4UytHl3Rj0O4qXTswM2pajCpyuhEohTdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0rGlAHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638FBC4CEEE;
	Sun,  8 Jun 2025 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749397465;
	bh=ns9qBcVaLvzcW1rZWYw11XjuIVyaBRpd9FC2YddBlOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0rGlAHhl9YxJTWSPIcwR6BRmqqfh2tZ9eB6VpjV/GeC8qbpJwoV0YP07qY1617bf
	 v0aI+TEqJJiZuV0VBfrPlgHt0ApzNgYOI9grqR8uuw5ToUOO1LoCCH9Vlq0Vbdf7NN
	 lZ7//49HunW6Eby0Lp7hWYcA42YO3w3u26B7XBak/LGWKyCbRSaxuRF8m4VAp/bQSk
	 diVrP3KBqyLikvqmXnBnwieEtp/HdCEGtiyNCIrFIY/KvOi9EbQfbkYjpfBQjC+DlN
	 xP6XPHQ2dB6G51wcxo9auhJ7pOyf/3TT7F2YjhskNyv3xI5s5WmW0srh3if56uatlM
	 QWCwTg1k2pkeA==
Date: Sun, 8 Jun 2025 16:44:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/11] iio: accel: adxl313: add basic interrupt
 handling for FIFO watermark
Message-ID: <20250608164416.7a2f3ac0@jic23-huawei>
In-Reply-To: <20250601172139.59156-7-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:34 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Prepare the interrupt handler. Add register entries to evaluate the
> incoming interrupt. Add functions to clear status registers and reset the
> FIFO.
> 
> Add FIFO watermark configuration and evaluation. Let a watermark to be
> configured. Evaluate the interrupt accordingly. Read out the FIFO content
> and push the values to the IIO channel.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl313.h      |  10 ++
>  drivers/iio/accel/adxl313_core.c | 190 +++++++++++++++++++++++++++++++
>  2 files changed, 200 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index ab6b9e11fde4..4f4a9fd39f6d 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -53,11 +53,19 @@
>  #define ADXL313_INT_ACTIVITY		BIT(4)
>  #define ADXL313_INT_DREADY		BIT(7)
>  
> +/* FIFO entries: how many values are stored in the FIFO */
> +#define ADXL313_REG_FIFO_STATUS_ENTRIES_MSK	GENMASK(5, 0)
> +/* FIFO samples: number of samples needed for watermark (FIFO mode) */
> +#define ADXL313_REG_FIFO_CTL_SAMPLES_MSK	GENMASK(4, 0)
>  #define ADXL313_REG_FIFO_CTL_MODE_MSK		GENMASK(7, 6)
>  
>  #define ADXL313_FIFO_BYPASS			0
>  #define ADXL313_FIFO_STREAM			2
>  
> +#define ADXL313_FIFO_SIZE			32
> +
> +#define ADXL313_NUM_AXIS			3
> +
>  extern const struct regmap_access_table adxl312_readable_regs_table;
>  extern const struct regmap_access_table adxl313_readable_regs_table;
>  extern const struct regmap_access_table adxl314_readable_regs_table;
> @@ -78,7 +86,9 @@ struct adxl313_data {
>  	struct regmap	*regmap;
>  	const struct adxl313_chip_info *chip_info;
>  	struct mutex	lock; /* lock to protect transf_buf */
> +	u8 watermark;
>  	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
> +	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
>  };
>  
>  struct adxl313_chip_info {
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 31ce1b218488..8a0b5542fb40 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -10,15 +10,21 @@
>  #include <linux/bitfield.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +
>  #include "adxl313.h"
>  
>  #define ADXL313_INT_NONE			U8_MAX
>  #define ADXL313_INT1				1
>  #define ADXL313_INT2				2
>  
> +#define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
> +
>  static const struct regmap_range adxl312_readable_reg_range[] = {
>  	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
>  	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> @@ -62,6 +68,7 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
>  	case ADXL313_REG_DATA_AXIS(4):
>  	case ADXL313_REG_DATA_AXIS(5):
>  	case ADXL313_REG_FIFO_STATUS:
> +	case ADXL313_REG_INT_SOURCE:
It's always been volatile, whether or  not we were writing it.

Hmm. Given this I'm dropping the regcache patch as I'd missed that was a partial
list when reviewing that one.

>  		return true;
>  	default:
>  		return false;
> @@ -363,6 +370,176 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	const unsigned int fifo_mask = 0x1f, interrupt_mask = 0x02;

Why not just use defines for the fields?  The second one is particularly
confusing as that is just the mask for the watermark interrupt not of
a general 'interrupt' field as the name suggests.


> +	int ret;
> +
> +	value = min(value, ADXL313_FIFO_SIZE - 1);
> +
> +	ret = regmap_update_bits(data->regmap, ADXL313_REG_FIFO_CTL,
> +				 fifo_mask, value);
> +	if (ret)
> +		return ret;
> +
> +	data->watermark = value;
> +
> +	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> +				  interrupt_mask, ADXL313_INT_WATERMARK);

	return regmap_set_bits(data->regmap, ADXL313_REG_INT_ENABLED,
			       ADXL313_INT_WATERMARK);
> +}


> +
> +static int adxl313_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = adxl313_set_measure_en(data, false);

I'd like a comment on why we need to disable measurements
here.  Some reference to the datasheet probably and that fifo mode
can only be changed with measurements disabled.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
> +			   FIELD_PREP(ADXL313_REG_FIFO_CTL_SAMPLES_MSK,	data->watermark) |
> +			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, ADXL313_FIFO_STREAM));
> +	if (ret)
> +		return ret;
> +
> +	return adxl313_set_measure_en(data, true);
> +}

> +static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)

Can we avoid 'event' naming here.  Events in IIO terms would not include
watermarks used to drain a fifo.

> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int samples;
> +
> +	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
> +		samples = adxl313_get_samples(data);
> +		if (samples < 0)
> +			return samples;
> +
> +		return adxl313_fifo_push(indio_dev, samples);
> +	}
> +
> +	/* Return error if no event data was pushed to the IIO channel. */
> +	return -ENOENT;
> +}
> +
> +static irqreturn_t adxl313_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int int_stat;
> +
> +	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
> +		return IRQ_NONE;
> +
> +	if (adxl313_push_event(indio_dev, int_stat))
> +		goto err;
> +
> +	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))

I suspect that we can have watermark and overrun set.  Whether it is appropriate
to drain the data out and push it to userspace isn't clear to me.  Maybe
add a comment on that so we can refer to it when considering the logic.

> +		goto err;
> +
> +	return IRQ_HANDLED;
> +
> +err:
> +	adxl313_fifo_reset(data);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  			      unsigned int writeval, unsigned int *readval)
>  {
> @@ -377,6 +554,7 @@ static const struct iio_info adxl313_info = {
>  	.read_raw	= adxl313_read_raw,
>  	.write_raw	= adxl313_write_raw,
>  	.read_avail	= adxl313_read_freq_avail,
> +	.hwfifo_set_watermark = adxl313_set_watermark,
>  	.debugfs_reg_access = &adxl313_reg_access,
>  };
>  
> @@ -487,6 +665,18 @@ int adxl313_core_probe(struct device *dev,
>  					 int_map_msk, int_line == ADXL313_INT2);
>  		if (ret)
>  			return ret;
> +
> +		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +						  &adxl313_buffer_ops);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						&adxl313_irq_handler,
> +						IRQF_SHARED | IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
>  	} else {
>  		/*
>  		 * FIFO_BYPASSED mode


