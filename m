Return-Path: <linux-iio+bounces-12400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF19D2541
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 13:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEAA2822E2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBA1CC16B;
	Tue, 19 Nov 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWiq+SJB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F51CBE8E;
	Tue, 19 Nov 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017942; cv=none; b=IKhPCNyImUGQx5TzsC3vYk/CEoWsPYDIKS3huInnvu+X8wnPtncsxF3H2yR1NEKOJrYNtWZROJ0jWQzyMuUxRKZl8zj47I2e/aZAJhnXB0w0cX5R3XR+WiZvsA8drpZlCXU1naKFUL+TDT89Nmk95o4KHlADa3OG1CKPKX3v3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017942; c=relaxed/simple;
	bh=lkUhTtmD41kYzlKoV3HaIOM3wy8l6VKIfJ9LVuwA5So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuL/Jd65yoLWR5jTS4LM92hR7VShFFrNm0jeDUXGpCC87w8vbn83AZAMP32PO/lcPaIMHzIpL0jUEAplnhmAGKOpuouR4pt0Pm6BT1HCAPcF2/cciq0uuIlDQFXAwIZuwmJ3jxBUSJAFGqhcoiUywgN42b4sD6TxZDCKe37gq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWiq+SJB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732017939; x=1763553939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lkUhTtmD41kYzlKoV3HaIOM3wy8l6VKIfJ9LVuwA5So=;
  b=PWiq+SJBJzXLaTKJ2K9U3qhBz+xB4fiwG3IGl6FC2uGG0AGyqRdMxrqz
   IAo/7KFHIyavE+JPz/vwrDOGB2pG+WOwawkdDdTwCpwQvrEFZIhI6lQvI
   r9oWzShOnlEGhx1Mcocr9bPGR+orvvYHpjdRAVQaGr32yuGTbM9PJr5Ra
   ahUjsUaAMK6AfQ+C3/gQguPDP/W/AhW4BqeZm+z2gVdwbbK1LqD3bJnZZ
   jwAaI1PVgwhCx3r+kjAHxSw1Mdjto4WMPsT5ENBi1ux2uEBNzmTqhfhN+
   AtvR8RcIjPmAI1//m9qOmau0fU4q84wUUB9ccaJGEsgCX2Yt/UKbYzHz7
   w==;
X-CSE-ConnectionGUID: CZdfDj8pRGGkWuEmXiPTmw==
X-CSE-MsgGUID: SnZEqAnbRD26N/anZF1inw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="35919442"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="35919442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 04:05:38 -0800
X-CSE-ConnectionGUID: pWtH3QdnSW67QskGe3OutA==
X-CSE-MsgGUID: mUI9pTApTRSudc3MBX30ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="94369827"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 04:05:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tDMz6-0000000GLhK-0aor;
	Tue, 19 Nov 2024 14:05:32 +0200
Date: Tue, 19 Nov 2024 14:05:31 +0200
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
Message-ID: <Zzx_C60W48ujpis9@smile.fi.intel.com>
References: <173031260171.39393.109639772708550094@njaxe.localdomain>
 <20241030203050.5cdf3450@jic23-huawei>
 <173037398492.12348.265826723028347056@njaxe.localdomain>
 <20241031143129.0000014e@Huawei.com>
 <173039799203.1353.4404042832923090619@njaxe.localdomain>
 <b56ba6a0db195ad44158509f3adb157b@gmail.com>
 <ZzsVOGvzgNTvuEtD@smile.fi.intel.com>
 <e56a8f3c81429c465e87a3abcccec1b4@gmail.com>
 <Zztlz08Wm-mGdy7p@smile.fi.intel.com>
 <65e16f628245a78da5c9d870d6c5c5a9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e16f628245a78da5c9d870d6c5c5a9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 19, 2024 at 12:25:18PM +0100, Matteo Martelli wrote:
