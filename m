Return-Path: <linux-iio+bounces-12524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1999D6965
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BE3281A4A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430461C683;
	Sat, 23 Nov 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljQzI1PK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664B14287;
	Sat, 23 Nov 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732371209; cv=none; b=glhbcM03NIWL20bnq6dWL0do9VlHfYHYi1+E1MhwY597QGyaFt/u/Zlu8M6pMC/O59DLT0SQ3xurX1DHaNFKUEShyY5SON/WdgIcTcjrA3eqVh7hYQtPtMaWBfzY9uZqhEvZiEqxTHKHqqqBH34FciTLdiTILn5hRXfEXoiIIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732371209; c=relaxed/simple;
	bh=uNCVEqdpLOAM74CzMd9OrzhoFRhSHRD1NCMnXYNfSnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8Kmh1tp3Xlt9/148G4KElQm0rTLQh3wHawJ4FMvDu93dXbsrMl+dB+IDGLFSsuAPRw0ZjjVnPC3av/bgCpX2Is5gqK59T+8Cb7yjbrmQZoUpoGr08bE+wlZriJ55xPq4gvhu3U5K1emZsa7Ck6YqGPXjhjTltdbnCEPeC1JnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljQzI1PK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEC0C4CECD;
	Sat, 23 Nov 2024 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732371208;
	bh=uNCVEqdpLOAM74CzMd9OrzhoFRhSHRD1NCMnXYNfSnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljQzI1PKyUziI9VNbQ72cqXnGNzrktLKAELwQN81+plAf323U8XaYO8m291SypXSB
	 53TNx+Rj6RRb5G4v70KkroLYi1joRz6vHUPlvNFy2IOKzGA4QnyPFQolwLbyL5Uh8X
	 6WbDR1gIo2TV14EPhK+S7sBaFJXceXVTzgHzHubwdBfh8Y8F+e7M0pqr6xgaHrmYnN
	 i9LGdekcTcjMdqq6k6QnLpu/Xxs/nqDG5bZ+J9pkzYrGlKNSkZIMHq2Ku2jz+c4ppR
	 Xcge8xgyZXTBzgxgvA/apO53TuyvgXADcLqExE+bWH8RuxLQfk60p3RdoW0XU1CXUX
	 eJhVlCse4EReA==
Date: Sat, 23 Nov 2024 14:13:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matteo Martelli <matteomartelli3@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <20241123141320.326b3340@jic23-huawei>
In-Reply-To: <Zzx_C60W48ujpis9@smile.fi.intel.com>
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
	<Zzx_C60W48ujpis9@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 14:05:31 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 19, 2024 at 12:25:18PM +0100, Matteo Martelli wrote:
