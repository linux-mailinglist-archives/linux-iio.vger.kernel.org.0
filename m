Return-Path: <linux-iio+bounces-14488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6696FA163BD
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948D93A4C2B
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 19:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0521DF983;
	Sun, 19 Jan 2025 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8dRAKRW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43251DF27C
	for <linux-iio@vger.kernel.org>; Sun, 19 Jan 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737314997; cv=none; b=XsIPrtzC41OdEd304L8l8DhlB8b+YE+c+TBuHED4mU20IQ6dsFGEZFI3cZiOBkvvpcnY7XSWxSHkA24qBKX98ED6MLqqU2ExKMYMo6yuWzOXhzDr7YmHHyaVtJdSQRy5jbmZInxq6crgDOm3VDL3zmXN3tdDbRRQDfurISu4GQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737314997; c=relaxed/simple;
	bh=f7ACFFsO0mjRSpoxqgBkblQND0/u/XESGZZv0i41HWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMpc1skigHrcIn4W0W8Tvlf/TcnZ6COyr1YWxy0njohm5FhRVZPr09qTRowwsXgFdfW/qxKcVR1wUW95YCLCu8tXiaH/r5uTWjA3KM8fSwNeGQoaDAWKfuiuaxXRDMeN+lq27vfOpoxy0Fa7d/Yz292hxFCv6p77PwOUaBL8nJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8dRAKRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13982C4CED6;
	Sun, 19 Jan 2025 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737314997;
	bh=f7ACFFsO0mjRSpoxqgBkblQND0/u/XESGZZv0i41HWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8dRAKRWSg5NdoiUNtEv79cf799sKjabUUE0iyCkwOBEF0931RcsnInOhFDNjM2XU
	 0VRuJN+hBbFrlQ57d4+oV5vSxJmkl8F3J+bB3d/00dKu2Ue90/Lk1C/f71wccPJFzF
	 RN5qlCXJkeo2mlckfi2Y4PdGXZ3wKykn9R4pzuHHy1tXlgzbyLjBY/EfEWpsp540Id
	 cgUH94yD14exdCC+MCFTFv8o+xCUe4xHAZd5B3LtWo94+MoBmKyjGlRM9rknhURgLG
	 7DqhbUj09EV9OF7/JjQes5NQGQQ3Wap95qv5kYbWrQl3IZ7yUuAspJ6Y+2pEwkWLTx
	 Bn1LHYtVN52DQ==
Date: Sun, 19 Jan 2025 19:29:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, =?UTF-8?B?4oCcTHVj?= Van =?UTF-8?B?T29zdGVu?=
 =?UTF-8?B?cnlja+KAnQ==?= <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <20250119192948.005fa672@jic23-huawei>
In-Reply-To: <61785c12-1a5e-4465-92e9-83d81c02dd59@baylibre.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
	<20250105172613.1204781-2-jic23@kernel.org>
	<88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
	<20250107142451.000021db@huawei.com>
	<c298f1bb-d0a1-42af-b237-9aa8e422ec1b@baylibre.com>
	<20250111133552.2a44c74e@jic23-huawei>
	<61785c12-1a5e-4465-92e9-83d81c02dd59@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 16:28:02 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/11/25 7:35 AM, Jonathan Cameron wrote:
