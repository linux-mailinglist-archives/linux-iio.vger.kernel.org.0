Return-Path: <linux-iio+bounces-13724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394919F99FD
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E2C1885C4E
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1AD21E088;
	Fri, 20 Dec 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEC1bo+D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F9199E8D;
	Fri, 20 Dec 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721581; cv=none; b=GF7aGiUGiO1ovaGaHbr+eV9kfklQoYnpe6RCfRCYSKm4O0vGHluryt8mTfFKykWFx1MrHZEDt4PUEIKN93wc6HUV7/d3oh0uP/8bjHkoWX6+AnO3tV7YiN7bef4YmjS0YdxJiu2/hchtp9648W09v/9U7e4ReU5DN9DM4GwBB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721581; c=relaxed/simple;
	bh=BIDq7AIc2nskhJGg/Wzud7O5YDPpt+4cTKsZUZF3l38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2EYX/H0N2wMMA3Ls57Ej8TX6Sx9Kzt001QPbdDfVWJ7/xnsGAaaVMILZQ1Dqc06DrWhOSuQ5cJU22R2Ipzee9Nv2gHVFjB/p7QRnIGBfzqt3Sf4s/7srg/ZQHBgP/5Uuky6GctBkv3mk7p3bQU/WduYiDkm4t8OpcEtmMCUPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEC1bo+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E2C4CECD;
	Fri, 20 Dec 2024 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734721580;
	bh=BIDq7AIc2nskhJGg/Wzud7O5YDPpt+4cTKsZUZF3l38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEC1bo+DKitazcPdbQW+58zwkkrhyJ24RLtl8zuPbqZii6c/1LRm4/Cp7NfAWEHDI
	 nwRgvNnej52kQWIoEuC/zdWS8yqfbgecVljNzkFicWpN0eAjDVrWMbsVKgAtlWsnC1
	 KxZjaAXOhlbq6nNVQAvmy8h/uULzpOKU17MoPSsHsxlXHfhNUXakK0BzagFmqZIrUA
	 +LdzzaOLDQ5uJ2x/SGL6i4Z/Womh2z3+TxHmAjYDkPrtHPumYVIGrjVTLwjAA5uCjN
	 5x2GdqjuS9ubDevqX2qAmTaW0BXlbQNNonF79icffbRiBEYIBJEY9a0HX9dDFrV9Ol
	 q9wPRoWxS02Fg==
Date: Fri, 20 Dec 2024 19:06:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Cc: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Mikael
 Gonella-Bolduc <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <20241220190608.713b0504@jic23-huawei>
In-Reply-To: <Z2RydCiREUYQPLtz@uva.nl>
References: <20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com>
	<20241216-apds9160-driver-v3-2-c29f6c670bdb@dimonoff.com>
	<20241219163454.09daa116@jic23-huawei>
	<Z2RydCiREUYQPLtz@uva.nl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 14:22:28 -0500
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> wrote:

> Hi Jonathan,
> 
> Regarding calibration attributes, while I did include them and made sure that what's exposed by the driver 
> is actually being correctly set in the registers and that it has an impact on the input data, 
> I do not have a real life use case for them right now and that's probably the case for almost everyone using the same chip.
> It's there as a provision in case something comes up and I end up needing them.
> 
> I'm also not sure on how it should be used and in which scenario.
> From what I understand, depending on the type of material in front of the sensor (tempered glass in my case),
> it's there to cancel out unwanted light reflection of what you don't want to detect.
> It does so by emitting another, very short, light pulse and takes the reflected light ADC count from that and substracts it.

I guess they apply a very short exposure time on that measurement to ensure it only picks up on light
received very soon after the pulse and hence in theory very near to the sensor.

> There's also another digital substraction parameter to always substract a value if you know what's the value to cancel out.
> 
> The 3 parameters in question in the datasheet:
> - PS_CAN_DIG : This is just a digital substraction
that one is fine as in_proximity_calibbias.

> - PS_CAN_ANA_DURATION: The duration of the short cancellation light pulse
> - PS_CAN_ANA_CURRENT: The light pulse current used

These two are new concepts so I think we may need some new ABI

It is kind of like a differential channel with separate controls
on the current and integration time (as a proxy for the pulse length).

For the current I think it is cleaner to use a second
out_currentX_* channel with labels provided to associate which current
channel is which. Provide the read_label attribute and label all channels.

Taking the duration, that's a bit of an oddity as it's really a characteristic
of the the output current channel, not the measurement itself. So
how about out_current1_pulse_time ?  Would need to be in seconds though
to match with integration_time ABI.

Having said all this. If there is a right setting (or a calibration procedure
to get something that works) for a given device incorporating this sensor
then the stuff perhaps belongs in DT.  If you go that way makes sure to cleanly
document why these are device characteristics rather than corrections for
calibration differences between different phones of the same model for instance.




