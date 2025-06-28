Return-Path: <linux-iio+bounces-21044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9940AEC857
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99851883055
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D020125F;
	Sat, 28 Jun 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/KUxi2D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC685661;
	Sat, 28 Jun 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124930; cv=none; b=TA63QpWuzAllVH/p4mcvWGa5ivU9REs3VHTxo/yJPPbZph495aDqnwqXjYNnC8CEtSGUR9HiTyH52KW8F9YxKrzr0sLLNHP/sq3xLo7Dcuh7fKYZIZlQOhw1lTZjjCVsjqv3PqCN2fKuiMq2QJFw5sIXZ4PHupilnyT/04ljQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124930; c=relaxed/simple;
	bh=1WWh3CzNqLLBw5WVI5LZj3HPj0OfYYihdha4Uh4arH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAcGcEq06eDeY+B1bWUP8WbRi2Qn7CQIn65qS66NNGZMd+umZgD+OQf40U04y2lTrYCZlCY0LPVNfGSOpWDrktdLkyJIctt85SZyRGvK2tqI8kw0YUIt8Cbq7hmNWT1kiO4KrFPlO6eGAZcl6tcBCXXZJIW16ETbWvdTFStHUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/KUxi2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E33CC4CEEA;
	Sat, 28 Jun 2025 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751124930;
	bh=1WWh3CzNqLLBw5WVI5LZj3HPj0OfYYihdha4Uh4arH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a/KUxi2DnO523t46iThYpDWHFtRyYOjUNd4SuniHYHLRlxHDHTeBoivGpk5P4yXPZ
	 STJUfh+FpNwQTP+WqnoQ+lRey1KcND2UWwWTzG6TTCkl7wkM0E8tfL7n3kXY+m8mQy
	 nOeO14HmAY4CZ3Tj5mUn6SuoogJlLaboWlllZqnBGkz/i+e4g5XJxx8mie9ylu3nz0
	 ly/kT1quCE4zUUJKxOKqDYwLATzyFh0/InlqIWtc0nHyHyxhwFW8gt+DItkNhZ4R12
	 sWfUaSql1hddWjXFPAD0xwkBvQIbZbahdkCCm1XeCrJHJ32BlX1yp14EMGDEjzMOaN
	 dwUndvpjr3QGQ==
Date: Sat, 28 Jun 2025 16:35:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA
 buffers at the end
Message-ID: <20250628163521.5a0aa1c8@jic23-huawei>
In-Reply-To: <6152da6f-84a1-40e0-9fe8-248a2835de6e@baylibre.com>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
	<20250623-losd-3-inv-icm42600-add-wom-support-v5-1-4b3b33e028fe@tdk.com>
	<CAMknhBEpkWrZdWSrhQS6E1GnENCipf+LxNNSNUyZrm8Gme2f_Q@mail.gmail.com>
	<FR3P281MB175703F651131703019D7295CE78A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250626194838.55c5eca4@jic23-huawei>
	<FR3P281MB175744F24BDD93870BB32ED0CE45A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<6152da6f-84a1-40e0-9fe8-248a2835de6e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 12:19:55 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/27/25 10:27 AM, Jean-Baptiste Maneyrol wrote:
> 
> ...
> 
> >>>>> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> >>>>> index 55ed1ddaa8cb5dd410d17db3866fa0f22f18e9d2..9b2cce172670c5513f18d5979a5ff563e9af4cb3 100644
> >>>>> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> >>>>> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> >>>>> @@ -148,9 +148,9 @@ struct inv_icm42600_suspended {
> >>>>>   *  @suspended:                suspended sensors configuration.
> >>>>>   *  @indio_gyro:       gyroscope IIO device.
> >>>>>   *  @indio_accel:      accelerometer IIO device.
> >>>>> - *  @buffer:           data transfer buffer aligned for DMA.
> >>>>> - *  @fifo:             FIFO management structure.
> >>>>>   *  @timestamp:                interrupt timestamps.
> >>>>> + *  @fifo:             FIFO management structure.
> >>>>> + *  @buffer:           data transfer buffer aligned for DMA.
> >>>>>   */
> >>>>>  struct inv_icm42600_state {
> >>>>>         struct mutex lock;
> >>>>> @@ -164,12 +164,12 @@ struct inv_icm42600_state {
> >>>>>         struct inv_icm42600_suspended suspended;
> >>>>>         struct iio_dev *indio_gyro;
> >>>>>         struct iio_dev *indio_accel;
> >>>>> -       u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
> >>>>> -       struct inv_icm42600_fifo fifo;
> >>>>>         struct {
> >>>>>                 s64 gyro;
> >>>>>                 s64 accel;
> >>>>>         } timestamp;
> >>>>> +       struct inv_icm42600_fifo fifo;    
> >>>>
> >>>> I didn't look at how the drivers use timestamp and fifo, but if they
> >>>> are passed as a buffer to SPI, then they need to stay in the DMA
> >>>> aligned area of the struct.    
> >>>
> >>> struct inv_icm42600_fifo has a buffer at its end that is passed to SPI.
> >>> Same things for buffer below. That's why both buffers are DMA
> >>> aligned.  
> >>
> >> It's a tiny bit esoteric that this is relying on structure alignment rules
> >> that says (iirc) the structure element will be aligned to maximum of it's
> >> elements and there is tail padding to that size as well.  Thus the whole
> >> struct inv_icm42600 is __aligned(IIO_DMA_MINALIGN) and the buffer in there
> >> is itself after padding to ensure that it is __aligned(IIO_DMA_MINALIGN)
> >>
> >>
> >> Anyhow, all I think this actually does is avoid one lot of padding
> >> (as well as making it slightly easier to reason about!)
> >>
> >> outer struct {
> >> stuff
> >> padding to align #1
> >> fifo {
> >> 	stuff
> >> 	padding to align
> >> 	buffer
> >> 	padding to fill up align
> >> }
> >> struct timestamp;
> >> ///this bit will go away as it can fit in the padding #1 (probably)
> >> Padding to align
> >> ////
> >> u8 buffer[2] __ailgned(IIO_DMA_MINALIGN)
> >>
> >>  
> > 
> > Hello David and Jonathan,
> > 
> > what should I changed for this patch? Rewrite the commit message?
> >   
> 
> I had to go digging through the source code to understand any of this, but
> now I finally do.
> 
> What would have made this clear to me in the commit message would be to say
> that:
> 
> 1. The timestamp <anonymous> struct is not used with DMA so it doesn't
>    belong after __aligned(IIO_DMA_MINALIGN).
> 2. struct inv_icm42600_fifo contains it's own __aligned(IIO_DMA_MINALIGN)
>    within it so it should not be after __ailgned(IIO_DMA_MINALIGN) in
>    the outer struct either.
> 3. Normally 1 would have been considered a bug, but because of the extra
>    alignment from 2, it actually was OK, but we shouldn't be relying on
>    such quirks.
> 
> 
LGTM. I thought about just applying this with David's message version but
given you are doing another spin for the other patches in the series I'll
pick this one up with those.

Thanks,

Jonathan

> 


