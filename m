Return-Path: <linux-iio+bounces-25807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C9C28F1E
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 143424E55E7
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F832343BE;
	Sun,  2 Nov 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5XqsoFA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF3DDC5;
	Sun,  2 Nov 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762086059; cv=none; b=b934NQL3xCGfVkeVUWiu5nSb5l4vQ63poyP6ioln//p++J366l829lSXpIXEWApsTJO/hfTTq4Mgr5Q8Ud76eily/OO7cIwTw+wXfb8UgR/AvKEyWALYEkhbpi/F8ZkYj71XSCOmJgUJVbqkK9sxfDJc8k/wlLI6qtwtfzSy/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762086059; c=relaxed/simple;
	bh=n94bvtqEdAkQcSd7x1g4JYSiEfxC/E+jLAZYwWamxd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCsr2+k7kujlIeOoNBCUSNM7YtxWHAl12tm3MxPDcuR6aLQzqxFw4ZPj2sCQaxvhDWQgfXnUhsd1ft9nWQcLFVzZb50ZAmzGQkwUTP7oxWWKXSVUA19Xqg45rBCD0d9ZDV2D3kNXQO7XKOhGNpfK0F/BZ8gFSntGhTxZfvsYdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5XqsoFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAB0C4CEF7;
	Sun,  2 Nov 2025 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762086058;
	bh=n94bvtqEdAkQcSd7x1g4JYSiEfxC/E+jLAZYwWamxd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P5XqsoFAYffj8SeGHRZO1CDPafXgA9D6jt7QVJrmU3kYsaL0AeoIuWZ7Ahs/32Doy
	 P/LdWOTc9wdgPmxrLxIy34D9EbSH1WWGhFphdQWTrvFu6Y56nBeQodLvBPTlN/QMUk
	 lplaZiTGmb3c48re+U3YlLNwIk2MAqdrSM7ogzPL7hlqHCXdGPjKH+PpicoY328pqR
	 BaNuqXMlC8OEaDw7QcxKKS2YvqisjzGt2XGlJSE2oPjtcAtEf0BjoSFvAIO8+Fx4Qa
	 qO1bCrbK6ymV2p4zNKkkrOdWPyu4AEeIFuJYu+rHgxCWIGws34rsegRTiMlcd6XTss
	 oVbGiWDWVAZwA==
Date: Sun, 2 Nov 2025 12:20:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jagath Jog J
 <jagathjog1996@gmail.com>
Subject: Re: [PATCH 3/6] iio: accel: bma220: add tap detection
Message-ID: <20251102122053.49ee2632@jic23-huawei>
In-Reply-To: <aQW9OnJSrOzn_Sws@lipo.home.arpa>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-3-153424d7ea08@subdimension.ro>
	<20251018181632.76851d4e@jic23-huawei>
	<aQW9OnJSrOzn_Sws@lipo.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Nov 2025 09:56:42 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello Jonathan,
> 
> thank you for the review.
> 
> On Sat, Oct 18, 2025 at 06:16:32PM +0100, Jonathan Cameron wrote:
> > > +			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
> > > +			if (ret)
> > > +				return ret;
> > > +			*val = FIELD_GET(BMA220_TT_DUR_MSK, reg_val);  
> > 
> > This needs to be in second if you are using duration. Is the register really in seconds?  
> 
> this IC has a very small number of bits that configure
> duration/hysteresis/threshold levels. it's between 2 and 6 for each
> of them. in the case of high and low G events the duration is not
> even directly defined as a time interval, but as a count of samples
> that are over a threshold value.

The ABI is in seconds, so you have to deal with scaling wrt to the sampling
frequency at the time.  I know it can be a pain to do, but consistent userspace
is the aim and so we need to match the ABI.

> 
> I was hoping that simply passing along a unitless value between 0 and
> parameter_max would be enough to customize all the event parameters.
> this does mean that the driver makes the assumption that the user is
> familiar with the device datasheet and knows the number of bits every
> parameter has been allocated. should the driver provide a conversion
> table for tt_duration just like for _scale_table and
> _lpf_3dB_freq_Hz_table?

Exactly.

> 
> > > @@ -506,13 +777,36 @@ static irqreturn_t bma220_irq_handler(int
> > > irq, void *private) struct bma220_data *data =
> > > iio_priv(indio_dev); int ret;
> > >  	unsigned int bma220_reg_if1;
> > > +	s64 timestamp = iio_get_time_ns(indio_dev);
> > > +
> > > +	guard(mutex)(&data->lock);
> > >  
> > >  	ret = regmap_read(data->regmap, BMA220_REG_IF1,
> > > &bma220_reg_if1); if (ret)
> > >  		return IRQ_NONE;
> > >  
> > > -	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1))
> > > +	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {  
> > 
> > Is it an either / or case? I.e. we can only have buffered reads with
> > the data ready interrupt or events?   That does happen in some
> > devices but is fairly unusual.  
> 
> the driver got an interrupt, so it checks the source - it's either a
> data ready when the sensor is used to sample the environment or it's
> an event in which case it just sets the event. now that you mention
> it I think I would miss events if both happened before the kernel
> executes the _irq_handler(), so I will rewrite this bit. if you ment
> something else please tell me.

That was exactly what I was getting at.  Given both occur on a particular
sample, it is guaranteed this will sometimes happen.

Jonathan

> 
> best regards,
> peter
> 
> >   
> > >  		iio_trigger_poll_nested(data->trig);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > > +	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
> > > +
> > > +		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)
> > > +			iio_push_event(indio_dev,
> > > +
> > > IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > +
> > > IIO_MOD_X_OR_Y_OR_Z,
> > > +
> > > IIO_EV_TYPE_GESTURE,
> > > +
> > > IIO_EV_DIR_SINGLETAP),
> > > +				       timestamp);
> > > +		else
> > > +			iio_push_event(indio_dev,
> > > +
> > > IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > +
> > > IIO_MOD_X_OR_Y_OR_Z,
> > > +
> > > IIO_EV_TYPE_GESTURE,
> > > +
> > > IIO_EV_DIR_DOUBLETAP),
> > > +				       timestamp);
> > > +	}
> > >  
> > >  	return IRQ_HANDLED;
> > >  }
> > >   
> >   
> 