> 
> I used a standard calibration attribute name for all of those, respectively:
> - in_proximity_calibscale
> - in_proxmiity_calibbias
> - out_current_calibbias
> 
> I don't know if this is a correct use or not.

Thanks for all the details.  That helps a lot!

Gut feeling from me is that we are looking at something best defined in firmware
/ DT given it's all about the glass in front of the sensor.
> 
> See my other comments inline.
> 
> Thank you,
> Mikael
> 
> On Thu, Dec 19, 2024 at 04:34:54PM +0000, Jonathan Cameron wrote:
> > On Mon, 16 Dec 2024 17:55:41 -0500
> > Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> >   
> > > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > 
> > > APDS9160 is a combination of ALS and proximity sensors.
> > > 
> > > This patch add supports for:
> > >     - Intensity clear data and illuminance data
> > >     - Proximity data
> > >     - Gain control, rate control
> > >     - Event thresholds
> > > 
> > > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>  
> > 
> > Hi Mikael,
> > 
> > A couple of questions on the calib* parts. I hadn't looked closely those
> > before and the datasheet is not very helpful!
> > 
> > Jonathan
> > 
> >   
> > > diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..0c93ab847d9a36aac7aa6a1893bba0fe819d9e28
> > > --- /dev/null
> > > +++ b/drivers/iio/light/apds9160.c  
> >   
> > > +
> > > +/*
> > > + * The PS intelligent cancellation level register allows
> > > + * for an on-chip substraction of the ADC count caused by
> > > + * unwanted reflected light from PS ADC output.  
> > As it's subtraction, why calibscale? Sounds more suitable to make this to calibbias.  
> > > + */
> > > +static int apds9160_set_ps_cancellation_level(struct apds9160_chip *data,
> > > +					      int val)
> > > +{
> > > +	int ret;
> > > +	__le16 buf;
> > > +
> > > +	if (val < 0 || val > 0xFFFF)
> > > +		return -EINVAL;
> > > +
> > > +	buf = cpu_to_le16(val);
> > > +	ret = regmap_bulk_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_DIG_LSB,
> > > +				&buf, 2);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	data->ps_cancellation_level = val;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * This parameter determines the cancellation pulse duration
> > > + * in each of the PWM pulse. The cancellation is applied during the
> > > + * integration phase of the PS measurement.
> > > + * Duration is programmed in half clock cycles
> > > + * A duration value of 0 or 1 will not generate any cancellation pulse  
> > 
> > Perhaps add some details on why this is a calibbias type control?
> > 
> > Whilst I can sort of grasp it might have a similar affect to a conventional
> > calibration bias by removing some offset, it's not totally obvious.
> >   
> 
> After looking at all possible types for a proxmity channel this is what I though was the most sensible choice.
> Is it possible to use a custom attribute type here if nothing fits?

Yeah, it feels like too much of a stretch so new ABI needed.

> Or maybe we should drop this entirely since it will probably be rarely used.

See above, maybe we push this to DT and make it a firmware description problem.

> 
> > > + */
> > > +static int apds9160_set_ps_analog_cancellation(struct apds9160_chip *data,
> > > +					       int val)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (val < 0 || val > 0x7F)
> > > +		return -EINVAL;
> > > +
> > > +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_DUR,
> > > +			   val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	data->ps_cancellation_analog = val;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * This parameter works in conjunction with the cancellation pulse duration
> > > + * The value determines the current used for crosstalk cancellation
> > > + * B4-B5: The coarse value defines cancellation current in steps of 60nA
> > > + * B0-B3: The fine value adjusts the cancellation current in steps of 2.4nA  
> > 
> > Whilst I'm failing to actually understand what this is doing and maybe never will
> > we can make the interface more intuitive by not using the encoded value.
> > Just use a value in nA with both the val and val2 parts.
> > 
> > it is rather odd given 15 * 2.4 is only 36 so there are holes..  PRobably a case
> > for getting as close as you can to the requested value.
> > 
> > Calibration parameters aren't guaranteed to have a simple interpretation but
> > this current case is worse that it needs to be.
> >  
> 
> Ok, noted I will make this change for v4 if it's best to keep this.
> This works in conjunction with the cancellation duration.
>  
> > > +	case IIO_CHAN_INFO_CALIBSCALE:
> > > +		if (val2 != 0)
> > > +			return -EINVAL;
> > > +		switch (chan->type) {
> > > +		case IIO_PROXIMITY:
> > > +			return apds9160_set_ps_cancellation_level(data, val);
> > > +		case IIO_CURRENT:
> > > +			return apds9160_set_ps_cancellation_current(data, val);  
> > 
> > I can't figure out what this one actually is.
> >   
> 
> This is the current used by the cancellation light pulse (PS_CAN_ANA_CURRENT).
> I might not be using the correct type name here, since it's so specific to this chip
> I just don't know which one to use.

It is a kind of cool feature, and so if it works well I expect it will become
more common over time. So maybe this is just the first of many devices to support this.

Jonathan



