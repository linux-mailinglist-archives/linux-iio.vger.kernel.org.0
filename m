Return-Path: <linux-iio+bounces-14336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A061A0FDDF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FD71662C7
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 01:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10243AA1;
	Tue, 14 Jan 2025 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAzPcGzs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF83597C;
	Tue, 14 Jan 2025 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817282; cv=none; b=d/O0YsTLkHAfgkK8wupg0kH3n61tyYEDyvRQ1QZbA9ZMeiBzq2DlwEdgoQkBb4zBnjDJu9wMffZuMvg9QPWyDLVL4vAcTxCQcOto0/ItuV6MaoD7Xs8gef9/JsClkVaJdIMPzbkPD7j8GBqsMehJnb8JWxNM2cejDLxGWFWPOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817282; c=relaxed/simple;
	bh=FtH77cl/rpstL759f+31paGLpCFQsRIA6Dmj5zQOO6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVigpN4oIAkL3opfKjdjKlEDBS94cZNl7cHoHqLh7pm9NcMbhemYgYQkI3+7k76/tOgwtV+TL6RjeM6ht3bPPKP39N+AWmvPiiY6tbeKQM3jcH2J5XX9IVPcz5nDZq5SPs93h4lrBWTip0L5z6sePfHzj356CAOtIWou+3jRDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAzPcGzs; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46b2fe9c6a9so1533171cf.0;
        Mon, 13 Jan 2025 17:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736817280; x=1737422080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmPOCH5hfbM75Lbyesisu8SSSCuyPooO0XAn15pw3Cs=;
        b=EAzPcGzseS4L21G13lMI/eyth5t3UlgfZdjxtMDni+DRGiM4bbnvW/s3RTU2tpsuw3
         GSkae1xY+pTnYvDfzu1L1rm7jRqyY86OqUXkwkr1+/02fuJj/sLGK3sdAOeCMgp5mbUj
         q543Aq/4Kef0626geV51oNaDlASiOGBdDLIV1UGbkouTHd0EPj0AAwzty+uwQc26Puf/
         L3WviuyZ3y7vxLeSg/jZp3bCx+wwfdGP688DX+0GKo45fOq+PDYd6rZ3z7mNRdanF28/
         d5UMOxjvxBU2sxRTOiKovZuCFNiyhk3CuuMgtAoHvaAjGtNu/zyBWz0xRfMc8d9gAIrv
         ZqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736817280; x=1737422080;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmPOCH5hfbM75Lbyesisu8SSSCuyPooO0XAn15pw3Cs=;
        b=Os8ywbaptpfCvGf6oKYUWvJ2U4sCeZrzpFgmXXY64eYoqoqrNU/VEaY/RyEBqNrgMT
         liVEIWe8iL8Uk8HZgiVoZ8M+3+rDZhrI6aiWgrsFdX80HMIC8/t07HnK1hPYX8MtMWkC
         qG3SPejFxmZ1nFBJ23et8GmS7y3NLfScAQGdSzqp/iW05Rq6+7YWXg29f6k2bIgdxowf
         rEBp1LGdvMXMhG27l2QpUBjTVQEP/9wgh1nMmDXOIoZroXdsYfxbHnL+UokYnDG+n1Ie
         HR7UqxOQPXb0pPxkF2hEKZ5cJg0jzc4r0LeQNiMiBJ4M5lh4vJrrq2tqreIm0zM4OtPB
         MVfg==
X-Forwarded-Encrypted: i=1; AJvYcCVRxvhUE3QkjTTByMk94EJEWak623ZEhDLIziMczpxOKmv6Z4/8uoW/4kPzYsqSFoJ1jR01lNcR8KN+@vger.kernel.org, AJvYcCVjuefiRXspjhvULnaUGtzCOF/9qv9M9PvN6U0FbXRKqGEKlqe/M0gtuEzpdYz5Fkqp1ufyeemJH7uog2ln@vger.kernel.org, AJvYcCX0QnAK758eWsKrwEWvOBz99ovmMzaMfBywcQx8ZO65npGWqAdQ0jT6IFIebySB3/nPDIpXbxATOn0x@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOO+U2oR1tTWVoEKHmOPb4+AK8QN230krKVeMHsajN8/rOQGD
	JEgGaaAI8gznNII74LoYpyIm86fEyejZZaYMVupQ/+QgRzv3mawa
