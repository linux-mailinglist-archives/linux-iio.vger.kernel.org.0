Return-Path: <linux-iio+bounces-11641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17009B6B23
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B056B21718
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C31EF95A;
	Wed, 30 Oct 2024 17:35:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112E2199FB1;
	Wed, 30 Oct 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309754; cv=none; b=lsxoQjomCx8B08uLYlbyOjrCS2kEfEHvZVd19SwBmDzbqjWFTSqXZQR5/MmLVK/hnVVI9xVyx8kqhufbskm4dBPAZlceW/+4BuhFLZYZyVRnoydeypV3MYD3WXEF1qHmDZNQgeWe2Xd0gO02IFPZtIqYOT+ofW9G93efxqEKi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309754; c=relaxed/simple;
	bh=BSasaU0mrz2wv1Rydn4ifPh2TNdENmALykPY4CNm9YU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOd/m2qH7cljB5sEs334KoaWWCFBx8zunNv4rRs6RJqoH5Wzpqf0kUyhJ9pvwEEfbv8yExqrNg78QgEjjeSvPMMGPmxfwDmyIL+Lv/y7Isw0PH6yYUZodVh/qwZX6LEikTxTfkpjxFdwfcW2pUk+bwnZjsGHq4thG/jBVqpBg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdvPw5nbcz6K5VP;
	Thu, 31 Oct 2024 01:34:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DEBC1401F3;
	Thu, 31 Oct 2024 01:35:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 18:35:46 +0100
Date: Wed, 30 Oct 2024 17:35:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Matteo Martelli <matteomartelli3@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>,
	Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul
 Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <20241030173545.00000374@Huawei.com>
In-Reply-To: <ZyJHFp6vbQ7deLFs@black.fi.intel.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
	<20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
	<ZyJHFp6vbQ7deLFs@black.fi.intel.com>
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
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Oct 2024 16:47:50 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:
> > Consumers need to call the producer's read_avail_release_resource()
> > callback after reading producer's available info. To avoid a race
> > condition with the producer unregistration, change inkern
> > iio_channel_read_avail() so that it copies the available info from the
> > producer and immediately calls its release callback with info_exists
> > locked.
> > 
> > Also, modify the users of iio_read_avail_channel_raw() and
> > iio_read_avail_channel_attribute() to free the copied available buffers
> > after calling these functions. To let users free the copied buffer with
> > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > but stores the available values in the returned variable.  
> 
> ...
> 
> > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > +					    struct iio_chan_spec const *chan,
> > +					    const int *vals, long mask)
> > +{
> > +	kfree(vals);
> > +}
> > +
> >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> >  			      struct iio_chan_spec const *chan,
> >  			      int val, int val2, long mask)
> > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> >  static const struct iio_info dpot_dac_info = {
> >  	.read_raw = dpot_dac_read_raw,
> >  	.read_avail = dpot_dac_read_avail,
> > +	.read_avail_release_resource = dpot_dac_read_avail_release_res,
> >  	.write_raw = dpot_dac_write_raw,
> >  };  
> 
> I have a problem with this approach. The issue is that we allocate
> memory in one place and must clear it in another. This is not well
> designed thingy in my opinion.

It is a tricky corner and we've not yet come up with a better
solution :(  I think one of the earlier versions did just always copy
and the reviews suggested that was painful given we are fixing a tiny
percentage of devices.  Hence we ended up with what is effectively
an optional copy if the provider knows the data is volatile.

So there are two 'potential' copies here and we need to be careful
to separate them for purposes of discussion.
A) Copy in provider if it has volatile available data.  In that
   case the copy is done in a call to it via read_avail, and release
   via a call to read_avail_release_resource().  So to my mind locally
   the same as any acquire / release pair.
B) Copy in the core for the case where we need the lifetime to persist.
   That is a effectively a kmemdup() call so we could call back to the
   core to release it but it would just be a kfree() wrapper.
 
(A) Only occurs in a tiny subset of drivers, most use non volatile data
    for read avail (constant, or constant after probe).
(B) Only occurs for consumer drivers that directly use the avail data.
    There are very few of those and no other sane way of solving this
    because we can't hold a lock into the provider for an unknown
    (long) time.


> I was thinking a bit of the solution and
> at least these two comes to my mind:
> 
> 1) having a special callback for .read_avail_with_copy (choose better
> name) that will dump the data to the intermediate buffer and clean it
> after all;

So we have that allocate the data in the provider and hand it to the
consumer which then frees it with kfree() in all cases?

Note that's what we do for the inkern interfaces (the ones consumer
drivers have to use), just in the core not the providers because that
corner is hard to close any other way. In this rare case we end up
potentially copying twice.

For the special cases where the buffer isn't passed on beyond
functions that are part of the IIO core, we avoid the need for that
(potentially second, probably only) copy because we can always
ensure the release call is made.  Note this is the common case
by far. It's the pretty printing done by the core to present this
data to sysfs etc, or to find out the max value for some consumer
that doesn't need the whole set.

> 
> 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.

The special handling that will need seems likely to be no more
obvious than the handling we have here.  I'm not really
sure how it would work.

> 
> In any case it looks fragile and not scalable. I propose to drop this
> and think again.
> 
> Yes, yes, I'm fully aware about the problem you are trying to solve and
> agree on the report, I think this solution is not good enough.

I'll back this out of my tree for now so the discussion can carry on.

Jonathan