> On Mon, 18 Nov 2024 18:05:35 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Nov 18, 2024 at 03:45:25PM +0100, Matteo Martelli wrote:
> > > On Mon, 18 Nov 2024 12:21:44 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > On Fri, Nov 15, 2024 at 03:25:06PM +0100, Matteo Martelli wrote:
> > > > > On Thu, 31 Oct 2024 19:06:32 +0100, Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > > > Quoting Jonathan Cameron (2024-10-31 15:31:29)
> > > > > > > On Thu, 31 Oct 2024 12:26:24 +0100
> > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > > > > > Quoting Jonathan Cameron (2024-10-30 21:30:50)
> > > > > > > > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > > > > > > > Quoting Andy Shevchenko (2024-10-30 15:47:50)  
> > > > > > > > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:    

> > > > > > > > > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > > > > > > > > callback after reading producer's available info. To avoid a race
> > > > > > > > > > > > condition with the producer unregistration, change inkern
> > > > > > > > > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > > > > > > > > producer and immediately calls its release callback with info_exists
> > > > > > > > > > > > locked.
> > > > > > > > > > > > 
> > > > > > > > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > > > > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > > > > > > > > after calling these functions. To let users free the copied buffer with
> > > > > > > > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > > > > > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > > > > > > > > but stores the available values in the returned variable.    

...

> > > > > > > > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > > > > > > > > +                                         struct iio_chan_spec const *chan,
> > > > > > > > > > > > +                                         const int *vals, long mask)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     kfree(vals);
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > >                             struct iio_chan_spec const *chan,
> > > > > > > > > > > >                             int val, int val2, long mask)
> > > > > > > > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > >  static const struct iio_info dpot_dac_info = {
> > > > > > > > > > > >       .read_raw = dpot_dac_read_raw,
> > > > > > > > > > > >       .read_avail = dpot_dac_read_avail,
> > > > > > > > > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > > > > > > > >       .write_raw = dpot_dac_write_raw,
> > > > > > > > > > > >  };    
> > > > > > > > > > > 
> > > > > > > > > > > I have a problem with this approach. The issue is that we allocate
> > > > > > > > > > > memory in one place and must clear it in another. This is not well
> > > > > > > > > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > > > > > > > > at least these two comes to my mind:
> > > > > > > > > > > 
> > > > > > > > > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > > > > > > > > name) that will dump the data to the intermediate buffer and clean it
> > > > > > > > > > > after all;
> > > > > > > > > > > 
> > > > > > > > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.    
> > > > > > > > > > 
> > > > > > > > > > Could you elaborate more about these potential solutions? Maybe with some
> > > > > > > > > > usage examples?
> > > > > > > > > > 
> > > > > > > > > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > > > > > > > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > > > > > > > > case, so that it would take care of freeing the buffer after calling
> > > > > > > > > > iio_format_after_*(). We considered this approach during an initial
> > > > > > > > > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > > > > > > > > to let the driver keep the release control through a callback for two
> > > > > > > > > > reasons:
> > > > > > > > > > 
> > > > > > > > > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > > > > > > > > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > > > > > > > > >    could still keep the buffer copy in its private data after giving it away,
> > > > > > > > > >    resulting in fact in a double ownership. However I think it would be clear
> > > > > > > > > >    enough in this case that the copy should be handled by the caller, or maybe
> > > > > > > > > >    not?  
> > > > > > > > > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > > > > > > > > not needed and that it prevents any optimization like you mention.  
> > > > > > > > 
> > > > > > > > I think the suggestion here is to add an additional .read_avail_with_copy()
> > > > > > > > without replacing the original .read_avail(), so all the current drivers that
> > > > > > > > use a constant avail list would not be affected.

> > > > Yes.

