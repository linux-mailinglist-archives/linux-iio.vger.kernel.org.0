Return-Path: <linux-iio+bounces-19880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 839A2AC34AD
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7B188EE5D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABEB1F30C3;
	Sun, 25 May 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHroGnTB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26323741;
	Sun, 25 May 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748177672; cv=none; b=Los1WrEtsrKwXOzcBLA45z9GHulxBeoNRPEYOFob8pjOAVg+/szs9LSIX9k6BW1MRuq5dNgl9nfgkGMa0D3jFKqTEbr4toF7tWbZiaDSOCRxhRnPK0RfooJ2Fy56ZjT3u6xMIT6yh8Rk24E9cuhlam/e56JnT3nNbJxd8ehtvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748177672; c=relaxed/simple;
	bh=s6zR8DcH1c1YqTiMmMYr21IC2MtrTyImKeXTEwzLhUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXdMT632j2lzD4m0gyzq4RKrk6xNBMqBLOus6bsvK+FgETYfcO/pNIt6nn18y1zMQgGLg7n2LdaQThiXT3lxAaC1MXIcQjppA6SxJWTMqqffnjla/EGiD6Ru6qslawTQ6CHIemg9x/WuoFGnDIu9u99Fz3lMDLlS83MrWfdqLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHroGnTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E7AC4CEEA;
	Sun, 25 May 2025 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748177671;
	bh=s6zR8DcH1c1YqTiMmMYr21IC2MtrTyImKeXTEwzLhUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LHroGnTB3WGD52CHHH2dIfpO507tUkFs15ahRkNoAD4DeoPm8hq6g+vmzu8wzbeH1
	 u21zDzvPPw8lYOdBCXlLaMirS8OkuWNPoz0bc1t1ZnpNHr06tq0UaSKneo/zKr9YpJ
	 RKjR0eP5tXEu3eF3Q0lyiy5Ju+5YFdMIYpjfnGvZRrPDY7L4TL4OjoiPI0uz2ILF5+
	 2KX8P9dIQjKeg5mITsVaImARAHzpaiFM5MQIeiMMVFcSZejgF9TstBFveLeivFH8cH
	 sZwoPLPay9YHS58HfQG4RqEnzCA256rj32YVjKmytHtLE6WEIKGCmiF9Zbi+Vd7Iao
	 vC7CdITgTZB1Q==
Date: Sun, 25 May 2025 13:54:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/12] iio: accel: adxl313: add FIFO watermark
Message-ID: <20250525135424.0f77096f@jic23-huawei>
In-Reply-To: <20250523223523.35218-9-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:19 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add FIFO watermark configuration and evaluation. Let a watermark to be
> configured. Evaluate the interrupt accordingly. Read out the FIFO content
> and push the values to the IIO channel.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

I'd rethink the patch split a little and combine this with the initial interrupt
support.  That will avoid confusion over when the reset fires.

> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 1e085f0c61a0..80991cd9bd79 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -373,6 +373,25 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,

> +
> +static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
I'd avoid the term 'event' for this as your only use so far is something
we'd not consider an 'event' in IIO terms.

I'd be tempted to just keep this as code directly in the _irq_handler()
but maybe it will become less manageable in later patches.

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
>  static irqreturn_t adxl313_irq_handler(int irq, void *p)
>  {
>  	struct iio_dev *indio_dev = p;
> @@ -480,6 +533,15 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
>  	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
>  		return IRQ_NONE;
>  
> +	if (adxl313_push_event(indio_dev, int_stat))
> +		goto err;
> +
> +	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
> +		goto err;
> +
> +	return IRQ_HANDLED;
> +
> +err:
>  	adxl313_fifo_reset(data);

Ah. This is all making a little more sense.  I think partly the issue
here is this got split up into a few too many patches.  FIFO plus
initial interrupt support in one would have been better perhaps.

Jonathan



