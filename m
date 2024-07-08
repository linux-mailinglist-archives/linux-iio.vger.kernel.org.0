Return-Path: <linux-iio+bounces-7447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E492A765
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499D0B20C1F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ABE145B37;
	Mon,  8 Jul 2024 16:34:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1927142E92;
	Mon,  8 Jul 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456487; cv=none; b=bYa7xxrJUz4DLj0y5VzhZsVb8GKrw1ePX1lMESWmPq+VAB3IydEl/K0qS3jpQbAVupZIEWdEK/G8+i3ruammq5xkrl2XT4aPCIIjjEg7g4DIAyXpYmRTuIV0PTXGBZfJ9Slx8gbaTL7EbjIkL7bbkU4YvnNyLOcQqt+Fwm4tewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456487; c=relaxed/simple;
	bh=WOiCAdxzw0RtgcrC2C05e61m8QK9MVaRBsyrvY0EiO4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVxxyXDbkQSqqInXYZ7czEz4Gdye8elWIczrQRowv1v4/GzeS7ZneU91ocxl9AZFjkXYQDhzBDcpNHV1tKFhWuQLy/oaWfTh5MliU4KWjdu7KN7V4Pk/oXaeJa7iFqIOqPU/NKoM//1shYaQNbQglKUN/7q25Dqo3su/RVDySjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHqSW5rcSz6JBdB;
	Tue,  9 Jul 2024 00:33:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 110521404F5;
	Tue,  9 Jul 2024 00:34:41 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 17:34:40 +0100
Date: Mon, 8 Jul 2024 17:34:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Matteo Martelli <matteomartelli3@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marius Cristea
	<marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Message-ID: <20240708173439.000070b4@Huawei.com>
In-Reply-To: <668bec2a8b23a_6e037017@njaxe.notmuch>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	<20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	<20240707160442.6bab64c9@jic23-huawei>
	<668bec2a8b23a_6e037017@njaxe.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> > Hi Matteo,
