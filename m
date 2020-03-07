Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345BE17D022
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCGVDD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 16:03:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45765 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgCGVDD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 16:03:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2902862pfg.12;
        Sat, 07 Mar 2020 13:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dUdKs486Qf2sNPUmggGQF9hkh/az1B9/gX/zjLCHfE=;
        b=u/fYFypze6McXtHJzbV9f6SiPwk5OuT1dAEvq2UXtd6LTM7SgZdyz46JG+pQXi01Mv
         dFq8ZBMNLKhLdTve2T45wjZb+fgMIVxXZwWm02IC/ogLlOwKiGh2pM2ppatoWjZ/GYzn
         h4bzsat7WOcAvlBkI5PYBnuOss13GiM6Fj78WipsxpWg9hPzuKq2QQ6m2dXxLky6eg9+
         LvcXO3ntdPTDW27snZrrPh2s5rrsaR+026VbplOSWd4vhY2x2jD6Rkcxo+nZfcpbEChC
         Uo+Jd6GAcMwcdt1Iw3erDlsVKJ3f01OHlR7A11f2r1/6LfQxsWTosWIwQXspMVR6YjyX
         yRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dUdKs486Qf2sNPUmggGQF9hkh/az1B9/gX/zjLCHfE=;
        b=tMOB5BlQJk31YByso/xcLDjeBKVsf5llKbyYDYSf99uckRr8KCFMfEE4o8ZjLCrcuj
         Kbik2HJ5TMksuKTWDlA6klccimI/G95paYNuGdz42CLLzL4HKKgLVbbedfvbf6udWwIH
         2W5CHFaQ3I+Ah5lz0Y/w7qqqJJZJDCmR3vQyvn0R+ZW79OQHW5kZdZPVkf8rSGfnpxkC
         iKnyjN/fgKpQXMCPqdivdghaVtEj8wwg36a5wBdWCDNter0XIY0Bgrxw4iyQPcfOOIek
         UgtLKvt7fJgqL0BeK4UQJb5PkaaAJSchh0w1xWr8wbxeSnPRsBf1tdAosdW6Aerobqx3
         zUHQ==
X-Gm-Message-State: ANhLgQ0B/ve+4CBdxt/okHvrNub1p3+Qk/wsgejpepLkhrXMtXCtS2u5
        c262mTY5zvBFDKoTGmCQkrE=
X-Google-Smtp-Source: ADFU+vuDAIugF+nu1N5hw3f9J43H6ybj5hMWrUQXj/Jm25hpsK3juvORKw8Z/MD73jQcZqvhzqLYfw==
X-Received: by 2002:a65:404d:: with SMTP id h13mr9191507pgp.156.1583614981676;
        Sat, 07 Mar 2020 13:03:01 -0800 (PST)
Received: from SARKAR ([43.224.157.39])
        by smtp.gmail.com with ESMTPSA id a9sm39479931pfo.35.2020.03.07.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 13:03:01 -0800 (PST)
Message-ID: <5e640c05.1c69fb81.4dd6f.a3c8@mx.google.com>
X-Google-Original-Message-ID: <20200307210256.GC12716@rohitsarkar5398@gmail.com>
Date:   Sun, 8 Mar 2020 02:32:56 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.ardelean@analog.com, dragos.bogdan@analog.com
Subject: Re: [PATCH v4] iio: adc: max1363: replace uses of mlock
References: <5e6355a8.1c69fb81.36f2c.ab37@mx.google.com>
 <20200307141946.79661dd0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307141946.79661dd0@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 07, 2020 at 02:19:46PM +0000, Jonathan Cameron wrote:
> On Sat, 7 Mar 2020 13:34:51 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > Replace usage indio_dev's mlock with either local lock or
> > iio_device_claim_direct_mode.
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> 
> There is a subtlety in here (which is why this one never
> got cleaned up before).  We need to protect against:
> 
> 1) Driver state being accessed from multiple places concurrently.
>    That will use your new lock.
> 2) Doing actions that cannot occur if in buffered mode.  The
>    claim_direct_mode stuff is for that.
I did consider using both, the local driver lock and the claim_direct in
some places, however I noticed that the claim_direct_mode internally uses
the mlock, hence I didnt think it was necessary to set the local lock as
well, as according to my understanding once a process acquires the mlock
no other process can run the critical section before the initial process
releases the mlock. Thus the driver state also remains consistent.