> > > > > > > > And I think this was the same
> > > > > > > > idea for the additional read_avail_ext() or the additional argument for the
> > > > > > > > read_avail() we were considering in [1]. So I would think that
> > > > > > > > iio_read_channel_info_avail() would do something like the following:
> > > > > > > > 
> > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > >         indio_dev->info->read_avail_with_copy(vals);
> > > > > > > >     else
> > > > > > > >         indio_dev->info->read_avail(vals);
> > > > > > > > 
> > > > > > > >     ...
> > > > > > > >     iio_format_avail_list(vals);
> > > > > > > >     ...
> > > > > > > > 
> > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > >         kfree(vals);
> > > > 
> > > > Right. At least that's what I see can be done with the existing users.
> > > > 
> > > > > > > Ok, sure that would work, but...
> > > > > > > 
> > > > > > > I don't really see this as being much less fragile than
> > > > > > > the existing solution + in cases that we do have where
> > > > > > > only some available are not const we will have to copy them
> > > > > > > all.
> > > > > > > 
> > > > > > > If anything it's more complex than making it a driver problem
> > > > > > > to provide the release call however it wants to do it.
> > > > 
> > > > ...but make a driver to allocate what's needed as well then.
> > > > 
> > > > > > > > And the drivers would choose whether to define the read_avail or the
> > > > > > > > read_avail_with_copy.
> > > > 
> > > > Either way drivers should know what to do with a data supplied to read_aval().
> > > > In one case we assume the [simple] workflow in the core, in the other we all
> > > > rely on the driver. Current approach makes a mix of these two. And that's what
> > > > I don't like.
> > > 
> > > If I understand your concern correctly, you are referring to the inkern
> > > iio_channel_read_avail() that makes the allocation for the consumer's
> > > buffer copy and you are suggesting that such copy should be done by the
> > > consumer driver code itself, this to be consistent with the producer
> > > drivers which directly handle the allocation of the copy.
> > 
> > One of the options, yes.
> > 
> > > One thing to notice is that the inkern iio_channel_read_avail() does
> > > together producer->read_avail() + copy + producer->read_avail_release()
> > > with info_exists locked. Also, the consumer driver would need to know
> > > the avail buffer size to allocate the buffer copy prior the
> > > iio_channel_read_avail() call, but such size is unknown before calling
> > > the actual producer's read_avail(). This would mean calling the
> > > producer's read_avail() and read_avail_release() callbacks separately
> > > without the lock held, with the risk of a memleak if the producer is
> > > unregistered between those calls.
> > 
> > Thanks for explaining this, but it even more makes me think that the design
> > is broken and your approach is rather a hack. So, what's the problem to
> > make IIO core to take care of the allocating and cleaning then without driver
> > being involved? Yes, this might require a hint from the driver on what to copy
> > if we want to avoid copying everything.
> 
> I am not particularly against it, other than the concerns that have
> emerged during this (and previous) discussion. Let me summarize them:

Thank you for a very good summary and fix-N proposals. I think I have nothing
to add and we should wait for Jonathan to finally choose (or propose a fix-N+1)
here.

