Return-Path: <linux-iio+bounces-12370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BDC9D0EEB
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFABB2E017
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECC7193428;
	Mon, 18 Nov 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECwF1rnq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A83D551;
	Mon, 18 Nov 2024 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925316; cv=none; b=H3LyvdibkCjnMDn5EV8P7+uVAW0EXBONGd19GGBRwj+sDB757Rk2Y7smTR3A++GT6s2pGghklthMubEgXMfW6JWfbu1STK2IS2NCShW+shvLkstS2FqoZ9JzFRpBpuGt6yhcyLLMGZ5T9tIICH97NANCd5sGfpmUPUDHgpFg8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925316; c=relaxed/simple;
	bh=EqLRLcPw+hpXYUlLvw3BsBBJsOhP3Yw6p6RDJlVDOBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPI66iCkfLFGTk5sn2Ofjr7vVs8Fd/xUy0sh7U9ApE7YXmqrEZp+o84VlU+K6UBgn/WdKvbmXrnIgtM1xBV/23ZuKzlFE9b8VHDuc/TjSUde/bQsWmNdmhmXXG89ie7pXLjIKsWr+9haWN1KCQCIj6WRM0OSY+uQ/jC4GefplVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECwF1rnq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731925315; x=1763461315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EqLRLcPw+hpXYUlLvw3BsBBJsOhP3Yw6p6RDJlVDOBM=;
  b=ECwF1rnqeaxksKVfP6jmB3urJ3xqBbdM6V4N8dwToMEJjgyErxXh+yKO
   SbW+DbAkE5DRQyrYToHphLJRdQj2io9qe0uoVAnuyxDr9nWrcLQd/iNIm
   dDPhOxFY1hOQr4L3D4dnJxjuk5MO3J5rbhe+76kJuy10t8TSX56X+wELo
   KslPK5mNOe4BsxNC4HC/D+9OmB4t4qt0kaLPR5DM+iuJQYq8EVGN2tcUh
   s3z6lzZLMnzQS5US0czKdPggjYwLKiRSM69Z0Re84lD6b2RJeP9QzHM3+
   RgQS44djK1+GNCZX1E+mtsqW+djzohSLSUEcyml6sMHg6lQICE86QT0qt
   Q==;
X-CSE-ConnectionGUID: 2vFN5feWRzm5lRhHl+o1Xg==
X-CSE-MsgGUID: v2PGeeFsQGWwZey5quQRZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42391473"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42391473"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 02:21:54 -0800
X-CSE-ConnectionGUID: CBZQnqNESDuCOWFsbupJSg==
X-CSE-MsgGUID: NnRZu1XWQYmxs2RFnSJFew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="94275234"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 02:21:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tCyt7-0000000Fy3E-08C0;
	Mon, 18 Nov 2024 12:21:45 +0200
Date: Mon, 18 Nov 2024 12:21:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>,
	Paul Cercueil <paul@crapouillou.net>,
	Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <ZzsVOGvzgNTvuEtD@smile.fi.intel.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
 <20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
 <ZyJHFp6vbQ7deLFs@black.fi.intel.com>
 <173031260171.39393.109639772708550094@njaxe.localdomain>
 <20241030203050.5cdf3450@jic23-huawei>
 <173037398492.12348.265826723028347056@njaxe.localdomain>
 <20241031143129.0000014e@Huawei.com>
 <173039799203.1353.4404042832923090619@njaxe.localdomain>
 <b56ba6a0db195ad44158509f3adb157b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56ba6a0db195ad44158509f3adb157b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 15, 2024 at 03:25:06PM +0100, Matteo Martelli wrote:
> On Thu, 31 Oct 2024 19:06:32 +0100, Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > Quoting Jonathan Cameron (2024-10-31 15:31:29)
> > > On Thu, 31 Oct 2024 12:26:24 +0100
> > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > Quoting Jonathan Cameron (2024-10-30 21:30:50)
> > > > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > > > Quoting Andy Shevchenko (2024-10-30 15:47:50)  
> > > > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:    

> > > > > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > > > > callback after reading producer's available info. To avoid a race
> > > > > > > > condition with the producer unregistration, change inkern
> > > > > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > > > > producer and immediately calls its release callback with info_exists
> > > > > > > > locked.
> > > > > > > > 
> > > > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > > > > after calling these functions. To let users free the copied buffer with
> > > > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > > > > but stores the available values in the returned variable.    

...

> > > > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > > > > +                                         struct iio_chan_spec const *chan,
> > > > > > > > +                                         const int *vals, long mask)
> > > > > > > > +{
> > > > > > > > +     kfree(vals);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > >                             struct iio_chan_spec const *chan,
> > > > > > > >                             int val, int val2, long mask)
> > > > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > >  static const struct iio_info dpot_dac_info = {
> > > > > > > >       .read_raw = dpot_dac_read_raw,
> > > > > > > >       .read_avail = dpot_dac_read_avail,
> > > > > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > > > >       .write_raw = dpot_dac_write_raw,
> > > > > > > >  };    
> > > > > > > 
> > > > > > > I have a problem with this approach. The issue is that we allocate
> > > > > > > memory in one place and must clear it in another. This is not well
> > > > > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > > > > at least these two comes to my mind:
> > > > > > > 
> > > > > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > > > > name) that will dump the data to the intermediate buffer and clean it
> > > > > > > after all;
> > > > > > > 
> > > > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.    
> > > > > > 
> > > > > > Could you elaborate more about these potential solutions? Maybe with some
> > > > > > usage examples?
> > > > > > 
> > > > > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > > > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > > > > case, so that it would take care of freeing the buffer after calling
> > > > > > iio_format_after_*(). We considered this approach during an initial
> > > > > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > > > > to let the driver keep the release control through a callback for two
> > > > > > reasons:
> > > > > > 
> > > > > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > > > > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > > > > >    could still keep the buffer copy in its private data after giving it away,
> > > > > >    resulting in fact in a double ownership. However I think it would be clear
> > > > > >    enough in this case that the copy should be handled by the caller, or maybe
> > > > > >    not?  
> > > > > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > > > > not needed and that it prevents any optimization like you mention.  
> > > > 
> > > > I think the suggestion here is to add an additional .read_avail_with_copy()
> > > > without replacing the original .read_avail(), so all the current drivers that
> > > > use a constant avail list would not be affected.

Yes.

> > > > And I think this was the same
> > > > idea for the additional read_avail_ext() or the additional argument for the
> > > > read_avail() we were considering in [1]. So I would think that
> > > > iio_read_channel_info_avail() would do something like the following:
> > > > 
> > > >     if (indio_dev->info->read_avail_with_copy)
> > > >         indio_dev->info->read_avail_with_copy(vals);
> > > >     else
> > > >         indio_dev->info->read_avail(vals);
> > > > 
> > > >     ...
> > > >     iio_format_avail_list(vals);
> > > >     ...
> > > > 
> > > >     if (indio_dev->info->read_avail_with_copy)
> > > >         kfree(vals);

Right. At least that's what I see can be done with the existing users.

> > > Ok, sure that would work, but...
> > > 
> > > I don't really see this as being much less fragile than
> > > the existing solution + in cases that we do have where
> > > only some available are not const we will have to copy them
> > > all.
> > > 
> > > If anything it's more complex than making it a driver problem
> > > to provide the release call however it wants to do it.

...but make a driver to allocate what's needed as well then.

> > > > And the drivers would choose whether to define the read_avail or the
> > > > read_avail_with_copy.

Either way drivers should know what to do with a data supplied to read_aval().
In one case we assume the [simple] workflow in the core, in the other we all
rely on the driver. Current approach makes a mix of these two. And that's what
I don't like.

> > > > What I was referring to is that, back then, you mentioned you would have
> > > > preferred to avoid passing ownership of the buffer around:
> > > > 
> > > > > That's a corner case we should think about closing. Would require an indicator
> > > > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > > > free on completion of the string building.  I don't like passing ownership
> > > > > of data around like that, but it is fiddly to do anything else given
> > > > > any simple double buffering is subject to race conditions.  
> > > > 
> > > > I guess there is some other reason other than avoiding the copy when not
> > > > necessary, since by introducing an additional function or argument or return
> > > > type, most of the unnecessary copies would already be avoided right?
> > > 
> > > It's not a strong reason beyond limiting scope of clever design +
> > > the key bit my mind is that the above is not substantially simpler and
> > > reduces our flexibility.
> > > 
> > > > Anyway any of this solutions would still prevent the potential optimizations of
> > > > point 2). It's worth mentioning that those kind of optimizations are currently
> > > > not adopted by any driver.
> > > 
> > > That one indeed not, but mixing dynamic and non dynamic is something
> > > you do in your pac1921 patch.
> > 
> > Good point! I didn't think about it, or more likely I forgot, that with an
> > additional read_avail_with_copy() used as in the example you cannot mix dynamic
> > and non dynamic available lists, thus those drivers that need at least one
> > dynamic available list would always copy all of them as they need to rely to
> > the read_avail_with_copy(). I guess this could be worked around with an
> > additional return argument for the read_avail() or an additional type like the
> > IIO_AVAIL_LIST_ALLOC suggested by Andy to signal the caller it needs to free
> > the list after use. However, I think they would introduce a more invasive
> > change in the current API compared to an additional optional callback,

It even sounds originally that it should be more invasive, so I don't think it's
a problem here.

> > so I agree that the current release callback is still a better option.

I disagree on this as I pointed above why.

> > > > > > 2) Some driver might want to avoid allocating a new copy of a big table if
> > > > > >    the race does not occur (e.g. with additional checks on buffer access
> > > > > >    code) and thus wouldn't call a free() in the release callback.
> > > > > >   
> > > > > > > In any case it looks fragile and not scalable. I propose to drop this
> > > > > > > and think again.    
> > > > > > 
> > > > > > I see your concerns, I am open to reconsider this in case we come up with
> > > > > > better solution after addressing the points above.
> > > > > >   
> > > > > > > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > > > > > > agree on the report, I think this solution is not good enough.
> > > > > > 
> > > > > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/
> > > > 
> > > > I hope I've brought a little more clarity to the discussion by providing some
> > > > history instead of making it more confusing.
> > > 
> > > Sure, the code example in particular is useful.
> 
> Just a friendly reminder this has been sitting for a while, any news or
> additional considerations?

Moving the allocation control to the drivers will satisfy me as well, however
it makes even more duplication of the code, but at least it will be cleaner
design-wise in my opinion.

In any case the last word is on Jonathan.

-- 
With Best Regards,
Andy Shevchenko



