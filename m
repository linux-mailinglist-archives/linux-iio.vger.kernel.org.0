Return-Path: <linux-iio+bounces-13346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A99ED780
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 21:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE5A168477
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4082210F2;
	Wed, 11 Dec 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF9IlOcV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B35259498;
	Wed, 11 Dec 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950394; cv=none; b=Uke/0wt4baFOUDxMefEsxkmqxAbcJqNMZ+hYU9trtrQdlAPVCA3pajYpc1fA7gAEQoBiuvX9u9OBxLe+TVb6mXHnw2AnFosqy8KtUcEDuFePKlZUpZ6GimMizith5DQ2Y//tfCcqe3GZ7jmGga4/U9rZndYmKDeaqeriFtyKVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950394; c=relaxed/simple;
	bh=h5MY6n9s52R9K4S4G1UuwM6yzSqhfXepqx5616VdQqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DP3iunav920+eYe6nA4N4b1C8aFqR3gnbk96i6862+pVFFtkdd/gyvfYaBV9NYY4vCG/8L3kP0Zn2aazlpr3KAGEESyId18/M+wG+Uj37Cm8doagyhozOxV0zZpQ8yqt5GPRw9xFFPGXC+iwqCCJikQe8FBJCbr/yBDocyKSvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF9IlOcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3A0C4CED2;
	Wed, 11 Dec 2024 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733950394;
	bh=h5MY6n9s52R9K4S4G1UuwM6yzSqhfXepqx5616VdQqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jF9IlOcVZ7CnGk+pLzx3qeNz2UQWzdj4Cq+PAIz6vAYiLBosddkGHEpY2oHZlWhzR
	 VwlJNbOjH1DLckuLuFBbq58vZJVSnRlcW4RoR6RQpilBd+/qyrZrAo0ZnoMaPHgq6O
	 BQ9mtKv7GclkmrGiOoisQkbRwirDaKcfO+FqVQMSlyJ+5X2msBsnqNhAz/TScksqiL
	 Pz+SqKitWfIFec/2yEQ0ILs2VEQL4ZqZUkbWuKGkXBumtHFr6Mu9o38sCdDnTYMXJq
	 sZixnWZ3JUmlP/QEqDD4TxBVzDwf3GdpkyE4VLIT9LgzzsqFrElfu6ZHYCeatsfcRY
	 6SZ1SvnBVqE6A==
Date: Wed, 11 Dec 2024 20:53:02 +0000
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
Subject: Re: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <20241211205302.2ba32a4a@jic23-huawei>
In-Reply-To: <Z1dl2C9/BYoeyudu@uva.nl>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
	<20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>
	<20241208122038.18cf7db8@jic23-huawei>
	<Z1dl2C9/BYoeyudu@uva.nl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 16:49:12 -0500
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> wrote:

> On Sun, Dec 08, 2024 at 12:20:38PM +0000, Jonathan Cameron wrote:
> > On Fri, 06 Dec 2024 11:09:57 -0500
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
> > As the bots noted, the maintainers entry has the wrong vendor prefix,
> > or the binding does.
> > 
> > Also the issue with missing include of linux/bitfield.h
> > 
> > Unused gain table is less obvious. Not sure what intent was on that one.
> > 
> > Given the discussion with Matti about how to do the gain control, please add
> > some description here of the outcome.  The control scheme is not particularly
> > obvious and is the key bit we should be reviewing.  It feels like you've
> > applied the feedback on v1 to the light channel but it is equally applicable
> > to proximity channels when they are just measures of reflected light intensity.
> > 
> > Various other minor things inline.
> > 
> > Thanks,
> > 
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> I will fix the warnings the bots noted and other inline comments for v3, sorry about that.
> Regarding gain control for ALS, I kept the non-linear table provided in the datasheet.
> The user can adjust the integration time and the available scales will update
> depending on the value.
> For example, at 100ms, you have possible scales of 0.819, 0.269, 0.131, etc. (lux/count).
> The hardware gain and other relevant registers gets adjusted by the driver depending on selected scale.
> The attribute is kept as read-only as Matti suggested.
> 
> Now, for proximity, again I'm confused. Please bear with me a little.
> The only "scale" I see in the datasheet is that the proximity sensor is for a short distance of under 70mm.

That sounds like a design point for sensitivity of sensor vs light source brightness.

> There's nothing provided in the datasheet to convert the proximity ADC count to a distance or to anything meaningful like standard units.
> I don't feel like this is really precise and the intended use case is probably like mine where you can use this to detect
> if there's something covering the sensor or not.
> 
> I took a look at other light/proximity sensors, again, it's not clear for me how to handle this.
> It seems that some drivers just directly control the hardware gain register with the scale even if it's not really a scale.
Typical case is that it is a scale, just not of distance.  But rather controls an amplifier on the light sensor,
so same as for the ambient light sensor.

The ABI docs are a little vague on this Documentation/ABI/testing/sysfs-bus-iio
has
What:		/sys/.../iio:deviceX/in_proximity_raw
What:		/sys/.../iio:deviceX/in_proximity_input
What:		/sys/.../iio:deviceX/in_proximityY_raw
KernelVersion:	3.4
Contact:	linux-iio@vger.kernel.org
Description:
		Proximity measurement indicating that some
		object is near the sensor, usually by observing
		reflectivity of infrared or ultrasound emitted.

		Often these sensors are unit less and as such conversion
		to SI units is not possible. Higher proximity measurements
		indicate closer objects, and vice versa. Units after
		application of scale and offset are meters.

So it kind of says we can't relate them to real units, but then we provide
a unit. Hmm, not our finest and clearest documentation.

Probably best bet is to follow precedence as even if we haven't tightly defined
it that is what any userspace tuning these value will be using.

Given inverse square law and different characteristics of reflective surfaces
I think it is normally a case of crank the gain up until the signal is good.

In most cases these proximity sensors aren't much more than fancy switches
though can be used for approaching vs moving away detection.

Anyhow, I haven't checked all the precedence in existing drivers but from
memory scale is the standard choice.

Hardware gain as a writable control is just rarely used and only in devices where
it doesn't affect what we are measuring. In proximity that means time of flight
sensors, not ones based on reflected intensity.

Jonathan

> 
> What should I do?
> 
> Best regards,
> Mikael


