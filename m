Return-Path: <linux-iio+bounces-10649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44999FE20
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E335F1C21C7F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC66F30C;
	Wed, 16 Oct 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="DGSncNb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuVTxnOj"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E6101C4;
	Wed, 16 Oct 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041631; cv=none; b=o4bRRPg6Opn+9hyVGh1kehiarWy0+qBC8c/LXG0hyMW5uCJOJFMIjNp9rvEHB4RkJGUuGI7R/LXkJZ3gXHTI/TQ5NU0sGD7d16RIw07FigZO11sidBelwuupJ2NQGky2IEU2MI0W2Qab3BZXyC8ZIY+idbPDzEeuvI87r+Eo1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041631; c=relaxed/simple;
	bh=Ex/EY6vOE5bNxPxknr1ZnHOBQoo0HrftMc/SeN6QmTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RDfng9SvJ8MoM0EowgAFxe+kVh8lBErWc7NmEkxEuxJ17eb3JC7WungLO8lWjNKpx+ZjmF8/8HXrdoKvxAHxicGBsfwfgiB4Lqm0mx53YE2bih9Vp3LnWlN8nTEferZX8ofJ4/6o51yUcOXFb/9RN7JUuzg664MCb+Gex4YB9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=DGSncNb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuVTxnOj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 912971140095;
	Tue, 15 Oct 2024 21:20:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 21:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729041626; x=
	1729128026; bh=t4XdgGozqx9hd+UL6A1KxRkRYUcyy2IjhsgnoLo+1og=; b=D
	GSncNb/DYgYqGGWpv6PWOLrn98acvMmwUBe1GVP023vpebdmHL0x/7ysBCzKN+hr
	drJ8lajD+t/WR8vKKbz74gCrdVqQ8erHoaTK0T+KupxxiUCj68hqE1H6xzH3+mPZ
	gbIf4/7BgqSsc2rAhp8Ze7SInRdG77JtswtsK/UMNJ00qX+t87pbAozlCI3NHOzf
	GutkvHm/BGjXp4eX101wGlwgrmIc7eU69WhsAuwpYaOK8jkYXPpxIUJJmH9otqAr
	V+czsBrG/jUw8/uupjDWfgxlnkwkTT5OXPNn0jH3+SCsgWWT1J88NKPge1C22z5r
	Z/aNQYPHYQTXYVjH6pgJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729041626; x=1729128026; bh=t4XdgGozqx9hd+UL6A1KxRkRYUcy
	y2IjhsgnoLo+1og=; b=IuVTxnOjXlHRhxuF899BwzHAkuFk7Dw7a6VueVuWCwN9
	nKTanmVCZzs5c3RusDy7ieOUzu5l0xunRg/0Q9M4E/rL/+g2mouigddDpCHIkdXe
	gjquPqDNE3Wsup8I8U3fN6T5+5/tdOwhkpgdDSmplHqTgAp+zv9vCHgJL1JfjOTa
	yr+XLrRDXHySoQVAqTaft4Wl/HaJ/ffu5PoJhcaAmiTLEWEbjYy4BEpkre9wt6BD
	X40avqeABY7CGldO4koS/b4jC6nJpvIGW7MdxgJzaAUmLYJDCpeE+D6MpIgSxiYb
	XzIk14anje18kcaqBsIu9WORb5rHnv7XBfYCt7GQlw==
X-ME-Sender: <xms:2hQPZzv-Vlw_XfdL-7yVvLxQxbatqFmjLD8rQc1U6uLweQXvXDgrDw>
    <xme:2hQPZ0ddzUleX-jLpyVkdREvYPWWljhNt7Sp2EJoxZs4hWaVOIX1VA3QnowupEqbz
    FEVqi0TRNH_kgqFzQ>
X-ME-Received: <xmr:2hQPZ2zZEnWxuvLk5V8O2owfCihbSNq9I9bsfIAauGkikpEHpkPlAHoP8TbQbzU4iyZQhycTz9_oeRt6JoxpJhB8HdeHD9GZ48E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpefgueegueeiheffkeektdetfffgffeu
    ieekvdefieejvdefiefgvefhiefhfefgveenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhlmhesmhgrnhhjrghrohdrohhrghdprhgtphhtthhopeguvghrvghkjhhohhhnrdgt
    lhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhiohesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdrug
    gvpdhrtghpthhtoheplhgrnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2hQPZyMH0SQFVGQN_bpqw38gcWtExDyaNHcxZs8tnFnE9mj3Q09SKQ>
    <xmx:2hQPZz9A8aMsMXN_ArRSP4tGoa5BkBu99g52PwsAVw2oB-v5FHM3LQ>
    <xmx:2hQPZyWRa-qezWgzr7VyuUp7Tm_mbCvqu2oNkcN12ED9Rk5Vfep3ZA>
    <xmx:2hQPZ0ec7crkCEq94pU4uUWageqAckEqmiIZy5tvfx7UXlHQGAWLsQ>
    <xmx:2hQPZ0PHdC5AaWDiYzUF0uDZdrFB3_pGYDmOvtPJKAr3kWESz8Zx9N3Z>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 21:20:25 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 3/3] iio: imu: Add scale and sampling frequency to
 BMI270 IMU