> > On Tue, 7 Jan 2025 10:09:15 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 1/7/25 8:24 AM, Jonathan Cameron wrote:  
> >>> On Mon, 6 Jan 2025 17:14:12 -0600
> >>> David Lechner <dlechner@baylibre.com> wrote:
> >>>     
> >>>> On 1/5/25 11:25 AM, Jonathan Cameron wrote:    
> >>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>>
> >>>>> Initial thought was to do something similar to __cond_lock()
> >>>>>
> >>>>> 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
> >>>>> + Appropriate static inline iio_device_release_direct_mode()
> >>>>>
> >>>>> However with that, sparse generates false positives. E.g.
> >>>>>
> >>>>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock      
> >>>>
> >>>> Even if false positives aren't technically wrong, if sparse is having a hard
> >>>> time reasoning about the code, then it is probably harder for humans to reason
> >>>> about the code as well. So rewriting these false positives anyway could be
> >>>> justified beyond just making the static analyzer happy.
> >>>>    
> >>>>>
> >>>>> So instead, this patch rethinks the return type and makes it more
> >>>>> 'conditional lock like' (which is part of what is going on under the hood
> >>>>> anyway) and return a boolean - true for successfully acquired, false for
> >>>>> did not acquire.      
> >>>>
> >>>> I think changing this function to return bool instead of int is nice change
> >>>> anyway since it makes writing the code less prone authors to trying to do
> >>>> something "clever" with the ret variable. And it also saves one one line of
> >>>> code.
> >>>>    
> >>>>>
> >>>>> To allow a migration path given the rework is now no trivial, take a leaf
> >>>>> out of the naming of the conditional guard we currently have for IIO
> >>>>> device direct mode and drop the _mode postfix from the new functions giving
> >>>>> iio_device_claim_direct() and iio_device_release_direct()
> >>>>>
> >>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>> ---
> >>>>>  include/linux/iio/iio.h | 22 ++++++++++++++++++++++
> >>>>>  1 file changed, 22 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> >>>>> index 56161e02f002..4ef2f9893421 100644
> >>>>> --- a/include/linux/iio/iio.h
> >>>>> +++ b/include/linux/iio/iio.h
> >>>>> @@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> >>>>>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> >>>>>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> >>>>>  
> >>>>> +/*
> >>>>> + * Helper functions that allow claim and release of direct mode
> >>>>> + * in a fashion that doesn't generate false positives from sparse.
> >>>>> + */
> >>>>> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)      
> >>>>
> >>>> Doesn't __cond_acquires depend on this patch [1] that doesn't look like it was
> >>>> ever picked up in sparse?
> >>>>
> >>>> [1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/    
> >>>
> >>> I wondered about that. It 'seems' to do the job anyway. I didn't fully
> >>> understand that thread so I just blindly tried it instead :)
> >>>
> >>> This case is simpler that that thread, so maybe those acrobatics aren't
> >>> needed?    
> >>
> >> I was not able to get a sparse warning without applying that patch to sparse
> >> first. My test method was to apply this series to my Linux tree and then
> >> comment out a iio_device_release_direct() line in a random driver.
> >>
> >> And looking at the way the check works, this is exactly what I would expect.
> >> The negative output argument in __attribute__((context,x,0,-1)) means something
> >> different (check = 0) without the spare patch applied.
> >>  
> > Curious. I wasn't being remotely careful with what sparse version
> > i was running so just went with what Arch is carrying which turns out to be
> > a bit old.
> > 
> > Same test as you describe gives me:
> >   CHECK   drivers/iio/adc/ad4000.c
> > drivers/iio/adc/ad4000.c:533:12: warning: context imbalance in 'ad4000_read_raw' - different lock contexts for basic block
> > 
> > So I tried that with latest sparse from kernel.org and I still get that warning
> > which is what I'd expect to see.
> > 
> > Simple make C=1 W=1 build
> > 
> > I wonder what we have different?  Maybe it is missing some cases?
> > 
> > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > index ef0acaafbcdb..6785d55ff53a 100644
> > --- a/drivers/iio/adc/ad4000.c
> > +++ b/drivers/iio/adc/ad4000.c
> > @@ -543,7 +543,7 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
> >                         return -EBUSY;
> >  
> >                 ret = ad4000_single_conversion(indio_dev, chan, val);
> > -               iio_device_release_direct(indio_dev);
> > +//             iio_device_release_direct(indio_dev);
> >                 return ret;
> >         case IIO_CHAN_INFO_SCALE:
> >                 *val = st->scale_tbl[st->span_comp][0];
> > 
> > Was the test I ran today.
> > 
> > Jonathan
> >   
> 
> Hmmm... I think maybe I had some other local modifications when I was testing
> previously. But I understand better what is going on now. Your implementation
> is only working because it is static inline. The __cond_acquires() and
> __releases() attributes have no effect and the "different lock contexts for
> basic block" warning is coming from the __acquire() and __release() attributes.
> So it is working correctly, but perhaps not for the reason you thought.

Ah. That indeed explains it.

> 
> I think what I had done locally is make iio_device_claim_direct() and
> iio_device_release_direct() regular functions instead of static inline so that
> it had to actually make use of __cond_acquires(). In that case, with an
> unpatched sparse, we get "unexpected unlock" warnings for all calls to
> iio_device_release_direct(). With patched sparse, this warning goes away.
> 
> So for now, we could take your patch with the __cond_acquires() and
> __releases() attribute removed (since they don't do anything) and leave
> ourselves a note in a comment that sparse needs to be fixed so that we can use
> the __cond_acquires() attribute if/when we get rid of
> iio_device_release_direct_mode() completely and want to make
> iio_device_release_direct() a regular function.

I'm in two minds over whether to keep the __cond_acquires / __releases markings
given there are other in tree uses already.  Mind you I don't care strongly
and I assume sparse at least always obeys inline instructions so what we
probably need is a comment to ensure we never move the code out of the header
unless sparse is fixed.  So I'll go ahead and drop the markings for now.

Even if sparse is never updated, we can keep a little bit of inline magic
in the header to handle the conditional __acquire() and have the real
acquire in an evil looking __iio_device_claim_direct() that no one
should ever touch directly.

We could in theory do similar for the existing iio_device_claim_direct_mode()
but I 'think' that will still give us some false positives + the boolean
return is nicer anyway and tends to give slightly more compact code..

So far making this change to a bunch more drivers has found 2 bugs and led
to a quite a bit of code cleanup. I'll finish doing the 'a's (accel and adc)
then post the result.  One thing I will probably change on this initial set is
splitting the refactors and changes to the new interface into separate
patches as they are different types of change.

Jonathan
> 
> 


