Return-Path: <linux-iio+bounces-22117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218BEB14476
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 00:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C98717B648
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891FC23496F;
	Mon, 28 Jul 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fzGslW6k"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FD41C69;
	Mon, 28 Jul 2025 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742681; cv=none; b=ipdbr29aUub+MW+vSofyILHHXME4JRtrGGZXEbrDtbYr/4czZLv0zvmxHMgEqjRrRyftXYrgoY1DDOQgJIMRCDS+MEGhI5ocYq9aDtyOd7PVDW6VdBV0220Ryqx/jQlE/rMf8S3qUk65DybK5HxzugDo9kouC47gjtkaqP+x8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742681; c=relaxed/simple;
	bh=Ky/PMGLyUDQZC9gL7CyrG5pqZrnrhZeqsFDICY7TrN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r++oQnDIaZpN0znJKXP7bmfBzk5C8d+N3Dm0C8qVgU1BmwLCh+6uFTzRLSchajUJf6WcpQpC6ZH8BrZ7XoQWYf3dinx6h2V8WpJdadMDjIEW7zQvJS4PKQLzoeu+DTcmO2p+UvvTMmnmkjJpSwIh72a75T62BnK9KEk6/c6AujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fzGslW6k; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ccf7735-6a2c-473a-ab67-ae0c5ff9a335@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753742675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5/0co1W+cu2shaBxXBw2d5dMLF1j3owv/slrDbSyAk=;
	b=fzGslW6kZZkYeu4/WJy+c5tm8uXUHreJ17xnA4jnLRtASHmQk+lzNA/LsSevM76wH9Qxii
	0OL0tyBHi9z04+P2gJ1q0SkKib7Eb2zdOFnQGgoV0u/zf7gkLeW21YjueCgdiSz56o0dTs
	btnPKWyjyrT6QbnX1FYvmoAG8/Ug1eo=
Date: Mon, 28 Jul 2025 18:44:30 -0400
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250727172126.35d0a477@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/27/25 12:21, Jonathan Cameron wrote:
> On Tue, 15 Jul 2025 12:52:19 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> On 7/15/25 07:09, Nuno Sá wrote:
>> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:  
>> >> Add an API to notify consumers about events. Events still need to be
>> >> enabled using the iio_read_event/iio_write_event functions. Of course,
>> >> userspace can also manipulate the enabled events. I don't think this is
>> >> too much of an issue, since userspace can also manipulate the event
>> >> thresholds. But enabling events may cause existing programs to be
>> >> surprised when they get something unexpected. Maybe we should set the
>> >> interface as busy when there are any in-kernel listeners?
>> >>   
>> > 
>> > Sensible question. I'm not that familiar with events but I suspect is not
>> > trivial (if doable) to do a similar approach as with buffers? With buffers, an
>> > inkernal consumer get's it's own buffer object (that goes into a list of active
>> > buffers in the iio device) with all channels enabled and then we demux the
>> > appropriate channels for each consumer.  
>> 
>> For in-kernel consumers I think it's reasonable to expect them to handle
>> events they didn't explicitly enable. I'm not sure about userspace
>> consumers.
> 
> This already happens because we don't have a demux equivalent (what we do
> for buffered data flow) so if a device only has a single enable bit that covers
> multiple events (annoyingly common for accelerometers for example) then
> userspace will get events it didn't ask for.   We 'could' fix that,
> but it's never really been worth the effort.
> 
> Events tend to be low data rate so an occasionally extra is rather different
> to having to have much larger data buffers to handle a range of channels you
> never asked for.
> 
> Lets be careful to document this behaviour as 'may enable extra events'
> as then if we decide later to do demux type stuff we won't be breaking ABI.
> No one will mind getting fewer spurious events due to a core improvement.

Where would this get documented?

>> 
>> > Independent of the above, we can argue that having both inkernel and userspace
>> > changing thresholds is ok (I mean, there's nothing stopping two userspace apps
>> > doing that) but we should likely be careful with enabling/disabling. If multiple
>> > consumers enable the same event, one of them disabling it should not disable it
>> > for all the consumers, right?  
>> 
>> Right now the HWMON consumer never permanently disable events to avoid this
>> issue. It does toggle the enable to determine if an alarm should stay
>> enabled:
>>              ________
>> condition __/        \________
>>           _____    ____    ___
>> enable         \__/    \__/
>> 
>> event       |     |
>>              __    ____
>> alarm     __/  \__/    \_____
>> 
>> read           1       1    0
>> 
>> I suppose this could also be done by comparing the raw threshold to the
>> channel.
> 
> I wonder if we should add the option to do a 'get_exclusive' or similar
> to block the IIO user interfaces if something critical is using the device.
> 
> If we were for instance to use this to block the IOCTL to get the events
> fd then any built in driver etc will almost certainly load before anyone
> can call the ioctl so it will fairly cleanly block things.

This is how it currently works for userspace. Only one process can create
the event fd, and everyone else gets -EBUSY.

Of course, it would be pretty surprising to have an IIO device where
some channels were used by userspace and others were used by hwmon and
then have your daemon stop working after you update your kernel because
now the hwmon driver takes exclusive event access.

I originally had kernel users read from the kfifo just like userspace,
but I was concerned about the above scenario.

--Sean

