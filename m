Return-Path: <linux-iio+bounces-7992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B093E5BE
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6022C2816D4
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635A750A80;
	Sun, 28 Jul 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9qATkSA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611F224DC;
	Sun, 28 Jul 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722179055; cv=none; b=YLz9sWKQJpnNq9pho3Xd/7YVqg0TBL3bJOKo/cXdZpBM+ZbFU3dUFjxZDo82o95DBAd95dS0aVibP78QgFF7Jd50dXKuDWEB/vzy9oDQbH5TC01BOUsCICqOZm9MQapOLho0o/aWBIjq0OSxkODmmdNzDfPy4DYmk6rCJRh9GC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722179055; c=relaxed/simple;
	bh=LQuwMxDMSVgbGcQjkAKcK62fjlXDEdSv12wT7+vEBHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nr0aO+uNl19cvdAz2L1TbF1tDAsQ3A/YpzdMtdJo4R1VjE3Qm67x+gD81V0p5n8H2Mjt23IgndEad96d7MORgQhVgwuN/a8Ma2ulimVcSeJH4c0xqX8WYE5JjjZzCA+5rYc1Sr9eTA3BrmthUrC+lCpB2mus6fCQ9Lcma8jrB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9qATkSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791DCC116B1;
	Sun, 28 Jul 2024 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722179054;
	bh=LQuwMxDMSVgbGcQjkAKcK62fjlXDEdSv12wT7+vEBHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9qATkSAiIco0e0sDhKReqYNu17mQRSCxHFLp4vIXgoRNlVQKs0+KFyuRg1Q0/2JT
	 CWb5nHjQdfU/D/EeSHAwoc+lhYj2t3FOIz+vC8WsB+QmjjwKo6uymkCxdq3aLGCEKH
	 x34M4h9PU9uNO8XHNzaxWWdaH38jeIIJLI6e81iMd4pAznqosJfiJhEU5OtyllndXu
	 nLzb4cs0uDPwihlKGaZyq+KGrJrteZcMNbl532B8eplmJ8QfbEeeMO5WBvgY4iyKUv
	 Gxcwrk3A05LGOcrI1e7SIIPuFzArUG16iZqfuLpaLSrxi3ubF4IgBB400Th9CHkwfX
	 /bySskCnFVwow==
Date: Sun, 28 Jul 2024 16:04:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Esteban Blanc" <eblanc@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
 <baylibre-upstreaming@groups.io>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Nuno Sa" <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240728160408.4b810505@jic23-huawei>
In-Reply-To: <D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
	<0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
	<D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

One quick comment form me inline.

The short version is non power of 2 storage is not an option because
it is a major ABI change and we aren't paying the cost of complexity
that brings to userspace for a very small number of drivers where
there is any real advantage to packing them tighter.

> 
> > So, from the datasheet, figure 39 we have something like a multiplexer where we
> > can have:
> >
> > - averaged data;
> > - normal differential;
> > - test pattern (btw, useful to have it in debugfs - but can come later);
> > - 8 common mode bits;
> >
> > While the average, normal and test pattern are really mutual exclusive, the
> > common mode voltage is different in the way that it's appended to differential
> > sample. Making it kind of an aggregated thingy. Thus I guess it can make sense
> > for us to see them as different channels from a SW perspective (even more since
> > gain and offset only apply to the differential data). But there are a couple of
> > things I don't like (have concerns):
> >
> > * You're pushing the CM channels into the end. So when we a 2 channel device
> > we'll have:
> >
> >  in_voltage0 - diff
> >  in_voltage1 - diff
> >  in_voltage2 - CM associated with chan0
> >  in_voltage0 - CM associated with chan1
> >
> > I think we could make it so the CM channel comes right after the channel where
> > it's data belongs too. So for example, odd channels would be CM channels (and
> > labels could also make sense).  
> 
> I must agree with you it would make more sense.
> 
> > Other thing that came to mind is if we could somehow use differential = true
> > here. Having something like:
> >
> > in_voltage1_in_voltage0_raw - diff data
> > ...
> > And the only thing for CM would be:
> >
> > in_voltage1_raw
> > in_voltage1_scale
> >
> > (not sure if the above is doable with ext_info - maybe only with device_attrs)
> >
> > The downside of the above is that we don't have a way to separate the scan
> > elements. Meaning that we don't have a way to specify the scan_type for both the
> > common mode and differential voltage. That said, I wonder if it is that useful
> > to buffer the common mode stuff? Alternatively, we could just have the scan_type
> > for the diff data and apps really wanting the CM voltage could still access the
> > raw data. Not pretty, I know...  
> 
> At the moment the way I "separate" them is by looking at the
> `active_scan_mask`. If the user asked for differential channel only, I put the
> chip in differential only mode. If all the channels are asked, I put
> the chip in differential + common mode. This way there is no need to
> separate anything in differential mode. See below for an example where
> this started.
> 
> > However, even if we go with the two separate channels there's one thing that
> > concerns me. Right now we have diff data with 32 for storage bits and CM data
> > with 8 storage bits which means the sample will be 40 bits and in reality we
> > just have 32. Sure, now we have SW buffering so we can make it work but the
> > ultimate goal is to support HW buffering where we won't be able to touch the
> > sample and thus we can't lie about the sample size. Could you run any test with
> > this approach on a HW buffer setup?   
> 
> Let's take AD4630-24 in diff+cm mode as an example. We would have 4 channels:
> - Ch0 diff with 24 bits of realbits and 24 bits of storagebits
> - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> - Ch1 diff with 24 bits of realbits and 24 bits of storagebits
> - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> ChX diff realbits + ChX cm realbits = 32 bits which is one sample as sent
> by the chip.
> 
> The problem I faced when trying to do this in this series is that IIO doesn't
> seem to like 24 storagebits and the data would get garbled. In diff only
> mode with the same channel setup (selecting only Ch0 diff and Ch1 diff)
> the data is also garbled. I used iio-oscilloscope software to test this setup.
> Here is the output with iio_readdev:
> ```
> # iio_readdev -s 1 ad4630-24 voltage0
> WARNING: High-speed mode not enabled
> Unable to refill buffer: Invalid argument (22)
> ```
> 
> I think this is happening when computing the padding to align ch1 diff.
> In `iio_compute_scan_bytes` this line `bytes = ALIGN(bytes, length);`
> will be invoked with bytes = 3 and length = 3 when selecting ch0 diff
> and ch1 diff (AD4630-24 in differential mode). The output is 5. As
> specified in linux/align.h:
> > @a is a power of 2  
> In our case `a` is `length`, and 3 is not a power of 2.
> 
> It works fine with Ch0/1 diff with 24 realbits and 32 storagebits with 8
> bits shift.
> 
> Intrestingly, a similar setup works great on AD4630-16:
> - Ch0 diff with 16 bits of realbits and 16 bits of storagebits
> - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> - Ch1 diff with 16 bits of realbits and 16 bits of storagebits
> - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> 
> In `iio_compute_scan_bytes` we will have ALIGN(3, 2) which will output
> 4, everything is fine. The output of iio-oscilloscope is as expected,
> a clean sinewave and iio_readdev does not throw an error.
> 
> All this to say that at the moment, I'm not sure how I will be able to
> put the CM byte in a separate channel for AD4630-24 without buffering it.
> It would be useful to return a "packed" buffer.

Whilst it might be useful to allow non power of 2 storage formats,
that's a break of the IIO userspace ABI so that isn't an approach to
consider. You must shuffle the data in the driver.

