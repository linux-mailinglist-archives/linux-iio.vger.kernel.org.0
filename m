Return-Path: <linux-iio+bounces-8032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1A93FED6
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 22:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AACB21FB9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9686C188CC8;
	Mon, 29 Jul 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwObgNdu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65B43152;
	Mon, 29 Jul 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283868; cv=none; b=UqzkvDQsKIZqm5KSIK/cgBVe4iBeNasSPyeH8yvByoT+9nOxEid9GJ5WPcBFBqiNqvd0d5ASDw+d4SS/rkuU+cKa1eAmQoXbvxCedFAHbD99JJ/KGJ1HWtTzM9EtHMyINuQZPeqQhRi7tdh4LlrxJqYr+AfzOcQdf8xEcMGP4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283868; c=relaxed/simple;
	bh=uDb5Fh4ZhVMA92QTS5K4scO4cYY50h/RnlGeYZVwiwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVT1OX6q9Qvq6fgowX2NC7vAZjDPbNLy4Pj0BIBunBbxvE64cXC2Xk6OBkPZ956s1DeBtNEUvNaImUd049oSaYUyN6NwKDqWFUY8tU9a6x26YDPzs4+ZxnaV+K85oCSpoiatVb5R/SgPAg79wWYjR6jvCOiq/R4gyy/8Smg1azo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwObgNdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9542FC32786;
	Mon, 29 Jul 2024 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722283867;
	bh=uDb5Fh4ZhVMA92QTS5K4scO4cYY50h/RnlGeYZVwiwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RwObgNdu4TuyaneR49qXJ8hUPuHkt2cwiPFRkhiSqKe4isQVyBStcN6WT4FXJVUDG
	 B82BIpGs86xP4gsgb/nDY32bD8ihwDnCpU98lzsRhUju44RxLR6w9PhKHr5O31r48y
	 7jpsYUMB1sqDCyZGuwVZVy2INvu24Mv42YTlL7ocCTJ0yMTrWnMZQdVo0XUkk58GZI
	 oGxwaS3zlEAObNELuHZybqejelAebyRBAAzmpdqWB+vDak7gFifi0+cQdjXt23hf+o
	 oV115+f799iVMSpMbwY0w1zqI4q3Cbi5BzF4pNHG8kH++58bguAFPfasLJV3urEnyQ
	 isrKY/CGnIXTQ==
Date: Mon, 29 Jul 2024 21:11:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marius Cristea <marius.cristea@microchip.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: add support for pac1921
Message-ID: <20240729211100.0d602d6e@jic23-huawei>
In-Reply-To: <66a784bac1db7_89a37017@njaxe.notmuch>
References: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
	<20240724-iio-pac1921-v4-3-723698e903a3@gmail.com>
	<20240728135306.422713ea@jic23-huawei>
	<66a784bac1db7_89a37017@njaxe.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +
> > > +/*
> > > + * Emit on sysfs the list of available scales contained in scales_tbl
> > > + *
> > > + * TODO:: this function can be replaced with iio_format_avail_list() if the
> > > + * latter will ever be exported.  
> > 
> > You could just have added a precursor patch doing that.
> > If you have time I'd certainly consider a patch that does export that function
> > and uses it here.
> >  
> I wasn't sure that one usage was enough to justify the export. I could
> definitely do it, I am assuming it would now go to a new patch series since
> this has already been merged into testing, right?
The requirements for justifying exporting an existing function is less
than it would be to add a new one.  As such I think it makes sense.

As you note, needs a separate patch on top of the tree.

> 
> > > + *
> > > + * Must be called with lock held if the scales_tbl can change runtime (e.g. for
> > > + * the current scales table)
> > > + */
> > > +static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
> > > +					  size_t size, char *buf)
> > > +{
> > > +	ssize_t len = 0;
> > > +
> > > +	for (unsigned int i = 0; i < size; i++) {
> > > +		if (i != 0) {
> > > +			len += sysfs_emit_at(buf, len, " ");
> > > +			if (len >= PAGE_SIZE)
> > > +				return -EFBIG;
> > > +		}
> > > +		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
> > > +				     scales_tbl[i][1]);
> > > +		if (len >= PAGE_SIZE)
> > > +			return -EFBIG;
> > > +	}
> > > +
> > > +	len += sysfs_emit_at(buf, len, "\n");
> > > +	return len;
> > > +}
> > > +
> > > +/*
> > > + * Read available scales for a specific channel
> > > + *
> > > + * NOTE: using extended info insted of iio.read_avail() because access to
> > > + * current scales must be locked as they depend on shunt resistor which may
> > > + * change runtime. Caller of iio.read_avail() would access the table unlocked
> > > + * instead.  
> > 
> > That's a corner case we should think about closing. Would require an indicator
> > to read_avail that the buffer it has been passed is a snapshot that it should
> > free on completion of the string building.  I don't like passing ownership
> > of data around like that, but it is fiddly to do anything else given
> > any simple double buffering is subject to race conditions.
> >  
> If I understand your suggestion the driver would allocate a new table and copy
> the values into it at each read_avail() call. Then
> iio_read_channel_info_avail() would free the buffer if some sort of
> free-after-use indicator flag is set. I guess such indicator might be set via an
> additional read_avail function argument (would be an extensive API change) or
> maybe via a new iio_chan_spec attribute.

Probably needs to be in read_avail() as otherwise we end up with yet more masks.
However, doesn't need to be global.  read_avail_ext() could be added that
is used in preference to read_avail() if it is supplied.  That new one can
be used only be drivers that need to handle the allocation and free.
However I prefer the explicit resource free option as we can in theory
at least do much cleverer things than simply freeing the buffer.

> 
> > An alternative would use a key of sometype to associate individual read_avail
> > calls with new ones to read_avail_release_resource. That might be cleaner.
> >   
> Are you referring to introduce a new read_avail_realease_resource callback that
> would be called at the end of iio_read_channel_info_avail() if set? Similarly
> to the previous point the driver would allocate a new table and copy the values
> into it at each read_avail() call, but the driver would also define a release
> callback to free such table. If otherwise you are referring to something less
> trivial, is there a similar API in the kernel that can be referred to for
> clarity?

Indeed what you suggest. Key is it puts the burden on the driver to do it's
own management. That avoids handing ownership of the buffer to the core
which is a pattern I'm not that keen on if we can avoid it.

The new callback would take the buffer pointer that came back from read_avail()
and pass that back to the driver.  In simple case the driver could just
free the buffer.  However, it could also do some cleverer stuff to keep
it around if a write hasn't raced with this code.  That might make sense if
it's a big table and calculating the values is expensive.

> 
> > oh well, a cleanup job for another day.   I suspect we have drivers today
> > that are subject to tearing of their available lists.
> >   
> I've just taken a quick look at the other drivers and the following twos seem
> to have the race condition issue since they are updating an available table
> during a write_raw() call and also exposing it during a read_avail() call:
> * drivers/iio/light/as73211.c: see int_time_avail table
> * drivers/iio/adc/ad7192.c: see filter_freq_avail table
> 
> There might be others, I've only looked into those that seemed likely to have
> this issue after some trivial greps.
> 
> Is there already a common way for iio to keep track of open issues (e.g. Issue
> tracker/TODO lists/etc)?

Not really.  Email to the list tends to be the most we do for tracking.
I have had various todo lists public over the years, but they tend to rot.

Fix stuff before we forget about it! :(

> 

> > > +static int pac1921_init(struct pac1921_priv *priv)
> > > +{
> > > +	unsigned int val;
> > > +	int ret;
> > > +
> > > +	/* Enter READ state before configuration */
> > > +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > > +				 PAC1921_INT_CFG_INTEN, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Configure gains, use 14-bits measurement resolution (HW default) */
> > > +	val = (u8)FIELD_PREP(PAC1921_GAIN_DI_GAIN_MASK, priv->di_gain) |
> > > +	      (u8)FIELD_PREP(PAC1921_GAIN_DV_GAIN_MASK, priv->dv_gain);  
> > 
> > Why are these cases needed?
> > Each of those values is going to fit in a u8 just fine and it's getting
> > written to a much larger variable.
> >   
> FIELD_PREP result type would be a long unsigned int due to the GENMASK type and
> -Wconversion would trigger a warning. The explicit casts is just to address
> -Wconversion warnings and to "state" that such casts are safe. 

In these cases the compiler can see the value range so it 'shouldn't' be necessary.
The compiler should be able to trivially establish there isn't a problem.

I can't see enough of the example to tell if the compiler has the visibility
of that function call that would be necessary to establish if the value
is big enough.

Of course, sometimes we get a dumb compiler so maybe it will still warn.

GCC docs state:
"
The option should not warn for explicit conversions or for cases where the value
cannot in fact change despite the implicit conversion."
https://gcc.gnu.org/wiki/NewWconversion

and we should be in that category here.  A lot of compiler work goes into
ensuring that the false positive rates for this sort of warning are low.
This particular case of a mask and shift by compile time constants should
be easy to figure out!

Jonathan


> In this way
> with -Wconversion (KBUILD_EXTRA_WARN=3) one could easily spot those other
> implicit casts that would end up with unwanted data corruption. I thought it to
> be a common practice and I also saw it in some other kernel patches, for
> example https://lore.kernel.org/all/1540883612.2354.2.camel@smigroup.net/ , but
> maybe it's not that common as I thought.
> I also see that maybe in this case casting to unsigned int would have likely
> been more clear.
> 
> Thanks,
> Matteo Martelli


