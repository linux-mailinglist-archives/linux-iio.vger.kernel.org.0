Return-Path: <linux-iio+bounces-13388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943C9EE858
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 15:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927F3281B4F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8672153E0;
	Thu, 12 Dec 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YloHqNEr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490A2147E3;
	Thu, 12 Dec 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012387; cv=none; b=eLE0qDGkVSA1fIcR9FfLO6oZhqlehrQ+6WXsBPngRZbN7Pr20ljtdN+LMzPUXkKOYUOnA7CwiLxSHqSRnkrtrznky+C30VYcco1ZJJhv14tuVfZpJIKeBrVEMfnCIrMFUaJPcUTtbm/7f07U3JRPpypTEwjvLK+2aZnMUJU09+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012387; c=relaxed/simple;
	bh=Z1+dkR69jAClM5yniRJy5igkt6+WGh5RLxKGLiJyaWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIdSirZr/nEpsSsZIyFhWFCt5a9P3SkZPNFpiQvCwTMviKwJ74p3XwtpI2ngWyVK6JVRHwYZL16O1//X25es9pjWXRJfsnZkgdn3o4O/K5+dpFVClYuUI3Gw8warLB8qWXPa896HvhOIHYwliXG6Y5qCvt1MXqnV0+dv77JwjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YloHqNEr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012385; x=1765548385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z1+dkR69jAClM5yniRJy5igkt6+WGh5RLxKGLiJyaWk=;
  b=YloHqNErjUH1hLCtzRpuv+mBrggfMu2sPdO8dYWi5ABB7PwR9hQnmqmq
   YheZaNf5xqxgGN8Brf4AUZTiR5NulcV/PDHAZcJkf5Cklz4/3meHubEbw
   KOvv1IkkpPz3x2OR44U6clOk+yUo1SHAT5f22LjlNWKL6zteSZaRvHyt3
   a/lqH9bnZwJ0T2UDrY/kNSC6V46QgbB3RzZaVXqVF2C+a07tgC+JpnFPL
   qFGWDZPeaXqEgHCBwAeuuVeduzJLv27xGeujlCldGN4a9fY/IOWjC9QoD
   vPG+iSYxYNxDgZcq1Wgr335xaMujQGDLUiIz5sTXE1nf1cohUl93/3aUX
   Q==;
X-CSE-ConnectionGUID: 2mwsK4rtR1uybEePe4QtPA==
X-CSE-MsgGUID: Dfw7CUhqQJmxopEKiA1aNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34156127"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34156127"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:06:24 -0800
X-CSE-ConnectionGUID: IejFWhCuTwOPzRmSozKTJA==
X-CSE-MsgGUID: AkCJbfnnTUihIOhgzn3akg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="101091431"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:06:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tLjpZ-00000006uk3-0EOm;
	Thu, 12 Dec 2024 16:06:17 +0200
Date: Thu, 12 Dec 2024 16:06:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-ID: <Z1rt2IGAtcRNm9n7@smile.fi.intel.com>
References: <e56a8f3c81429c465e87a3abcccec1b4@gmail.com>
 <Zztlz08Wm-mGdy7p@smile.fi.intel.com>
 <65e16f628245a78da5c9d870d6c5c5a9@gmail.com>
 <Zzx_C60W48ujpis9@smile.fi.intel.com>
 <20241123141320.326b3340@jic23-huawei>
 <9b2f3557dc93c4b75752f812e2645262@gmail.com>
 <20241126174147.23fed403@jic23-huawei>
 <9db64d227f70f016b614a9cff5469f2d@gmail.com>
 <Z03xngKjNQYrKvgw@smile.fi.intel.com>
 <ed7b48be0216bab2a81e74cf905814d2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7b48be0216bab2a81e74cf905814d2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 12, 2024 at 10:46:04AM +0100, Matteo Martelli wrote:
