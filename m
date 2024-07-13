Return-Path: <linux-iio+bounces-7585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1E93050E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18F128304B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6B69D2B;
	Sat, 13 Jul 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1duXqLx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4047F64;
	Sat, 13 Jul 2024 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866123; cv=none; b=OkxuTlb/xEgn8TqgTk0rpuarC0fPO3+OGOi/SaWbTPbAOdjRwQnbknv5OJ9mr+Tql0LqecK+vXQLC96dDtwVfW4qxMyvdl3liggkZmFZsZ34ucmQnMSPvJXvUCpr6OMfhb4gO4Ux94Jj0oekdLFkSb1qfiT/VRi3o54Gbz4TBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866123; c=relaxed/simple;
	bh=tg5CfJaivTcWkVihybBxeEHcR4ZUtyvXdevKnslQIIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcgQ7EozV4CyjXiGWZ78a3c6lyp9QTin3D7J4QEmUnMlwCeyCHjhJzp7xalfvh4lJXPjEulgg2vf4v9l8AoDS0Q/onV3woTSAFWsRyKr/xlCGRusB09JUTClW2jOfSTstDKaJ4Qr2Msmlx2q51moUTwdErcwt0EAJtXbf7rrdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1duXqLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7717C32781;
	Sat, 13 Jul 2024 10:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720866122;
	bh=tg5CfJaivTcWkVihybBxeEHcR4ZUtyvXdevKnslQIIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c1duXqLxvHclxDPZgNXHVfVZXjEkseE28aoiPAr/TmGHJ0XD1/0r+csRaHbFQUHL9
	 787yg4In6/r/HTOYdwmpTpEK5ezul/WpWoXOBhcyvq6BsHEW1qTtHJF2FTqZdeYN/d
	 utr0/Y4tlKWNa0R8RyHp38WAofuXl8XqHgodOcw9Bcp3+VExksVf4cL528engsuLVC
	 rWQSHBTDx9voxHB19kpE+gemgZtr/Xs46fMGvsL0AZkZb9QKH4S3UwW8741PbANuff
	 FR/pfvUWXDUeTHQ1Onz5Ie5AbHZgFLVjT+6ncPNuk399yMnAbOZYANokVbgf/gX28B
	 1U7UFiWrTJAOw==
Date: Sat, 13 Jul 2024 11:21:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marius Cristea
 <marius.cristea@microchip.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Message-ID: <20240713112153.3576fc2a@jic23-huawei>
In-Reply-To: <668cf2f3ece62_1f6ba37012@njaxe.notmuch>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	<20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	<20240707160442.6bab64c9@jic23-huawei>
	<668bec2a8b23a_6e037017@njaxe.notmuch>
	<20240708173439.000070b4@Huawei.com>
	<668cf2f3ece62_1f6ba37012@njaxe.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jul 2024 10:21:07 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Jonathan Cameron wrote:
> ...
> > > I could add the shunt-resistor controls to allow calibration as Marius
> > > suggested, but that's also a custom ABI, what are your thoughts on this?  
> > 
> > This would actually be a generalization of existing device specific ABI
> > that has been through review in the past.
> > See Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> > for example (similar in other places).
> > So if you want to do this move that ABI up a level to cover multiple devices
> > (removing the entries in specific files as you do so).
> >   
> I would do this in a separate commit, would you prefer it in this same patch
> set or in another separate patch?

Separate commit in this series as otherwise it's not obvious why we are
doing it. In theory should be before this patch as then what you use here
is already documented, but I don't care that much on the order.

