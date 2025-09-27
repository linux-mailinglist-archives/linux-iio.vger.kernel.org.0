Return-Path: <linux-iio+bounces-24510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFDEBA62A1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 20:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C9F16CD5A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA38226CF7;
	Sat, 27 Sep 2025 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W91OrnwI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81027125B2;
	Sat, 27 Sep 2025 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758998394; cv=none; b=tt5iZ9s0Ko2vzsYLFEG61w3idBOCR0enEr5v3HEeP943pTumRwfB0zan/sY4h9lof8OZB4jBfbWB+juY0ZdqYjErQ5xKAn+bzsj73NZsjDQZz6txPIdwI/KffMkIiOHhBj1aqfs2t4sPX9rvJHDilw3QPEUn2wbsKUTvEJ9oLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758998394; c=relaxed/simple;
	bh=OFYiSOw/Gfgr0DCpc3CpqcVoziWlnm2ezT1witONfFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EF2K/T3DPbEYsXAORq02FbThlb2D2khFXP5BBtjQKJYiVNvD8yKG0ubGDWF1zBfX7tb1XyD/BokqBaHKIewaCyN+VCEhAvypGpwLcTGoQmQN4GFJ8RyW5TWSjaLAde5WT6SNi1hAxk9pzhtlqnjG6cnYWyXq1UBwODfSNASltbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W91OrnwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98C3C4CEE7;
	Sat, 27 Sep 2025 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758998394;
	bh=OFYiSOw/Gfgr0DCpc3CpqcVoziWlnm2ezT1witONfFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W91OrnwIIQ/6SdcGFCI1/vfL5oABFijapNz4i+zpBW7OPI8KGSbGROpuLDmfPKrB9
	 2LmfuEJLkMRlsOhrc9smv5rCR/6qmpcGnW0fN52sIAqge+r5+7NhDYGn5dIg/uhdFB
	 SdrMCUL+clzJUKyJ4K895RXpkSYhelv+AJGKu0Rg3W7oACKGl/YGhJQD4LBVDg1cVV
	 Okn3bED/O8k1E3ujeAc5furOM1DIhaF8G6uxB0A2es7nSXQsUkf8n1dQ3RFdyJHGZd
	 FlBBp1qqfLGOLz3VcE2OBB1LLwm4XnYrVmo0SQnbrnHxoTQ9p7SENfF2H88rT7VKdh
	 0cC5nt/3ihSRA==
Date: Sat, 27 Sep 2025 19:39:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andreas Kemnade <andreas@kemnade.info>, Mark Brown <broonie@kernel.org>,
 jdelvare@suse.com, lgirdwood@gmail.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair@alistair23.me>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <20250927193945.787eb1a5@jic23-huawei>
In-Reply-To: <e6c8f022-ebfc-459c-806b-f75618f65916@roeck-us.net>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
	<20250924090023.282ae450@kemnade.info>
	<b68d40d9-6ea9-49a9-8a2e-8b899f33340d@roeck-us.net>
	<20250924195358.16bbd90c@kemnade.info>
	<e6c8f022-ebfc-459c-806b-f75618f65916@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 12:16:14 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/24/25 10:53, Andreas Kemnade wrote:
