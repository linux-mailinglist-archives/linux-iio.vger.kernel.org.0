Return-Path: <linux-iio+bounces-22140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78EB15414
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 22:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F9818A73AE
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DBB2BDC2B;
	Tue, 29 Jul 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uChDz+94"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9B2BDC0F
	for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819787; cv=none; b=JjPwdsBZb6oxMfulTMJpT50ludcnuD5+oNATzhHuRWgSU2qDR1GHeC6jvuqLxPGRS0KXjbx8b5fu3FrIEPyUh2dAjNRegnnNUyaMIyZ/QKsP19tvJ0hXS7dY1ATqs02/Djz2KG63D1qg8tgf+SCMy0TheidFYlQ1qmTiwWac5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819787; c=relaxed/simple;
	bh=WLDylOIV5DSMc4Htd6swaNHV52iheLDXvOXUuB1Dke0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKn1RbuUDlSHRLL4hrdcAS8ph6fS8TNaKDLikS8Imz57gwLNwozmvBIj6Livo645LIYRa1IzpSKzwVDFPGiWSCwobpPXW5a66ukvylOsMMJ3YDFjiMgrLr+KmtU/n2b/5rZtx4MZ01jfjydACvc8Gh8NOthaGemYGGVrf/znOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uChDz+94; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <edb59657-ced2-4557-afe5-07bd83af848e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753819783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4G9jfzRkCbi/mdO+Af4USWQef/YfKBzN+BkPPWWEt4=;
	b=uChDz+94+uHWqCtw9dDp1C8OkiF0RiZYFpLz2gaeoz1TgXkBVWUnJLeu1RXKRUMWBNyLCp
	9LnM4w2SUCCPDoI9e5/7fvCC2if1a8o/m7eOaTG1Ao0KV6eD0m6f1yJXWae3uOyn6b3xZM
	zQOwq4U1JpVYd1jHlpjwv4F/DsGxYrg=
Date: Tue, 29 Jul 2025 16:09:20 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-4-sean.anderson@linux.dev>
 <d8e5c8fbeaee42e9e0708460c47bd68053cd8710.camel@gmail.com>
 <9b187e7f-a116-4aea-a9a6-b9222562868d@linux.dev>
 <20250727172126.35d0a477@jic23-huawei>
 <0ccf7735-6a2c-473a-ab67-ae0c5ff9a335@linux.dev>
 <20250729193346.39791223@jic23-huawei>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250729193346.39791223@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 14:33, Jonathan Cameron wrote:
> On Mon, 28 Jul 2025 18:44:30 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> On 7/27/25 12:21, Jonathan Cameron wrote:
>> > On Tue, 15 Jul 2025 12:52:19 -0400
>> > Sean Anderson <sean.anderson@linux.dev> wrote:
>> >   
>> >> On 7/15/25 07:09, Nuno Sá wrote:  
>> >> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:    
>> >> >> Add an API to notify consumers about events. Events still need to be
>> >> >> enabled using the iio_read_event/iio_write_event functions. Of course,
>> >> >> userspace can also manipulate the enabled events. I don't think this is
>> >> >> too much of an issue, since userspace can also manipulate the event
>> >> >> thresholds. But enabling events may cause existing programs to be
>> >> >> surprised when they get something unexpected. Maybe we should set the
>> >> >> interface as busy when there are any in-kernel listeners?
>> >> >>     
>> >> > 
>> >> > Sensible question. I'm not that familiar with events but I suspect is not
>> >> > trivial (if doable) to do a similar approach as with buffers? With buffers, an
>> >> > inkernal consumer get's it's own buffer object (that goes into a list of active
>> >> > buffers in the iio device) with all channels enabled and then we demux the
>> >> > appropriate channels for each consumer.    
>> >> 
>> >> For in-kernel consumers I think it's reasonable to expect them to handle
>> >> events they didn't explicitly enable. I'm not sure about userspace
>> >> consumers.  
>> > 
>> > This already happens because we don't have a demux equivalent (what we do
>> > for buffered data flow) so if a device only has a single enable bit that covers
>> > multiple events (annoyingly common for accelerometers for example) then
>> > userspace will get events it didn't ask for.   We 'could' fix that,
>> > but it's never really been worth the effort.
>> > 
>> > Events tend to be low data rate so an occasionally extra is rather different
>> > to having to have much larger data buffers to handle a range of channels you
>> > never asked for.
>> > 
>> > Lets be careful to document this behaviour as 'may enable extra events'
>> > as then if we decide later to do demux type stuff we won't be breaking ABI.
>> > No one will mind getting fewer spurious events due to a core improvement.  
>> 
>> Where would this get documented?
> 
> Starting point will be in the docs for the ABI that asks for any events at all.
> 
> Also useful to add some thing to Documentation/IIO though there are lots of
> other things those docs don't yet cover :(