> 3) Prevent us enabling monitor mode when in buffered mode, or
>    buffered mode when in monitor mode (because it's really
>    fiddly to support both given the odd way this hardware
>    works and I never bothered).  That requires making sure
>    direct mode is claimed before trying to enable the monitor
>    mode and also that we don't enable buffered mode. Now interestingly
>    there doesn't actually seem to be anything stopping buffered mode
>    if monitor mode is on.  Probably a bug, but I'd be nervous about
>    fixing that without test hardware.
> 
> Ignoring that last subtle bit, we sometimes for 1 and 2 need to take
> both locks.  We can't be in buffered mode and we need to edit
> local state.
> 
> Jonathan
> 
> > ---
> 
> That's better :)  I should have looked at v4 before v3 I guess.
> 
Forgot to add the changelog in v3 :) . Should have mentioned that
explicitly, my bad!
> > Changelog v3 -> v4
> > * Fix indentation
> > 
> > Changelog v2 -> v3
> > * use iio_device_claim_direct when switching modes
> > * replace mlock usage in max1363_write_event_config
> > 
> > Changelog v1 -> v2
> > * Fix indentation
> > 
> >  drivers/iio/adc/max1363.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> > index 5c2cc61b666e..a1550c0b4c0a 100644
> > --- a/drivers/iio/adc/max1363.c
> > +++ b/drivers/iio/adc/max1363.c
> > @@ -150,6 +150,7 @@ struct max1363_chip_info {
> >   * @current_mode:	the scan mode of this chip
> >   * @requestedmask:	a valid requested set of channels
> >   * @reg:		supply regulator
> > + * @lock		lock to ensure state is consistent
> >   * @monitor_on:		whether monitor mode is enabled
> >   * @monitor_speed:	parameter corresponding to device monitor speed setting
> >   * @mask_high:		bitmask for enabled high thresholds
> > @@ -169,6 +170,7 @@ struct max1363_state {
> >  	const struct max1363_mode	*current_mode;
> >  	u32				requestedmask;
> >  	struct regulator		*reg;
> > +	struct mutex			lock;
> >  
> >  	/* Using monitor modes and buffer at the same time is
> >  	   currently not supported */
> > @@ -364,7 +366,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> >  	struct max1363_state *st = iio_priv(indio_dev);
> >  	struct i2c_client *client = st->client;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> 
> So this protects against change of state from polled to buffered mode.
> Great.  However, we also use state in here which should be protected
> by the local lock.  The solution is to take that local lock as well.
> 
> > +	if (ret < 0)
> > +		goto error_ret;
> >  	/*
> >  	 * If monitor mode is enabled, the method for reading a single
> >  	 * channel will have to be rather different and has not yet
> > @@ -372,7 +376,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> >  	 *
> >  	 * Also, cannot read directly if buffered capture enabled.
> >  	 */
> > -	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
> > +	if (st->monitor_on) {
> >  		ret = -EBUSY;
> >  		goto error_ret;
> >  	}
> > @@ -404,8 +408,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
> >  		data = rxbuf[0];
> >  	}
> >  	*val = data;
> > +
> >  error_ret:
> > -	mutex_unlock(&indio_dev->mlock);
> > +	iio_device_release_direct_mode(indio_dev);
> >  	return ret;
> >  
> >  }
> > @@ -705,9 +710,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
> >  	if (!found)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	st->monitor_speed = i;
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  
> >  	return 0;
> >  }
> > @@ -810,12 +815,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
> >  	int val;
> >  	int number = chan->channel;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	mutex_lock(&st->lock);
> >  	if (dir == IIO_EV_DIR_FALLING)
> >  		val = (1 << number) & st->mask_low;
> >  	else
> >  		val = (1 << number) & st->mask_high;
> > -	mutex_unlock(&indio_dev->mlock);
> > +	mutex_unlock(&st->lock);
> >  
> >  	return val;
> >  }
> > @@ -962,7 +967,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
> >  	u16 unifiedmask;
> >  	int number = chan->channel;
> >  
> > -	mutex_lock(&indio_dev->mlock);
> > +	iio_device_claim_direct_mode(indio_dev);
> 
> So the question is whether we are stopping this changing because
> we are in buffered mode or because it's local state...
> 
> >  	unifiedmask = st->mask_low | st->mask_high;
> >  	if (dir == IIO_EV_DIR_FALLING) {
> >  
> > @@ -989,7 +994,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
> >  
> >  	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
> >  error_ret:
> > -	mutex_unlock(&indio_dev->mlock);
> > +	iio_device_release_direct_mode(indio_dev);
> >  
> >  	return ret;
> >  }
> > @@ -1587,6 +1592,7 @@ static int max1363_probe(struct i2c_client *client,
> >  
> >  	st = iio_priv(indio_dev);
> >  
> > +	mutex_init(&st->lock);
> >  	st->reg = devm_regulator_get(&client->dev, "vcc");
> >  	if (IS_ERR(st->reg)) {
> >  		ret = PTR_ERR(st->reg);
> 