> > On Wed, 24 Sep 2025 00:17:48 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> >> On 9/24/25 00:00, Andreas Kemnade wrote:  
> >>> On Sat, 20 Sep 2025 23:18:59 +0100
> >>> Mark Brown <broonie@kernel.org> wrote:
> >>>      
> >>>> On Sat, Sep 20, 2025 at 11:33:07PM +0200, Andreas Kemnade wrote:
> >>>>     
> >>>>> Just for learning, yes, it is an abuse of the _optional for non-optional
> >>>>> things, so a dirty hack which should not go in, therefore RFC. But what
> >>>>> happens more than having the hwmon device endlessly deferred at worst?  
> >>>>
> >>>> There's also the fact that this API is so frequently abused for bad and
> >>>> broken reasons that I regularly audit users and try to fix them, I'd
> >>>> rather not see any new users that don't have a really strong reason to
> >>>> use it.
> >>>>     
> >>>>> The wanted regulator is the one defined in sy7636a-regulator.c. So it
> >>>>> is all an issue internal to the sy7636a.  
> >>>>     
> >>>>> Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
> >>>>> I see several other solutions:
> >>>>> a) call device_is_bound() on every other children of dev->parent, if not
> >>>>> bound defer.
> >>>>> b) do not care about the regulator api at all, just check whether
> >>>>>      the corresponding bit is set before reading temperature, return
> >>>>>      -ENODATA if not, some mutex is probably needed.
> >>>>> c) do not care about the regulator api at all, just set the
> >>>>>      corresponding bit (together with some mutex locking and counting).  
> >>>>
> >>>> I assume this is using the regulator API because someone might use an
> >>>> external regulator in a system design for some reason (better quality,
> >>>> power efficiency or a shared reference between multiple devices I
> >>>> guess?), or because the supply might also be used by external devices?
> >>>>     
> >>>>> d) copy the of_node pointer from the parent, add a regulator phandle property
> >>>>>      to the node pointing to the regulator in the node itself.
> >>>>>      That sounds like your idea but is against the current dt binding for
> >>>>>      this device and afaik it is uncommon to have mfd-internal things wired
> >>>>>      up this way
> >>>>>
> >>>>> e) something clean, simple I miss  
> >>>>
> >>>> The idea is that the relationship between the devices should be
> >>>> registered before the devices, that's how the regulator knows to defer.
> >>>> We used to have an API for doing this for board files which might fit
> >>>> here, but it got removed since nobody wants board files any more.  If
> >>>> you're allocating the devices dynamically that's annoying to implement
> >>>> though...  
> >>>
> >>> looking a bit around:
> >>> max5970-regulator.c has hwmon integrated and no extra device. That would
> >>> simplify things. Although it does not report temperature. Some
> >>> touchscreens have temperature via hwmon, some others have temperature
> >>> via iio, directly in one device without mfd. Maybe that is also
> >>> the better way here?
> >>>      
> >>
> >> Touchscreens reporting temperature via iio is in general the wrong thing to do.
> >> Touchscreens report the temperature for monitoring reasons, after all.
> >> But then, sure, if you insist. I am getting tired of arguing.
> >>  
> > I apparently did not make clear what my question refers to. It was more about separate
> > hwmon device + mfd vs. integrating everything into the regulator driver.
> >   
> 
> What I keep failing to understand is why people keep avoiding the potential of
> implementing auxiliary device drivers, since that would be the perfect solution
> and match the intended use case for auxiliary devices.
> 
> > But since you brought up the topic hwmon vs. iio for temperature. I do not have
> > a strong opinion here as long as I can somehow live with it. Nothing I want to
> > fight for. One sensor I use for measuring room temperature is hwmon, another
> > one is iio. So it is all not that consistent.
> >   
> 
> That doesn't mean what exists is consistent or even makes sense. Some driver support
> for chips intended for reporting the environment or chip temperature are pushed into iio.

There might be some that have slipped through but when it's monitoring specific chip
as opposed to part of of a SoC ADC where some channels are for monitoring and others
very much not (e.g. the touchscreen ADC channels), I do direct people to provide
reasons and +CC hwmon. There are a few odd corner cases where we had a driver for
a mems device or similar that doesn't fit in hwmon come along and there is a
variant of that silicon that only has the temp part enabled.

Without specific part numbers I don't know why it happened here.

We get a few drivers every year where I think it's just familiarity with IIO that
drove the initial submission and for those we push them to submit a hwmon driver instead
and I +CC the hwmon list on that suggestion.  Guenter frequently eyeballs the driver
and points that another driver can be trivially modified to support it.

Mind you I may well miss some :(


> I have no idea why that is the case. Yes, that results in odd situations like yours,
> but there is nothing I can do about it. I can only guess that _someone_ is pushing for
> submitting drivers into IIO instead of hwmon, but that is just a wild guess. You would
> have to ask the driver authors and/or IIO maintainers for reasons. I am copying the IIO
> mailing list for feedback.
> 
> Also, again, I am tired of arguing, so I typically don't even comment anymore (if I even
> notice) unless explicitly asked.
> 
> > But what is the hwmon equivalent for
> > devm_fwnode_iio_channel_get_by_name() + iio_read_channel_processed()?
> >   
> 
> Assuming you refer to the exported functions for in-kernel use, so far no one has
> expressed a need for it. The best solution would probably be a hwmon->iio bridge,
> or equivalent functions could be implemented and exported.
> 
> > I wonder whether I really need a thermal zone. It adds stuff not needed here,
> > trip points and polling.
> >   
> 
> The driver _registers_ a thermal zone, but that doesn't mean it has to be configured.
> If one is configured (typically via devicetree), it is obviously needed.
> 
> > Documentation/hwmon/sy7636a-hwmon.rst seems to be wrong. It is not
> > SoC-on-die temperature, but temperature from an external NTC. And
> > that is typically used to tune the EPD refresh to the temperature.  
> 
> Please feel free to submit a patch correcting the documentation.
> 
> Guenter
> 