> > On Mon, 18 Nov 2024 18:05:35 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Mon, Nov 18, 2024 at 03:45:25PM +0100, Matteo Martelli wrote:  
> > > > On Mon, 18 Nov 2024 12:21:44 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > > On Fri, Nov 15, 2024 at 03:25:06PM +0100, Matteo Martelli wrote:  
> > > > > > On Thu, 31 Oct 2024 19:06:32 +0100, Matteo Martelli <matteomartelli3@gmail.com> wrote:  
> > > > > > > Quoting Jonathan Cameron (2024-10-31 15:31:29)  
> > > > > > > > On Thu, 31 Oct 2024 12:26:24 +0100
> > > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:  
> > > > > > > > > Quoting Jonathan Cameron (2024-10-30 21:30:50)  
> > > > > > > > > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > > > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:  
> > > > > > > > > > > Quoting Andy Shevchenko (2024-10-30 15:47:50)    
> > > > > > > > > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:      
> 
> > > > > > > > > > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > > > > > > > > > callback after reading producer's available info. To avoid a race
> > > > > > > > > > > > > condition with the producer unregistration, change inkern
> > > > > > > > > > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > > > > > > > > > producer and immediately calls its release callback with info_exists
> > > > > > > > > > > > > locked.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > > > > > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > > > > > > > > > after calling these functions. To let users free the copied buffer with
> > > > > > > > > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > > > > > > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > > > > > > > > > but stores the available values in the returned variable.      
> 
> ...
> 
> > > > > > > > > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > > > > > > > > > +                                         struct iio_chan_spec const *chan,
> > > > > > > > > > > > > +                                         const int *vals, long mask)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +     kfree(vals);
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > > >                             struct iio_chan_spec const *chan,
> > > > > > > > > > > > >                             int val, int val2, long mask)
> > > > > > > > > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > > >  static const struct iio_info dpot_dac_info = {
> > > > > > > > > > > > >       .read_raw = dpot_dac_read_raw,
> > > > > > > > > > > > >       .read_avail = dpot_dac_read_avail,
> > > > > > > > > > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > > > > > > > > >       .write_raw = dpot_dac_write_raw,
> > > > > > > > > > > > >  };      
> > > > > > > > > > > > 
> > > > > > > > > > > > I have a problem with this approach. The issue is that we allocate
> > > > > > > > > > > > memory in one place and must clear it in another. This is not well
> > > > > > > > > > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > > > > > > > > > at least these two comes to my mind:
> > > > > > > > > > > > 
> > > > > > > > > > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > > > > > > > > > name) that will dump the data to the intermediate buffer and clean it
> > > > > > > > > > > > after all;
> > > > > > > > > > > > 
> > > > > > > > > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.      
> > > > > > > > > > > 
> > > > > > > > > > > Could you elaborate more about these potential solutions? Maybe with some
> > > > > > > > > > > usage examples?
> > > > > > > > > > > 
> > > > > > > > > > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > > > > > > > > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > > > > > > > > > case, so that it would take care of freeing the buffer after calling
> > > > > > > > > > > iio_format_after_*(). We considered this approach during an initial
> > > > > > > > > > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > > > > > > > > > to let the driver keep the release control through a callback for two
> > > > > > > > > > > reasons:
> > > > > > > > > > > 
> > > > > > > > > > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > > > > > > > > > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > > > > > > > > > >    could still keep the buffer copy in its private data after giving it away,
> > > > > > > > > > >    resulting in fact in a double ownership. However I think it would be clear
> > > > > > > > > > >    enough in this case that the copy should be handled by the caller, or maybe
> > > > > > > > > > >    not?    
> > > > > > > > > > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > > > > > > > > > not needed and that it prevents any optimization like you mention.    
> > > > > > > > > 
> > > > > > > > > I think the suggestion here is to add an additional .read_avail_with_copy()
> > > > > > > > > without replacing the original .read_avail(), so all the current drivers that
> > > > > > > > > use a constant avail list would not be affected.  
> 
> > > > > Yes.  
> 
> > > > > > > > > And I think this was the same
> > > > > > > > > idea for the additional read_avail_ext() or the additional argument for the
> > > > > > > > > read_avail() we were considering in [1]. So I would think that
> > > > > > > > > iio_read_channel_info_avail() would do something like the following:
> > > > > > > > > 
> > > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > > >         indio_dev->info->read_avail_with_copy(vals);
> > > > > > > > >     else
> > > > > > > > >         indio_dev->info->read_avail(vals);
> > > > > > > > > 
> > > > > > > > >     ...
> > > > > > > > >     iio_format_avail_list(vals);
> > > > > > > > >     ...
> > > > > > > > > 
> > > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > > >         kfree(vals);  
> > > > > 
> > > > > Right. At least that's what I see can be done with the existing users.
> > > > >   
> > > > > > > > Ok, sure that would work, but...
> > > > > > > > 
> > > > > > > > I don't really see this as being much less fragile than
> > > > > > > > the existing solution + in cases that we do have where
> > > > > > > > only some available are not const we will have to copy them
> > > > > > > > all.
> > > > > > > > 
> > > > > > > > If anything it's more complex than making it a driver problem
> > > > > > > > to provide the release call however it wants to do it.  
> > > > > 
> > > > > ...but make a driver to allocate what's needed as well then.
> > > > >   
> > > > > > > > > And the drivers would choose whether to define the read_avail or the
> > > > > > > > > read_avail_with_copy.  
> > > > > 
> > > > > Either way drivers should know what to do with a data supplied to read_aval().
> > > > > In one case we assume the [simple] workflow in the core, in the other we all
> > > > > rely on the driver. Current approach makes a mix of these two. And that's what
> > > > > I don't like.  
> > > > 
> > > > If I understand your concern correctly, you are referring to the inkern
> > > > iio_channel_read_avail() that makes the allocation for the consumer's
> > > > buffer copy and you are suggesting that such copy should be done by the
> > > > consumer driver code itself, this to be consistent with the producer
> > > > drivers which directly handle the allocation of the copy.  
> > > 
> > > One of the options, yes.
> > >   
> > > > One thing to notice is that the inkern iio_channel_read_avail() does
> > > > together producer->read_avail() + copy + producer->read_avail_release()
> > > > with info_exists locked. Also, the consumer driver would need to know
> > > > the avail buffer size to allocate the buffer copy prior the
> > > > iio_channel_read_avail() call, but such size is unknown before calling
> > > > the actual producer's read_avail(). This would mean calling the
> > > > producer's read_avail() and read_avail_release() callbacks separately
> > > > without the lock held, with the risk of a memleak if the producer is
> > > > unregistered between those calls.  
> > > 
> > > Thanks for explaining this, but it even more makes me think that the design
> > > is broken and your approach is rather a hack. So, what's the problem to
> > > make IIO core to take care of the allocating and cleaning then without driver
> > > being involved? Yes, this might require a hint from the driver on what to copy
> > > if we want to avoid copying everything.  
> > 
> > I am not particularly against it, other than the concerns that have
> > emerged during this (and previous) discussion. Let me summarize them:  
> 
> Thank you for a very good summary and fix-N proposals. I think I have nothing
> to add and we should wait for Jonathan to finally choose (or propose a fix-N+1)
> here.
Agreed. This is very useful enumeration of various options with plenty
of details!

