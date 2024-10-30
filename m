Return-Path: <linux-iio+bounces-11653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3B9B6DB6
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 21:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D569A282D46
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F71DE8B1;
	Wed, 30 Oct 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr7mwaFC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE919CC24;
	Wed, 30 Oct 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320261; cv=none; b=DmIV569tY5Hh9M2Y1EjEmJ8hMvvRduMzrMddu4wlptTcZHl92iFeOakfkc9k/+0APU+CMCRDtQQYjvlViG9RYFTq1n22kPGPo4K+CwBM/tEnnH1aNi3qV0BymPXV2WmivODxeoLtEXoBHjEziXmjFjTHnsgSdB21qw1RYjRVghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320261; c=relaxed/simple;
	bh=cKV4S6rk2gNSyd2ElGMwF5RQwJz0BRa0abJTbXhDhFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgHBmNhVWI1r2ZcfifrTP1jk9EASTwi8TjNmTrwTj4Bdkax7Pa52LiO8fTLhWVzKj3+gutiXWJB67tnRlbTW8nYplh0DepMt6Wt09DQWAj61qvcBAxv73fHsdV3cxlubniqOCv+ja/SuzW+2peoobPaT5Dd7ImNoT0Ipp8IEweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr7mwaFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD9CC4CECE;
	Wed, 30 Oct 2024 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730320260;
	bh=cKV4S6rk2gNSyd2ElGMwF5RQwJz0BRa0abJTbXhDhFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nr7mwaFCmM/wn1rNici20hpH4Boy5LrlbBOemodMXr4aCyfm99obML8PfY8+vbkMj
	 Iuug02nVevoMjzeWQqiPZlKhzMPWDT/vjc/B42epn0RA9tXYLS9CbN6yf4bsONTKuT
	 MkDSC3BV80DYJwBQ03RZQsl1iriDsaxSp7FKlqcxsYlZVd8A4+fZpqTUB88nThMbSw
	 6tLPLTYD4m4pJj/cX1qSe0+kID//xrPPzoO3HqDEMOy0LQMt7rrA15g4uhvsUOTZMd
	 7sHwTGUE/ryo7tC1IeRx/awMFz4uvfsqGvtvO6lXO8LvrvhkscwV6f5PJbzUmZjxi3
	 EMqBn6+9VVFtA==
Date: Wed, 30 Oct 2024 20:30:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers
 <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul Cercueil
 <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <20241030203050.5cdf3450@jic23-huawei>
In-Reply-To: <173031260171.39393.109639772708550094@njaxe.localdomain>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
	<20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
	<ZyJHFp6vbQ7deLFs@black.fi.intel.com>
	<173031260171.39393.109639772708550094@njaxe.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 19:23:21 +0100
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Quoting Andy Shevchenko (2024-10-30 15:47:50)
> > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:  
> > > Consumers need to call the producer's read_avail_release_resource()
> > > callback after reading producer's available info. To avoid a race
> > > condition with the producer unregistration, change inkern
> > > iio_channel_read_avail() so that it copies the available info from the
> > > producer and immediately calls its release callback with info_exists
> > > locked.
> > > 
> > > Also, modify the users of iio_read_avail_channel_raw() and
> > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > after calling these functions. To let users free the copied buffer with
> > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > but stores the available values in the returned variable.  
> > 
> > ...
> >   
> > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > +                                         struct iio_chan_spec const *chan,
> > > +                                         const int *vals, long mask)
> > > +{
> > > +     kfree(vals);
> > > +}
> > > +
> > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > >                             struct iio_chan_spec const *chan,
> > >                             int val, int val2, long mask)
> > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > >  static const struct iio_info dpot_dac_info = {
> > >       .read_raw = dpot_dac_read_raw,
> > >       .read_avail = dpot_dac_read_avail,
> > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > >       .write_raw = dpot_dac_write_raw,
> > >  };  
> > 
> > I have a problem with this approach. The issue is that we allocate
> > memory in one place and must clear it in another. This is not well
> > designed thingy in my opinion. I was thinking a bit of the solution and
> > at least these two comes to my mind:
> > 
> > 1) having a special callback for .read_avail_with_copy (choose better
> > name) that will dump the data to the intermediate buffer and clean it
> > after all;
> > 
> > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.  
> 
> Could you elaborate more about these potential solutions? Maybe with some
> usage examples?
> 
> If I get it correctly, in both cases you are suggesting to pass ownership
> of the vals buffer to the caller, iio_read_channel_info_avail() in this
> case, so that it would take care of freeing the buffer after calling
> iio_format_after_*(). We considered this approach during an initial
> discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> to let the driver keep the release control through a callback for two
> reasons:
> 
> 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
>    maybe Jonathan can elaborate why? The risk I can think of is that the driver
>    could still keep the buffer copy in its private data after giving it away,
>    resulting in fact in a double ownership. However I think it would be clear
>    enough in this case that the copy should be handled by the caller, or maybe
>    not?
Mostly the lack of desire to have to copy for the 95% of cases where it's
not needed and that it prevents any optimization like you mention.

Jonathan
> 
> 2) Some driver might want to avoid allocating a new copy of a big table if
>    the race does not occur (e.g. with additional checks on buffer access
>    code) and thus wouldn't call a free() in the release callback.
> 
> > 
> > In any case it looks fragile and not scalable. I propose to drop this
> > and think again.  
> 
> I see your concerns, I am open to reconsider this in case we come up with
> better solution after addressing the points above.
> 
> > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > agree on the report, I think this solution is not good enough.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> >   
> 
> [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/
> 
> Best regards,
> Matteo Martelli