> 
> ...
> > >   
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/resolution_bits_available
> > > > > +KernelVersion:	6.10
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		List all possible ADC measurement resolutions: "11 14"
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/integration_samples
> > > > > +KernelVersion:	6.10
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Number of samples taken during a full integration period. Can be
> > > > > +		set to any power of 2 value from 1 (default) to 2048.
> > > > > +		This attribute affects the integration time: higher the number
> > > > > +		of samples, longer the integration time. See Table 4-5 in device
> > > > > +		datasheet for details.    
> > > > 
> > > > Sounds like oversampling_ratio which is standards ABI. So use that or explain
> > > > why you can't here.    
> > > 
> > > I am not sure that this is an oversampling ratio but correct me if I am wrong:
> > > generally by increasing the oversampling you would have additional samples in a
> > > fixed time period, while in this case by increasing the number of samples you
> > > would still have the same number of samples in a fixed time period, but you
> > > would have a longer integration period. So maybe the comment is not very
> > > clear since this parameter actually means "the number of samples required to
> > > complete the integration period".  
> > 
> > No. Oversampling is independent of the sampling period in general (though
> > here the 'integration time' is very confusing terminology.  You may
> > have to have sampling_frequency (if provided) updated to incorporate that
> > the device can't deliver data as quickly.
> >   
> > > 
> > > Initially I thought to let the user edit this by writing the integration_time
> > > control (which is currently read-only), but since the integration period
> > > depends also on the resolution and whether filters are enabled or not, it would
> > > have introduced some confusion: what parameter is being changed upon
> > > integretion_time write? Maybe after removing resolution and filter controls
> > > there would be no such confusion anymore.  
> > 
> > Hmm. The documentation seems to have an unusual definition of 'integration' time.
> > That looks like 1/sampling_frequency.  In an oversampling device integration time
> > is normally about a single sample, not the aggregate of sampling and read out
> > etc.
> > 
> > I guess here the complexity is that integration time isn't about the time
> > taken for a capacitor to charge, but more the time over which power is computed.
> > But then the value is divided by number of samples so I'm even more confused.
> > 
> > If we just read 'integration time' as data acquisition time, it makes a lot
> > more sense.
> >   
> I think I now get what you are suggesting, please correct me otherwise:
> 
> 1. Let's consider the sampling frequency as how often the device provides
>    computed ("integrated") measurements to the host, so this would be
>    1/"integration period". This is not the internal ADC sampling rate.
> 
> 2. I will expose sampling_frequency (RO), oversampling_ratio (R/W) and
>    oversampling_ratio_available (RO) to the user, where oversampling_ratio
>    corresponds to what the datasheet refers to as the "number of ADC samples to
>    complete an integration".
> 
> 3. When the user writes the oversampling_ratio, the sampling_frequency gets
>    updated accordingly.
> 
> 4. With two real examples:
>     4.1. The user writes 16 to oversampling_ratio, then reads 43.478 from
>       sampling_frequency: with 16 samples the "integration period" is 23ms
>       (from Table 4-5) so 1/0.023 => 43.478 Hz
>     4.2. The user writes 2048 to oversampling_ratio, then reads 0.34 from
>       sampling_frequency: with 2048 samples the "integration period" is 2941ms
>       (from Table 4-5) so 1/2.941 => 0.34 Hz
> 
> 5. Do not expose the integration_time control to avoid confusion: the so called
>    "integration period" can be derived from the sampling frequency as
>    1/sampling_frequency.

Yes, that seems like the best approach to me.

There is always a slight confusion between trigger sampling_frequency and
channel sampling_frequency but only relationship is that the combination of the
channel sampling frequencies put a max limit on the trigger sampling
(how often we can actually measure things).  Sometimes they are the same
value because of hardware contraints, sometimes not.

> 
> ...
> > > > > +static int pac1921_update_cfg_reg(struct pac1921_priv *priv, unsigned int reg,
> > > > > +				  unsigned int mask, unsigned int val)
> > > > > +{
> > > > > +	/* Enter READ state before configuration */
> > > > > +	int ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > > > > +				     PAC1921_INT_CFG_INTEN, 0);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	/* Update configuration value */
> > > > > +	ret = regmap_update_bits(priv->regmap, reg, mask, val);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	/* Re-enable integration and reset start time */
> > > > > +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > > > > +				 PAC1921_INT_CFG_INTEN, PAC1921_INT_CFG_INTEN);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	priv->integr_start_time = jiffies;    
> > > > 
> > > > Add a comment for why this value.
> > > >    
> > > Could you elaborate what's confusing here? The comment above states "reset
> > > start time", maybe I should move it above the assignment of
> > > priv->integr_start_time? Or it's the use of jiffies that it's confusing?  
> > 
> > Why is it jiffies?   Why not jiffies * 42?
> > I'm looking for a datasheet reference for why the particular value is used.
> >   
> I used jiffies just to track the elapsed time between readings. Something I am
> not considering here? Of course jiffies granularity might be larger than the
> minimum sampling frequency. Is there a common better approach?

Ah, you are using it as the base for another comparison.

Integr_start_time sounded like the time at which integration should start
not when it did.  integr_started_time maybe?  Or perhaps I'm projecting my
misread onto the naming. Maybe even call out the unit in the name as
right now you have start_time in jiffies and integr_period in usecs.

A postfix of _jiffies and _usecs would help avoid confusion there.

