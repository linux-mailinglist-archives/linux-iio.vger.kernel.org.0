Return-Path: <linux-iio+bounces-12606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93E9D7779
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87BF2824F4
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2125142E86;
	Sun, 24 Nov 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCLk+bOn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9C13C67C;
	Sun, 24 Nov 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474192; cv=none; b=lSmtd83EiqywY0EiNYkVtXMn772B7QZeJ6HxNd9PGevB6oKGY1otDDYTo1IM7kl1NLkXoWzlkDdggoiykiUT7M5SqdyqaQ3NOW1kkzQ22z5mb1aMMTQmxTxhr6/jr7rkkXmEBhg6w1YN+g4778gHpKHKqdP1I5qjAeInae6JsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474192; c=relaxed/simple;
	bh=tpzQGGlunNRU4afz4XTgeaR3JxlnsELgP/tOf5UDoE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGTYAqIl6difghWw3Ei1s+9C4af+eL95Q+lRRT/by0ybSWhHgkGH5NA14pucRrJ2SCn7ArNBpxlB9Ay5zYS2U79/hbo5tHKQruKRTpBamsJKwsU2yIrx8mUciiQ16Pg7cyen70la8nN82hD0WQM/IgaYiYjjDP6geB5zejIFAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCLk+bOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD61DC4CECC;
	Sun, 24 Nov 2024 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732474192;
	bh=tpzQGGlunNRU4afz4XTgeaR3JxlnsELgP/tOf5UDoE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MCLk+bOneYspae2wesZrkdjEBBmuelMDQlFQLXuZc4QZPpk03pG8dYzpbGqtDukvf
	 cKQxjY5gkTiulLEIf4sakE0jPzoBtygYu4JIeXXvu4dC4uWJMFjULVaXprtk1HPlsW
	 L+Dq9OutpKu76ezTWtCSqbXJJSDgMCwkQQPb5eO/LzGEu8DXA29YXq+f8mscuiLQvJ
	 EG4hReY1tEsJG4Xfee3+0l92F/buRbduT0wwubYnpcvAFo9J7FLmI50mh+4r58UFek
	 xOEVo5S9gVrTHcCicO70DNpzUW6WvhVruE/+QOE9LB8V3yHj8oT5zVGK1OCiVvLACT
	 aJmxhpDup94hA==
Date: Sun, 24 Nov 2024 18:49:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 14/22] iio: accel: adxl345: read FIFO entries
Message-ID: <20241124184944.53499c29@jic23-huawei>
In-Reply-To: <20241117182651.115056-15-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-15-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:43 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a function to read the elements of the adxl345 FIFO. This will
> flush the FIFO, and brings it into a ready state. The read out
> is used to read the elemnts and to reset the fifo again. The cleanup
> equally needs a read on the INT_SOURCE register.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 40 ++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 508de81bb9..40e78dbdb0 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -140,6 +140,8 @@ struct adxl34x_state {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
>  	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
> +
> +	__le16 fifo_buf[3 * ADXL34x_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
That doesn't work.  Look at why we have IIO_DMA_MINALIGN().
Hint is that the buffer needs to end up in a cacheline with nothing that might
be written by software in the same line.  int_map and below will be so this
is not doing it's job.

Also not used in this patch.

>  	u8 int_map;
>  	bool fifo_delay; /* delay: delay is needed for SPI */
>  	u8 intio;
> @@ -323,6 +325,37 @@ static const struct attribute_group adxl345_attrs_group = {
>  	.attrs = adxl345_attrs,
>  };
>  
> +/**
> + * adxl345_get_fifo_entries() - Read number of FIFO entries into *fifo_entries.
> + * @st: The initialized state instance of this driver.
> + * @fifo_entries: A field to be initialized by this function with the number of
> + * FIFO entries.
> + *
> + * Since one read on the FIFO is reading all three axis, X, Y and Z in one, the
> + * number of FIFO entries corresponds to the number of triples of those values.
> + * Note, this sensor does not support treating any axis individually, or
> + * exclude them from measuring.
> + *
> + * Return: 0 or error value.
> + */
> +static int adxl345_get_fifo_entries(struct adxl34x_state *st, int *fifo_entries)
> +{
> +	unsigned int regval = 0;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_FIFO_STATUS, &regval);
> +	if (ret) {
> +		pr_warn("%s(): Failed to read FIFO_STATUS register\n", __func__);
As before, seems overkill to warn int his path but not really anywhere else.
dev_err() if you do want to.
> +		*fifo_entries = 0;
> +		return ret;
> +	}
> +
> +	*fifo_entries = 0x3f & regval;
> +	pr_debug("%s(): fifo_entries %d\n", __func__, *fifo_entries);
> +
> +	return 0;
return the value (similar comment to previous patch review.)
> +}
> +
>  static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
>  };
>  
> @@ -363,6 +396,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = ((struct iio_poll_func *) p)->indio_dev;
>  	struct adxl34x_state *st = iio_priv(indio_dev);
>  	u8 int_stat;
> +	int fifo_entries;
>  	int ret;
>  
>  	ret = adxl345_get_status(st, &int_stat);
> @@ -380,9 +414,11 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  		goto done;
>  	}
>  
> -	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK))
> +	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
>  		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
> -
> +		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
Do it all in one go. I want to see interrupt through to data hitting the kfifo +
registration of that kfifo all in one patch.

It is not complicated enough to need to jump through this very slow introduction
of code.

Jonathan

> +			goto done;
> +	}
>  	goto done;
>  done:
>  