In-Reply-To: <20241014201124.5621c4aa@jic23-huawei> (Jonathan Cameron's
	message of "Mon, 14 Oct 2024 20:11:24 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-4-justin@justinweiss.com>
	<20241012123535.1abe63bd@jic23-huawei> <87jzecpvpd.fsf@justinweiss.com>
	<20241013164000.19087833@jic23-huawei> <87ttdfn2nr.fsf@justinweiss.com>
	<20241014201124.5621c4aa@jic23-huawei>
Date: Tue, 15 Oct 2024 18:20:24 -0700
Message-ID: <877ca8alnr.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Sun, 13 Oct 2024 13:55:36 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Jonathan Cameron <jic23@kernel.org> writes:
>> 
>> > On Sat, 12 Oct 2024 19:45:18 -0700
>> > Justin Weiss <justin@justinweiss.com> wrote:
>> >  
>> >> Jonathan Cameron <jic23@kernel.org> writes:
>> >>   
>> >> > On Fri, 11 Oct 2024 08:37:49 -0700
>> >> > Justin Weiss <justin@justinweiss.com> wrote:
>> >> >    
>> >> >> Add read and write functions and create _available entries. Use
>> >> >> IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
>> >> >> the BMI160 / BMI323 drivers.    
>> >> >
>> >> > Ah.  Please break dropping _FREQUENCY change out as a separate fix
>> >> > with fixes tag etc and drag it to start of the patch. It was never
>> >> > wired to anything anyway
>> >> >
>> >> > That's a straight forward ABI bug so we want that to land ahead
>> >> > of the rest of the series.    
>> >> 
>> >> Thanks, I'll pull that into its own change and make it the first patch.
>> >>   
>> >> > Does this device have a data ready interrupt and if so what affect
>> >> > do the different ODRs for each type of sensor have on that?
>> >> > If there are separate data ready signals, you probably want to 
>> >> > go with a dual buffer setup from the start as it is hard to unwind
>> >> > that later.    
>> >> 
>> >> It has data ready interrupts for both accelerometer and gyroscope and a
>> >> FIFO interrupt. I had held off on interrupts to keep this change
>> >> simpler, but if it's a better idea to get it in earlier, I can add it
>> >> alongside the triggered buffer change.  
>> >
>> > Ok. So the challenge is that IIO buffers are only described by external
>> > metadata.  We don't carry tags within them.  Hence if you are using
>> > either effectively separate datastreams (the two data ready interrupts)
>> > or a fifo that is tagged data (how this difference of speed is normally handled
>> > if it's one buffer) then when we push them into IIO buffers, they have
>> > to go into separate buffers.
>> >
>> > In older drivers this was done via the heavy weight option of registering
>> > two separate IIO devices. Today we have the ability to support multiple buffers
>> > in one driver. I'm not sure we've yet used it for this case, so I think
>> > there may still be some gaps around triggering that will matter for the
>> > separate dataready interrupt case (fifo is fine as no trigger involved).
>> > Looking again at that code, it looks like there may need to be quite
>> > a bit more work to cover this case proeprly.
>> >
>> > We may be able to have a migration path from the simple case you have
>> > (where timing is an external trigger) to multiple buffers.
>> > It would involve:
>> > 1) Initial solution where the frequencies must match if the fifo is in use.
>> >    Non fifo trigger from data ready might work but we'd need to figure out
>> >    if they run in close enough timing.
>> > 2) Solution where we add a second buffer and if the channels are enabled
>> >    in that we can allow separate timing for the two sensor types.
>> >
>> > This is one of those hardware features that seems like a good idea
>> > from the hardware design point of view but assumes a very specific
>> > sort of software model :(
>> >
>> > Jonathan  
>> 
>> Hm, that does sound tricky. If there's an example I can follow, I can
>> make an attempt at it.
>
> I don't think it ever got used for a device like this - so probably no
> examples, but I might have forgotten one. (this was a few years back).
>
>> Otherwise, if there's a change I can make now
>> that would help with migrating in the future, I can do that instead.
>> 
>> Of the devices I've looked at, only one has had the interrupts usable
>> and that one only had a single pin available.
> Lovely!  
>
>> So if this change doesn't
>> make it harder to add later if it's necessary, I would still be OK going
>> without full support for now.
> I stopped being lazy and opened the datasheet.
>
> Hmm. We have auxiliary channels as well.  oh goody.
> Considering just the fifo as that's the high performance route.
>
> Basically we can do headerless mode trivially as that's just one buffer.
> (same ODR for all sensors).
> We could do headered version but without messing with multiple buffers
> that would be only when all sensors have same ODR (after a messy
> transition period perhaps - that bit of the datasheet is less than
> intuitive!) The reason we might do headered mode is to support the
> timestamps but we can probably get those via a quick read of other
> registers after draining the fifo.

OK, that sounds good. It looks like the BMI323 driver approximates
timestamps by slicing up the time period between the last flush and the
current flush. It seems like that could also work.

If I understand it right, the simple way forward would be to use only
the fifo watermark interrupt, to set the fifo to headerless mode, and
only allow that buffer to be enabled when the ODR is the same between
the accel and gyro sensors.

Since that sounds like a fairly independent change, I can hold it for a
future patch, unless you think it belongs in this set.

Thank you for the rest of the feedback and advice, I really appreciate
it. I think I have enough for another revision soon.

Justin

> So I'm fine with just not supporting the weird corner cases unless
> we get someone turning up who
> a) cares
> b) if foolish (or motivated) enough to do the necessary work 
> c) (if they are lucky) we have the infrastructure in place because someone
>    else needed the missing bits.
>
> Jonathan
>
>
>> 
>> Justin

