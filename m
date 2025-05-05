Return-Path: <linux-iio+bounces-19099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09EFAA943D
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05D67A2893
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3624E4AA;
	Mon,  5 May 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7XN04HQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFD846C;
	Mon,  5 May 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451268; cv=none; b=TONPYBTCaijRHofoedVHsRKxBAm+9PRLChdfufayAR/lzn7tyhLlOQUC+kk4zbr0E5Pw+zOh3wAIpEUkdU8YWa0xud8zPcTfTDWsvStYGvWUd9ypoQ6c3HONHJCbJSnSr+uKL6EHRdH2Mylg3Y5moHD1K7IxnXuP2R5ujbNdb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451268; c=relaxed/simple;
	bh=ZGaIAChcWBsrNYMQPa6bkuXH0JoWvSBNPtU0khdL8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIQfEitECpkYYGv9MYJL4u+wzcqzlheRX0wCLpnx53CnWqyr1E/sj4xSU46NRff60vHMapc8d0mVN5bxfczbtr5TNUHRtKXEb/bww/zByEHYI0YOxUca8YtAhgD6ROY/UvN8eMsiYsE2pvRmmBEfJeb3c/Hu10gBqttemE9dmdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7XN04HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC47C4CEF1;
	Mon,  5 May 2025 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746451267;
	bh=ZGaIAChcWBsrNYMQPa6bkuXH0JoWvSBNPtU0khdL8D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A7XN04HQ3rANmKTX7oQFW2nVpdHn/4KqIZ0NQy+FpQqoLhh9wjk9HtPN2e5Ila1x9
	 YqHnB+94XCl+QnyPnJmRYLSlNB0P+xVy5PgHj3SOEghusbheyW5zctZ2E8mWJVwXPw
	 +Weq+C/tRAiOI3pE5k/N6W25tC5XFzB3VuPDX6hHmSgWSF/J5g2ZueX1UFYFhvgiXq
	 ATdwFthnSYjkoPOhSmoNEc6cMb05691ihg1hCPKmERkXERXZg9HNytAKkB25IMixR4
	 VHMGkkq6vhi1+JwsryNmJTFlGk+jTUvAtNTP8GlVnlre2yZzk8dJgaB1pcm43EW02P
	 deGG5IaTOFJ4Q==
Date: Mon, 5 May 2025 14:21:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: bmi270: add step counter watermark event
Message-ID: <20250505142100.2a182402@jic23-huawei>
In-Reply-To: <yudy5vbwblqzkx34pgekqi3noyctaxo77n2lb6mqidb4veqadm@534j4towopou>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
	<20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
	<20250426144739.31b8bd36@jic23-huawei>
	<yudy5vbwblqzkx34pgekqi3noyctaxo77n2lb6mqidb4veqadm@534j4towopou>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 21:57:21 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> On Sat, Apr 26, 2025 at 02:47:39PM +0100, Jonathan Cameron wrote:
> > On Thu, 24 Apr 2025 21:14:51 -0300
> > Gustavo Silva <gustavograzs@gmail.com> wrote:
> >   
> > > Add support for generating events when the step counter reaches the
> > > configurable watermark.
> > > 
> > > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>  
> > 
> > Main thing in here is I think the event type isn't the right one.
> >  
> 
> Hi Jonathan,
> 
> Thanks for the review.
> I think the answers to your questions in this patch come down to me
> trying to keep this driver consistency with the bmi323 driver, since
> the two devices are very similar.
> However I have no objections to change the event type if you think it
> is appropriate.

Yeah. From the discussion with Lothar, it's clear we have some inconsistency
on these event types :(  Anyhow, I may well be wrong - see below.

> 
> > > @@ -119,6 +128,7 @@ struct bmi270_data {
> > >  	 /* Protect device's private data from concurrent access */
> > >  	struct mutex mutex;
> > >  	int steps_enabled;
> > > +	unsigned int feature_events;  
> > 
> > Why do we need this rather than just checking the register?
> >   
> Not really needed, I just tried to keep it similar to the bmi323 driver.

Generally I'd prefer drives to use regmap caching to get benefits of caching everything
appropriate rather than use their own local caches.


> > > +	return 0;
> > > +}
> > > +
> > >  static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
> > >  {
> > >  	int i;
> > > @@ -539,19 +585,32 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
> > >  {
> > >  	struct iio_dev *indio_dev = private;
> > >  	struct bmi270_data *data = iio_priv(indio_dev);
> > > -	unsigned int status;
> > > +	unsigned int status0, status1;
> > > +	s64 timestamp = iio_get_time_ns(indio_dev);
> > >  	int ret;
> > >  
> > >  	scoped_guard(mutex, &data->mutex) {
> > > +		ret = regmap_read(data->regmap, BMI270_INT_STATUS_0_REG,
> > > +				  &status0);
> > > +		if (ret)
> > > +			return IRQ_NONE;
> > > +
> > >  		ret = regmap_read(data->regmap, BMI270_INT_STATUS_1_REG,
> > > -				  &status);
> > > +				  &status1);
> > >  		if (ret)
> > >  			return IRQ_NONE;
> > >  	}
> > >  
> > > -	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status))
> > > +	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
> > >  		iio_trigger_poll_nested(data->trig);
> > >  
> > > +	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
> > > +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
> > > +							     IIO_NO_MOD,  
> > why use IIO_MOD_EVENT_CODE() if not modified?
> >   
> My bad, I blindly followed what is implemented in the bmi323 driver.
> I'll fix it in v2.

It's not wrong as such, just that we have a more specific macro for this case.
> 
> > > +							     IIO_EV_TYPE_CHANGE,
> > > +							     IIO_EV_DIR_NONE),  
> > As below. This looks like a rising threshold event.
> > 
> > Change tends to be for things like activity detection (walking/standing etc)

I got this wrong.  Forgot about how this ABI was defined until reading it earlier
today for the discussion with Lothar!

> >    
> Using rising threshold event is fine by me, but then shouldn't we
> update the bmi323 driver as well?

If it is an event that occurs every step?  In that case CHANGE is correct.
If it is an event on a particular threshold of steps being passed.  I.e.
1000 steps, then a threshold is appropriate.   Vs every 1000 steps
in which case change is appropriate.  Seems from below comment it is
every N so this is fine as is. 

> 
> > > +			       timestamp);
> > > +
> > >  	return IRQ_HANDLED;
> > >  }
> > >  
> > > @@ -761,10 +820,111 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
> > >  	}
> > >  }
> > >
> > > +
> > > +static const struct iio_event_spec bmi270_step_wtrmrk_event = {
> > > +	.type = IIO_EV_TYPE_CHANGE,  
> > 
> > Change would be a per step event.
> > IIUC this is a rising threshold.
> >  
> Yeah, if the watermark level is configured to N steps, an event is
> generated every time the step counter counts N steps.

This is fine then as change.  My mistake!

Jonathan



> 
> > > +	.dir = IIO_EV_DIR_NONE,
> > > +	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> > > +			       BIT(IIO_EV_INFO_VALUE),
> > > +};  
> > 
> >   


