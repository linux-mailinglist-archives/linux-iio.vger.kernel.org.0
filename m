Return-Path: <linux-iio+bounces-16892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB82A6353A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745AF3A97EB
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A41A00ED;
	Sun, 16 Mar 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxvKjf0D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910F154BFE;
	Sun, 16 Mar 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123482; cv=none; b=XHeBndnAXdCwsXRUDJ9ICo4DYhD3MfylyvgpucX77f2Ti+7GJ1RVtiTqb7Vx+que0focG+A+/NgXHdLd2RigLIXhLnDMRmMBllNk//eV42YSPT2YywS+Shq+2NzXghUSsnUr19VFXoAAjKUZW8Yu70jZ5I9hIuu/vtGxmVFxLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123482; c=relaxed/simple;
	bh=ETh+2NuhKN296ts6b8maoM++LUe3y0VwqjygzWnoSuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRIWPp+zpMLC6sjNH8aPgKKD54RqjQ7vy3Zh3uI+skNd3auTnafWFUV9y6MVZ9zuoVE36rM250oA2pcXzIQlDm/3IA5Nd2IcKEu6S1qcenE20ZJpQCS3o2SUNWE8H+e4UOqzr8oLrXbDykQf4lL2eMa/KH2j9AS+ubQqL0RYx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxvKjf0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4E2C4CEDD;
	Sun, 16 Mar 2025 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123481;
	bh=ETh+2NuhKN296ts6b8maoM++LUe3y0VwqjygzWnoSuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxvKjf0DEnEybG0oAuMdW66aeW7ZdF14h2QKKIPZ8WYYPKOWuPc4aVVmuAg1yoq55
	 E6iHe+87g/RBNX9heiwYAUTgHRRmzh8To87pRJodT5AxIa2BzACWSPX5rNzvBuY1XR
	 6T+Mf6tIZ4YCl3vzfB229vNO6Eth8AwM+QMAQHQPy4QiNr1X745tzcjvSpHtvpeh9c
	 SDnSqnF4XAUzjUfY3qncxxXFvDcnkuDq67MDZyP3Mc5ufc+RZkEG4z8PUxYRJgHeSR
	 OfcJntFtnShqpJliZfhYA0GRlaGib3TACWP+t+ZGpECxV/g/rSuSCsTbVdTWT1HBwM
	 12yIHl+H8OjPQ==
Date: Sun, 16 Mar 2025 11:11:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 02/14] iio: accel: adxl345: move INT enable to regmap
 cache
Message-ID: <20250316111105.58598a2e@jic23-huawei>
In-Reply-To: <20250313165049.48305-3-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:37 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace the interrupt enable member variable to the regmap cache. This
> makes the function set_interrupts() obsolete. The interrupt enable
> register is written when the driver is probed. Thus it is perfectly
> cacheable.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied with a small tweak. I don't think you touch set_watermark
again later in the series so this shouldn't cause too much impact.

> ---
>  drivers/iio/accel/adxl345_core.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 6f337b26999a..10e2da7de17e 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -36,7 +36,6 @@ struct adxl345_state {
>  	struct regmap *regmap;
>  	bool fifo_delay; /* delay: delay is needed for SPI */
>  	int irq;
> -	u8 int_map;
>  	u8 watermark;
>  	u8 fifo_mode;
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
> @@ -114,11 +113,6 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
>  }
>  
> -static int adxl345_set_interrupts(struct adxl345_state *st)
> -{
> -	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
> -}
> -
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -217,7 +211,7 @@ static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
> -	unsigned int fifo_mask = 0x1F;
> +	const unsigned int fifo_mask = 0x1F, watermark_mask = 0x02;
>  	int ret;
>  
>  	value = min(value, ADXL345_FIFO_SIZE - 1);
> @@ -227,7 +221,10 @@ static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
>  		return ret;
>  
>  	st->watermark = value;
> -	st->int_map |= ADXL345_INT_WATERMARK;
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE, watermark_mask,
> +				 ADXL345_INT_WATERMARK);
> +	if (ret)
> +		return ret;
tweaked to
	return regmap.
>  
>  	return 0;
>  }
> @@ -381,11 +378,6 @@ static void adxl345_fifo_reset(struct adxl345_state *st)
>  static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = adxl345_set_interrupts(st);
> -	if (ret < 0)
> -		return ret;
>  
>  	st->fifo_mode = ADXL345_FIFO_STREAM;
>  	return adxl345_set_fifo(st);
> @@ -401,8 +393,7 @@ static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	st->int_map = 0x00;
> -	return adxl345_set_interrupts(st);
> +	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
>  }
>  
>  static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
> @@ -524,6 +515,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  	indio_dev->available_scan_masks = adxl345_scan_masks;
>  
> +	/* Reset interrupts at start up */
> +	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
> +	if (ret)
> +		return ret;
> +
>  	if (setup) {
>  		/* Perform optional initial bus specific configuration */
>  		ret = setup(dev, st->regmap);


