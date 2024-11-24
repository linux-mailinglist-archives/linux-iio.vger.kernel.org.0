Return-Path: <linux-iio+bounces-12611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B8D9D7797
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3280F282547
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF542052;
	Sun, 24 Nov 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slIGLFMl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FF2500A6;
	Sun, 24 Nov 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474865; cv=none; b=qHnOZQAR1N1s/1cswcdDjG9+UFVkuGnJqTgNGOLQm8LAKcgag2ozy38RpvgGpaiprXyPWHUiDzu+UC1D/okcV9bZXUDzDBmk0277X+dpZbpK6pFeeNnFxI1uyf2+owziOCp806BqH2ZVM39Jfb9pc5thn9awIwkIW7cXRROPQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474865; c=relaxed/simple;
	bh=qwU2hAb1VK5QQX+zguM+4DOjUFAiKjl6aQ19Q+aMnjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0EIrV7EMQOaRun9Fk46scAJSVB6pYS4GVNGv/50HZCNM0JzQ8Lke2nNSGURoU46qiCfYneYvJ4NAgtBoyP1HDYhB1fCUMID+fyTxmvOWE6Kd0UW2dSca6PTvcR/Ebux+q9Hm6IkFZQz8hr8Ntsau4DMHolGtBxnulUMQPyBZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slIGLFMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412C8C4CECC;
	Sun, 24 Nov 2024 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732474865;
	bh=qwU2hAb1VK5QQX+zguM+4DOjUFAiKjl6aQ19Q+aMnjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slIGLFMlULq8KTuJKHBF20P9mJ53f4ZrcjsZBpmLzv74k9U/u6xF8+a2c68a5yDyv
	 o7pReaOcmNCqO25q/wKb8kIddvfNUElzkXcwNwBGHxeSwq8Lv/66KxIjVF4E+Q9+tW
	 ZEz/dxkjEMxBeQ/p9FJO0f1oVJQwpDiVFLNjmcBMN5WXsXi9uN1dubM3iAu5lrGmC0
	 D+T2mYZTGqIVpnNr2cNj2Ei5xjip91SnB0vbd4tv6odPb4Hk0IHO05PckIT0MlLWXk
	 C94GxoVtZ+w4bG0gSCGfKnIiP1C0GhvBQjn7wOZlMWEGuZC5lN3w/wJmXXJmG/bCY4
	 HrNxWAt2xbvVQ==
Date: Sun, 24 Nov 2024 19:00:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 18/22] iio: accel: adxl345: start measure at buffer
 en/disable
Message-ID: <20241124190057.73dd7cd5@jic23-huawei>
In-Reply-To: <20241117182651.115056-19-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-19-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:47 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add and initialize the buffer options to use the FIFO and watermark
> feature of the adxl345 sensor. In this way measure enable will happen
> in at enabling the buffer.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Various minor comments.  In general I haven't commented on every
instance of formatting problems etc. Please generalize though all the
patches based on comments that are made.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 105 +++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index a653774db8..b57a123ac9 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -181,6 +181,28 @@ static const struct iio_chan_spec adxl34x_channels[] = {
>  	ADXL34x_CHANNEL(2, chan_z, Z),
>  };
>  
> +static int adxl345_set_interrupts(struct adxl34x_state *st)
> +{
> +	int ret;
> +	unsigned int int_enable = st->int_map;
> +	unsigned int int_map;
> +
> +	/* Any bits set to 0 in the INT map register send their respective
> +	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
> +	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
> +	 */
> +	int_map = 0xFF & (st->intio ? st->int_map : ~st->int_map);
> +	pr_debug("%s(): Setting INT_MAP 0x%02X\n", __func__, int_map);
> +
> +	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
> +	if (ret)
> +		return ret;
> +
> +	pr_debug("%s(): Setting INT_ENABLE 0x%02X\n", __func__, int_enable);
> +	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
> +	return ret;
> +}
> +
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -330,6 +352,41 @@ static const struct attribute_group adxl345_attrs_group = {
>  	.attrs = adxl345_attrs,
>  };
>  
> +static int adxl345_set_fifo(struct adxl34x_state *st)
> +{
> +	struct adxl34x_platform_data *data = &st->data;
> +	u8 fifo_ctl;
> +	int ret;
> +
> +	/* FIFO should be configured while in standby mode */
> +	adxl345_set_measure_en(st, false);
Check for errors.
> +
> +	/* The watermark bit is set when the number of samples in FIFO
> +	 * equals the value stored in the samples bits (register
> +	 * FIFO_CTL). The watermark bit is cleared automatically when
> +	 * FIFO is read, and the content returns to a value below the
> +	 * value stored in the samples bits.
> +	 */
> +	fifo_ctl = 0x00 |
What does the 0x00 bring?  Get rid of that.
> +		ADXL345_FIFO_CTL_SAMLPES(data->watermark) |
> +		ADXL345_FIFO_CTL_TRIGGER(st->intio) |
> +		ADXL345_FIFO_CTL_MODE(data->fifo_mode);
> +
> +	pr_debug("%s(): fifo_ctl 0x%02X\n", __func__, fifo_ctl);
> +
> +	/* The watermark bit is set when the number of samples in FIFO
> +	 * equals the value stored in the samples bits (register
> +	 * FIFO_CTL). The watermark bit is cleared automatically when
> +	 * FIFO is read, and the content returns to a value below the
> +	 * value stored in the samples bits.
> +	 */
> +	ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
> +	if (ret < 0)
> +		return ret;
> +
> +	return adxl345_set_measure_en(st, true);
> +}
> +
>  /**
>   * adxl345_get_fifo_entries() - Read number of FIFO entries into *fifo_entries.
>   * @st: The initialized state instance of this driver.
> @@ -416,7 +473,50 @@ static void adxl345_empty_fifo(struct adxl34x_state *st)
>  	regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
>  }
>  
> +static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl34x_state *st = iio_priv(indio_dev);
> +	struct adxl34x_platform_data *data = &st->data;
> +	int ret;
> +
> +	ret = adxl345_set_interrupts(st);
> +	if (ret)
> +		return -EINVAL;
> +
> +	/* Default to FIFO mode: STREAM, since it covers the general usage
> +	 * and does not bypass the FIFO
> +	 */
> +	data->fifo_mode = ADXL_FIFO_STREAM;
> +	adxl345_set_fifo(st);
check for errors and probably try and unwind what was done in here if you
get one.

> +
> +	return 0;
> +}
> +
> +static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl34x_state *st = iio_priv(indio_dev);
> +	struct adxl34x_platform_data *data = &st->data;
> +	int ret;
> +
> +	/* Turn off interrupts */
> +	st->int_map = 0x00;
> +
> +	ret = adxl345_set_interrupts(st);
> +	if (ret) {
> +		pr_warn("%s(): Failed to disable INTs\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* Set FIFO mode: BYPASS, according to the situation */
> +	data->fifo_mode = ADXL_FIFO_BYPASS;
> +	adxl345_set_fifo(st);
always check for errors.

> +
> +	return 0;
> +}

>  
>  static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
> @@ -625,7 +725,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;

That is set when you register a triggered buffer.

>  	indio_dev->channels = adxl34x_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);