One absolute key thing to note here is we should not care at all what
inkern does for it's handling internally of the available lists.  The big
ABI question is all about consumers drivers directly using the resulting list of
available values.  The use in the IIO core and the inkern helpers should
naturally follow.


> 
> > fix-1) the current one. Your concerns are:
> >     * for consumers the copy allocation is taken care by the inkern API
> >       but the release is handled by the consumer driver code, making it
> >       a fragile design.

So this was something I'm not sure I agree with.  There are plenty
of get / release patterns out there. This is just another one of those
but perhaps it doesn't 'smell' enough like that.

Perhaps think of it as

int *iio_channel_avail_get()
void iio_channel_avail_release()

We could perhaps make it look more standard using a cookie rather than
reconstructing the equivalent data at the release call.

struct iio_avail_cookie {
	const int *avail;
	void *provider_priv;
// see later for a maybe...
	struct iio_dev *indio_dev;
};

const int *iio_avail_from_cookie(struct iio_avail_cookie *cookie)
{
	return cookie->avail;
}

struct iio_avail_cookie *iio_channel_avail_get(struct iio_dev, struct iio_chan_spec)
{
	allocate a cookie and fill it in.
}

and code would always explicitly release after it is done with the cookie.

Something like

void iio_channel_avail_release(struct iio_dev *iio_dev, struct iio_avail_cookie *cookie)
// could even move the iio_dev pointer into the cookie, so it becomes
// iio_channel_avail_release(struct iio_avail_cookie *cookie) and suitable for __free magic.
{
	if (iio_dev->info->avail_release)
		iio_dev->info->avail_release(cookie);
	kfree(cookie);
	/*
	 * Could add optimizations around cookie handling to avoid alloc + free in most cases
	 * or use an object pool.
	 */
}

The current proposal just avoid the need for a cookie as for all known cases so far
provider_priv could == the channel requested.


> >     * consumers and producers manage the allocation differently, the
> >       first handles it via the inkern API, the second one in the
> >       producer driver code, making it inconsistent.

The inkern API changes are mostly an attempt to reduce boiler plate. The only
case we really should be worrying about to my mind is the consumer wanting
to access the full available list. 

> > 
> > fix-2) adding a read_avail_with_copy(): a driver with both const avail
> > lists and mutable avail lists would always return a copy for all of
> > them, including the const ones. Example above.

Hmm. So this could work but with the firm rule that a provider must never
provide both options and a core check on drivers to enforce that probe.
Any existing consumers must be modified to try both paths
(read_avail_with_copy then read_avail) to avoid regressions.

For future code, if we miss a case that doesn't do this then the upshot
is that the call will fail and the consumer needs fixing but at least
it is not a regression because it will never have worked for that
particular consumer + producer pair.  Not too horrible, but I'm not
really seeing it as better than option 1.

> > 
> > fix-3) adding a release_avail return param to read_avail(): this would
> > require a change to all the drivers using it. Also it
> > looks to me an unusual pattern, are there other similar patterns around
> > the codebase? Example below.

No advantage that I can see vs an explicit get / release where the
release may do nothing if there was no allocation.

> > 
> > fix-4) adding a new enum variant to the avail type like
> > IIO_AVAIL_LIST_ALLOC: to me this looks hacky as it mixes the logic type
> > of the data structure and how it is handled in memory. I think the
> > latter should better fit in a different field, however this modification
> > would have little impact in the current code. Example below.

This one I really don't like. Needs non obvious / subtle handling in the
consumer drivers.

> > 
> > So far these alternatives only consider moving the release of the copy
> > buffer in the IIO core but not its allocation.

I'm confused.  Moving it in, or out of the core?  What does this mean
for a consumer driver after the avail list?

