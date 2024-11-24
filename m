Return-Path: <linux-iio+bounces-12607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EDD9D7784
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF97C2825FC
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC213BC0C;
	Sun, 24 Nov 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC3DubQY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7D2500DB;
	Sun, 24 Nov 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474496; cv=none; b=qJQHmNRSQOqxOwLJAt6vtGT1KIZkW99lisF+DNIgzQWEQG6kBVffefpCJlrF11SRukEY7sIGZvefvP1lCG/eYC3Ef+HNHkHK0ApJpwRioo10xZuMMxVRv6bbzMY3g6IfWKL43YTMzO+inMKKqzdYU9DdF3rXjwKu5HWNUCngAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474496; c=relaxed/simple;
	bh=XRcZ3HN46afrveF0JXF2TiFqNDTACellTF+3m1lwJn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxnBIGCUdTqwiwCyAsmOIihr2/yHf9C2oPL430XheUccW71JIZt7i0PMHx5fICtPfh6b39e5xXIlrTP02mkW89aSUISzONwHHcIGWy4IO+qLk3UCdGl3Ba3Nde+IRZ4f5L44e+9c+HtfEAwVnQx0IdJJT99BIECLg0cHU0CQ2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC3DubQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0804C4CECC;
	Sun, 24 Nov 2024 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732474495;
	bh=XRcZ3HN46afrveF0JXF2TiFqNDTACellTF+3m1lwJn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rC3DubQY5QSyIMlHql8TyLQBOs+Bnp221fRDXATkQpUO2a0eb93xaq3LmT+v/no5K
	 maLjKmLve2xihg2vxDOCc9qMpRW2Iz4/ZLzCqZiB9iGpnEBzC3Ficf0kaETlMFxXjk
	 /ww/T1PNmGIipmop0mqmL8vr+d2jEHHXmnL6DOpDwxTTRrkTStPyOQ98uzWn9lxcFz
	 5ZUChdvAawnyJj17xzdtFiURHiXWbg2LIFrXTN5Hm3Hy6teD7FyhU+dmFea5AWFdz3
	 uKPHjcx6ZdJ2yMH+M6dH7b2RX0tBij7dQAF1AbYxL2kWzE7NYfQpcIeA+Z0xPfv/4L
	 LfFD/J/wkZFHA==
Date: Sun, 24 Nov 2024 18:54:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 15/22] iio: accel: adxl345: reset the FIFO on error
Message-ID: <20241124185449.6f81ade1@jic23-huawei>
In-Reply-To: <20241117182651.115056-16-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-16-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:44 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a function to empty the FIFO and reset the INT_SOURCE register.
> Reading out is used to reset the fifo again. For cleanup also a read
> on the INT_SOURCE register is needed to allow the adxl345 to issue
> interrupts again. Without clearing the fields no further interrupts
> will happen.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 75 ++++++++++++++++++++++++++++----
>  1 file changed, 67 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 40e78dbdb0..82bd5c2b78 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -356,6 +356,61 @@ static int adxl345_get_fifo_entries(struct adxl34x_state *st, int *fifo_entries)
>  	return 0;
>  }
>  
> +/**
> + * adxl345_read_fifo_elements() - Read fifo_entries number of elements.
> + * @st: The instance of the state object of this sensor.
> + * @fifo_entries: The number of lines in the FIFO referred to as fifo_entry,
> + * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes each.
> + *
> + * The FIFO of the sensor is read linewise. The read measurement values are
> + * queued in the corresponding data structure in *st.
> + *
> + * It is recommended that a multiple-byte read of all registers be performed to
> + * prevent a change in data between reads of sequential registers. That is to
> + * read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.

To ensure this, set avail_scan_modes.
Then if the user requests a subset, the IIO core code will extract what is necessary
from the read of everythign.


> + *
> + * Return: 0 or error value.
> + */
> +static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries)
> +{
> +	size_t count, ndirs = 3;
> +	int i, ret;
> +
> +	count = 2 * ndirs; /* 2 byte per direction */
sizeof(st->fifo_buf[0] * ndirs);

> +	for (i = 0; i < fifo_entries; i++) {
> +		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
> +				st->fifo_buf + (i * count / 2), count);
> +		if (ret) {
> +			pr_warn("%s(): regmap_noinc_read() failed\n", __func__);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * adxl345_empty_fifo() - Empty the FIFO.
> + * @st: The instance to the state object of the sensor.
> + *
> + * Reading all elements of the FIFO linewise empties the FIFO. Reading th
> + * interrupt source register resets the sensor. This is needed also in case of
> + * overflow or error handling to reenable the sensor to issue interrupts.
> + */
> +static void adxl345_empty_fifo(struct adxl34x_state *st)
> +{
> +	int regval;
> +	int fifo_entries;
> +
> +	/* In case the HW is not "clean" just read out remaining elements */
> +	adxl345_get_fifo_entries(st, &fifo_entries);
> +	if (fifo_entries > 0)
> +		adxl345_read_fifo_elements(st, fifo_entries);
> +
> +	/* Reset the INT_SOURCE register by reading the register */
> +	regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
> +}
> +
>  static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
>  };
>  
> @@ -401,30 +456,34 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  
>  	ret = adxl345_get_status(st, &int_stat);
>  	if (ret < 0)
> -		goto done;
> +		goto err;
All this churn just makes things less readable.  Better to have the bulk
of the addition of fifo handling in one patch. It won't be too large
for review.
>  
>  	/* Ignore already read event by reissued too fast */
>  	if (int_stat == 0x0)
> -		goto done;
> +		goto err;
>  
>  	/* evaluation */
>  
>  	if (int_stat & ADXL345_INT_OVERRUN) {
>  		pr_debug("%s(): OVERRUN event detected\n", __func__);
> -		goto done;
> +		goto err;
>  	}
>  
>  	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
>  		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
>  		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
> -			goto done;
> -	}
> -	goto done;
> -done:
> +			goto err;
>  
> -	if (indio_dev)
>  		iio_trigger_notify_done(indio_dev->trig);
> +	}
>  
> +	goto done;
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	adxl345_empty_fifo(st);
> +	return IRQ_NONE;
NONE is probably a bad idea. Something went wrong but that doesn't
mean it wasn't our interrupt.  In most cases it is better to just
return that we handled it.  IRQ_NONE might be valid if the status
said it wasn't ours.

> +
> +done:
>  	return IRQ_HANDLED;
return where you have goto done and get rid of this.

>  }
>  