Notably the whole events API :l

>> 
>> >>   
>> >> > Independent of the above, we can argue that having both inkernel and userspace
>> >> > changing thresholds is ok (I mean, there's nothing stopping two userspace apps
>> >> > doing that) but we should likely be careful with enabling/disabling. If multiple
>> >> > consumers enable the same event, one of them disabling it should not disable it
>> >> > for all the consumers, right?    
>> >> 
>> >> Right now the HWMON consumer never permanently disable events to avoid this
>> >> issue. It does toggle the enable to determine if an alarm should stay
>> >> enabled:
>> >>              ________
>> >> condition __/        \________
>> >>           _____    ____    ___
>> >> enable         \__/    \__/
>> >> 
>> >> event       |     |
>> >>              __    ____
>> >> alarm     __/  \__/    \_____
>> >> 
>> >> read           1       1    0
>> >> 
>> >> I suppose this could also be done by comparing the raw threshold to the
>> >> channel.  
>> > 
>> > I wonder if we should add the option to do a 'get_exclusive' or similar
>> > to block the IIO user interfaces if something critical is using the device.
>> > 
>> > If we were for instance to use this to block the IOCTL to get the events
>> > fd then any built in driver etc will almost certainly load before anyone
>> > can call the ioctl so it will fairly cleanly block things.  
>> 
>> This is how it currently works for userspace. Only one process can create
>> the event fd, and everyone else gets -EBUSY.
>> 
>> Of course, it would be pretty surprising to have an IIO device where
>> some channels were used by userspace and others were used by hwmon and
>> then have your daemon stop working after you update your kernel because
>> now the hwmon driver takes exclusive event access.
> 
> True.  I wonder how many boards we don't know about are using the iio-hwmon
> bridge. We can check the ones in kernel for whether they grab all the
> channels (which would rule this out).
>
> Another things we could do is have an opt in from the IIO driver.
> That way only 'new' drivers would have this behaviour.  Not nice though.

I would really like for this to "just work" if at all possible, so an
opt-out would be preferable. Maybe a hwmon module parameter.

But I think we can do better:

- Both kernel/userspace can/should handle unexpected events
  - This includes extra (synthetic) events.
- Both kernel/userspace mostly just want to enable events
- Disabling events is not as important because of the previous bullet.
- But losing events is probably bad so we want to ensure we trigger
  events at the same places they would have been triggered before.

So maybe we have an implementation where

- Enabling an event disables the backing event before re-enabling it if
  there are any existing users
- Disabling an event only disables the backing event if all users are
  gone

It could look something like

iio_sysfs_event_set(event, val):
    if val:
        if !event.user_enable
            disable(event)
        enable(event)
    else if !event.kernel_enables
        disable(event)
    event.user_enable = val

iio_inkern_event_set(event, val):
    if val:
        if event.kernel_enables++ || event.user_enable
            disable(event)
        enable(event)
    else if !--event.kernel_enables && !event.user_enable:
        disable(event)

--Sean

>> 
>> I originally had kernel users read from the kfifo just like userspace,
>> but I was concerned about the above scenario.
>> 
> 
> yeah, always a problem to retrofit policy.
> 
>> --Sean
>> 
> 

