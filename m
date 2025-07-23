Return-Path: <linux-iio+bounces-21923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6030B0F785
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BB81C80791
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8E1E3DD7;
	Wed, 23 Jul 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO0pS5qq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10678F4F;
	Wed, 23 Jul 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286183; cv=none; b=KYTxjb78pnLSy9qkmlEWVsUzMX/HUIz0ZeuSjL5f8jLAzi0q6zSBXzduFIgOsTjlXAYU5pwvQCYG3urR/MTTnybq/D9prutzFTyGbl9BwQ7lJeH/aOb9eobSG9iVV3rIxQfLwMBJ1Dh+AYbRyMv4guCqreD9otnTl1Ak9SFyCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286183; c=relaxed/simple;
	bh=EN9+m3bH+TJpgrCM7uWfTcM91Em9VgRtsgV5GqA5fd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqHynS1aDq55bKvlZkOIn7pydqjflXxyypgyyuullEXq0ef/3nR6M80n2LEzShI3XG9NYguMMDd50MhAI9glyPO1RKoB38loBq/1BvQRMt2OqNtPJhdqKIYFWV/2D9A7fKYUj8rRE0JXVp37Y1dMzskdP73I5927rFt2YaskOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO0pS5qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC551C4CEE7;
	Wed, 23 Jul 2025 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286183;
	bh=EN9+m3bH+TJpgrCM7uWfTcM91Em9VgRtsgV5GqA5fd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VO0pS5qqAgPXx/o6Dbu03y1edTLCWVAh7/ig9hegmLZdW0EOucz+0u2C1vPTkAH7T
	 l92gy6ZShIsxyeVvSdQoOVZ23dr5F/avulMGaQB5mBGMkDsQZ2ntwEJE4KGeneavDU
	 Fh6QdwHl3Az7F06SbFSUO7lb8mdigE8EvftzQJOI8bCdhkFPtEof4JJJ4ofyasSEYb
	 iH8uYrO9XFgXB+mWW0dzILZQu7QZOwUTuLy/ZCXQToFgZ+xTUZN3XY8K0Q7Fppw16D
	 E9bhruIy7uHq/ZLv8vRhADQUKNJTJPOWRkJ5pIqSjIyT43xA6OwGj/2bXok63CYAxr
	 8e0XObngroXEQ==
Date: Wed, 23 Jul 2025 16:56:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Yasin Lee
 <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
Message-ID: <20250723165615.67969881@jic23-huawei>
In-Reply-To: <f74d6542-cc4e-40dd-8ef9-2a766d0b51ef@baylibre.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
	<823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
	<aIDuEcHhaGtz2klP@smile.fi.intel.com>
	<795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
	<aIDzvNYIaJnSuzOa@smile.fi.intel.com>
	<7ca7e0b9-a77d-4de8-92b1-fea3250e8155@baylibre.com>
	<aID6jfjULn2kvvQJ@smile.fi.intel.com>
	<f74d6542-cc4e-40dd-8ef9-2a766d0b51ef@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:11:50 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/23/25 10:06 AM, Andy Shevchenko wrote:
> > On Wed, Jul 23, 2025 at 09:57:58AM -0500, David Lechner wrote:  
> >> On 7/23/25 9:37 AM, Andy Shevchenko wrote:  
> >>> On Wed, Jul 23, 2025 at 09:29:37AM -0500, David Lechner wrote:  
> >>>> On 7/23/25 9:13 AM, Andy Shevchenko wrote:  
> >>>>> On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:  
> >>>>>> On 7/22/25 6:07 PM, David Lechner wrote:  
> >>>>>>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
> >>>>>>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
> >>>>>>> the data before pushing it to the IIO buffer.  
> >>>>>  
> >>>>>> It is odd to have data already in CPU-endian and convert it to LE
> >>>>>> before pushing to buffers. So I'm a bit tempted to do this instead
> >>>>>> since it probably isn't likely anyone is using this on a big-endian
> >>>>>> system:  
> >>>>>
> >>>>> I can say that first of all, we need to consult with the datasheet for the
> >>>>> actual HW endianess. And second, I do not believe that CPU endianess may be
> >>>>> used,   
> >>>>
> >>>> Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.
> >>>>  
> >>>>> I can't imagine when this (discrete?) component can be integrated in such
> >>>>> a way. That said, I think your second approach even worse.  
> >>>>
> >>>> hx9023s_sample() is calling get_unaligned_le16() on all of the data
> >>>> read over the bus, so in the driver, all data is stored CPU-endian
> >>>> already rather than passing actual raw bus data to the buffer.  
> >>>
> >>> I see, now it makes a lot of sense. Thanks for clarifying this to me.
> >>>  
> >>>> So it seems a waste of CPU cycles to convert it back to little-endian
> >>>> to push to the buffer only for consumers to have to convert it back
> >>>> to CPU-endian again. But since most systems are little-endian already
> >>>> this doesn't really matter since no actual conversion is done in this
> >>>> case.  
> >>>
> >>> Right, but it's buggy on BE, isn't it?
> >>>  
> >>
> >> Right now, the driver is buggy everywhere. The scan info says that the
> >> scan data is BE, but in reality, it is LE (no matter the CPU-endianness).
> >>
> >> With the simple patch, it fixes the scan info to reflect reality that
> >> the data is LE in the buffer. This works on BE systems. They just have
> >> an extra conversion from BE to LE in the kernel when pushing to the
> >> buffer and userspace would have to convert back to BE to do math on it.
> >>
> >> With the alternate patch you didn't like, the forced conversion to LE
> >> when pushing to buffers is dropped, so nothing would change on LE
> >> systems but BE systems wouldn't have the extra order swapping.  
> > 
> > But do they need that? If you supply CPU order (and it is already in a such
> > after get_unaligned_*() calls) then everything would be good, no?
> >   
> 
> It doesn't make sense to my why, but the existing code is changing
> back to LE before pushing to buffers for some reason.
> 
> 
> 	iio_for_each_active_channel(indio_dev, bit) {
> 		index = indio_dev->channels[bit].channel;
> 		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
> 	}
> 
> 	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> 				    sizeof(data->buffer), pf->timestamp);
> 
> I agree that it seems unnecessary which is why I suggested the
> alternate patch to drop the cpu_to_le16() and just leave it
> CPU-endian when pushing to the buffers.
> 

This one was seriously odd and went though a lot of discussions around
endian conversions during review.  Definitely wait for Yasin to reply.

That's not to say I can recall how we ended up with the dance that
you are seeing now (and I'm too far behind on reviews to get to digging
through threads to refresh my memory).

Jonathan



