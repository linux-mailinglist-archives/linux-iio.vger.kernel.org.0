Return-Path: <linux-iio+bounces-11696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0AB9B7CE4
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D55B281DFD
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C719E97A;
	Thu, 31 Oct 2024 14:31:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E1126C00;
	Thu, 31 Oct 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385099; cv=none; b=hzOsXfY4O6+OwwV9NaJ2ihnbq06nYD/KVOttiB2ASBGNsN2+5OG39sOsEpfcCLy5ToLyi2FE4mJLhCaC5IOXgkkY/eWyyn9d8CEQFZAS2ziK/FwxKsSL+809tR3SESqpple+NKyCxZWVh5amyO4b9yOLMjriN5QquZXb73eWcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385099; c=relaxed/simple;
	bh=PuDbDPSsaYw6fzKpOB6WGo3iQDhxrpPMSFphqPAYYpo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EN28I5JAEc6VDfn4PEbOzatLq94W/w6VmutorAxlxxp9PC5ywPodkbXL7ZdUHH747jHCVCo85UAHGn8QWGlw7kx6Y6txra/pOOYgSCoYOIJdzDcgLFCxEWfcAR/vL0wliXEEsDAqmZlcFV1vJV59hm+cGAJ+/5ds78hAV8H6QU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XfRBl4Tjhz6GDmf;
	Thu, 31 Oct 2024 22:26:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 20CAB140136;
	Thu, 31 Oct 2024 22:31:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Oct
 2024 15:31:31 +0100
Date: Thu, 31 Oct 2024 14:31:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Matteo Martelli <matteomartelli3@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
	<alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
	<peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
	<sre@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <20241031143129.0000014e@Huawei.com>
In-Reply-To: <173037398492.12348.265826723028347056@njaxe.localdomain>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
	<20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
	<ZyJHFp6vbQ7deLFs@black.fi.intel.com>
	<173031260171.39393.109639772708550094@njaxe.localdomain>
	<20241030203050.5cdf3450@jic23-huawei>
	<173037398492.12348.265826723028347056@njaxe.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 31 Oct 2024 12:26:24 +0100
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Quoting Jonathan Cameron (2024-10-30 21:30:50)
> > On Wed, 30 Oct 2024 19:23:21 +0100
> > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> >   
> > > Quoting Andy Shevchenko (2024-10-30 15:47:50)  
> > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:    
> > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > callback after reading producer's available info. To avoid a race
> > > > > condition with the producer unregistration, change inkern
> > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > producer and immediately calls its release callback with info_exists
> > > > > locked.
> > > > > 
> > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > after calling these functions. To let users free the copied buffer with
> > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > but stores the available values in the returned variable.    
> > > > 
> > > > ...
> > > >     
> > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > +                                         struct iio_chan_spec const *chan,
> > > > > +                                         const int *vals, long mask)
> > > > > +{
> > > > > +     kfree(vals);
> > > > > +}
> > > > > +
> > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > >                             struct iio_chan_spec const *chan,
> > > > >                             int val, int val2, long mask)
> > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > >  static const struct iio_info dpot_dac_info = {
> > > > >       .read_raw = dpot_dac_read_raw,
> > > > >       .read_avail = dpot_dac_read_avail,
> > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > >       .write_raw = dpot_dac_write_raw,
> > > > >  };    
> > > > 
> > > > I have a problem with this approach. The issue is that we allocate
> > > > memory in one place and must clear it in another. This is not well
> > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > at least these two comes to my mind:
> > > > 
> > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > name) that will dump the data to the intermediate buffer and clean it
> > > > after all;
> > > > 
> > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.    
> > > 
> > > Could you elaborate more about these potential solutions? Maybe with some
> > > usage examples?
> > > 
> > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > case, so that it would take care of freeing the buffer after calling
> > > iio_format_after_*(). We considered this approach during an initial
> > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > to let the driver keep the release control through a callback for two
> > > reasons:
> > > 
> > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > >    could still keep the buffer copy in its private data after giving it away,
> > >    resulting in fact in a double ownership. However I think it would be clear
> > >    enough in this case that the copy should be handled by the caller, or maybe
> > >    not?  
> > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > not needed and that it prevents any optimization like you mention.  
> 
> I think the suggestion here is to add an additional .read_avail_with_copy()
> without replacing the original .read_avail(), so all the current drivers that
> use a constant avail list would not be affected. And I think this was the same
> idea for the additional read_avail_ext() or the additional argument for the
> read_avail() we were considering in [1]. So I would think that
> iio_read_channel_info_avail() would do something like the following:
> 
>     if (indio_dev->info->read_avail_with_copy)
>         indio_dev->info->read_avail_with_copy(vals);
>     else
>         indio_dev->info->read_avail(vals);
> 
>     ...
>     iio_format_avail_list(vals);
>     ...
> 
>     if (indio_dev->info->read_avail_with_copy)
>         kfree(vals);

Ok, sure that would work, but...

I don't really see this as being much less fragile than
the existing solution + in cases that we do have where
only some available are not const we will have to copy them
all.

If anything it's more complex than making it a driver problem
to provide the release call however it wants to do it.
 

> 
> And the drivers would choose whether to define the read_avail or the
> read_avail_with_copy.
> 
> What I was referring to is that, back then, you mentioned you would have
> preferred to avoid passing ownership of the buffer around:
> 
> > That's a corner case we should think about closing. Would require an indicator
> > to read_avail that the buffer it has been passed is a snapshot that it should
> > free on completion of the string building.  I don't like passing ownership
> > of data around like that, but it is fiddly to do anything else given
> > any simple double buffering is subject to race conditions.  
> 
> I guess there is some other reason other than avoiding the copy when not
> necessary, since by introducing an additional function or argument or return
> type, most of the unnecessary copies would already be avoided right?

It's not a strong reason beyond limiting scope of clever design +
the key bit my mind is that the above is not substantially simpler and
reduces our flexibility.

> 
> Anyway any of this solutions would still prevent the potential optimizations of
> point 2). It's worth mentioning that those kind of optimizations are currently
> not adopted by any driver.

That one indeed not, but mixing dynamic and non dynamic is something
you do in your pac1921 patch.

Jonathan


> 
> > 
> > Jonathan  
> > > 
> > > 2) Some driver might want to avoid allocating a new copy of a big table if
> > >    the race does not occur (e.g. with additional checks on buffer access
> > >    code) and thus wouldn't call a free() in the release callback.
> > >   
> > > > 
> > > > In any case it looks fragile and not scalable. I propose to drop this
> > > > and think again.    
> > > 
> > > I see your concerns, I am open to reconsider this in case we come up with
> > > better solution after addressing the points above.
> > >   
> > > > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > > > agree on the report, I think this solution is not good enough.
> > > > 
> > > > -- 
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > >     
> > > 
> > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/
> > > 
> > > Best regards,
> > > Matteo Martelli  
> >   
> 
> I hope I've brought a little more clarity to the discussion by providing some
> history instead of making it more confusing.

Sure, the code example in particular is useful.

Jonathan

> 
> Best regards,
> Matteo Martelli
> 
> 


