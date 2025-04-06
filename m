Return-Path: <linux-iio+bounces-17685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC5A7CF0F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE26188A112
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D615746E;
	Sun,  6 Apr 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eufMYO9C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E7A29
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743958974; cv=none; b=W97OafYkB1CttV9yOV368BVW8bqfJ/itKDQRHsUTyeTmNDPUuNn7SrIqvKH3ZzkS1rZMVFmWfi/sXaJJzGuocQlWtCG8ofSp1LA1mOo+6qV9JqKsj/aS/gKHgMd2twXFtsQY02peUhPUoO9iAwfoZI04rlcpXQ/UF2LLCsUha4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743958974; c=relaxed/simple;
	bh=RLHrayU6KSL8XyZEBRequkcP7jk+GTsFOwzbiW0LMeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0po7QTs1jRzXFDjYlmz6ql2IJP5MSpObASRJDrd8j3h70Tpk6PzI7R3caQE16cX+or2c0Vo22JmsHIoz2u42vAtd6e325zRH9xd10YFG03SLDZs9ZfxPDKa/NZZ9u3Sin0rrxjhpVAi95zmPeuxPdkKzFtxN53QHlAcjCd1/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eufMYO9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D5CC4CEE3;
	Sun,  6 Apr 2025 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743958973;
	bh=RLHrayU6KSL8XyZEBRequkcP7jk+GTsFOwzbiW0LMeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eufMYO9CS1HErs4H5tr0nu+xa4f2rCl427ZCMz3agN6458HW/OppDPJj+oRtULZak
	 L9oPYXPRRsjE3vFtUgjHM4mgkQQnXYn3cX33YYceCck/uB4Awta15CHfiQnO9sEe+5
	 BxSJsZMm3/qRTr+noI1/JX/Mq4irglqF3B27Y67EOWJAVrMWpO34wQvjP5yuVNdUPL
	 Ije3TCvxHpcjQjhZDmcyWYBYmRNXwABZUxrq+cTxyLmXCPLL6o1J2NPB2VM+FUKkwW
	 Xns/7Mx7yQEAXSMssvLl9dQzi5yaAsx3s14o1on7j7VwIIfXiOXMVt12t1XsIWGtMY
	 SbXJlWzYC3K8A==
Date: Sun, 6 Apr 2025 18:02:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 05/16] iio: adc: Use iio_push_to_buffers_with_ts() to
 provide length for runtime checks.
Message-ID: <20250406180246.108a58a5@jic23-huawei>
In-Reply-To: <b282990a-de51-4120-abde-9b628847d9f9@baylibre.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
	<20250309182100.1351128-6-jic23@kernel.org>
	<b282990a-de51-4120-abde-9b628847d9f9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 16:49:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/9/25 1:20 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This new function allows us to perform debug checks in the helper to ensure
> > that the overrun does not occur.  Use it in all the simple cases where
> > either a static buffer or a structure is used in the drivers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> ...
> 
> > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > index 9a020680885d..77c5dd414d36 100644
> > --- a/drivers/iio/adc/ad4030.c
> > +++ b/drivers/iio/adc/ad4030.c
> > @@ -706,8 +706,9 @@ static irqreturn_t ad4030_trigger_handler(int irq, void *p)
> >  	if (ret)
> >  		goto out;
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_data.raw,
> > -					   pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, st->rx_data.raw,  
> 
> Would &st->rx_data be more correct? I guess it doesn't really matter in this case.
Feels slightly more logical to use rx_data so changed.

> 
> > +				    sizeof(st->rx_data.raw),
> > +				    pf->timestamp);
> >  
> >  out:
> >  	iio_trigger_notify_done(indio_dev->trig);  
> 
> ...
> 
> > diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> > index 18559757f908..4217d3963455 100644
> > --- a/drivers/iio/adc/ad7266.c
> > +++ b/drivers/iio/adc/ad7266.c
> > @@ -87,8 +87,9 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
> >  
> >  	ret = spi_read(st->spi, st->data.sample, 4);
> >  	if (ret == 0) {
> > -		iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
> > -			    pf->timestamp);
> > +		iio_push_to_buffers_with_ts(indio_dev, &st->data,
> > +					    sizeof(st->data),  
> 
> This one has `s64 timestamp;` which should be aligned_s64.
Ah. That's an old bug!  Guess no one rand this on x86_32 :)

I'll add a precursor fix.
Note I didn't include some other drivers in this series because they are
also broken, but I missed this one. Good spot.
> 
> > +					    pf->timestamp);
> >  	}
> >  
> >  	iio_trigger_notify_done(indio_dev->trig);
> > diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> > index 28b88092b4aa..def5f91dc343 100644
> > --- a/drivers/iio/adc/ad7298.c
> > +++ b/drivers/iio/adc/ad7298.c
> > @@ -155,8 +155,9 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
> >  	if (b_sent)
> >  		goto done;
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> > -		iio_get_time_ns(indio_dev));
> > +	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf,  
> 
> Does this one actually have enough room in rx_buf for 9 16-bit channels and a
> an aligned timestamp?

