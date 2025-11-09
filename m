Return-Path: <linux-iio+bounces-26066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00494C43F38
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 14:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC26C188C5E5
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8AB2FB094;
	Sun,  9 Nov 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqnfcmlS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30141C695;
	Sun,  9 Nov 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696243; cv=none; b=oWSIwGHr9BU2H5PKBri31TvkXr3yGAAtTXlLGsJwKJw0oL29LnzMrifEUPGZkHThEY8cUJAB65JAAEUrlw4SI4+0cZ4uH4A/6sw6lZ9PCivNeoXk9daFWYJQ6B7qpWfjrHLk8oVLRqAEK2WJVcH+lY7RJwAZsRWbub5HcNDcyWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696243; c=relaxed/simple;
	bh=cuEucSgyJsPvgO1+0PApeWx27vuWaEEkAYpo2mXy/xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoWiLX5flKwXcdnTwx2TjHfD8LM7lK9K335j30NmYTM7lN9DSx5NhbKgvYm+ozn4hgzedRsOhC9dePq+2mc6q4rRGG1/Kzw04noYTpQ+Ys3gX3LFV8vSJYiVPYwDb34Tz/0W9xIFYdrVsqG3jnU3F99aI852xv1egf5kLU2eGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqnfcmlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6C0C4CEF7;
	Sun,  9 Nov 2025 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762696243;
	bh=cuEucSgyJsPvgO1+0PApeWx27vuWaEEkAYpo2mXy/xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CqnfcmlS4jce+Tk3CwuSGAeaz1SRW71oYW6V/gX1TsYq9tjHjf8KkXIjPSBbh0eDL
	 0jCqExKdkp14iKV2Ioza9ZianctOKuUSpsfXAjTIN7ETrTNPYi/RelwHnWpSVrNFCm
	 SyeZXeW2OVj2se2iLruyLZOcMRyfFOHi/o7ZhUOJ+ATdQqfdH2hlc3oIFUzTxw+LZl
	 EBhMw7/drRGtC9aUsBWfnKTCix8SUFAObMpD/L0YvUtYyVQR4Gbyg9Mp2I/d/ZQzLR
	 A4zjYw5k2v1BtYwU/tUhKg75NF9s7PrzecSQ+MBu4Sv2B+5G7EwG3KMSUPzZNg6CCe
	 Ey4z/HL+JQbmQ==
Date: Sun, 9 Nov 2025 13:50:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ma Ke <make24@iscas.ac.cn>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, error27@gmail.com, andriy.shevchenko@intel.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: Fix error handling in
 viio_trigger_alloc
Message-ID: <20251109135036.4c05833b@jic23-huawei>
In-Reply-To: <74993472-4845-42d5-8b50-8fa8dc5b42fa@suswa.mountain>
References: <20251106082923.32688-1-make24@iscas.ac.cn>
	<74993472-4845-42d5-8b50-8fa8dc5b42fa@suswa.mountain>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 18:16:06 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Thu, Nov 06, 2025 at 04:29:23PM +0800, Ma Ke wrote:
> > ---
> > Changes in v2:
> > - modified the patch, thanks for developer's suggestions.
> > ---
> >  drivers/iio/industrialio-trigger.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index 54416a384232..9f6d30a244d9 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
> >  			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> >  	}
> >  	kfree(trig->name);
> > +	mutex_destroy(&trig->pool_lock);
> >  	kfree(trig);
> >  }
> >  
> > @@ -596,8 +597,9 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
> >  
> >  free_descs:
> >  	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > +	trig->subirq_base = 0;  
> 
> This doesn't work.  Do it before the goto.

This is a bit ugly however we do it. Maybe should just call
device_initialize() to hand over to the reference counted version much later?
Just before return trig seems easiest spot to reason about.

That seems nicer than doing an irq_get_chip() in iio_trig_release() to figure
out if the first part of the if (trig->subirq_base) conditional block should run or not.

Adding a flag to the trig structure just to indicate we got to running
that loop also feels annoying but at least would ensure we could just do
a put_device() in here without the other handling above.

> 
> regards,
> dan carpenter
> 
> >  free_trig:
> > -	kfree(trig);
> > +	put_device(&trig->dev);
> >  	return NULL;
> >  }
> >  
> > -- 
> > 2.17.1  


