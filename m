Return-Path: <linux-iio+bounces-674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D69C8076A6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E72B281F71
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA36A005;
	Wed,  6 Dec 2023 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W58MNNTI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A92364B2
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 17:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68788C433C8;
	Wed,  6 Dec 2023 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701883976;
	bh=XEf6tIDOSMPHN/MSARI80obGogkE99GvYNfgujy4bHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W58MNNTIrWqXAVyrXcuSgrRioprROjVZ1gnyAlVTMR+oAz51Sw3z1yxDxfhlVuO9Z
	 Wxykyc+RerDlupvdQWC10OELAMzqOhIvXJzdyskjZqNG4bDsbHTfdmGWjTwMqHzkTu
	 taeU3SbnzPW8JD5A2/ipbc9bO5znelpN2dO3TIjGZnKZ7jcSldf4TKB1DHsIncpt5Y
	 TdQUPFiP0BsjQ3te/SEcDHiR2tkMDfWUuxH8qhbpM2NNg5Isa2mW1yPy0F/5L7W+kG
	 X5JFPrgVt7mnM3NWLGJ1gvKOPvy4sqQop/W/4dy7xSKXMRQvXQEV57fQRyYRhmH9Pt
	 fm97nMHyYv6tQ==
Date: Wed, 6 Dec 2023 17:32:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: temperature: mlx90635 MLX90635 IR
 Temperature sensor
Message-ID: <20231206173248.7eb5a4a8@jic23-huawei>
In-Reply-To: <CAKv63uuBjkqffEzVsJcsMKK3wYoShJ0gNU_X+=KrU1zicTVdEw@mail.gmail.com>
References: <cover.1701168726.git.cmo@melexis.com>
	<c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
	<20231204142224.51f2ccdf@jic23-huawei>
	<CAKv63usxdfOviH=M6iUiNTtBFZVOseWUGz63Q-oJniBDFvTpSQ@mail.gmail.com>
	<20231204170623.0c0cd598@jic23-huawei>
	<CAKv63uuBjkqffEzVsJcsMKK3wYoShJ0gNU_X+=KrU1zicTVdEw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 20:56:39 +0100
Crt Mori <cmo@melexis.com> wrote:

> On Mon, 4 Dec 2023 at 18:06, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 4 Dec 2023 16:34:30 +0100
> > Crt Mori <cmo@melexis.com> wrote:
> >  
> > > On Mon, 4 Dec 2023 at 15:22, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >  
> ...
> > > While in Sleep Step mode, the EEPROM is powered down, but the cache
> > > buffers those values. Still when you try to write or read a volatile
> > > register (which should not be prevented by cache enabled as per my
> > > opinion, but code says differently) in that mode, it returns -EBUSY
> > > (as we discovered by code), so this kind of manipulation is needed to
> > > enable write and read operations from volatile registers.  
> >
> > So the cache trick is just meant for the eeprom?  Can you use two regmaps.
> > (I've seen similar done for devices with different ways of reading which
> > this 'kind of' corresponds to).
> > One to cover the eeprom and the other the registers that always work.
> > That should let you separately control if they are in caching state or
> > not.
> > Or just read the eeprom into a manually created cache on boot?
> >  
> 
> It did not seem correct to create a manual cache, since regcache does
> this job. I tried two separated regmaps, but when I tried to
> initialize them I got into kernel panic/crash, so I could not get it
> working on same device. Do you have any device in mind I could
> template this against?

I'm not sure which device I was thinking of, but grepping and looking for
likely targets got me
https://elixir.bootlin.com/linux/latest/source/drivers/mfd/madera-spi.c#L90
which registers one regmap for 32bit registers and one for 16 bit registers
as the devices have two non overlapping ranges.

Not sure why it would crash (as opposed to one trampling on the other) but
maybe there is something tied more tightly to the device than I think.

> 
> ...
> > > "invalid" data (shouldn't differ much, but I wanted to prevent that as
> > > it might be 0).  
> >
> > ok.  Just give a little bit more of that detail.  I'd not understood
> > intent is to ensure one trigger -> one measurement.  
> 
> OK.
> > >  
> ...
> > >
> > > Burst is from 90632 terminology (and our chip register map), but maybe
> > > more general would be "trigger_measurement"?  
> >
> > ok. But why only if in SLEEP_STEP?
> >  
> 
> Because in continuous mode (other mode used here) the measurement
> table is constantly updated, so trigger is not useful and would only
> slow down the reading. And I did not want to block the data retrieval
> when person wants to read the data fast.

Fair enough - add a comment so reader can easily follow that.

> 
> > >  
> > > > > +static int mlx90635_get_refresh_rate(struct mlx90635_data *data,
> > > > > +                                  unsigned int *refresh_rate)
> > > > > +{
> > > > > +     unsigned int reg;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > > > +             regcache_cache_only(data->regmap, false);  
> > > >
> > > > Definitely needs a comment on why this is needed in this case.
> > > >  
> > >
> > > Here and below (where we turn it back to true?), but then I assume in
> > > all other instances as well? Maybe a more general comment in the
> > > sleep_step mode function?  
> >
> > If we keep this, then yes I think we need comments on these - even if
> > it's as simple as 'not accessing an eeprom register so we want to
> > talk to the device'.  
> 
> OK, then this is an option if I cannot make two regmaps work.
> 
> > >  
> > > > > +  
> ...
> > > changed we should end up in correct state. I can wrap a mutex around
> > > though.  
> >
> > Assuming regcache_cache_only() isn't refcounted, you could end up with a
> > second copy of this racing through and accessing the data after the
> > first one turned the cache back on so the -EBUSY your mentioned.
> >  
> 
> True. I will use mutex then for this action.