> fix-1) the current one. Your concerns are:
>     * for consumers the copy allocation is taken care by the inkern API
>       but the release is handled by the consumer driver code, making it
>       a fragile design.
>     * consumers and producers manage the allocation differently, the
>       first handles it via the inkern API, the second one in the
>       producer driver code, making it inconsistent.
> 
> fix-2) adding a read_avail_with_copy(): a driver with both const avail
> lists and mutable avail lists would always return a copy for all of
> them, including the const ones. Example above.
> 
> fix-3) adding a release_avail return param to read_avail(): this would
> require a change to all the drivers using it. Also it
> looks to me an unusual pattern, are there other similar patterns around
> the codebase? Example below.
> 
> fix-4) adding a new enum variant to the avail type like
> IIO_AVAIL_LIST_ALLOC: to me this looks hacky as it mixes the logic type
> of the data structure and how it is handled in memory. I think the
> latter should better fit in a different field, however this modification
> would have little impact in the current code. Example below.
> 
> So far these alternatives only consider moving the release of the copy
> buffer in the IIO core but not its allocation. You also suggest to make
> the IIO core take care of the copy allocation. The problem I see with
> this is that if the copy is handled outside the driver it could take
> place concurrently with the modification of the original buffer since it
> would not be locked by driver private mutex, thus making the copy
> useless. This might be worked around by adding an additional optional
> callback (e.g. read_avail_will_copy/read_avail_is_mutable) to just take
> the size and check if a copy will be provided, so maybe something like:
> 
> fix-5) iio_read_channel_info_avail():
> {
>     ...
>     int *vals;
>     bool copy = false;
>     if (indio_dev->info->read_avail_will_copy) {
>         copy = indio_dev->info->read_avail_will_copy(..., &length, ...);
>         if (copy) {
>             vals = kcalloc(length, sizeof(int), GFP_KERNEL);
>         }
>     }
> 
>     indio_dev->info->read_avail(&vals, ...);
> 
>     if (ret < 0)
>             return ret;
>     switch (ret) {
>     case IIO_AVAIL_LIST:
>             ret = iio_format_avail_list(buf, vals, type, length);
>     case IIO_AVAIL_RANGE:
>             ret = iio_format_avail_range(buf, vals, type);
>     default:
>             ret = -EINVAL;
>     }
> 
>     if (copy)
>         kfree(vals);
> }
> 
> If I am not missing anything this could work and maybe it could also
> avoid the double copy on the consumers but would require all of them to
> wrap the read_avail_will_copy(). Also, I find it quite a weird pattern
> that in some cases vals would be an input buffer to be filled and in
> other cases it would be a return argument pointing to the const buffer
> stored inside the driver. At least I wouldn't say it's more robust than
> the current fix-1.
> 
> All these alternatives also prevents some potential optimization already
> mentioned before. Reporting it again as it is now lost in the mess below:
>     Some driver might want to avoid allocating a new copy of a big table if
>     the race does not occur (e.g. with additional checks on buffer access
>     code) and thus wouldn't call a free() in the release callback.
> 
> In the end I don't find any of the above alternatives to provide an
> obvious better solution.
> 
> > > > > > > > What I was referring to is that, back then, you mentioned you would have
> > > > > > > > preferred to avoid passing ownership of the buffer around:
> > > > > > > > 
> > > > > > > > > That's a corner case we should think about closing. Would require an indicator
> > > > > > > > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > > > > > > > free on completion of the string building.  I don't like passing ownership
> > > > > > > > > of data around like that, but it is fiddly to do anything else given
> > > > > > > > > any simple double buffering is subject to race conditions.  
> > > > > > > > 
> > > > > > > > I guess there is some other reason other than avoiding the copy when not
> > > > > > > > necessary, since by introducing an additional function or argument or return
> > > > > > > > type, most of the unnecessary copies would already be avoided right?
> > > > > > > 
> > > > > > > It's not a strong reason beyond limiting scope of clever design +
> > > > > > > the key bit my mind is that the above is not substantially simpler and
> > > > > > > reduces our flexibility.
> > > > > > > 
> > > > > > > > Anyway any of this solutions would still prevent the potential optimizations of
> > > > > > > > point 2). It's worth mentioning that those kind of optimizations are currently
> > > > > > > > not adopted by any driver.
> > > > > > > 
> > > > > > > That one indeed not, but mixing dynamic and non dynamic is something
> > > > > > > you do in your pac1921 patch.
> > > > > > 
> > > > > > Good point! I didn't think about it, or more likely I forgot, that with an
> > > > > > additional read_avail_with_copy() used as in the example you cannot mix dynamic
> > > > > > and non dynamic available lists, thus those drivers that need at least one
> > > > > > dynamic available list would always copy all of them as they need to rely to
> > > > > > the read_avail_with_copy(). I guess this could be worked around with an
> > > > > > additional return argument for the read_avail() or an additional type like the
> > > > > > IIO_AVAIL_LIST_ALLOC suggested by Andy to signal the caller it needs to free
> > > > > > the list after use. However, I think they would introduce a more invasive
> > > > > > change in the current API compared to an additional optional callback,
> > > > 
> > > > It even sounds originally that it should be more invasive, so I don't think it's
> > > > a problem here.
> > > 
> > > In the hope it helps the discussion let me provide examples for the
> > > additional two options we have other than the current
> > > read_avail_release_resource() (fix-1) and the read_avail_with_copy()
> > > (fix-2) already shown above:
> > 
> > Thanks!
> > 
> > > fix-3) iio_read_channel_info_avail():
> > > {
> > >     ...
> > >     bool release_avail = false;
> > > 
> > >     ret = indio_dev->info->read_avail(vals, ..., &release_avail);
> > > 
> > >     ...
> > >     ret = iio_format_avail_list(vals, ...);
> > >     ...
> > > 
> > >     if (release_avail)
> > >         kfree(vals);
> > > 
> > >     return ret;
> > > }
> > > 
> > > 
> > > fix-4) iio_read_channel_info_avail():
> > > {
> > >     ...
> > >     indio_dev->info->read_avail(vals, ...);
> > > 
> > >     if (ret < 0)
> > >             return ret;
> > >     switch (ret) {
> > >     case IIO_AVAIL_LIST_ALLOC:
> > >             ret = iio_format_avail_list(buf, vals, type, length);
> > >             kfree(vals);
> > >             return ret;
> > >     case IIO_AVAIL_LIST:
> > >             return iio_format_avail_list(buf, vals, type, length);
> > >     case IIO_AVAIL_RANGE:
> > >             return iio_format_avail_range(buf, vals, type);
> > >     default:
> > >             return -EINVAL;
> > >     }
> > > }
> > > 
> > > > > > so I agree that the current release callback is still a better option.
> > > > 
> > > > I disagree on this as I pointed above why.
> > > > 
> > > > > > > > > > 2) Some driver might want to avoid allocating a new copy of a big table if
> > > > > > > > > >    the race does not occur (e.g. with additional checks on buffer access
> > > > > > > > > >    code) and thus wouldn't call a free() in the release callback.
> > > > > > > > > >   
> > > > > > > > > > > In any case it looks fragile and not scalable. I propose to drop this
> > > > > > > > > > > and think again.    
> > > > > > > > > > 
> > > > > > > > > > I see your concerns, I am open to reconsider this in case we come up with
> > > > > > > > > > better solution after addressing the points above.
> > > > > > > > > >   
> > > > > > > > > > > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > > > > > > > > > > agree on the report, I think this solution is not good enough.
> > > > > > > > > > 
> > > > > > > > > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/
> > > > > > > > 
> > > > > > > > I hope I've brought a little more clarity to the discussion by providing some
> > > > > > > > history instead of making it more confusing.
> > > > > > > 
> > > > > > > Sure, the code example in particular is useful.
> > > > > 
> > > > > Just a friendly reminder this has been sitting for a while, any news or
> > > > > additional considerations?
> > > > 
> > > > Moving the allocation control to the drivers will satisfy me as well, however
> > > > it makes even more duplication of the code, but at least it will be cleaner
> > > > design-wise in my opinion.
> > > 
> > > Would it work with the constraints on the info_exists lock mentioned
> > > above?
> > 
> > None of the given examples (fix-N) provides a lock, so I have no clue how it's
> > involved here. May be you can elaborate more?
> 
> I thought that with "Moving the allocation control to the drivers" you
> were referring to the option (not included among fix-N) to move the
> allocation of the consumer copy from the inkern iio_channel_read_avail()
> to the consumer drivers themselves. You elaborated this point above
> where I answered with the concerns about the info_exists lock that
> should be addressed.
> 
> > > > In any case the last word is on Jonathan.

-- 
With Best Regards,
Andy Shevchenko



