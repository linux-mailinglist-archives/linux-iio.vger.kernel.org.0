Return-Path: <linux-iio+bounces-14838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C273A24A98
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88083A60DF
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3811C5F0F;
	Sat,  1 Feb 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw2llv6y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A071C548A;
	Sat,  1 Feb 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428225; cv=none; b=uhNsSj9E+ukU8R1ARZfeLOPMjMVJNH0nz0WejD1JXiN8qlb/j25YPYRbV6v7w5F0LtVtm/SW4e+vR6BI5mS7YbjTJy5P2cxZbNAg//ElxeeMPgnLxN8YBy92PMwkdTtFMEZlXa9/baPrnHpI4S+4VURDyH3Hxcy1T/XKWoQZEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428225; c=relaxed/simple;
	bh=GnrOUZhTL7gypNtyaTHEjj8pXk55RWK/byJMlNWWfQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7W+xiUWOmr85yZ0X62lbFreAT18qrDlN0/qJNeNWo4o7UbwSRvPrGNJfNANVxRalJbd68WpufOMbvfVUnWkVr9dkpFV5x7nHI5cHk5S8K67El8ZwWFZ+JUzQjm5YqVEqjggjxVB0G6xHZe6ETlBTzf+3DXK0i2K2GjVnygtbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw2llv6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC95DC4CED3;
	Sat,  1 Feb 2025 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738428224;
	bh=GnrOUZhTL7gypNtyaTHEjj8pXk55RWK/byJMlNWWfQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fw2llv6y9S9h5k0u94HM4x7qBObO+CeqA/HyawhpNdARA78iGMlti9JrJfmF7ZLmP
	 TKeYO3K28yYNVwO9OQQGNJyMR73t4pp31IL4MHQnfoQGOU2hve89aBuZgjpvLrp6fN
	 c9SdG2oJroQHClFI84XtjfDsXsXs0cZs6EnMGDO7qj6wKTvK6XjlCNsSUPczsMPY1x
	 hINYM0AGxEGxSGaF3SxF52MUfbkwF2J2zNqLQ4NdZBwIezoppPH8AV48Y9A+lBORv9
	 icKFomi2Pqsi+cziHFMO0zbZIv0uHsSY8NGtDqQCCp83zJ1f4WE2+MRNFNPOjqAxha
	 B/YGlpN8+MMlw==
Date: Sat, 1 Feb 2025 16:43:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 04/12] iio: accel: adxl345: reorganize irq handler
Message-ID: <20250201164338.3359f306@jic23-huawei>
In-Reply-To: <20250128120100.205523-5-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:52 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Reorganize the IRQ handler. Move the overrun handling to the bottom.
> Overrun leads to reset the interrupt register. This also happens at
> evaluation of a particular interrupt event. So, actually it makes more
> sense to evaluate the event if possible, and only fall back to pure
> overrun handling as a last resort. Further simplify fetching the
> interrupt status function. Both is in preparation to build interrupt

Both are preparatory steps to build

> handling up for the handling of different detected events, implemented
> in follow up patches.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

> ---
>  drivers/iio/accel/adxl345_core.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 8fbf0a43746f..7ee50a0b23ea 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -491,16 +491,9 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
>  	.predisable = adxl345_buffer_predisable,
>  };
>  
> -static int adxl345_get_status(struct adxl345_state *st)
> +static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
>  {
> -	int ret;
> -	unsigned int regval;
> -
> -	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
> -	if (ret < 0)
> -		return ret;
> -
> -	return FIELD_GET(ADXL345_REG_INT_SOURCE_MSK, regval);

Maybe worth commenting in the patch description that this is the whole register
anyway.  Makes it obvious why this isn't a functional change.

Also delete that MSK value as it is rather pointless!
> +	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
>  }
>  
>  static int adxl345_fifo_push(struct iio_dev *indio_dev,
> @@ -536,14 +529,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  	int int_stat;
>  	int samples;
>  
> -	int_stat = adxl345_get_status(st);
> -	if (int_stat <= 0)
> +	if (adxl345_get_status(st, &int_stat))
>  		return IRQ_NONE;
>  
> -	if (int_stat & ADXL345_INT_OVERRUN)
> -		goto err;
> -
> -	if (int_stat & ADXL345_INT_WATERMARK) {
> +	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
>  		samples = adxl345_get_samples(st);
>  		if (samples < 0)
>  			goto err;
> @@ -551,6 +540,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  		if (adxl345_fifo_push(indio_dev, samples) < 0)
>  			goto err;
>  	}
> +
> +	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
> +		goto err;
> +
>  	return IRQ_HANDLED;
>  
>  err:


