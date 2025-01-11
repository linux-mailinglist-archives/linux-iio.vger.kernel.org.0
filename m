Return-Path: <linux-iio+bounces-14133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA0A0A3F0
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 14:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9263A7EC4
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67331A8F82;
	Sat, 11 Jan 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwE2ARlT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557D14C5B0
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736602559; cv=none; b=rAMPgNAPt1BXDsQxNBboxDtJIOVCRHCLoLpQQBHuRIeLUd+YBI7wI3swSTS8TbRzBJ2CWDusjn3HYizzuL8+r4mtB5MYgXKYHCBSj4LCAbu3E0fVeDVqk7AerT4ew5qtKJm+4au8rBllfrXg9sEDy9gndq4JrMKJa0lcrZRhnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736602559; c=relaxed/simple;
	bh=YzwsVSZLGbJMG6PdfDiSkeYcvy8RGdTgu7+OvtTcIIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKuxKsynqPlzIz3twv8cdrHZjyGIYZIfcHU4aXVkIKGUP0IhEll7rLSgCZWKTdv1rJiPwPJHMxaJB568C3E8TVQuAi8tSGAa7o1O37LjTnf5ciBj8+SfUwoEB1qeY7AiX5ElRgnaLPcAoXsG6aBbMR1L/GsER66T8JQ3gjWtbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwE2ARlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720ACC4CED2;
	Sat, 11 Jan 2025 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736602559;
	bh=YzwsVSZLGbJMG6PdfDiSkeYcvy8RGdTgu7+OvtTcIIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OwE2ARlTNNMsU82y9fPjCvg2p9/K6hHq4Cp/tvIOoprYUQ44sUoqngDqMg/HNfZOW
	 yluLKzc5m5JWuTNSmHSoQyBtZTnuAsOh3IRFLtZZtW603+Qvbv3vVOGmF7XjBRz7YD
	 +uV31d9tKQOxpWxLn9JnE9sYmxUniAPZYTMLDEWRFI3N/cPV9GdnJOWbvGOFC1nAa6
	 5u++BjsLXR2LeM/+PkmEOuGNwV5poxTKV2cp23OQr0ULKGM6ofTpve8VK180IvJCl9
	 LUTuywwMjVsrFj/K6IWDbF1+j/99erQ+lcRHujv+2BX+kTGwK4eVc15F5200GvO4++
	 bm7tUEY1ZbHOA==
Date: Sat, 11 Jan 2025 13:35:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, =?UTF-8?B?4oCcTHVj?= Van =?UTF-8?B?T29zdGVu?=
 =?UTF-8?B?cnlja+KAnQ==?= <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <20250111133552.2a44c74e@jic23-huawei>
In-Reply-To: <c298f1bb-d0a1-42af-b237-9aa8e422ec1b@baylibre.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
	<20250105172613.1204781-2-jic23@kernel.org>
	<88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
	<20250107142451.000021db@huawei.com>
	<c298f1bb-d0a1-42af-b237-9aa8e422ec1b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 10:09:15 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/7/25 8:24 AM, Jonathan Cameron wrote:
> > On Mon, 6 Jan 2025 17:14:12 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 1/5/25 11:25 AM, Jonathan Cameron wrote:  
> >>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>
> >>> Initial thought was to do something similar to __cond_lock()
> >>>
> >>> 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
> >>> + Appropriate static inline iio_device_release_direct_mode()
> >>>
> >>> However with that, sparse generates false positives. E.g.
> >>>
> >>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock    
> >>
> >> Even if false positives aren't technically wrong, if sparse is having a hard
> >> time reasoning about the code, then it is probably harder for humans to reason
> >> about the code as well. So rewriting these false positives anyway could be
> >> justified beyond just making the static analyzer happy.
> >>  
> >>>
> >>> So instead, this patch rethinks the return type and makes it more
> >>> 'conditional lock like' (which is part of what is going on under the hood
> >>> anyway) and return a boolean - true for successfully acquired, false for
> >>> did not acquire.    
> >>
> >> I think changing this function to return bool instead of int is nice change
> >> anyway since it makes writing the code less prone authors to trying to do
> >> something "clever" with the ret variable. And it also saves one one line of
> >> code.
> >>  
> >>>
> >>> To allow a migration path given the rework is now no trivial, take a leaf
> >>> out of the naming of the conditional guard we currently have for IIO
> >>> device direct mode and drop the _mode postfix from the new functions giving
> >>> iio_device_claim_direct() and iio_device_release_direct()
> >>>
> >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> ---
> >>>  include/linux/iio/iio.h | 22 ++++++++++++++++++++++
> >>>  1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> >>> index 56161e02f002..4ef2f9893421 100644
> >>> --- a/include/linux/iio/iio.h
> >>> +++ b/include/linux/iio/iio.h
> >>> @@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> >>>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> >>>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> >>>  
> >>> +/*
> >>> + * Helper functions that allow claim and release of direct mode
> >>> + * in a fashion that doesn't generate false positives from sparse.
> >>> + */
> >>> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)    
> >>
> >> Doesn't __cond_acquires depend on this patch [1] that doesn't look like it was
> >> ever picked up in sparse?
> >>
> >> [1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/  
> > 
> > I wondered about that. It 'seems' to do the job anyway. I didn't fully
> > understand that thread so I just blindly tried it instead :)
> > 
> > This case is simpler that that thread, so maybe those acrobatics aren't
> > needed?  
> 
> I was not able to get a sparse warning without applying that patch to sparse
> first. My test method was to apply this series to my Linux tree and then
> comment out a iio_device_release_direct() line in a random driver.
> 
> And looking at the way the check works, this is exactly what I would expect.
> The negative output argument in __attribute__((context,x,0,-1)) means something
> different (check = 0) without the spare patch applied.
> 
Curious. I wasn't being remotely careful with what sparse version
i was running so just went with what Arch is carrying which turns out to be
a bit old.

Same test as you describe gives me:
  CHECK   drivers/iio/adc/ad4000.c
drivers/iio/adc/ad4000.c:533:12: warning: context imbalance in 'ad4000_read_raw' - different lock contexts for basic block

So I tried that with latest sparse from kernel.org and I still get that warning
which is what I'd expect to see.

Simple make C=1 W=1 build

I wonder what we have different?  Maybe it is missing some cases?

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index ef0acaafbcdb..6785d55ff53a 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -543,7 +543,7 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
                        return -EBUSY;
 
                ret = ad4000_single_conversion(indio_dev, chan, val);
-               iio_device_release_direct(indio_dev);
+//             iio_device_release_direct(indio_dev);
                return ret;
        case IIO_CHAN_INFO_SCALE:
                *val = st->scale_tbl[st->span_comp][0];

Was the test I ran today.

Jonathan





