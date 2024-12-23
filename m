Return-Path: <linux-iio+bounces-13760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4059FAE4D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 13:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727F71883418
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2F19D8A9;
	Mon, 23 Dec 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e93842EO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4118FDDC
	for <linux-iio@vger.kernel.org>; Mon, 23 Dec 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957156; cv=none; b=JPgE58/zMPGBtYti1g6jb7ba+PrL23NNiMxZ6lBBNpA2q5kUt+fW50eGnamivAQJZHY6yUqz0aLr0izF873nu5yuc6hYnlLC26XX5EfeWHdumwTloCLqk6Mh3gM73omNJ85J3aeejuZZG82sg6j7gokFff/YFcqsdaNGm4/nQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957156; c=relaxed/simple;
	bh=qeby5yWedl2Xg67AsEpCCEXokLHslIHVsSZ2AqTAH6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3NU5BtvQeAnv2m3fAotx1JyAyjliWWbLmyYR0v9XNrHUm+8qE/hqBPXvEAwJrto1TgboDnmq3JLTke/PxxX7lup+B/UYBwDnVgLA3RZRhEEeYx45FWCJkHidlgmaf5FfJDEknP0XrcpdsQ+8E5eKAmkC00rT/BT+niKzuhZx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e93842EO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C913EC4CED3;
	Mon, 23 Dec 2024 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734957156;
	bh=qeby5yWedl2Xg67AsEpCCEXokLHslIHVsSZ2AqTAH6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e93842EOAvTWhUQNME9LBdsBOorftUxWcrKG8nNCT4YE5NWlcvf1lvyESDSIg+WNA
	 ZJjMMHfFYqhm7rf85QlyvC0ZspxmK+kuDC27JQ9xFEEK9e4fYbSOnZdF7X5ea6u7hR
	 UvuY1ZzT3Ue//s07hd68X3Ek7u69PX4muO/SNKG87/euWg90Dm/fA8zJ5kvGpeRQWc
	 3TD58EEMwIbSOG/RP3s5hMl1nAWesD32MxGiLAfndF4pnzRtjCcJXuHWB0xhpJL7dk
	 8Ts/3+2lfxJvFpxDJVY8KfUnG2UUZbxtk/blWkTdESwPt/zm95mVbW/7kVub/6Dvx5
	 bKH7/kkLw30pQ==
Date: Mon, 23 Dec 2024 12:32:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Heiko
 Stuebner <heiko@sntech.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/20] IIO: Tidying up timestamp alignment markings.
Message-ID: <20241223123230.20a27870@jic23-huawei>
In-Reply-To: <Z19HlhLWNqH_alRY@smile.fi.intel.com>
References: <20241215182912.481706-1-jic23@kernel.org>
	<Z19HlhLWNqH_alRY@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 23:18:14 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Dec 15, 2024 at 06:28:51PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > I haven't +CC everyone relevant as that would be too long a list
> > and these are mostly entirely mechanical changes that just need
> > someone to sanity check I didn't do anything stupid.
> > 
> > This combines several related types of change:
> > 
> > - Some 'fixes'. These aren't actual bugs but more places where
> >   the code relies on factors it shouldn't such as what architecture
> >   the driver is running on, or padding of the wrong element happening
> >   to always make enough room.
> > - Now we have aligned_s64, use that to replace all the remaining
> >   s64 timestamp __aligned(8) instances in IIO.
> >   This is both cleaner and hopefully less prone to confusing static
> >   analysis tools.
> > - Change the timestamp type in iio_push_to_buffers_with_timestamp() to s64.
> >   This is an entirely in kernel interface. It's data is pushed to user space
> >   in many case but by a rather indirect route, so I think it is more
> >   appropriate to switch this to s64 which is the type of almost all the
> >   values passed into it. Note a follow up series may tidy up some
> >   local variables that are of the int64_t type.
> > - Change the few int64_t timestamp __aligned(8) cases to aligned_s64.
> >   This is mostly a consistency thing to avoid confusion if a new author
> >   is trying to figure out what types they should use.  Better to have
> >   one answer than a mixture.
> > 
> > There is one other IIO driver hiding over in media that will be modified
> > by a separate patch because I want to add some more info to that and
> > a more specific CC list.  
> 
> I briefly looked at most of the patches and haven't noticed any potential
> issues, all seems like a straightforward conversion. Hence
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> for all, except 15 and 19.
> 
> Patch 15 has got a few minor comments (and to accent on that I'm not sure about
> my offer for sizeof(), using direct variable might make it inconsistent in this
> case, because the following line uses explicit type instead of typeof(), and
> using the latter makes the code unreadable).
> 
> Patch 19 seems correct to me, but I'm not going to give a tag to be on the safe
> side.

Thanks, I've applied all but 15 and 19 (which could do with more eyes and will
be more obvious in a v2 with just two patches!)

Will tidy up 15 and send out a v2 shortly.

Thanks,

Jonathan

> 