> On Mon, 2 Dec 2024 19:42:54 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Nov 29, 2024 at 05:04:54PM +0100, Matteo Martelli wrote:
> > > On Tue, 26 Nov 2024 17:41:47 +0000, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > On Tue, 26 Nov 2024 17:31:16 +0100
> > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > > On Sat, 23 Nov 2024 14:13:20 +0000, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > > > On Tue, 19 Nov 2024 14:05:31 +0200
> > > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > > > On Tue, Nov 19, 2024 at 12:25:18PM +0100, Matteo Martelli wrote:  
> > > > > > > > On Mon, 18 Nov 2024 18:05:35 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:    
> > > > > > > > > On Mon, Nov 18, 2024 at 03:45:25PM +0100, Matteo Martelli wrote:    
> > > > > > > > > > On Mon, 18 Nov 2024 12:21:44 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:    
> > > > > > > > > > > On Fri, Nov 15, 2024 at 03:25:06PM +0100, Matteo Martelli wrote:    
> > > > > > > > > > > > On Thu, 31 Oct 2024 19:06:32 +0100, Matteo Martelli <matteomartelli3@gmail.com> wrote:    
> > > > > > > > > > > > > Quoting Jonathan Cameron (2024-10-31 15:31:29)    
> > > > > > > > > > > > > > On Thu, 31 Oct 2024 12:26:24 +0100
> > > > > > > > > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:    
> > > > > > > > > > > > > > > Quoting Jonathan Cameron (2024-10-30 21:30:50)    
> > > > > > > > > > > > > > > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > > > > > > > > > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:    
> > > > > > > > > > > > > > > > > Quoting Andy Shevchenko (2024-10-30 15:47:50)      
> > > > > > > > > > > > > > > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:        
> > > > > > >   
> > > > > > > > > > > > > > > > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > > > > > > > > > > > > > > > callback after reading producer's available info. To avoid a race
> > > > > > > > > > > > > > > > > > > condition with the producer unregistration, change inkern
> > > > > > > > > > > > > > > > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > > > > > > > > > > > > > > > producer and immediately calls its release callback with info_exists
> > > > > > > > > > > > > > > > > > > locked.
> > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > > > > > > > > > > > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > > > > > > > > > > > > > > > after calling these functions. To let users free the copied buffer with
> > > > > > > > > > > > > > > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > > > > > > > > > > > > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > > > > > > > > > > > > > > > but stores the available values in the returned variable.        
> > > > > > > 
> > > > > > > ...
> > > > > > >   
> > > > > > > > > > > > > > > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > > > > > > > > > > > > > > > +                                         struct iio_chan_spec const *chan,
> > > > > > > > > > > > > > > > > > > +                                         const int *vals, long mask)
> > > > > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > > > > +     kfree(vals);
> > > > > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > > > > > > > > >                             struct iio_chan_spec const *chan,
> > > > > > > > > > > > > > > > > > >                             int val, int val2, long mask)
> > > > > > > > > > > > > > > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > > > > > > > > >  static const struct iio_info dpot_dac_info = {
> > > > > > > > > > > > > > > > > > >       .read_raw = dpot_dac_read_raw,
> > > > > > > > > > > > > > > > > > >       .read_avail = dpot_dac_read_avail,
> > > > > > > > > > > > > > > > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > > > > > > > > > > > > > > >       .write_raw = dpot_dac_write_raw,
> > > > > > > > > > > > > > > > > > >  };        
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > I have a problem with this approach. The issue is that we allocate
> > > > > > > > > > > > > > > > > > memory in one place and must clear it in another. This is not well
> > > > > > > > > > > > > > > > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > > > > > > > > > > > > > > > at least these two comes to my mind:
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > > > > > > > > > > > > > > > name) that will dump the data to the intermediate buffer and clean it
> > > > > > > > > > > > > > > > > > after all;
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.        
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > Could you elaborate more about these potential solutions? Maybe with some
> > > > > > > > > > > > > > > > > usage examples?
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > > > > > > > > > > > > > > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > > > > > > > > > > > > > > > case, so that it would take care of freeing the buffer after calling
> > > > > > > > > > > > > > > > > iio_format_after_*(). We considered this approach during an initial
> > > > > > > > > > > > > > > > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > > > > > > > > > > > > > > > to let the driver keep the release control through a callback for two
> > > > > > > > > > > > > > > > > reasons:
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > > > > > > > > > > > > > > > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > > > > > > > > > > > > > > > >    could still keep the buffer copy in its private data after giving it away,
> > > > > > > > > > > > > > > > >    resulting in fact in a double ownership. However I think it would be clear
> > > > > > > > > > > > > > > > >    enough in this case that the copy should be handled by the caller, or maybe
> > > > > > > > > > > > > > > > >    not?      
> > > > > > > > > > > > > > > > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > > > > > > > > > > > > > > > not needed and that it prevents any optimization like you mention.      
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > I think the suggestion here is to add an additional .read_avail_with_copy()
> > > > > > > > > > > > > > > without replacing the original .read_avail(), so all the current drivers that
> > > > > > > > > > > > > > > use a constant avail list would not be affected.    
> > > > > > >   
> > > > > > > > > > > Yes.    
> > > > > > >   
> > > > > > > > > > > > > > > And I think this was the same
> > > > > > > > > > > > > > > idea for the additional read_avail_ext() or the additional argument for the
> > > > > > > > > > > > > > > read_avail() we were considering in [1]. So I would think that
> > > > > > > > > > > > > > > iio_read_channel_info_avail() would do something like the following:
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > > > > > > > > >         indio_dev->info->read_avail_with_copy(vals);
> > > > > > > > > > > > > > >     else
> > > > > > > > > > > > > > >         indio_dev->info->read_avail(vals);
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > >     ...
> > > > > > > > > > > > > > >     iio_format_avail_list(vals);
> > > > > > > > > > > > > > >     ...
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > > > > > > > > >         kfree(vals);    
> > > > > > > > > > > 
> > > > > > > > > > > Right. At least that's what I see can be done with the existing users.
> > > > > > > > > > >     
> > > > > > > > > > > > > > Ok, sure that would work, but...
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > I don't really see this as being much less fragile than
> > > > > > > > > > > > > > the existing solution + in cases that we do have where
> > > > > > > > > > > > > > only some available are not const we will have to copy them
> > > > > > > > > > > > > > all.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > If anything it's more complex than making it a driver problem
> > > > > > > > > > > > > > to provide the release call however it wants to do it.    
> > > > > > > > > > > 
> > > > > > > > > > > ...but make a driver to allocate what's needed as well then.
> > > > > > > > > > >     
> > > > > > > > > > > > > > > And the drivers would choose whether to define the read_avail or the
> > > > > > > > > > > > > > > read_avail_with_copy.    
> > > > > > > > > > > 
> > > > > > > > > > > Either way drivers should know what to do with a data supplied to read_aval().
> > > > > > > > > > > In one case we assume the [simple] workflow in the core, in the other we all
> > > > > > > > > > > rely on the driver. Current approach makes a mix of these two. And that's what
> > > > > > > > > > > I don't like.    
> > > > > > > > > > 
> > > > > > > > > > If I understand your concern correctly, you are referring to the inkern
> > > > > > > > > > iio_channel_read_avail() that makes the allocation for the consumer's
> > > > > > > > > > buffer copy and you are suggesting that such copy should be done by the
> > > > > > > > > > consumer driver code itself, this to be consistent with the producer
> > > > > > > > > > drivers which directly handle the allocation of the copy.    
> > > > > > > > > 
> > > > > > > > > One of the options, yes.
> > > > > > > > >     
> > > > > > > > > > One thing to notice is that the inkern iio_channel_read_avail() does
> > > > > > > > > > together producer->read_avail() + copy + producer->read_avail_release()
> > > > > > > > > > with info_exists locked. Also, the consumer driver would need to know
> > > > > > > > > > the avail buffer size to allocate the buffer copy prior the
> > > > > > > > > > iio_channel_read_avail() call, but such size is unknown before calling
> > > > > > > > > > the actual producer's read_avail(). This would mean calling the
> > > > > > > > > > producer's read_avail() and read_avail_release() callbacks separately
> > > > > > > > > > without the lock held, with the risk of a memleak if the producer is
> > > > > > > > > > unregistered between those calls.    
> > > > > > > > > 
> > > > > > > > > Thanks for explaining this, but it even more makes me think that the design
> > > > > > > > > is broken and your approach is rather a hack. So, what's the problem to
> > > > > > > > > make IIO core to take care of the allocating and cleaning then without driver
> > > > > > > > > being involved? Yes, this might require a hint from the driver on what to copy
> > > > > > > > > if we want to avoid copying everything.    
> > > > > > > > 
> > > > > > > > I am not particularly against it, other than the concerns that have
> > > > > > > > emerged during this (and previous) discussion. Let me summarize them:    
> > > > > > > 
> > > > > > > Thank you for a very good summary and fix-N proposals. I think I have nothing
> > > > > > > to add and we should wait for Jonathan to finally choose (or propose a fix-N+1)
> > > > > > > here.  
> > > > > > Agreed. This is very useful enumeration of various options with plenty
> > > > > > of details!
> > > > > > 
> > > > > > One absolute key thing to note here is we should not care at all what
> > > > > > inkern does for it's handling internally of the available lists.  The big
> > > > > > ABI question is all about consumers drivers directly using the resulting list of
> > > > > > available values.  The use in the IIO core and the inkern helpers should
> > > > > > naturally follow.
> > > > > > 
> > > > > > > > fix-1) the current one. Your concerns are:
> > > > > > > >     * for consumers the copy allocation is taken care by the inkern API
> > > > > > > >       but the release is handled by the consumer driver code, making it
> > > > > > > >       a fragile design.  
> > > > > > 
> > > > > > So this was something I'm not sure I agree with.  There are plenty
> > > > > > of get / release patterns out there. This is just another one of those
> > > > > > but perhaps it doesn't 'smell' enough like that.
> > > > > > 
> > > > > > Perhaps think of it as
> > > > > > 
> > > > > > int *iio_channel_avail_get()
> > > > > > void iio_channel_avail_release()
> > > > > > 
> > > > > > We could perhaps make it look more standard using a cookie rather than
> > > > > > reconstructing the equivalent data at the release call.  
> > > > > 
> > > > > Would this imply that also the read_info callback provided by the
> > > > > iio_info struct should be replaced? Something like info->get_avail()
> > > > > returning a iio_avail_cookie instead of info->read_avail(const int **vals)?
> > > > > * If yes, that would be a big impact in the current code as all
> > > > > iio drivers defining read_avail would need to be changed (I am not
> > > > > against it but better consider it).
> > > > > * If no, then I find odd that iio_info->avail_release(cookie) gets a
> > > > > cookie that has been allocated outside the provider driver: the read
> > > > > functions gives something to the user and its corresponing release
> > > > > handle another type of object (even it's just a wrapper). Is this the
> > > > > usual pattern for cookies?
> > > > 
> > > > I think the trick here is that the provider drivers wouldn't be involved
> > > > in the cookie handling. We might have done it differently if we
> > > > were starting from scratch, but the legacy is a pain as normal!
> > > > Consumers can stay the same as you have here as all the information in
> > > > the cookie would be gathered from existing read_avail plus the parameters.
> > > > Tricky bit is the provider_priv, but we may not even need that.  If that
> > > > becomes a useful thing we'd need a new optional get_avail_with_priv()
> > > > or something like that.  Might need to stash the channel info in the
> > > > cookie as well.
> > > > 
> > > > Provider wouldn't see the cookie at release either as we'd just
> > > > pass parameters from the cookie into the release callback then free
> > > > the cookie in the core code.  Technically ownership of the cookie
> > > > would lie with the consumer not the provider but we'd hide all that
> > > > away from the consumer.
> > > 
> > > I see now that your suggestion to use the cookie would only affect
> > > consumers. What confused me is your example below where the producer's
> > > release would use the cookie as well:
> > > 
> > >             iio_dev->info->avail_release(cookie);
> > > 
> > > Anyway, if iio_info->read_avail and
> > > iio_info->read_avail_release_resource are not going to be changed, how
> > > could we address the case where the consumers simply forwards their
> > > providers avail data back to the core for sysfs print, like as follows?
> > > 
> > > static int dpot_dac_read_avail(struct iio_dev *indio_dev,
> > > 			       struct iio_chan_spec const *chan,
> > > 			       const int **vals, int *type, int *length,
> > > 			       long mask)
> > > {
> > > 	struct dpot_dac *dac = iio_priv(indio_dev);
> > > 
> > > 	switch (mask) {
> > > 	case IIO_CHAN_INFO_RAW:
> > > 		*type = IIO_VAL_INT;
> > > 		return iio_read_avail_channel_raw(dac->dpot, vals, length);
> > > 
> > > 		/* NOTE: Here we could call the cookie = iio_channel_avail_get() and
> > > 		  fill the return arguments with the content of the
> > > 		  cookie, but wouldn't the cookie be lost? How to return
> > > 		  it to caller? */
> > > 	}
> > > 
> > > 	return -EINVAL;
> > > }
> > > 
> > > static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > 					    struct iio_chan_spec const *chan,
> > > 					    const int *vals, long mask)
> > > {
> > > 	kfree(vals);
> > > 	/* NOTE: Here the consumer should access the cookie to call
> > > 	 * iio_channel_avail_release(cookie), but how can it? */
> > > }
> > > ...
> > > static const struct iio_info dpot_dac_info = {
> > > 	.read_avail = dpot_dac_read_avail,
> > > 	.read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > };
> > > 
> > > 
> > > > 
> > > > Whether we would use the cookie magic in the inkern code other
> > > > than the getter itself would depend a bit on what it looks like
> > > > 
> > > > We might need to do a global rename of read_avail to get_avail
> > > > though to make the relationship to release_avail obvious.
> > > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > struct iio_avail_cookie {
> > > > > > 	const int *avail;
> > > > > > 	void *provider_priv;
> > > > > > // see later for a maybe...
> > > > > > 	struct iio_dev *indio_dev;
> > > > > > };
> > > > > > 
> > > > > > const int *iio_avail_from_cookie(struct iio_avail_cookie *cookie)
> > > > > > {
> > > > > > 	return cookie->avail;
> > > > > > }
> > > > > >  
> > > > > 
> > > > > I suppose that struct iio_avail_cookie and their access functions like
> > > > > iio_avail_from_cookie would be define in iio.h as they are required for
> > > > > producer drivers too. Correct?
> > > > 
> > > > Initially at least I'd try just making them visible to the consumer.
> > > > 
> > > > > 
> > > > > > 
> > > > > > struct iio_avail_cookie *iio_channel_avail_get(struct iio_dev, struct iio_chan_spec)
> > > > > > {
> > > > > > 	allocate a cookie and fill it in.
> > > > > > }
> > > > > > 
> > > > > > and code would always explicitly release after it is done with the cookie.
> > > > > > 
> > > > > > Something like
> > > > > > 
> > > > > > void iio_channel_avail_release(struct iio_dev *iio_dev, struct iio_avail_cookie *cookie)
> > > > > > // could even move the iio_dev pointer into the cookie, so it becomes
> > > > > > // iio_channel_avail_release(struct iio_avail_cookie *cookie) and suitable for __free magic.
> > > > > > {
> > > > > > 	if (iio_dev->info->avail_release)
> > > > > > 		iio_dev->info->avail_release(cookie);
> > > > > > 	kfree(cookie);
> > > > > > 	/*
> > > > > > 	 * Could add optimizations around cookie handling to avoid alloc + free in most cases
> > > > > > 	 * or use an object pool.
> > > > > > 	 */
> > > > > > }  
> > > > > 
> > > > > Do these two functions refer to inkern consumer APIs? Would
> > > > > iio_channel_avail_get() replace the current inkern
> > > > > iio_read_avail_channel_attribute()? 
> > > > 
> > > > Yes.
> > > > 
> > > > >In that case I think
> > > > > iio_channel_avail_get() would copy the cookie (and its inner avail
> > > > > buffer) from the provider driver, or allocate a new cookie with the
> > > > > copied avail buffer if info->read_avail() is kept unchanged, and
> > > > > immediately call the provider info->avail_release(cookie) to do
> > > > > copy+release with info_exist_lock locked.
> > > > 
> > > > I don't think the provider ever explicitly deals with the cookie,
> > > > just data read from it in the inkern code.
> > > > 
> > > > > At that point
> > > > > iio_channel_avail_release() would only need to call
> > > > > kfree(iio_avail_from_cookie(cookie)) and kfree(cookie).
> > > > 
> > > > 
> > > > Ah. I'm forgetting the issue with the provider device instance
> > > > going away. In that case it may well have to copy the avail data
> > > > to fill the cookie returned to the consumer driver much like we
> > > > copy it now.+ free it.  We could do something smarter with that
> > > > cookie though to avoid a free if it's static const stuff as the
> > > > provider module should be locked in place I think.
> > > > 
> > > > > 
> > > > > > 
> > > > > > The current proposal just avoid the need for a cookie as for all known cases so far
> > > > > > provider_priv could == the channel requested.
> > > > > > 
> > > > > >   
> > > > > > > >     * consumers and producers manage the allocation differently, the
> > > > > > > >       first handles it via the inkern API, the second one in the
> > > > > > > >       producer driver code, making it inconsistent.  
> > > > > > 
> > > > > > The inkern API changes are mostly an attempt to reduce boiler plate. The only
> > > > > > case we really should be worrying about to my mind is the consumer wanting
> > > > > > to access the full available list. 
> > > > > >   
> > > > > > > > 
> > > > > > > > fix-2) adding a read_avail_with_copy(): a driver with both const avail
> > > > > > > > lists and mutable avail lists would always return a copy for all of
> > > > > > > > them, including the const ones. Example above.  
> > > > > > 
> > > > > > Hmm. So this could work but with the firm rule that a provider must never
> > > > > > provide both options and a core check on drivers to enforce that probe.
> > > > > > Any existing consumers must be modified to try both paths
> > > > > > (read_avail_with_copy then read_avail) to avoid regressions.
> > > > > > 
> > > > > > For future code, if we miss a case that doesn't do this then the upshot
> > > > > > is that the call will fail and the consumer needs fixing but at least
> > > > > > it is not a regression because it will never have worked for that
> > > > > > particular consumer + producer pair.  Not too horrible, but I'm not
> > > > > > really seeing it as better than option 1.
> > > > > >   
> > > > > > > > 
> > > > > > > > fix-3) adding a release_avail return param to read_avail(): this would
> > > > > > > > require a change to all the drivers using it. Also it
> > > > > > > > looks to me an unusual pattern, are there other similar patterns around
> > > > > > > > the codebase? Example below.  
> > > > > > 
> > > > > > No advantage that I can see vs an explicit get / release where the
> > > > > > release may do nothing if there was no allocation.
> > > > > >   
> > > > > > > > 
> > > > > > > > fix-4) adding a new enum variant to the avail type like
> > > > > > > > IIO_AVAIL_LIST_ALLOC: to me this looks hacky as it mixes the logic type
> > > > > > > > of the data structure and how it is handled in memory. I think the
> > > > > > > > latter should better fit in a different field, however this modification
> > > > > > > > would have little impact in the current code. Example below.  
> > > > > > 
> > > > > > This one I really don't like. Needs non obvious / subtle handling in the
> > > > > > consumer drivers.
> > > > > >   
> > > > > > > > 
> > > > > > > > So far these alternatives only consider moving the release of the copy
> > > > > > > > buffer in the IIO core but not its allocation.  
> > > > > > 
> > > > > > I'm confused.  Moving it in, or out of the core?  What does this mean
> > > > > > for a consumer driver after the avail list?
> > > > > >   
> > > > > > > You also suggest to make  
> > > > > > > > the IIO core take care of the copy allocation. The problem I see with
> > > > > > > > this is that if the copy is handled outside the driver it could take
> > > > > > > > place concurrently with the modification of the original buffer since it
> > > > > > > > would not be locked by driver private mutex, thus making the copy
> > > > > > > > useless. This might be worked around by adding an additional optional
> > > > > > > > callback (e.g. read_avail_will_copy/read_avail_is_mutable) to just take
> > > > > > > > the size and check if a copy will be provided, so maybe something like:
> > > > > > > > 
> > > > > > > > fix-5) iio_read_channel_info_avail():  
> > > > > > 
> > > > > > This is picking on the wrong code for this discussion.  Use
> > > > > > iio_read_avail_channel_attribute() for example because that's the one
> > > > > > where ABI matters.  Anything within the IIO core is just a question of
> > > > > > 'niceness' it isn't important like a function called by a consumer driver.
> > > > > > 
> > > > > > Code of a consumer driver will be similar to this however.  A few things
> > > > > > would be needed to make this pattern work.
> > > > > >    
> > > > > > > > {
> > > > > > > >     ...
> > > > > > > >     int *vals;
> > > > > > > >     bool copy = false;
> > > > > > > >     if (indio_dev->info->read_avail_will_copy) {
> > > > > > > >         copy = indio_dev->info->read_avail_will_copy(..., &length, ...);  
> > > > > > 
> > > > > > return length as 0 can reasonably mean we don't need to allocate.
> > > > > > That value must be the maximum possible size that can ever be needed, not the
> > > > > > current one.
> > > > > >   
> > > > > > > >         if (copy) {
> > > > > > > >             vals = kcalloc(length, sizeof(int), GFP_KERNEL);
> > > > > > > >         }
> > > > > > > >     }
> > > > > > > > 
> > > > > > > >     indio_dev->info->read_avail(&vals, ...);  
> > > > > > 
> > > > > > For iio_read_avail_channel_attribute it will a little fiddlier but end result
> > > > > > is the same but done under the exist lock. If the device went away before this
> > > > > > call then we will get an error, otherwise this will fill vals and provide
> > > > > > the right length. 
> > > > > >   
> > > > > > > > 
> > > > > > > >     if (ret < 0)
> > > > > > > >             return ret;
> > > > > > > >     switch (ret) {
> > > > > > > >     case IIO_AVAIL_LIST:
> > > > > > > >             ret = iio_format_avail_list(buf, vals, type, length);
> > > > > > > >     case IIO_AVAIL_RANGE:
> > > > > > > >             ret = iio_format_avail_range(buf, vals, type);
> > > > > > > >     default:
> > > > > > > >             ret = -EINVAL;
> > > > > > > >     }
> > > > > > > > 
> > > > > > > >     if (copy)
> > > > > > > >         kfree(vals);
> > > > > > > > }
> > > > > > > > 
> > > > > > > > If I am not missing anything this could work and maybe it could also
> > > > > > > > avoid the double copy on the consumers but would require all of them to
> > > > > > > > wrap the read_avail_will_copy(). Also, I find it quite a weird pattern
> > > > > > > > that in some cases vals would be an input buffer to be filled and in
> > > > > > > > other cases it would be a return argument pointing to the const buffer
> > > > > > > > stored inside the driver. At least I wouldn't say it's more robust than
> > > > > > > > the current fix-1.  
> > > > > > Agreed. It works, but I'm not seeing the advantage and the multiple use
> > > > > > of the vals parameter is too subtle to be maintainable.
> > > > > >   
> > > > > > > > 
> > > > > > > > All these alternatives also prevents some potential optimization already
> > > > > > > > mentioned before. Reporting it again as it is now lost in the mess below:
> > > > > > > >     Some driver might want to avoid allocating a new copy of a big table if
> > > > > > > >     the race does not occur (e.g. with additional checks on buffer access
> > > > > > > >     code) and thus wouldn't call a free() in the release callback.
> > > > > > > > 
> > > > > > > > In the end I don't find any of the above alternatives to provide an
> > > > > > > > obvious better solution.  
> > > > > > 
> > > > > > Agreed.  My only question vs just taking the existing solution is whether
> > > > > > it makes sense to use a more explicit struct iio_avail_cookie
> > > > > > to hold all the info that we pass to release.  I don't particularly like
> > > > > > that we'll end up allocating that cookie structure but it would make it more
> > > > > > like a typical get / release and perhaps closer to what readers would
> > > > > > expect to see?
> > > > > > 
> > > > > > What do you think?  
> > > > > 
> > > > > I cannot answer about what readers would expect since I am quite new to
> > > > > kernel internals and I was not aware about the cookie pattern myself.
> > > > > However, I agree that it seems more clear than the current solution but
> > > > > only if it's going to replace the iio_info read_avail() callback,
> > > > > otherwise I think that only using the cookie on the release callback
> > > > > would make it even more confusing. It is worth noting that in that case
> > > > > all current provider drivers defining the read_avail callback should be
> > > > > changed.
> > > > Key I think is we really don't need to be careful with what happens in inkern.c
> > > > (though obviously good to use infrastructure we invent for other things),
> > > > only what is presented by consumer.h interfaces to consumer drivers.
> > > > Those get and release the cookie.
> > > > 
> > > > That's a much smaller set of drivers to modify.
> > > > 
> > > > Or as Andy suggested, maybe it's just a question of naming and we need
> > > > a get and release but otherwise don't bother with the complexity of the cookie.
> > > > Maybe just rename read_avail to make it obvious.
> > > > 
> > > > Right now I'm thinking the cookie wrappers around get_avail / release_avail
> > > > to wrap up basically the parameters passed to get_avail + the output so
> > > > that we have a neat package to pass to release_avail will end up the neatest
> > > > solution but I may be wrong :(
> > > 
> > > If there is a way to address my issue above I can see some benefits in
> > > terms of clarity. In general I think it's more clear to return a struct
> > > instead of using return arguments, it would also simplify the __free()
> > > cleanup as we wouldn't need the additional *_retvals wrapper for that
> > > purpose. Also, I think using an inkern helper for the release adds more
> > > clarity to the consumer drivers even if it's just a wrapper to kfree(),
> > > but that could be achieved without the cookie too.
> > 
> > IIUC we need also new read_avail_alloc() which returns cookie structure,
> > in this case the read_aval_release() will take it as a parameter. It means
> > it will be the driver's responsibility to carry on the cookie.
> 
> I think this would be in contrast of Jonathan's suggestion to keep the
> cookie pattern out of the provider drivers scope.

In my understanding of cookies is that it's an opaque pointer / object,
so it is fine to pass it through the caller / user. We do cookies, e.g.,
in DMA engine subsystem and it's fine, the actual cookie's data is kept
out of the scope of the provider drivers.

Did I miss anything?

> > > What I am not sure about is what is the specific semantic of the cookie
> > > pattern. I mean that to me it's just a structure collecting all the
> > > avail info related fields. Is the _cookie suffix just to make it clear
> > > it's something that must be later released, or are there other
> > > implications? Also I see you are considering it as an opaque structure.
> > > To me it makes sense for the consumer driver to use getters (like
> > > iio_avail_from_cookie()) to access the fields, but maybe we could just
> > > access them directly from the inkern functions?
> > > 
> > > I am trying to put this together, for now I am stuck with the issue
> > > mentioned above about the case when the consumer driver forwards the
> > > provider avail data to the core. However, for the sake of example, let
> > > me share my current draft (hoping not to make this conversation even
> > > more messy). Please take a look to the NOTE comments.
> > > 
> > > fix-6) the cookie pattern for consumers
> > > 
> > > /* inkern.c */
> > > ...
> > > struct iio_avail_cookie { //NOTE: cookie suffix needed?
> > > 	const int *avail;
> > > 	int val_type; //NOTE: renamed from type to avoid confusion with former return type (SCALE|RANGE)
> > > 	int length;
> > > 	int type; //NOTE: former provider's return.
> > > 	void *provider_priv; //NOTE: necessary? can't it be retrieved from indio_dev directly?
> > > 	struct iio_dev *indio_dev; //NOTE: currently not used. Necessary?
> > > };
> > > 
> > > inline const int *iio_avail_from_cookie(struct iio_avail_cookie *cookie)
> > > {
> > > 	return cookie->avail;
> > > }
> > > EXPORT_SYMBOL_GPL(iio_avail_from_cookie);
> > > 
> > > inline int iio_avail_val_type_from_cookie(struct iio_avail_cookie *cookie)
> > > {
> > > 	return cookie->val_type;
> > > }
> > > EXPORT_SYMBOL_GPL(iio_avail_val_type_from_cookie);
> > > 
> > > ...
> > > 
> > > // NOTE: this is the former iio_channel_read_avail(), suggesting __ prefix as
> > > // it is only used locally in inkern.c
> > > static struct iio_avail_cookie *
> > > __iio_channel_avail_get(struct iio_channel *chan, enum iio_chan_info_enum info)
> > > {
> > > 	const struct iio_info *iio_info = chan->indio_dev->info;
> > > 
> > > 	if (!iio_channel_has_available(chan->channel, info))
> > > 		return ERR_PTR(-EINVAL);
> > > 
> > > 	if (iio_info->read_avail) {
> > > 		const int *vals_tmp;
> > > 		const int *vals_copy;
> > > 		int type;
> > > 		int length;
> > > 		int ret;
> > > 
> > > 		ret = iio_info->read_avail(chan->indio_dev, chan->channel,
> > > 					   &vals_tmp, &type, &length, info);
> > > 		if (ret < 0)
> > > 			return ERR_PTR(ret);
> > > 
> > > 		/*
> > > 		 * Copy the producer's avail buffer with lock_exists locked to
> > > 		 * avoid possible race with producer unregistration.
> > > 		 */
> > > 		vals_copy = kmemdup_array(vals_tmp, length, sizeof(int),
> > > 					  GFP_KERNEL);
> > > 		if (!vals_copy)
> > > 			return ERR_PTR(-ENOMEM);
> > > 
> > > 		if (iio_info->read_avail_release_resource)
> > > 			iio_info->read_avail_release_resource(
> > > 				chan->indio_dev, chan->channel, vals_tmp, info);
> > > 
> > > 		struct iio_avail_cookie *cookie =
> > > 			kzalloc(sizeof(struct iio_avail_cookie), GFP_KERNEL);
> > > 
> > > 		cookie->avail = vals_copy;
> > > 		cookie->val_type = type;
> > > 		cookie->length = length;
> > > 		cookie->type = ret;
> > > 		cookie->provider_priv = chan->indio_dev->priv;
> > > 		cookie->indio_dev = chan->indio_dev;
> > > 
> > > 		return cookie;
> > > 	}
> > > 	return ERR_PTR(-EINVAL);
> > > }
> > > 
> > > // NOTE: this is the former iio_read_avail_channel_attribute()
> > > struct iio_avail_cookie *iio_channel_avail_get(struct iio_channel *chan,
> > > 					       enum iio_chan_info_enum info)
> > > {
> > > 	struct iio_dev_opaque *iio_dev_opaque =
> > > 		to_iio_dev_opaque(chan->indio_dev);
> > > 
> > > 	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > > 	if (!chan->indio_dev->info)
> > > 		return ERR_PTR(-ENODEV);
> > > 
> > > 	return __iio_channel_avail_get(chan, info);
> > > }
> > > EXPORT_SYMBOL_GPL(iio_channel_avail_get);
> > > 
> > > void iio_channel_avail_release(struct iio_avail_cookie *cookie)
> > > {
> > > 	kfree(cookie->avail);
> > > 	kfree(cookie);
> > > }
> > > EXPORT_SYMBOL_GPL(iio_channel_avail_release);
> > > 
> > > //NOTE: this is the former iio_read_avail_channel_raw()
> > > struct iio_avail_cookie *iio_channel_avail_get_raw(struct iio_channel *chan)
> > > {
> > > 	struct iio_avail_cookie *cookie;
> > > 
> > > 	cookie = iio_channel_avail_get(chan, IIO_CHAN_INFO_RAW);
> > > 
> > > 	if (cookie && cookie->val_type != IIO_VAL_INT) {
> > > 		/* raw values are assumed to be IIO_VAL_INT */
> > > 		iio_channel_avail_release(cookie);
> > > 		return ERR_PTR(-EINVAL);
> > > 	}
> > > 
> > > 	return cookie;
> > > }
> > > EXPORT_SYMBOL_GPL(iio_channel_avail_get_raw);
> > > 
> > > //NOTE: a usage example inside inkern.c
> > > static int iio_channel_read_max(struct iio_channel *chan,
> > > 				int *val, int *val2, int *type,
> > > 				enum iio_chan_info_enum info)
> > > {
> > > 	struct iio_avail_cookie *cookie __free(iio_avail_cookie) =
> > > 		iio_channel_avail_get(chan, info);
> > > 
> > > 	if (IS_ERR(cookie))
> > > 		return PTR_ERR(cookie);
> > > 
> > > 	*type = cookie->val_type;
> > > 
> > > 	switch (cookie->type) {
> > > 	case IIO_AVAIL_RANGE:
> > > 		switch (*type) {
> > > 		case IIO_VAL_INT:
> > > 			*val = cookie->avail[2];
> > > 			break;
> > > 		default:
> > > 			*val = cookie->avail[4];
> > > 			if (val2)
> > > 				*val2 = cookie->avail[5];
> > > 		}
> > > 		return 0;
> > > 	...
> > > }
> > > 
> > > /* consumers.h */
> > > 
> > > struct iio_avail_cookie;
> > > 
> > > //TODO: docs
> > > 
> > > struct iio_avail_cookie *iio_channel_avail_get(struct iio_channel *chan,
> > > 					       enum iio_chan_info_enum info);
> > > struct iio_avail_cookie *iio_channel_avail_get_raw(struct iio_channel *chan);
> > > inline const int *iio_avail_from_cookie(struct iio_avail_cookie *cookie);
> > > inline int iio_avail_val_type_from_cookie(struct iio_avail_cookie *cookie);
> > > inline int iio_avail_length_from_cookie(struct iio_avail_cookie *cookie);
> > > inline int iio_avail_type_from_cookie(struct iio_avail_cookie *cookie);
> > > 
> > > void iio_channel_avail_release(struct iio_avail_cookie *cookie);
> > > 
> > > DEFINE_FREE(iio_avail_cookie, struct iio_avail_cookie *, iio_channel_avail_release(_T))
> > > 
> > > /* ingenic-battery.c: a usage example for consumer drivers */
> > > 
> > > static int ingenic_battery_set_scale(struct ingenic_battery *bat)
> > > {
> > > 	const int *scale_vals;
> > > 	...
> > > 
> > > 	struct iio_avail_cookie *scale __free(iio_avail_cookie) =
> > > 		iio_channel_avail_get(bat->channel, IIO_CHAN_INFO_SCALE);
> > > 
> > > 	if (IS_ERR(scale)) {
> > > 		dev_err(bat->dev, "Unable to read channel avail scale\n");
> > > 		return PTR_ERR(scale);
> > > 	}
> > > 	if (iio_avail_type_from_cookie(scale) != IIO_AVAIL_LIST ||
> > > 	    iio_avail_type_from_cookie(scale) != IIO_VAL_FRACTIONAL_LOG2)
> > > 		return -EINVAL;
> > > 
> > > 	scale_vals = iio_avail_from_cookie(scale);
> > > 	//NOTE: can later access scale_vals[i]
> > > 	...
> > > 	return 0;
> > > }
> > > 
> > > /* dpto-dac.c: a problematic usage example for consumers forwarding
> > >  * providers data directly back to the core for sysfs exposure */
> > > 
> > > static int dpot_dac_read_avail(struct iio_dev *indio_dev,
> > > 			       struct iio_chan_spec const *chan,
> > > 			       const int **vals, int *type, int *length,
> > > 			       long mask)
> > > {
> > > 	struct dpot_dac *dac = iio_priv(indio_dev);
> > > 
> > > 	switch (mask) {
> > > 	case IIO_CHAN_INFO_RAW: {
> > > 		struct iio_avail_cookie *avail;
> > > 
> > > 		avail = iio_channel_avail_get_raw(dac->dpot);
> > > 		if (IS_ERR(avail))
> > > 			return PTR_ERR(avail);
> > > 
> > > 		*vals = iio_avail_from_cookie(avail);
> > > 		*type = iio_avail_val_type_from_cookie(avail);
> > > 		*length = iio_avail_length_from_cookie(avail);
> > > 		return iio_avail_type_from_cookie(avail);
> > > 		//NOTE: cookie gets lost.
> > > 	}
> > > 	}
> > > 
> > > 	return -EINVAL;
> > > }
> > > 
> > > static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > 					    struct iio_chan_spec const *chan,
> > > 					    const int *vals, long mask)
> > > {
> > > 	kfree(vals);
> > > 	//NOTE: we can't call iio_channel_avail_release() without the cookie
> > > }
> > > 
> > > ...
> > > 
> > > static const struct iio_info dpot_dac_info = {
> > > 	.read_avail = dpot_dac_read_avail,
> > > 	.read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > };
> > > 
> > > What do you think?
> > 
> > > > > > > > > > > > > > > What I was referring to is that, back then, you mentioned you would have
> > > > > > > > > > > > > > > preferred to avoid passing ownership of the buffer around:
> > > > > > > > > > > > > > >     
> > > > > > > > > > > > > > > > That's a corner case we should think about closing. Would require an indicator
> > > > > > > > > > > > > > > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > > > > > > > > > > > > > > free on completion of the string building.  I don't like passing ownership
> > > > > > > > > > > > > > > > of data around like that, but it is fiddly to do anything else given
> > > > > > > > > > > > > > > > any simple double buffering is subject to race conditions.      
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > I guess there is some other reason other than avoiding the copy when not
> > > > > > > > > > > > > > > necessary, since by introducing an additional function or argument or return
> > > > > > > > > > > > > > > type, most of the unnecessary copies would already be avoided right?    
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > It's not a strong reason beyond limiting scope of clever design +
> > > > > > > > > > > > > > the key bit my mind is that the above is not substantially simpler and
> > > > > > > > > > > > > > reduces our flexibility.
> > > > > > > > > > > > > >     
> > > > > > > > > > > > > > > Anyway any of this solutions would still prevent the potential optimizations of
> > > > > > > > > > > > > > > point 2). It's worth mentioning that those kind of optimizations are currently
> > > > > > > > > > > > > > > not adopted by any driver.    
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > That one indeed not, but mixing dynamic and non dynamic is something
> > > > > > > > > > > > > > you do in your pac1921 patch.    
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Good point! I didn't think about it, or more likely I forgot, that with an
> > > > > > > > > > > > > additional read_avail_with_copy() used as in the example you cannot mix dynamic
> > > > > > > > > > > > > and non dynamic available lists, thus those drivers that need at least one
> > > > > > > > > > > > > dynamic available list would always copy all of them as they need to rely to
> > > > > > > > > > > > > the read_avail_with_copy(). I guess this could be worked around with an
> > > > > > > > > > > > > additional return argument for the read_avail() or an additional type like the
> > > > > > > > > > > > > IIO_AVAIL_LIST_ALLOC suggested by Andy to signal the caller it needs to free
> > > > > > > > > > > > > the list after use. However, I think they would introduce a more invasive
> > > > > > > > > > > > > change in the current API compared to an additional optional callback,    
> > > > > > > > > > > 
> > > > > > > > > > > It even sounds originally that it should be more invasive, so I don't think it's
> > > > > > > > > > > a problem here.    
> > > > > > > > > > 
> > > > > > > > > > In the hope it helps the discussion let me provide examples for the
> > > > > > > > > > additional two options we have other than the current
> > > > > > > > > > read_avail_release_resource() (fix-1) and the read_avail_with_copy()
> > > > > > > > > > (fix-2) already shown above:    
> > > > > > > > > 
> > > > > > > > > Thanks!
> > > > > > > > >     
> > > > > > > > > > fix-3) iio_read_channel_info_avail():
> > > > > > > > > > {
> > > > > > > > > >     ...
> > > > > > > > > >     bool release_avail = false;
> > > > > > > > > > 
> > > > > > > > > >     ret = indio_dev->info->read_avail(vals, ..., &release_avail);
> > > > > > > > > > 
> > > > > > > > > >     ...
> > > > > > > > > >     ret = iio_format_avail_list(vals, ...);
> > > > > > > > > >     ...
> > > > > > > > > > 
> > > > > > > > > >     if (release_avail)
> > > > > > > > > >         kfree(vals);
> > > > > > > > > > 
> > > > > > > > > >     return ret;
> > > > > > > > > > }
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > fix-4) iio_read_channel_info_avail():
> > > > > > > > > > {
> > > > > > > > > >     ...
> > > > > > > > > >     indio_dev->info->read_avail(vals, ...);
> > > > > > > > > > 
> > > > > > > > > >     if (ret < 0)
> > > > > > > > > >             return ret;
> > > > > > > > > >     switch (ret) {
> > > > > > > > > >     case IIO_AVAIL_LIST_ALLOC:
> > > > > > > > > >             ret = iio_format_avail_list(buf, vals, type, length);
> > > > > > > > > >             kfree(vals);
> > > > > > > > > >             return ret;
> > > > > > > > > >     case IIO_AVAIL_LIST:
> > > > > > > > > >             return iio_format_avail_list(buf, vals, type, length);
> > > > > > > > > >     case IIO_AVAIL_RANGE:
> > > > > > > > > >             return iio_format_avail_range(buf, vals, type);
> > > > > > > > > >     default:
> > > > > > > > > >             return -EINVAL;
> > > > > > > > > >     }
> > > > > > > > > > }
> > > > > > > > > >     
> > > > > > > > > > > > > so I agree that the current release callback is still a better option.    
> > > > > > > > > > > 
> > > > > > > > > > > I disagree on this as I pointed above why.
> > > > > > > > > > >     
> > > > > > > > > > > > > > > > > 2) Some driver might want to avoid allocating a new copy of a big table if
> > > > > > > > > > > > > > > > >    the race does not occur (e.g. with additional checks on buffer access
> > > > > > > > > > > > > > > > >    code) and thus wouldn't call a free() in the release callback.
> > > > > > > > > > > > > > > > >       
> > > > > > > > > > > > > > > > > > In any case it looks fragile and not scalable. I propose to drop this
> > > > > > > > > > > > > > > > > > and think again.        
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > I see your concerns, I am open to reconsider this in case we come up with
> > > > > > > > > > > > > > > > > better solution after addressing the points above.
> > > > > > > > > > > > > > > > >       
> > > > > > > > > > > > > > > > > > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > > > > > > > > > > > > > > > > > agree on the report, I think this solution is not good enough.    
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/    
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > I hope I've brought a little more clarity to the discussion by providing some
> > > > > > > > > > > > > > > history instead of making it more confusing.    
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Sure, the code example in particular is useful.    
> > > > > > > > > > > > 
> > > > > > > > > > > > Just a friendly reminder this has been sitting for a while, any news or
> > > > > > > > > > > > additional considerations?    
> > > > > > > > > > > 
> > > > > > > > > > > Moving the allocation control to the drivers will satisfy me as well, however
> > > > > > > > > > > it makes even more duplication of the code, but at least it will be cleaner
> > > > > > > > > > > design-wise in my opinion.    
> > > > > > > > > > 
> > > > > > > > > > Would it work with the constraints on the info_exists lock mentioned
> > > > > > > > > > above?    
> > > > > > > > > 
> > > > > > > > > None of the given examples (fix-N) provides a lock, so I have no clue how it's
> > > > > > > > > involved here. May be you can elaborate more?    
> > > > > > > > 
> > > > > > > > I thought that with "Moving the allocation control to the drivers" you
> > > > > > > > were referring to the option (not included among fix-N) to move the
> > > > > > > > allocation of the consumer copy from the inkern iio_channel_read_avail()
> > > > > > > > to the consumer drivers themselves. You elaborated this point above
> > > > > > > > where I answered with the concerns about the info_exists lock that
> > > > > > > > should be addressed.
> > > > > > > >     
> > > > > > > > > > > In any case the last word is on Jonathan.    

-- 
With Best Regards,
Andy Shevchenko