X-Gm-Gg: ASbGnctD30KSZtcc6B87Ji7iidCL96DX70ZEFJB0eFVmEeRFpK3BKlQy3hXjU8TvOWP
	1efMBSOLl3LEGcQHpwaBXWrQLWYCqSGENSqwlLx6GAra2NqeOsYV+5a+K7KMCWY6LcOqGymn4tF
	jnTBJvBrDPBr5Y2QdRixbYjP3n7L+BcyCmoCwjRlXAiA/hw42XMMaAUouGfOQ4cDb7MawqEKMtr
	JajBTeKbyoCFHlBvCrNFZOuGY7TxdDaDY9s9EhGY9vCo/B8lKVZ235XkCtGdynzFN5lZTkAazuZ
	EA==
X-Google-Smtp-Source: AGHT+IFyWWcpJojau7VOfXFCaLT6bnYbAfSToV3/g69UG2mIawbwSV6jPmXR4rJ7tyAtwFzgH0luZg==
X-Received: by 2002:a05:622a:1a9a:b0:467:5fd2:9963 with SMTP id d75a77b69052e-46c71003a8cmr17932831cf.6.1736817279636;
        Mon, 13 Jan 2025 17:14:39 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8732f7d1sm47279421cf.17.2025.01.13.17.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 17:14:38 -0800 (PST)
Date: Mon, 13 Jan 2025 22:14:33 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 09/15] iio: adc: ad7768-1: Move buffer allocation to a
 separate function
Message-ID: <Z4W6eVn1+HMqISxK@JSANTO12-L01.ad.analog.com>
Reply-To: 20250112124056.4c933181@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <319a685855eb4b942e05e456a37319d3f73f7cd4.1736201898.git.Jonathan.Santos@analog.com>
 <20250112124056.4c933181@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112124056.4c933181@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 12:26:05 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > This change moves the buffer allocation in a separate function, making
> > space for adding another type of iio buffer if needed.
> > 
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 64 ++++++++++++++++++++++----------------
> >  1 file changed, 37 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index cd1b08053105..eaa9a12737ac 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -163,6 +163,7 @@ struct ad7768_state {
> >  	struct iio_trigger *trig;
> >  	struct gpio_desc *gpio_sync_in;
> >  	struct gpio_desc *gpio_reset;
> > +	int irq;
> >  	const char *labels[ARRAY_SIZE(ad7768_channels)];
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> > @@ -569,6 +570,40 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
> >  	return 0;
> >  }
> >  
> > +static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
> > +{
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
> > +					  indio_dev->name,
> > +					  iio_device_id(indio_dev));
> > +	if (!st->trig)
> > +		return -ENOMEM;
> > +
> > +	st->trig->ops = &ad7768_trigger_ops;
> > +	iio_trigger_set_drvdata(st->trig, indio_dev);
> > +	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->trig = iio_trigger_get(st->trig);
> > +
> > +	init_completion(&st->completion);
> > +
> > +	ret = devm_request_irq(indio_dev->dev.parent, st->irq,
> > +			       &ad7768_interrupt,
> > +			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > +			       indio_dev->name, indio_dev);
> > +	if (ret)
> 
> As with the completion, the interrupt is not just for triggered buffer use
> either, so probably doesn't belong in this function.  Again, not
> a bug to do so, but hurts readability a little.
> 

OK, i see it now. I will make the modifcations.

> > +		return ret;
> > +
> > +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> > +					       &iio_pollfunc_store_time,
> > +					       &ad7768_trigger_handler,
> > +					       &ad7768_buffer_ops);
> > +}
> > +
> >  static int ad7768_probe(struct spi_device *spi)
> >  {
> >  	struct ad7768_state *st;
> > @@ -610,6 +645,7 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return PTR_ERR(st->mclk);
> >  
> >  	st->mclk_freq = clk_get_rate(st->mclk);
> > +	st->irq = spi->irq;
> >  
> >  	mutex_init(&st->lock);
> >  
> > @@ -625,37 +661,11 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return ret;
> >  	}
> >  
> > -	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > -					  indio_dev->name,
> > -					  iio_device_id(indio_dev));
> > -	if (!st->trig)
> > -		return -ENOMEM;
> > -
> > -	st->trig->ops = &ad7768_trigger_ops;
> > -	iio_trigger_set_drvdata(st->trig, indio_dev);
> > -	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> > -	if (ret)
> > -		return ret;
> > -
> > -	indio_dev->trig = iio_trigger_get(st->trig);
> > -
> > -	init_completion(&st->completion);
> > -
> >  	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = devm_request_irq(&spi->dev, spi->irq,
> > -			       &ad7768_interrupt,
> > -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > -			       indio_dev->name, indio_dev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > -					      &iio_pollfunc_store_time,
> > -					      &ad7768_trigger_handler,
> > -					      &ad7768_buffer_ops);
> > +	ret = ad7768_triggered_buffer_alloc(indio_dev);
> >  	if (ret)
> >  		return ret;
> >  
> 

