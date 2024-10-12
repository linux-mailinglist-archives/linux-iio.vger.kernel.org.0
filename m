Return-Path: <linux-iio+bounces-10524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48599B60D
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13305B21D6F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095B40BF5;
	Sat, 12 Oct 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHogr1/j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD683E499;
	Sat, 12 Oct 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749543; cv=none; b=dn619kGQ+Lkl4XZRGsTPaVlLMVGKQqHURMPKub99rSkFXQRaUwUmc587E5/wz9aoW3/dnEicStKP0zO/7eymJT5U3I9pv+ISOq96M2d5WusX3cDYH8QRqvKFYAPcaUeJ+rWyGCnCaEIwjEwGvoCMTHcBk+wOI4E9Ez1YatAZkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749543; c=relaxed/simple;
	bh=dA2qb4NLjpGAZhnV0bMqDo+v2YIqLurPG1QfGiRkT9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApgkubawDfipZwkUhszDDudqMFSXv0u5SyP9jY8bBT7elJye0OF6JdjAxiJEt0juU5pKgzuLtilB8CbZYiab8MHYj3bkkM7NFZi0WgPTGV7jVJhXXNKpR0ycWlp9/Hy8kfTzc0t2/Z7r4aYAsr+kwsxiga/8rrOw9s0vup/0EFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHogr1/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E567C4CEC6;
	Sat, 12 Oct 2024 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728749542;
	bh=dA2qb4NLjpGAZhnV0bMqDo+v2YIqLurPG1QfGiRkT9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tHogr1/jHJR6fwiMKSQ6mBRNWD9CesugHp8FR4Mlp/XUNWhaGorUt6Kfsl1rkDIzZ
	 z0h0hqvLotoCeUyhcAFNlsnIIq5Ew3OMtHyhGTM8hZJnYGV52SuLxkPVjDZVkNZ8cR
	 A8vrT/mrnrc25EfcwnnUJkgyT3LQq9+AUjvOvd0VI9fUiGHxSjUhHLAoM4hLGpoeqt
	 VC/CxBbp9ihZOeGlYnsoXJ3yEahdbmdrbS8Jc1wFTyP9h8+87k4wlzGkNWoXo5JptD
	 HgFFFqDU2D0EpvNGVuAsx0JqgYfRG1y8dft2fgwVgp3pVBVVOSHpQM1LBsnGFhPX5H
	 poMIUNZ2bM7Uw==
Date: Sat, 12 Oct 2024 17:12:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andy.shevchenko@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 1/2] iio: light: rpr0521: Use generic
 iio_pollfunc_store_time()
Message-ID: <20241012171217.0e79404f@jic23-huawei>
In-Reply-To: <20240928161017.29fd249c@jic23-huawei>
References: <20240922162041.525896-1-vassilisamir@gmail.com>
	<20240922162041.525896-2-vassilisamir@gmail.com>
	<20240928161017.29fd249c@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 16:10:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 22 Sep 2024 18:20:40 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The custom rpr0521_trigger_consumer_store_time() is registered as trigger
> > handler in the devm_iio_triggered_buffer_setup() function. This function
> > is called from the calling of the iio_trigger_poll() used in the
> > sysfs/hrt triggers and it is not used anywhere else in this driver.  
> It might be any number of other triggers (hardware triggers from other
> drivers for example).
> 
> Other than that I think your reasoning is correct but would ideally
> like some input from someone more familiar with this driver.
> 
> If that isn't forthcoming I'll pick this up in a week or two.
Two weeks gone. No one surfaced and I think this is fine.

Applied.

Jonathan

> 
> Jonathan
> 
> > 
> > The irq handler of the driver is the rpr0521_drdy_irq_handler() which
> > saves the timestamp and then wakes the irq thread. The irq thread is
> > the rpr0521_drdy_irq_thread() function which checks if the irq came
> > from the sensor and wakes up the trigger threaded handler through
> > iio_trigger_poll_nested() or returns IRQ_NONE in case the irq didn't
> > come from this sensor.
> > 
> > This means that in the current driver, you can't reach the
> > rpr0521_trigger_consumer_store_time() when the device's irq is
> > triggered. This means that the extra check of iio_trigger_using_own()
> > is redundant since it will always be false so the general
> > iio_pollfunc_store_time() can be used.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/light/rpr0521.c | 14 +-------------
> >  1 file changed, 1 insertion(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> > index 78c08e0bd077..56f5fbbf79ac 100644
> > --- a/drivers/iio/light/rpr0521.c
> > +++ b/drivers/iio/light/rpr0521.c
> > @@ -438,18 +438,6 @@ static irqreturn_t rpr0521_drdy_irq_thread(int irq, void *private)
> >  	return IRQ_NONE;
> >  }
> >  
> > -static irqreturn_t rpr0521_trigger_consumer_store_time(int irq, void *p)
> > -{
> > -	struct iio_poll_func *pf = p;
> > -	struct iio_dev *indio_dev = pf->indio_dev;
> > -
> > -	/* Other trigger polls store time here. */
> > -	if (!iio_trigger_using_own(indio_dev))
> > -		pf->timestamp = iio_get_time_ns(indio_dev);
> > -
> > -	return IRQ_WAKE_THREAD;
> > -}
> > -
> >  static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
> >  {
> >  	struct iio_poll_func *pf = p;
> > @@ -1016,7 +1004,7 @@ static int rpr0521_probe(struct i2c_client *client)
> >  		/* Trigger consumer setup */
> >  		ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
> >  			indio_dev,
> > -			rpr0521_trigger_consumer_store_time,
> > +			iio_pollfunc_store_time,
> >  			rpr0521_trigger_consumer_handler,
> >  			&rpr0521_buffer_setup_ops);
> >  		if (ret < 0) {  
> 
> 


