Return-Path: <linux-iio+bounces-12614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E309D77BA
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D2282396
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA416C687;
	Sun, 24 Nov 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTY23YY7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED16165EFC;
	Sun, 24 Nov 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475397; cv=none; b=SIWGlToatie+0eAyllIzUb+m9bdPGrGVRXvz5O8uI/N7UkgCPMDuGW5v8ytagrQNc+o+RS9jcml/7OO55wNtjrsXgsbjaoourABjdu9oe3UoYF65rU0MJn5S5iOhCqwHFN5seqigmYYBUxSz8Np3A+NmBhr8OuDbvEaj4aHggJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475397; c=relaxed/simple;
	bh=Wic38XdFni1bEFimAC/2K0akwcrNh2+Sfq/HI2kyQms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twqxF7yevRRIhJ2Y2sGGrAnxXJEy45emAbmzwmiwwpw5yPmJh0w/BcLhMo7iYfiiIgfgk6MageFvy3ZnjeCdTtRkYJYiaTtKb5ErKyIUX0rYVZqsJVAt1wbqLym6cO6G8aBuBsJ+gDD4tkPogmucN/c0L+UOPTRZkJt9By6MjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTY23YY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF75C4CECC;
	Sun, 24 Nov 2024 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732475397;
	bh=Wic38XdFni1bEFimAC/2K0akwcrNh2+Sfq/HI2kyQms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTY23YY7bxvEvd2suBOxEbCZUINKGt7PfLgjz6ExUJ23GsogOCN87FSsgmu7vuSGg
	 g0ulfbHOG0ZWzzjed5EHdYFfU2LCvW9rRrol1SdVf//by1Q1ZqxMH8FTVQjvLddvPh
	 o7AKf20xmchIE922ikgf2Ogc4b81CWl+TuR2GV0GUHX24qdsJjzT7AvtEow8gpcWta
	 1zpfcXhCrKt7XkWPSRqFVXZU0tcA7LQ051R1fPFSboojMz+yZeEBO5m2+pW9KklQam
	 46uG3mNhGQq3+ym5WixVFip0bTCd5QuGpszKk8Q/50U8+PTYQOWCL+ZK9oF9q5nkYg
	 fMDKwEQOPowTw==
Date: Sun, 24 Nov 2024 19:09:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 21/22] iio: accel: adxl345: sync FIFO reading with
 sensor
Message-ID: <20241124190949.373d2ac6@jic23-huawei>
In-Reply-To: <20241117182651.115056-22-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-22-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:50 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Pause the measurement while reading fifo values. Initially an interrupt
> is triggered if watermark of the FIFO is reached, or in case of
> OVERRUN. The sensor stays mute until FIFO is cleared and interrupts are
> read. Situations now can arise when the watermark is configured to a
> lower value. While reading the values, new values arrive such that a
> permanent OVERRUN state of the FIFO is reached, i.e. either the FIFO
> never gets emptied entirely because of permanently new arriving
> measurements. No more interrupts will be issued and the setup results
> in OVERRUN. To avoid such situation, stop measuring while solving an
> OVERRUN condition and generally reading FIFO entries.
Whilst solving overrun it makes sense.  Whilst dealing with a watermark
interrupt not so much.  The whole point of those is to allow capture
of data without missing samples. We should continue to acquire data
during the readback.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 07c336211f..c79f0f5e3b 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -730,6 +730,11 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  
>  	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
>  		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
> +
> +		/* Pause measuring, at low watermarks this would easily brick the
> +		 * sensor in permanent OVERRUN state
> +		 */
> +		adxl345_set_measure_en(st, false);
>  		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
>  			goto err;
>  
> @@ -737,12 +742,15 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
>  			goto err;
>  
>  		iio_trigger_notify_done(indio_dev->trig);
> +		adxl345_set_measure_en(st, true);
>  	}
>  
>  	goto done;
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> +	adxl345_set_measure_en(st, false);
>  	adxl345_empty_fifo(st);
> +	adxl345_set_measure_en(st, true);
>  	return IRQ_NONE;
>  
>  done:


