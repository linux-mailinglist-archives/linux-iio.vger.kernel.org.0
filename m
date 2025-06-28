Return-Path: <linux-iio+bounces-21062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760AAEC92E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8A5189BCF3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A414D25C827;
	Sat, 28 Jun 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BByhqIii"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709326B776;
	Sat, 28 Jun 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129972; cv=none; b=bckpDCvI86DQrQe+LyPEYfJ1nV4ni54JMixinMG3h9/wtqsHdYdZ4hQEIDadTjMDOJWMsl3qPApFrceouuIvhyeptzmsgQ3K+z+vRubRc0/QnnNAgYu52oAbblvWh4QkHetrlTpkhFeGTywVbLD/r/pv+OUwNvWGjp2qMO0Qhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129972; c=relaxed/simple;
	bh=Y5Qcyl7nKMYyq3O12CVaaVN37dB7H+wpJaM/exZ7iBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkD+QFFjbFuRhxgmvr2zUXcfz0V0YQGJbtHGi7y/4gJyz3o1z/Um1SDWjkwuEruSsqRv4uhm6+wXPbKASzClZ0MW36AmtPi74P6EshX9mU51nVzdIO5DX60nYhghQTk3JlP9XAoukW1h7rNcT3F0z2r/E8ghecb50JawarjeDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BByhqIii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C3BC4CEEA;
	Sat, 28 Jun 2025 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129971;
	bh=Y5Qcyl7nKMYyq3O12CVaaVN37dB7H+wpJaM/exZ7iBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BByhqIii/jGyvsPSopSMeO4uvmrBCvtWFj0AfORzaOJZQGm60+2PygB9hmk8ZOMpl
	 r7M+7dUQUPpNSKAM7wEllE0qRILgDkRQHYQ5TTqCvjcQNbcjmsWLL9ZWn3/zt8tio3
	 Y5pjAxWcMqHKEdxgVPQqcRmDufxxT+Ge51ZyO6uy9EAZdq26t7M+moajtOub3rdhIL
	 eTy58yhM3XA38tL+5YZkWw4gSywoiTHWOulc2+ske4b51P85rGeF5aI70O8E+VsKFm
	 TwjHtm92zevdPHHQtrf5csup3FjVP44QhwZKbI2Ft9c2yR4Uq4gUK4uCaP15Uw7vTG
	 J6NgDDPBE95yA==
Date: Sat, 28 Jun 2025 17:59:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
 <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
 <marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
 <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
 <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v2 2/2] iio: imu: smi330: Add driver
Message-ID: <20250628175921.1db14102@jic23-huawei>
In-Reply-To: <AM8PR10MB4721C0BBFBAE160FB494482CCD7AA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
	<20250513150028.42775-3-Jianping.Shen@de.bosch.com>
	<20250525175157.2446f878@jic23-huawei>
	<AM8PR10MB4721C0BBFBAE160FB494482CCD7AA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 09:31:19 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> Hi Jonathan,
