Return-Path: <linux-iio+bounces-15595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BB2A37625
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6079D3AD7A9
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB418DB08;
	Sun, 16 Feb 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhjzyT9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E04315C;
	Sun, 16 Feb 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725547; cv=none; b=jEHvIt21uO3mZRN/1XbNiCz0x/3F5V/0X6PrSAnfJPJh+VxZmydEgbAHSFZsSfRvRYC0BTK+WriRw4ibxxJ2j7zRnN5+X/NwcA8lDptIDAwlYrkhOViDq20K1xswp8/j4Kb59hdqeLxCnT+qZXQddNb3VIKBMScDgU3sGagIB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725547; c=relaxed/simple;
	bh=3xC1IVKMp+3oQbtY/qgKmmdKo4k+6efAR0w3j2pPxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVPOioaQDKKKHTsaV/QWT4kXJ3UPTVNUduANInN83iLiuRehTgUklvi2eIOQeKg0YAoZdFgit3DSVlNiBsfQEgBBlTtcZr+qAv/pMmbEzfCfIkarwQXVJ5a6AhZBUGaW+8JoCXxTU+pw4KdPr8MDyc/sARxlSe1m7r0BbLpuVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhjzyT9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A9EC4CEDD;
	Sun, 16 Feb 2025 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739725547;
	bh=3xC1IVKMp+3oQbtY/qgKmmdKo4k+6efAR0w3j2pPxgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FhjzyT9BiV709Byrqef2BA3OMRv/+FEZ98xfnXqsHwwZpL9+GS7JWbAPWymDFVSwk
	 wpTpzKlUzkPX+QBt9Sum78xbo35OK5j33M4GfBUBHuCwfHNL5Jbfwt3hAzcUO+8TLq
	 TjZ5PEfiZXAXU8983Kw49OU5w25olwDU3DtziQrcDKxP9IJO/CRdCxuP2vEtwLr4W8
	 K9xGFj7zMdztEVwN+ktOQBhDUOoviVRpiEYreKujvhd1L/c7CEBsAxgZuEK5hsymXu
	 RIa6XvK0q0caEbb3y/NzZ86Rw+LpDMKK4cGByVoL87EfN4EJBEThEAObuYGA1CqJpC
	 +jv2RYyDYw2Xw==
Date: Sun, 16 Feb 2025 17:05:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 03/14] iio: accel: adxl345: reorganize irq handler
Message-ID: <20250216170541.3042a8f5@jic23-huawei>
In-Reply-To: <20250210110119.260858-4-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:08 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Reorganize the IRQ handler. Move the overrun handling to the bottom.
> Overrun leads to reset the interrupt register. This also happens at
> evaluation of a particular interrupt event. First evaluate an event
> if possible, then fall back to overrun handling. Additionally simplify
> fetching the interrupt status function.
> 
> Both is in preparation to build interrupt handling up for the handling
> of different detected events, implemented in follow up patches.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

Changes are fine, but I think we should reevaluate if the little
helper to get_status is actually useful any more.  Probably best
to just drop it as part of this patch.

Jonathan

> ---
>  drivers/iio/accel/adxl345.h      |  1 -
>  drivers/iio/accel/adxl345_core.c | 26 +++++++++-----------------
>  2 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 517e494ba555..bc6d634bd85c 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -43,7 +43,6 @@
>  #define ADXL345_REG_INT_ENABLE		0x2E
>  #define ADXL345_REG_INT_MAP		0x2F
>  #define ADXL345_REG_INT_SOURCE		0x30
> -#define ADXL345_REG_INT_SOURCE_MSK	0xFF
>  #define ADXL345_REG_DATA_FORMAT		0x31
>  #define ADXL345_REG_XYZ_BASE		0x32
>  #define ADXL345_REG_DATA_AXIS(index)				\
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 468d562de227..2928c1c0760f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -107,8 +107,7 @@ static int adxl345_set_interrupts(struct adxl345_state *st)
>  	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
>  	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
>  	 */
> -	int_map = FIELD_GET(ADXL345_REG_INT_SOURCE_MSK,
> -			    st->intio ? st->int_map : ~st->int_map);
> +	int_map = st->intio ? st->int_map : ~st->int_map;
>  
>  	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
>  	if (ret)
> @@ -404,16 +403,9 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
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
> +	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);

After this cleanup/refactoring this function no longer has a reason to exist.
Just call regmap_read() directly inline.

>  }
>  
>  static int adxl345_fifo_push(struct iio_dev *indio_dev,
> @@ -449,14 +441,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  	int int_stat;
>  	int samples;
>  
> -	int_stat = adxl345_get_status(st);
> -	if (int_stat <= 0)
> +	if (adxl345_get_status(st, &int_stat))

	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))

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
> @@ -464,6 +452,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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