> You also suggest to make
> > the IIO core take care of the copy allocation. The problem I see with
> > this is that if the copy is handled outside the driver it could take
> > place concurrently with the modification of the original buffer since it
> > would not be locked by driver private mutex, thus making the copy
> > useless. This might be worked around by adding an additional optional
> > callback (e.g. read_avail_will_copy/read_avail_is_mutable) to just take
> > the size and check if a copy will be provided, so maybe something like:
> > 
> > fix-5) iio_read_channel_info_avail():

This is picking on the wrong code for this discussion.  Use
iio_read_avail_channel_attribute() for example because that's the one
where ABI matters.  Anything within the IIO core is just a question of
'niceness' it isn't important like a function called by a consumer driver.

Code of a consumer driver will be similar to this however.  A few things
would be needed to make this pattern work.
 
> > {
> >     ...
> >     int *vals;
> >     bool copy = false;
> >     if (indio_dev->info->read_avail_will_copy) {
> >         copy = indio_dev->info->read_avail_will_copy(..., &length, ...);

return length as 0 can reasonably mean we don't need to allocate.
That value must be the maximum possible size that can ever be needed, not the
current one.

> >         if (copy) {
> >             vals = kcalloc(length, sizeof(int), GFP_KERNEL);
> >         }
> >     }
> > 
> >     indio_dev->info->read_avail(&vals, ...);

For iio_read_avail_channel_attribute it will a little fiddlier but end result
is the same but done under the exist lock. If the device went away before this
call then we will get an error, otherwise this will fill vals and provide
the right length. 

> > 
> >     if (ret < 0)
> >             return ret;
> >     switch (ret) {
> >     case IIO_AVAIL_LIST:
> >             ret = iio_format_avail_list(buf, vals, type, length);
> >     case IIO_AVAIL_RANGE:
> >             ret = iio_format_avail_range(buf, vals, type);
> >     default:
> >             ret = -EINVAL;
> >     }
> > 
> >     if (copy)
> >         kfree(vals);
> > }
> > 
> > If I am not missing anything this could work and maybe it could also
> > avoid the double copy on the consumers but would require all of them to
> > wrap the read_avail_will_copy(). Also, I find it quite a weird pattern
> > that in some cases vals would be an input buffer to be filled and in
> > other cases it would be a return argument pointing to the const buffer
> > stored inside the driver. At least I wouldn't say it's more robust than
> > the current fix-1.
Agreed. It works, but I'm not seeing the advantage and the multiple use
of the vals parameter is too subtle to be maintainable.

> > 
> > All these alternatives also prevents some potential optimization already
> > mentioned before. Reporting it again as it is now lost in the mess below:
> >     Some driver might want to avoid allocating a new copy of a big table if
> >     the race does not occur (e.g. with additional checks on buffer access
> >     code) and thus wouldn't call a free() in the release callback.
> > 
> > In the end I don't find any of the above alternatives to provide an
> > obvious better solution.

Agreed.  My only question vs just taking the existing solution is whether
it makes sense to use a more explicit struct iio_avail_cookie
to hold all the info that we pass to release.  I don't particularly like
that we'll end up allocating that cookie structure but it would make it more
like a typical get / release and perhaps closer to what readers would
expect to see?

What do you think?

Jonathan

