Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5F17D4A5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 17:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCHQOf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 12:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgCHQOf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Mar 2020 12:14:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9526A20866;
        Sun,  8 Mar 2020 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583684074;
        bh=oDnDXOHrzJPCTRj8HMe9/xXDgwWbCQV7+UR3qAzBCeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L8GIS/fK3roA7dzXiPjv66A0tSIBr4WN98jvFrwZrXOMsc/m/H/KgQSJIDVh5+BC5
         uNfkpWqmCkaqMk2g/+ZoG4szOh/igBSKy2TX0vsVaozu1pi/I/WB8f9n105jQDuBF1
         JDoxzwfFK72Nx0ijbh5QriWTFi0GzVw0EZCah8z8=
Date:   Sun, 8 Mar 2020 16:14:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.ardelean@analog.com, dragos.bogdan@analog.com
Subject: Re: [PATCH v4] iio: adc: max1363: replace uses of mlock
Message-ID: <20200308161426.716d1ffb@archlinux>
In-Reply-To: <5e640c05.1c69fb81.4dd6f.a3c8@mx.google.com>
References: <5e6355a8.1c69fb81.36f2c.ab37@mx.google.com>
        <20200307141946.79661dd0@archlinux>
        <5e640c05.1c69fb81.4dd6f.a3c8@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Mar 2020 02:32:56 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> On Sat, Mar 07, 2020 at 02:19:46PM +0000, Jonathan Cameron wrote:
> > On Sat, 7 Mar 2020 13:34:51 +0530
> > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> >   
> > > Replace usage indio_dev's mlock with either local lock or
> > > iio_device_claim_direct_mode.
> > > 
> > > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>  
> > 
> > There is a subtlety in here (which is why this one never
> > got cleaned up before).  We need to protect against:
> > 
> > 1) Driver state being accessed from multiple places concurrently.
> >    That will use your new lock.
> > 2) Doing actions that cannot occur if in buffered mode.  The
> >    claim_direct_mode stuff is for that.  
> I did consider using both, the local driver lock and the claim_direct in
> some places, however I noticed that the claim_direct_mode internally uses
> the mlock, hence I didnt think it was necessary to set the local lock as
> well, as according to my understanding once a process acquires the mlock
> no other process can run the critical section before the initial process
> releases the mlock. Thus the driver state also remains consistent.

Any state changes in the driver done under the local lock can still happen.
There is also a question of 'obviousness'.  The driver code should not
'care' what the internals of claim_direct_mode is doing.
That can be expected to protect against moving out of direct mode, but
not anything about 'how'.

Hence, take them both.