> 
> most findings are already fixed. For 3 findings we still have something unclear. It will be nice if you can give us little bit more indication.
> 
> >> +
> >> +static const struct iio_chan_spec smi330_channels[] = {
> >> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, X, SMI330_SCAN_ACCEL_X),
> >> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Y, SMI330_SCAN_ACCEL_Y),
> >> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Z, SMI330_SCAN_ACCEL_Z),
> >> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, X, SMI330_SCAN_GYRO_X),
> >> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Y, SMI330_SCAN_GYRO_Y),
> >> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Z, SMI330_SCAN_GYRO_Z),
> >> +	SMI330_TEMP_CHANNEL(SMI330_TEMP_OBJECT),
> >> +	IIO_CHAN_SOFT_TIMESTAMP(SMI330_SCAN_TIMESTAMP),
> >> +};
> >> +
> >> +static const struct smi330_sysfs_attr smi330_accel_scale_attr = {
> >> +	.reg_vals = (int[]){ SMI330_ACCEL_RANGE_2G,  
> >SMI330_ACCEL_RANGE_4G,  
> >> +			     SMI330_ACCEL_RANGE_8G,  
> >SMI330_ACCEL_RANGE_16G },
> >
> >Do we need the (int[]) part here?  
> 
> Remove it will lead to a compiler warning. 

Fair enough.  Would have been good to put the compiler warning here.
I'd failed to realise you were intialising a pointer not a fixed
sized array.


> 
> 
> >> +
> >> +	if (*indio_dev->active_scan_mask == SMI330_ALL_CHAN_MSK) {
> >> +		ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG,
> >> +				       data->buf, ARRAY_SIZE(smi330_channels));
> >> +		if (ret)
> >> +			goto out;
> >> +	} else {
> >> +		iio_for_each_active_channel(indio_dev, chan) {
> >> +			ret = regmap_read(data->regmap,
> >> +					  SMI330_ACCEL_X_REG + chan, &sample);  
> >
> >Given there is always a trade off between the efficiency of a bulk read and reading
> >just the channels enabled, we often just set available_scan_masks, read the lot and
> >let the IIO core worry about resorting the data as needed.  
> 
> Is any IIO API available to take care the resorting data?

When you say resorting I'm not totally sure what you mean. If it's simply
removing entries we don't wan then provide available_scan_masks and the
IIO core code does it all for you.  If fewer elements are required
by the consumer (which may be userspace) then it repacks the data to include
only what you'd expect.
> 
> >
> >For example, if you want all but 1 channel that is almost certainly quicker and that is
> >more likely to be the common case than you want 1 channel only using the buffer.
> >
> >So I'd like some more explanation here on why this path is needed.  
> 
> We try to read the data just for activated channel and put them in buffer. If just one channel activated, reading data for all channels leads to unnecessary data transfer on bus.

The trade off is that in many case a loop of regmap_read() calls is much less
efficient than regmap_bulk_read() even though it may result in less data on the bus.

So the question then becomes how common is it for people to have
1 channel, 2 channels,  n - 1 channels, n channels.

It is common that reading n - 1 in a loop is slower than reading
n and dropping one + data mangling to realign everything after the
missing channel.  Normally we assume that if someone bought a fancy
device they probably want most of it's channels and optimise for that
rather than a small subset of channels.

The optimisation you have for all channels made me think that if that
was worth doing the overheads of separate reads must be significant!

> 
> >  
> >> +			if (ret)
> >> +				goto out;
> >> +			data->buf[i++] = sample;
> >> +		}
> >> +	}
> >> +
> >> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
> >> +					   data->current_timestamp);
> >> +
> >> +out:
> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}  
> 
> 
> >> +static irqreturn_t smi330_irq_handler(int irq, void *p) {
> >> +	struct iio_dev *indio_dev = p;
> >> +	struct smi330_data *data = iio_priv(indio_dev);
> >> +
> >> +	atomic64_set(&data->irq_timestamp, iio_get_time_ns(indio_dev));  
> >
> >Why do you need the atomic here? If there is a top half / thread race then you could
> >get garbage data anyway.  
> 
> The atomic here is used to prevent simultaneous read (in bottom half) / write (in top half) to the "data->irq_timestamp"
> This happens if the next interrupt comes too early when the current bottom half is still reading "data->irq_timestamp". 
> The next top half will interrupt the execution of current bottom half and change the "data->irq_timestamp". 
> Finally, the current bottom half get a wrong value.

So what you are doing is preventing tearing, not a wrong value in the sense of
getting the next time stamp.

It's fairly unusual for a complex device to not have some form of explicit ack that stops us getting
a new interrupt until we've handled the last one (IRQF_ONESHOT can be appropriate as well).
I think the issue here is that the second interrupt might have nothing to do with data ready (which I'd
hope does need some form of clear) but we grab a timestamp anyway.  Rather than run the risk of a
very wrong timestamp it might make more sense to just grab a less accurate timestamp in
the threaded handler.

Jonathan