> > 
> > A little too fast for sending a new version.  Result is Marius reviewed
> > v1. I may replicate some of Marius' comments but do make sure you
> > cover them all for v3.
> > 
> > One big question I have here, is do typical usecases for this device care
> > much about reducing integration time? I'd have thought they were all
> > relatively slow.  As such it may make sense to not support some
> > of the modes that need to lower integration time (this is a common thing
> > to decide to skip in the interests of maintainability and user interface
> > complexity reduction).
> > 
> > Looks reasonably speedy to me, unless very high numbers of samples
> > are used.  So that control makes sense to expose, perhaps not
> > the resolution one.
> > 
> > Note that custom ABI is almost always a bad idea.  We enable it for the
> > cases where there is no other choice, but reality is those cases then
> > all need custom userspace software, so the controls are much less likely
> > to actually used :(
> > 
> > 
> > Jonathan
> >  
> 
> Hi Jonathan,
> 
> Thanks for your feedback, this clarified a lot.
> 
> I agree to keep the user interface simple, so I will remove the
> controls that don't look necessary, based on your comments below. Anyway note
> that some of the comments from Marius (from patch v1) are in contrasts with
> this, suggesting to actually extend the interface, by exposing the
> shunt-resistor and controls for the OUT analog pin.
> 
> I could add the shunt-resistor controls to allow calibration as Marius
> suggested, but that's also a custom ABI, what are your thoughts on this?

This would actually be a generalization of existing device specific ABI
that has been through review in the past.
See Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
for example (similar in other places).
So if you want to do this move that ABI up a level to cover multiple devices
(removing the entries in specific files as you do so).

> 
> Instead I would not introduce controls for the OUT pin, at least not for the
> moment, since it would require some more considerations on the additional
> custom controls and an implementation extension to support the pin-controlled
> integration mode. Right now I defaulted the device operation mode to the
> free-run power integration mode, which to me it looks like the more versatile
> since in this way the device exposes all three measurements of voltage, current
> and power, but the OUT pin setting is fixed to output the power value in a
> fixed range.
> I think that the OUT pin might not be used at all in many use cases so I would
> leave the OUT pin setting as fixed for now and maybe extend it in the future
> when more use cases arise. I am open to reconsider this though.

Absolutely fine to not support things in an initial driver.
Those that need them can contribute support later, or you can decide
to do so if you like.


> 
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/resolution_bits_available
> > > +KernelVersion:	6.10
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		List all possible ADC measurement resolutions: "11 14"
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/integration_samples
> > > +KernelVersion:	6.10
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Number of samples taken during a full integration period. Can be
> > > +		set to any power of 2 value from 1 (default) to 2048.
> > > +		This attribute affects the integration time: higher the number
> > > +		of samples, longer the integration time. See Table 4-5 in device
> > > +		datasheet for details.  
> > 
> > Sounds like oversampling_ratio which is standards ABI. So use that or explain
> > why you can't here.  
> 
> I am not sure that this is an oversampling ratio but correct me if I am wrong:
> generally by increasing the oversampling you would have additional samples in a
> fixed time period, while in this case by increasing the number of samples you
> would still have the same number of samples in a fixed time period, but you
> would have a longer integration period. So maybe the comment is not very
> clear since this parameter actually means "the number of samples required to
> complete the integration period".

No. Oversampling is independent of the sampling period in general (though
here the 'integration time' is very confusing terminology.  You may
have to have sampling_frequency (if provided) updated to incorporate that
the device can't deliver data as quickly.

> 
> Initially I thought to let the user edit this by writing the integration_time
> control (which is currently read-only), but since the integration period
> depends also on the resolution and whether filters are enabled or not, it would
> have introduced some confusion: what parameter is being changed upon
> integretion_time write? Maybe after removing resolution and filter controls
> there would be no such confusion anymore.

Hmm. The documentation seems to have an unusual definition of 'integration' time.
That looks like 1/sampling_frequency.  In an oversampling device integration time
is normally about a single sample, not the aggregate of sampling and read out
etc.

I guess here the complexity is that integration time isn't about the time
taken for a capacitor to charge, but more the time over which power is computed.
But then the value is divided by number of samples so I'm even more confused.

If we just read 'integration time' as data acquisition time, it makes a lot
more sense.



> > > +
> > > +/* Check if overflow occurred and if so, push the corresponding events.  
> > 
> > As mentioned below, without controls I don't think userspace has any way to know
> > these are coming.   It is useful even for overflow events to provide
> > a) A way to mask them off.
> > b) The threshold values.  So that userspace can see that they are overflow events.
> >    These will be readonly of course.
> >   
> I see your point, I will add controls. About thresholds, should they be related
> to raw values or to scaled values? In the first case they would always be
> fixed to 1023 being the measurement resolution, regardless of the selected
> gains. In the latter case they would depend on the current gains and I guess
> that they would be in the same unit of the scale (mV/mA/mW).

Thresholds are in raw units.  1023 is indeed what I'd expect here.

...

> > > +static int pac1921_update_cfg_reg(struct pac1921_priv *priv, unsigned int reg,
> > > +				  unsigned int mask, unsigned int val)
> > > +{
> > > +	/* Enter READ state before configuration */
> > > +	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > > +				     PAC1921_INT_CFG_INTEN, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Update configuration value */
> > > +	ret = regmap_update_bits(priv->regmap, reg, mask, val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Re-enable integration and reset start time */
> > > +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > > +				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	priv->integr_start_time = jiffies;  
> > 
> > Add a comment for why this value.
> >  
> Could you elaborate what's confusing here? The comment above states "reset
> start time", maybe I should move it above the assignment of
> priv->integr_start_time? Or it's the use of jiffies that it's confusing?

Why is it jiffies?   Why not jiffies * 42?
I'm looking for a datasheet reference for why the particular value is used.

> 
> > > +	priv->first_integr_done = false;  
> > Will default to this anyway, so you could skip it unless you feel this is
> > useful from documentation point of view.
> >  
> That variable is being asserted after the first integration period is complete
> to avoid spurious data (see pac1921_data_ready()). Here it is being reset after
> a configuration change to invalidate previous data. So the assignment is
> necessary.
Ah. I' missed this happens in a config change path rather than only first
time after reset of device.



> > > +static ssize_t pac1921_read_filters_enabled(struct iio_dev *indio_dev,
> > > +					    uintptr_t private,
> > > +					    const struct iio_chan_spec *chan,
> > > +					    char *buf)
> > > +{
> > > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > > +	bool enabled;
> > > +
> > > +	scoped_guard(mutex, &priv->lock) {
> > > +		enabled = priv->filters_en;
> > > +	}
> > > +	return sysfs_emit(buf, "%d\n", enabled);  
> > 
> > It's not a fast path hence holding the lock a little longer than necessary doesn't
> > matter, so I'd do the simpler.
> > 
> > 	guard(mutex)(&priv->lock);
> > 
> > 	return sysfs_emit(buf, "%d\n", enabled);
> >  
> Ok, but I think you mean:
> 
> 	guard(mutex)(&priv->lock);
> 	return sysfs_emit(buf, "%d\n", priv->filters_en);
oops. yes.

> >   
> > > +	for_each_set_bit(bit, idev->active_scan_mask, idev->masklength) {
> > > +		int val;
> > > +
> > > +		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> > > +		if (ret)
> > > +			goto done;
> > > +
> > > +		priv->scan.chan[ch++] = (u16)val;  
> > 
> > Why not make read_res take a u16 * and pass in the destination directly?
> >   
> pac1921_read_res() takes an int *val so that pac1921_read_raw() can pass its
> int *val argument directly and to avoid an additional u16 var. However I don't
> mind changing it if that looks more clear.

I think it would be cleaner to maintain the type up to the caller.


> 
> Thanks again,
> Matteo
> 

For future reference, no need to acknowledge stuff you agree
with.  Much better to crop to the places where there are questions or responses
as it saves time for the next step of the discussion!

Thanks,

Jonathan