> 
> > 3) Prevent us enabling monitor mode when in buffered mode, or
> >    buffered mode when in monitor mode (because it's really
> >    fiddly to support both given the odd way this hardware
> >    works and I never bothered).  That requires making sure
> >    direct mode is claimed before trying to enable the monitor
> >    mode and also that we don't enable buffered mode. Now interestingly
> >    there doesn't actually seem to be anything stopping buffered mode
> >    if monitor mode is on.  Probably a bug, but I'd be nervous about
> >    fixing that without test hardware.
> > 
> > Ignoring that last subtle bit, we sometimes for 1 and 2 need to take
> > both locks.  We can't be in buffered mode and we need to edit
> > local state.
> > 
> > Jonathan
> >   
> > > ---  
> > 
> > That's better :)  I should have looked at v4 before v3 I guess.
> >   
> Forgot to add the changelog in v3 :) . Should have mentioned that
> explicitly, my bad!
> > > Changelog v3 -> v4
> > > * Fix indentation
> > > 
> > > Changelog v2 -> v3
> > > * use iio_device_claim_direct when switching modes
> > > * replace mlock usage in max1363_write_event_config
> > > 
> > > Changelog v1 -> v2
> > > * Fix indentation
> > > 
> > >  drivers/iio/adc/max1363.c | 24 +++++++++++++++---------
> > >  1 file changed, 15 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> > > index 5c2cc61b666e..a1550c0b4c0a 100644
> > > --- a/drivers/iio/adc/max1363.c
> > > +++ b/drivers/iio/adc/max1363.c
> > > @@ -150,6 +150,7 @@ struct max1363_chip_info {
> > >   * @current_mode:	the scan mode of this chip
> > >   * @requestedmask:	a valid requested set of channels
> > >   * @reg:		supply regulator
> > > + * @lock		lock to ensure state is consistent
> > >   * @monitor_on:		whether monitor mode is enabled
> > >   * @monitor_speed:	parameter corresponding to device monitor speed setting
> > >   * @mask_high:		bitmask for enabled high thresholds
> > > @@ -169,6 +170,7 @@ struct max1363_state {
> > >  	const struct max1363_mode	*current_mode;
> > >  	u32				requestedmask;
> > >  	struct regulator		*reg;
> > > +	struct mutex			lock;
> > >  
> > >  	/* Using monitor modes and buffer at the same time is
> > >  	   currently not supported */
> > > @@ -364,7 +366,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> > >  	struct max1363_state *st = iio_priv(indio_dev);
> > >  	struct i2c_client *client = st->client;
> > >  
> > > -	mutex_lock(&indio_dev->mlock);
> > > +	ret = iio_device_claim_direct_mode(indio_dev);  
> > 
> > So this protects against change of state from polled to buffered mode.
> > Great.  However, we also use state in here which should be protected
> > by the local lock.  The solution is to take that local lock as well.
> >   
> > > +	if (ret < 0)
> > > +		goto error_ret;
> > >  	/*
> > >  	 * If monitor mode is enabled, the method for reading a single
> > >  	 * channel will have to be rather different and has not yet
> > > @@ -372,7 +376,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> > >  	 *
> > >  	 * Also, cannot read directly if buffered capture enabled.
> > >  	 */
> > > -	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
> > > +	if (st->monitor_on) {
> > >  		ret = -EBUSY;
> > >  		goto error_ret;
> > >  	}
> > > @@ -404,8 +408,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> > >  		data = rxbuf[0];
> > >  	}
> > >  	*val = data;
> > > +
> > >  error_ret:
> > > -	mutex_unlock(&indio_dev->mlock);
> > > +	iio_device_release_direct_mode(indio_dev);
> > >  	return ret;
> > >  
> > >  }
> > > @@ -705,9 +710,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
> > >  	if (!found)
> > >  		return -EINVAL;
> > >  
> > > -	mutex_lock(&indio_dev->mlock);
> > > +	mutex_lock(&st->lock);
> > >  	st->monitor_speed = i;
> > > -	mutex_unlock(&indio_dev->mlock);
> > > +	mutex_unlock(&st->lock);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -810,12 +815,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
> > >  	int val;
> > >  	int number = chan->channel;
> > >  
> > > -	mutex_lock(&indio_dev->mlock);
> > > +	mutex_lock(&st->lock);
> > >  	if (dir == IIO_EV_DIR_FALLING)
> > >  		val = (1 << number) & st->mask_low;
> > >  	else
> > >  		val = (1 << number) & st->mask_high;
> > > -	mutex_unlock(&indio_dev->mlock);
> > > +	mutex_unlock(&st->lock);
> > >  
> > >  	return val;
> > >  }
> > > @@ -962,7 +967,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
> > >  	u16 unifiedmask;
> > >  	int number = chan->channel;
> > >  
> > > -	mutex_lock(&indio_dev->mlock);
> > > +	iio_device_claim_direct_mode(indio_dev);  
> > 
> > So the question is whether we are stopping this changing because
> > we are in buffered mode or because it's local state...
> >   
> > >  	unifiedmask = st->mask_low | st->mask_high;
> > >  	if (dir == IIO_EV_DIR_FALLING) {
> > >  
> > > @@ -989,7 +994,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
> > >  
> > >  	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
> > >  error_ret:
> > > -	mutex_unlock(&indio_dev->mlock);
> > > +	iio_device_release_direct_mode(indio_dev);
> > >  
> > >  	return ret;
> > >  }
> > > @@ -1587,6 +1592,7 @@ static int max1363_probe(struct i2c_client *client,
> > >  
> > >  	st = iio_priv(indio_dev);
> > >  
> > > +	mutex_init(&st->lock);
> > >  	st->reg = devm_regulator_get(&client->dev, "vcc");
> > >  	if (IS_ERR(st->reg)) {
> > >  		ret = PTR_ERR(st->reg);  
> >   