Only 8 channels have scan_index != -1 so this is fine I think.
-1 is magic for don't allow this one to be used in buffered mode.

> 
> __be16	rx_buf[12] __aligned(IIO_DMA_MINALIGN);
> 
> 
> > +				    sizeof(st->rx_buf),
> > +				    iio_get_time_ns(indio_dev));
> >  
> >  done:
> >  	iio_trigger_notify_done(indio_dev->trig);  
> 
> ...
> 
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index 631e83717167..3ffa11b2e060 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -679,8 +679,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
> >  	if (ret)
> >  		goto error_ret;
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
> > -					   iio_get_time_ns(indio_dev));
> > +	iio_push_to_buffers_with_ts(indio_dev, &st->data, sizeof(st->data),  
> 
> This one might need ALIGNED in the buffer declarations. I'm working on this
> driver though, so can fix it up.
Corner case.  It's actually fine because IIO_DMA_MINALIGN is >= 8 but
that's not obvious and may not remain true for all future architectures so
indeed good to tidy that up at somepoint with the additional markings.

> 
> > +				    iio_get_time_ns(indio_dev));
> >  error_ret:
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  	/* The rising edge of the CONVST signal starts a new conversion. */
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 5a863005aca6..4eb586d473ce 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -474,8 +474,9 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
> >  	if (ret < 0)
> >  		goto out;
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
> > -					   iio_get_time_ns(indio_dev));
> > +	iio_push_to_buffers_with_ts(indio_dev, &st->data.scan,
> > +				    sizeof(st->data.scan),  
> 
> This one could use aligned_s64 on the timestamp.
Definitely. Another bug I'll put a separate fix in for this.

> 
> > +				    iio_get_time_ns(indio_dev));
> >  
> >  out:
> >  	iio_trigger_notify_done(indio_dev->trig);  
> 
> ...
> 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 87945efb940b..0369151c7db1 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -207,8 +207,8 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
> >  	if (b_sent)
> >  		goto done;
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> > -					   iio_get_time_ns(indio_dev));
> > +	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf, sizeof(st->rx_buf),  
> 
> This one is similar to ad7298 but doesn't have a temperature channel, so
> probably OK. Still could use ALIGNED in the buffer declaration to make it more
> obvious that we have a timestamp.

Also relies on IIO_DMA_MINALIGN >= 8
It's a bit messy to force alignment twice so I'll leave this for now.

> 
> > +				    iio_get_time_ns(indio_dev));
> >  
> >  done:
> >  	iio_trigger_notify_done(indio_dev->trig);
> > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> > index a1e48a756a7b..5ffb4b5f5c99 100644
> > --- a/drivers/iio/adc/dln2-adc.c
> > +++ b/drivers/iio/adc/dln2-adc.c
> > @@ -488,8 +488,8 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
> >  		       (void *)dev_data.values + t->from, t->length);
> >  	}
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data,
> > -					   iio_get_time_ns(indio_dev));
> > +	iio_push_to_buffers_with_ts(indio_dev, &data, sizeof(data),  
> 
> Could use aligned_s64 on timestamp_space.

This one is more subtle as the structure is big enough but the overall
structure might be misaligned. I'll add a patch fixing it but not sure
it is suitable for a backport.

> 
> > +				    iio_get_time_ns(indio_dev));
> >  
> >  done:
> >  	iio_trigger_notify_done(indio_dev->trig);  
> 
> ...
> 
> > diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> > index 8f1e6acea53b..92baf3f5f560 100644
> > --- a/drivers/iio/adc/mxs-lradc-adc.c
> > +++ b/drivers/iio/adc/mxs-lradc-adc.c
> > @@ -425,7 +425,8 @@ static irqreturn_t mxs_lradc_adc_trigger_handler(int irq, void *p)
> >  		j++;
> >  	}
> >  
> > -	iio_push_to_buffers_with_timestamp(iio, adc->buffer, pf->timestamp);
> > +	iio_push_to_buffers_with_ts(iio, adc->buffer, sizeof(adc->buffer),  
> 
> u32			buffer[10] __aligned(8);
> 
> Technically OK, but could use ALIGN. There are some other drivers like this
> but I won't call all of them out since they should be OK.

You mean to calculate the number of entrees in the array?

Jonathan

> 
> > +				    pf->timestamp);
> >  
> >  	iio_trigger_notify_done(iio->trig);
> >    
> 
> ...
> 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index 5dbf5f136768..32e7938b3892 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -1858,8 +1858,8 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
> >  
> >  	/* reset buffer index */
> >  	adc->bufi = 0;
> > -	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> > -					   pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, adc->buffer, sizeof(adc->buffer),  
> 
> u16			buffer[STM32_ADC_MAX_SQ + 4] __aligned(8);
> 
> Could use ALIGN for timestamp instead of assuming STM32_ADC_MAX_SQ * 2 is the
> correct alignment. There are also a few more drivers like this that depend on
> a macro being even or multiple of 4 to get the correct alignment, which seems
> like it could be fragile, e.g. if a temperature channel was added.
> 
> > +				    pf->timestamp);
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  
> >  	/* re-enable eoc irq */  
> 
> ...
> 
> 