> >   
> > > > > > > > > What I was referring to is that, back then, you mentioned you would have
> > > > > > > > > preferred to avoid passing ownership of the buffer around:
> > > > > > > > >   
> > > > > > > > > > That's a corner case we should think about closing. Would require an indicator
> > > > > > > > > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > > > > > > > > free on completion of the string building.  I don't like passing ownership
> > > > > > > > > > of data around like that, but it is fiddly to do anything else given
> > > > > > > > > > any simple double buffering is subject to race conditions.    
> > > > > > > > > 
> > > > > > > > > I guess there is some other reason other than avoiding the copy when not
> > > > > > > > > necessary, since by introducing an additional function or argument or return
> > > > > > > > > type, most of the unnecessary copies would already be avoided right?  
> > > > > > > > 
> > > > > > > > It's not a strong reason beyond limiting scope of clever design +
> > > > > > > > the key bit my mind is that the above is not substantially simpler and
> > > > > > > > reduces our flexibility.
> > > > > > > >   
> > > > > > > > > Anyway any of this solutions would still prevent the potential optimizations of
> > > > > > > > > point 2). It's worth mentioning that those kind of optimizations are currently
> > > > > > > > > not adopted by any driver.  
> > > > > > > > 
> > > > > > > > That one indeed not, but mixing dynamic and non dynamic is something
> > > > > > > > you do in your pac1921 patch.  
> > > > > > > 
> > > > > > > Good point! I didn't think about it, or more likely I forgot, that with an
> > > > > > > additional read_avail_with_copy() used as in the example you cannot mix dynamic
> > > > > > > and non dynamic available lists, thus those drivers that need at least one
> > > > > > > dynamic available list would always copy all of them as they need to rely to
> > > > > > > the read_avail_with_copy(). I guess this could be worked around with an
> > > > > > > additional return argument for the read_avail() or an additional type like the
> > > > > > > IIO_AVAIL_LIST_ALLOC suggested by Andy to signal the caller it needs to free
> > > > > > > the list after use. However, I think they would introduce a more invasive
> > > > > > > change in the current API compared to an additional optional callback,  
> > > > > 
> > > > > It even sounds originally that it should be more invasive, so I don't think it's
> > > > > a problem here.  
> > > > 
> > > > In the hope it helps the discussion let me provide examples for the
> > > > additional two options we have other than the current
> > > > read_avail_release_resource() (fix-1) and the read_avail_with_copy()
> > > > (fix-2) already shown above:  
> > > 
> > > Thanks!
> > >   
> > > > fix-3) iio_read_channel_info_avail():
> > > > {
> > > >     ...
> > > >     bool release_avail = false;
> > > > 
> > > >     ret = indio_dev->info->read_avail(vals, ..., &release_avail);
> > > > 
> > > >     ...
> > > >     ret = iio_format_avail_list(vals, ...);
> > > >     ...
> > > > 
> > > >     if (release_avail)
> > > >         kfree(vals);
> > > > 
> > > >     return ret;
> > > > }
> > > > 
> > > > 
> > > > fix-4) iio_read_channel_info_avail():
> > > > {
> > > >     ...
> > > >     indio_dev->info->read_avail(vals, ...);
> > > > 
> > > >     if (ret < 0)
> > > >             return ret;
> > > >     switch (ret) {
> > > >     case IIO_AVAIL_LIST_ALLOC:
> > > >             ret = iio_format_avail_list(buf, vals, type, length);
> > > >             kfree(vals);
> > > >             return ret;
> > > >     case IIO_AVAIL_LIST:
> > > >             return iio_format_avail_list(buf, vals, type, length);
> > > >     case IIO_AVAIL_RANGE:
> > > >             return iio_format_avail_range(buf, vals, type);
> > > >     default:
> > > >             return -EINVAL;
> > > >     }
> > > > }
> > > >   
> > > > > > > so I agree that the current release callback is still a better option.  
> > > > > 
> > > > > I disagree on this as I pointed above why.
> > > > >   
> > > > > > > > > > > 2) Some driver might want to avoid allocating a new copy of a big table if
> > > > > > > > > > >    the race does not occur (e.g. with additional checks on buffer access
> > > > > > > > > > >    code) and thus wouldn't call a free() in the release callback.
> > > > > > > > > > >     
> > > > > > > > > > > > In any case it looks fragile and not scalable. I propose to drop this
> > > > > > > > > > > > and think again.      
> > > > > > > > > > > 
> > > > > > > > > > > I see your concerns, I am open to reconsider this in case we come up with
> > > > > > > > > > > better solution after addressing the points above.
> > > > > > > > > > >     
> > > > > > > > > > > > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > > > > > > > > > > > agree on the report, I think this solution is not good enough.  
> > > > > > > > > > > 
> > > > > > > > > > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/  
> > > > > > > > > 
> > > > > > > > > I hope I've brought a little more clarity to the discussion by providing some
> > > > > > > > > history instead of making it more confusing.  
> > > > > > > > 
> > > > > > > > Sure, the code example in particular is useful.  
> > > > > > 
> > > > > > Just a friendly reminder this has been sitting for a while, any news or
> > > > > > additional considerations?  
> > > > > 
> > > > > Moving the allocation control to the drivers will satisfy me as well, however
> > > > > it makes even more duplication of the code, but at least it will be cleaner
> > > > > design-wise in my opinion.  
> > > > 
> > > > Would it work with the constraints on the info_exists lock mentioned
> > > > above?  
> > > 
> > > None of the given examples (fix-N) provides a lock, so I have no clue how it's
> > > involved here. May be you can elaborate more?  
> > 
> > I thought that with "Moving the allocation control to the drivers" you
> > were referring to the option (not included among fix-N) to move the
> > allocation of the consumer copy from the inkern iio_channel_read_avail()
> > to the consumer drivers themselves. You elaborated this point above
> > where I answered with the concerns about the info_exists lock that
> > should be addressed.
> >   
> > > > > In any case the last word is on Jonathan.  
> 


