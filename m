Return-Path: <linux-iio+bounces-16992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77521A65D48
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 19:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED0A17361E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351361DDC15;
	Mon, 17 Mar 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVM559R2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DE143748;
	Mon, 17 Mar 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237516; cv=none; b=pZK7YU4y2ez52/hDOb3J/JKIrFtJG57GVhKyS9/fpPMVm09UA0yzpA8WNvVMB4AX0pax4pASQBDiQaeWaXKByMPD4hRDLhnVPWbveJbucqtKe7rbQYGqMvGP6EMnNtJ8WChqQo7SViWwbuTB22Qa9OYE+K026TRsHGLV3yVaRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237516; c=relaxed/simple;
	bh=zIs0Y0BVAU9E77z/Zzluoby72K6idCnOcy81f26DbrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjCiQe17wVHnGdZfnZiT8OzQYeA0OMt6LhbS4wDCJp8e92um8+MDW8Xxe32v2JG6Rak4Zqzy46/diknznbPqyFBH+bKb1jcYcAxzRQ1aCE7YBQkdiVm2RTLZdW1KkHkPRgpFAQBa/UHngw66xjnhK3IrkbJ7/KEdSL0cQxVq1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVM559R2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8611C4CEE3;
	Mon, 17 Mar 2025 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237513;
	bh=zIs0Y0BVAU9E77z/Zzluoby72K6idCnOcy81f26DbrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVM559R2kPO3CO1hH+pgQNvu5hEbnw4/r9xTQr2jmWwM1Po/1nthbIAlZL8eNhhNt
	 EFeoLu3jachtwwWZd5pDI/ry4RP5BUzRZrojRIMjs0TSN+7vZVb2kMj0AO6gXWJ1i8
	 tWpNw3nSA5UF1kHJ7Qvnils2vGCBiTLxX134/BAUCIu48gXjOEf+HCOTTqizi8yAbO
	 yq/s2w2c9wSoUC9OrNkm7EeXMlz3qno06xEbKcjjOjr/8G2Hibu9aoJdoFkSq77VkI
	 dM8pxb787jkAYJPm6u/3gJZQyzwGwgmaAyshaKEfvSgTY4PkxtAz9XFnBbZvjlLMq8
	 zONQlopE7k/3g==
Date: Mon, 17 Mar 2025 18:51:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, corbet@lwn.net
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <20250317185144.68dd564e@jic23-huawei>
In-Reply-To: <Z9haCda4yF2SZ6gb@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
	<301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>
	<20250317102751.5702fb82@jic23-huawei>
	<Z9hAUs1wPOIAo2nt@debian-BULLSEYE-live-builder-AMD64>
	<60831e04-52c2-446f-8bc5-b5d3e9e5fd40@baylibre.com>
	<Z9haCda4yF2SZ6gb@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 14:21:13 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi, comments inline.
> 
> On 03/17, David Lechner wrote:
> > On 3/17/25 10:31 AM, Marcelo Schmitt wrote:
> > 
> >   
> > > ...  
> > >>> +/*
> > >>> + * This executes a data sample transfer when using SPI offloading for when the
> > >>> + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
> > >>> + * tree property is set to "high". In this connection mode, the ADC SDI pin is
> > >>> + * connected to VIO and ADC CNV pin is connected to a SPI controller CS (it
> > >>> + * can't be connected to a GPIO).
> > >>> + *
> > >>> + * In order to achieve the maximum sample rate, we only do one transfer per
> > >>> + * SPI offload trigger. This has the effect that the first sample data is not
> > >>> + * valid because it is reading the previous conversion result. We also use  
> > >>
> > >> Say what happens to that invalid sample.  Is it dropped or provided to userspace
> > >> as if it were valid?  (I hope dropped!)  
> > > 
> > > TL;DR: The invalid sample goes into the buffer as a valid one.
> > > 
> > > In AD4000 '3-wire' mode, data capture has a latency (delay) of one sample.
> > > 
> > > The ADC begins sampling data N at CNV rising edge
> > >           |   +-- CNV (usually SPI CS) is brought low to begin reading the data
> > >           |   |                                +-- Data N + 1 that will be read
> > >           |   |                                |   on the next transfer starts 
> > >           v   v                                v   being sampled at end of transfer N.
> > >            ___                                  ____            
> > > CNV  _____/   \________________________________/    \_____
> > >                     _     _             _
> > > SCLK ______________/ \___/ \_ ...   ___/ \_______________
> > >                    ___   ___           ___
> > > SDO  _____________/___\_/___\ ...   __/___\_______________
> > >                     ^
> > >                     |
> > >              Data from conversion N is output from here on
> > > 
> > > A better drawing can be found in datasheet page 29, Figure 57.
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/ADAQ4003.pdf
> > > 
> > > In sum, we're always reading a conversion that started at the end of the
> > > previous SPI transfer or, in other words, the data comes out with a latency
> > > (delay) of one read.
> > > 
> > > Datasheet somehow mentions that by saying
> > > 	When turbo mode is enabled, the conversion result read on SDO corresponds to
> > > 	the result of the previous conversion.
> > > 
> > > I think I can do a dummy SPI transfer on buffer preenable so at least the
> > > first data is not invalid. Would that be better?  
> > 
> > Not really. There will be a relatively long delay between that conversion
> > trigger and when the sample is read. So the data might be slightly less stale
> > in that case, but still not particularly useful, e.g. if you are doing any
> > kind of signal processing that expects equal time between all samples.
> > 
> > On similar chips, like ad7944, we just documented that the first sample does
> > not contain valid data and needs to be discarded.
> >   
> Okay, I'll assume that to be acceptable and do the same for this one.

Hmm. Doesn't really pass the useability 'smell' test but I guess
if there is precedence and clear docs it should be fine.

> 
> ...
> 
> > > I also didn't expect to find out HDL support for 16-bit data width was removed.
> > > We used to have a build parameter for 16-bit precision ADCs.
> > > https://github.com/analogdevicesinc/hdl/commit/b2dc91b30dae891b6319d88e083f26e726f43ba0#diff-1117c2618353232e5f22aa6a12e8ae976757fa897b3425f470a12123cae26535L13  
> > 
> > A while back the HDL engineers mentioned to us that they wanted to standardize
> > on 32-bit data words everywhere. While not the most efficient use of memory,
> > having fewer options does make things simpler across the entire software stack.
> >   
> Ack
> 
> > > 
> > > Would something like 'because SPI offloading leads to data being pushed to
> > > memory in CPU endianness' be a reasonable comment?  
> > 
> > Another way to say it is that SPI offload reads data in complete words and not
> > in separate 8-bit xfers (bits_per_word = realbits vs. bits_per_word = 8).
> >   
> Ah sure, I recall the effect of setting .bits_per_word now.
> Will add a comment explaining why the difference in endianness.

Great

> 
> Thanks,
> Marcelo


