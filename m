Return-Path: <linux-iio+bounces-25544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE4C1159D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 21:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B74E2425
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CBA31E0E0;
	Mon, 27 Oct 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="MqNaE0TN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFF2DFA5B;
	Mon, 27 Oct 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595979; cv=none; b=HNNr+cW4JnXmja7wWPM3njBRPiPjEDhfr82lZN3eWqpW5PIgZ6S1yXvEjREskVAHwjn/uWMlM+Wc1hEQbPfK8nzS8250/b4ZAcPfRACeW8zeSzmZc1E1iCVXlBCd2/aLUcy+kura9o4gdCYRBUzzpjZuCr5FFAas+sVJDksD1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595979; c=relaxed/simple;
	bh=Aw+BybLNrwuSpQ7MDJf/UWP1PG7FAZGChvgePU/sTOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5DTujSMYNuqAFSSM/JA0ZF66L+lY2PBw21oba7TDzpRm2g4MKRxeXpN+WE1QXLfTGHusjBK0ShXEmKUcYRfdg50arx4T/0DksD2kKI2+Pj7PCeZPv5QraNRqqiF+MmAUmc782cBv/wuSe7VNb6yaj8iXxq7SHoVdIE4x/PRV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=MqNaE0TN; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=l2PjZvXIFPMAjJ5YwND+QOEeX0npuRmwWMZdLM/srTU=; b=MqNaE0TN6zVuqXY3csSAobBvxW
	laVLaisOBusHIbeCbzrA17uvH+FqF70LpfvTVWMHpBEoxp0CN52E3kNTisbKoVf3n24d7ADUX5Zvl
	gGbLcBrwKUHjQ3qp8Z9f1xhRlfQgPfQtz+m6OwQb65i57E6xkOcOp+/rGSNzDYg56GVuSHY0c1mX2
	l3ERuDzPK/+SjKpyPILpTCPfydVMH7rWpDFB1Yk5GaUqAGB3pui+iMbKtflCyJ6f+2oSptOWCn5eH
	9GgfZDbhLaNHU51Gp27XH3wG82xsKw21FDOrVlWFayJ/QBMCZa0DvSDeMTILj5Ui0P1dA5dO64ek7
	79Ab1HXg==;
Date: Mon, 27 Oct 2025 21:12:43 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
 jdelvare@suse.com, lgirdwood@gmail.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair@alistair23.me>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <20251027211243.0bc3d769@kemnade.info>
In-Reply-To: <20250927193945.787eb1a5@jic23-huawei>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
	<20250924090023.282ae450@kemnade.info>
	<b68d40d9-6ea9-49a9-8a2e-8b899f33340d@roeck-us.net>
	<20250924195358.16bbd90c@kemnade.info>
	<e6c8f022-ebfc-459c-806b-f75618f65916@roeck-us.net>
	<20250927193945.787eb1a5@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Sep 2025 19:39:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 24 Sep 2025 12:16:14 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 9/24/25 10:53, Andreas Kemnade wrote:  
> > > On Wed, 24 Sep 2025 00:17:48 -0700
> > > Guenter Roeck <linux@roeck-us.net> wrote:
> > >     
> > >> On 9/24/25 00:00, Andreas Kemnade wrote:    
> > >>> On Sat, 20 Sep 2025 23:18:59 +0100
> > >>> Mark Brown <broonie@kernel.org> wrote:
> > >>>        
> > >>>> On Sat, Sep 20, 2025 at 11:33:07PM +0200, Andreas Kemnade wrote:
> > >>>>       
> > >>>>> Just for learning, yes, it is an abuse of the _optional for non-optional
> > >>>>> things, so a dirty hack which should not go in, therefore RFC. But what
> > >>>>> happens more than having the hwmon device endlessly deferred at worst?    
> > >>>>
> > >>>> There's also the fact that this API is so frequently abused for bad and
> > >>>> broken reasons that I regularly audit users and try to fix them, I'd
> > >>>> rather not see any new users that don't have a really strong reason to
> > >>>> use it.
> > >>>>       
> > >>>>> The wanted regulator is the one defined in sy7636a-regulator.c. So it
> > >>>>> is all an issue internal to the sy7636a.    
> > >>>>       
> > >>>>> Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
> > >>>>> I see several other solutions:
> > >>>>> a) call device_is_bound() on every other children of dev->parent, if not
> > >>>>> bound defer.
> > >>>>> b) do not care about the regulator api at all, just check whether
> > >>>>>      the corresponding bit is set before reading temperature, return
> > >>>>>      -ENODATA if not, some mutex is probably needed.
> > >>>>> c) do not care about the regulator api at all, just set the
> > >>>>>      corresponding bit (together with some mutex locking and counting).    
> > >>>>
> > >>>> I assume this is using the regulator API because someone might use an
> > >>>> external regulator in a system design for some reason (better quality,
> > >>>> power efficiency or a shared reference between multiple devices I
> > >>>> guess?), or because the supply might also be used by external devices?
> > >>>>       
> > >>>>> d) copy the of_node pointer from the parent, add a regulator phandle property
> > >>>>>      to the node pointing to the regulator in the node itself.
> > >>>>>      That sounds like your idea but is against the current dt binding for
> > >>>>>      this device and afaik it is uncommon to have mfd-internal things wired
> > >>>>>      up this way
> > >>>>>
> > >>>>> e) something clean, simple I miss    
> > >>>>
> > >>>> The idea is that the relationship between the devices should be
> > >>>> registered before the devices, that's how the regulator knows to defer.
> > >>>> We used to have an API for doing this for board files which might fit
> > >>>> here, but it got removed since nobody wants board files any more.  If
> > >>>> you're allocating the devices dynamically that's annoying to implement
> > >>>> though...    
> > >>>
> > >>> looking a bit around:
> > >>> max5970-regulator.c has hwmon integrated and no extra device. That would
> > >>> simplify things. Although it does not report temperature. Some
> > >>> touchscreens have temperature via hwmon, some others have temperature
> > >>> via iio, directly in one device without mfd. Maybe that is also
> > >>> the better way here?
> > >>>        
> > >>
> > >> Touchscreens reporting temperature via iio is in general the wrong thing to do.
> > >> Touchscreens report the temperature for monitoring reasons, after all.
> > >> But then, sure, if you insist. I am getting tired of arguing.
> > >>    
> > > I apparently did not make clear what my question refers to. It was more about separate
> > > hwmon device + mfd vs. integrating everything into the regulator driver.
> > >     
> > 
> > What I keep failing to understand is why people keep avoiding the potential of
> > implementing auxiliary device drivers, since that would be the perfect solution
> > and match the intended use case for auxiliary devices.
> >   
> > > But since you brought up the topic hwmon vs. iio for temperature. I do not have
> > > a strong opinion here as long as I can somehow live with it. Nothing I want to
> > > fight for. One sensor I use for measuring room temperature is hwmon, another
> > > one is iio. So it is all not that consistent.
> > >     
> > 
> > That doesn't mean what exists is consistent or even makes sense. Some driver support
> > for chips intended for reporting the environment or chip temperature are pushed into iio.  
> 
> There might be some that have slipped through but when it's monitoring specific chip
> as opposed to part of of a SoC ADC where some channels are for monitoring and others
> very much not (e.g. the touchscreen ADC channels), I do direct people to provide
> reasons and +CC hwmon. There are a few odd corner cases where we had a driver for
> a mems device or similar that doesn't fit in hwmon come along and there is a
> variant of that silicon that only has the temp part enabled.
> 
> Without specific part numbers I don't know why it happened here.
> 
HIH6130 (humidity + temperature via hwmon) vs bme280
(humidity + temperature + pressure via iio).

So maybe the very basic thing: What does "monitor" mean in this context?
Checking the state of the hardware (what temperature) to take
safety/emergency measures or to tune things to work optimally at the given
conditions? 

But when monitoring is about the health of the system... well in
a drone e.g. probably everything which can be iio can be considered part of the
system health and like the temperature, things can be controlled by some actors.

Well as long as I do not need anything specific to one or the other api, I can
live with things. I am a bit curious about the background.

Regards,
Andreas


