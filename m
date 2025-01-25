Return-Path: <linux-iio+bounces-14561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75BA1C2FB
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9FE16774A
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78912063F8;
	Sat, 25 Jan 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq0uTg1a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E01E7C2D
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737806370; cv=none; b=I/nfUPRieB7WZ6zqOyznEmBi6WT9oWM+YBvWehuGw+pZjILrvdnLwBDWjdI0KyYCEOcMKeSFd7eyn+axdoxVxHPiUmjALNCQb3RePhTGLK2rU7ZsFun8nDFIF+pmXCbix8yHT9p4iKXXckJ5zswDPFh3ZwVNMrt4HqHhO1GWPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737806370; c=relaxed/simple;
	bh=0iImxwRVx/PC6KxFXCUrIicBexBShKU6xJlYgfpS1+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YD4Rvs0/yKtT9paBrGtPzAMyuT4GLYPH6DZwnViCrjyX8vmqBZu+XM9suDgR+aI7f99+1d6Jj2FgFUXQW/19EKn/isLEEEHJH4H4eVYavH/NG9jQgkbAbZ8/kYsHe9plgh/wZgACcwiVg5a/p7tX66HaD5obNe7v0+Za6NyjWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq0uTg1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3597DC4CED6;
	Sat, 25 Jan 2025 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737806370;
	bh=0iImxwRVx/PC6KxFXCUrIicBexBShKU6xJlYgfpS1+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iq0uTg1avgTRacGNh9taz/qsbwMiA3LS13rRNkmhVBbbrQHTQ1O1EJaBJKlzqppXW
	 TnlSztfnmpiLNS4Z91oRFnyOxAnTRG/qODR5lJlm35Lab6OUDrof4CXF6+CY/Cmw11
	 xcKTN1lW9JEwYNovAWllXDBAkmOP45XqjYj9yWclEALO7+9a4Cg5EflOYsY3ArClc6
	 9tcfa0eiS5fNzc3sPGwnndUCYEkw+iFcvuRyDqiDUPiS/B997/+QrHUrJqPoxQWpBm
	 BnjhWC2myQDETktNLNI7lNslDmkNXeb79G3KiAJJkl69SiCQPHhpGXxnRVIhdva5N0
	 9SEmyo/lkRIWQ==
Date: Sat, 25 Jan 2025 11:59:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, =?UTF-8?B?4oCc?=
 =?UTF-8?B?THVj?= Van =?UTF-8?B?T29zdGVucnlja+KAnQ==?=
 <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <20250125115923.59c64785@jic23-huawei>
In-Reply-To: <Z40-dXoKfy1iQHnB@debian-BULLSEYE-live-builder-AMD64>
References: <20250105172613.1204781-1-jic23@kernel.org>
	<20250105172613.1204781-2-jic23@kernel.org>
	<88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
	<20250107142451.000021db@huawei.com>
	<c298f1bb-d0a1-42af-b237-9aa8e422ec1b@baylibre.com>
	<20250111133552.2a44c74e@jic23-huawei>
	<61785c12-1a5e-4465-92e9-83d81c02dd59@baylibre.com>
	<Z40-dXoKfy1iQHnB@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jan 2025 15:03:33 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/11, David Lechner wrote:
> > On 1/11/25 7:35 AM, Jonathan Cameron wrote:  
> > > On Tue, 7 Jan 2025 10:09:15 -0600
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >  
> > >> On 1/7/25 8:24 AM, Jonathan Cameron wrote:  
> > >>> On Mon, 6 Jan 2025 17:14:12 -0600
> > >>> David Lechner <dlechner@baylibre.com> wrote:
> > >>>  
> > >>>> On 1/5/25 11:25 AM, Jonathan Cameron wrote:  
> > >>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >>>>>
> > >>>>> Initial thought was to do something similar to __cond_lock()
> > >>>>>
> > >>>>> 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
> > >>>>> + Appropriate static inline iio_device_release_direct_mode()
> > >>>>>
> > >>>>> However with that, sparse generates false positives. E.g.
> > >>>>>
> > >>>>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock  
> > >>>>
> > >>>> Even if false positives aren't technically wrong, if sparse is having a hard
> > >>>> time reasoning about the code, then it is probably harder for humans to reason
> > >>>> about the code as well. So rewriting these false positives anyway could be
> > >>>> justified beyond just making the static analyzer happy.
> > >>>>  
> > >>>>>
> > >>>>> So instead, this patch rethinks the return type and makes it more
> > >>>>> 'conditional lock like' (which is part of what is going on under the hood
> > >>>>> anyway) and return a boolean - true for successfully acquired, false for
> > >>>>> did not acquire.  
> > >>>>
> > >>>> I think changing this function to return bool instead of int is nice change
> > >>>> anyway since it makes writing the code less prone authors to trying to do
> > >>>> something "clever" with the ret variable. And it also saves one one line of
> > >>>> code.
> > >>>>  
> > >>>>>
> > >>>>> To allow a migration path given the rework is now no trivial, take a leaf
> > >>>>> out of the naming of the conditional guard we currently have for IIO
> > >>>>> device direct mode and drop the _mode postfix from the new functions giving
> > >>>>> iio_device_claim_direct() and iio_device_release_direct()
> > >>>>>
> > >>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >>>>> ---
> > >>>>>  include/linux/iio/iio.h | 22 ++++++++++++++++++++++
> > >>>>>  1 file changed, 22 insertions(+)
> > >>>>>
> > >>>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > >>>>> index 56161e02f002..4ef2f9893421 100644
> > >>>>> --- a/include/linux/iio/iio.h
> > >>>>> +++ b/include/linux/iio/iio.h
> > >>>>> @@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> > >>>>>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> > >>>>>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> > >>>>>
> > >>>>> +/*
> > >>>>> + * Helper functions that allow claim and release of direct mode
> > >>>>> + * in a fashion that doesn't generate false positives from sparse.
> > >>>>> + */
> > >>>>> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)  
> > >>>>
> > >>>> Doesn't __cond_acquires depend on this patch [1] that doesn't look like it was
> > >>>> ever picked up in sparse?
> > >>>>
> > >>>> [1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/  
> 
> I applied those two patches to iio testing branch. The diffs appear to be
> duplicated in email patches and patch 1 first hunk applies to line 353 of
> include/linux/refcount.h instead of line 361. I also didn't re-add
> __cond_acquires() which is present in current kernel but not in the patch.
> I then applied patch 1 and patch 9 of this series.
> 
> > >>>
> > >>> I wondered about that. It 'seems' to do the job anyway. I didn't fully
> > >>> understand that thread so I just blindly tried it instead :)
> > >>>
> > >>> This case is simpler that that thread, so maybe those acrobatics aren't
> > >>> needed?  
> > >>
> > >> I was not able to get a sparse warning without applying that patch to sparse
> > >> first. My test method was to apply this series to my Linux tree and then
> > >> comment out a iio_device_release_direct() line in a random driver.
> > >>
> > >> And looking at the way the check works, this is exactly what I would expect.
> > >> The negative output argument in __attribute__((context,x,0,-1)) means something
> > >> different (check = 0) without the spare patch applied.
> > >>  
> > > Curious. I wasn't being remotely careful with what sparse version
> > > i was running so just went with what Arch is carrying which turns out to be
> > > a bit old.
> > >
> > > Same test as you describe gives me:
> > >   CHECK   drivers/iio/adc/ad4000.c
> > > drivers/iio/adc/ad4000.c:533:12: warning: context imbalance in 'ad4000_read_raw' - different lock contexts for basic block
> > >
> > > So I tried that with latest sparse from kernel.org and I still get that warning
> > > which is what I'd expect to see.
> > >
> > > Simple make C=1 W=1 build
> > >
> > > I wonder what we have different?  Maybe it is missing some cases?
> > >
> > > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > > index ef0acaafbcdb..6785d55ff53a 100644
> > > --- a/drivers/iio/adc/ad4000.c
> > > +++ b/drivers/iio/adc/ad4000.c
> > > @@ -543,7 +543,7 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
> > >                         return -EBUSY;
> > >
> > >                 ret = ad4000_single_conversion(indio_dev, chan, val);
> > > -               iio_device_release_direct(indio_dev);
> > > +//             iio_device_release_direct(indio_dev);
> > >                 return ret;
> > >         case IIO_CHAN_INFO_SCALE:
> > >                 *val = st->scale_tbl[st->span_comp][0];
> > >  
> With the patches from [1], patches 1 and 9 of this series, and the change above,
> I got the different lock contexts warn as shown above. No change to Sparse.
> Tested with both Sparse v0.6.4-66-g0196afe1 from [2] and the Sparse version
> I have from Debian (Sparse 0.6.4 (Debian: 0.6.4-5)).
> 
> [1]: https://lore.kernel.org/all/20220630135934.1799248-1-aahringo@redhat.com/
> [2]: git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> 
> > > Was the test I ran today.
> > >
> > > Jonathan
> > >  
> >
> > Hmmm... I think maybe I had some other local modifications when I was testing
> > previously. But I understand better what is going on now. Your implementation
> > is only working because it is static inline. The __cond_acquires() and
> > __releases() attributes have no effect and the "different lock contexts for
> > basic block" warning is coming from the __acquire() and __release() attributes.
> > So it is working correctly, but perhaps not for the reason you thought.
> >
> > I think what I had done locally is make iio_device_claim_direct() and
> > iio_device_release_direct() regular functions instead of static inline so that
> > it had to actually make use of __cond_acquires(). In that case, with an
> > unpatched sparse, we get "unexpected unlock" warnings for all calls to
> > iio_device_release_direct(). With patched sparse, this warning goes away.
> >  
> I think the patches changing to iio_device_claim_direct() are bugy.
> I did something similar while working on ad4170 and got deadlock.

This needs debugging as there should be no functional change.

> In the patch updating ad4000 we had
> 
>         case IIO_CHAN_INFO_RAW:
> -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -                       return ad4000_single_conversion(indio_dev, chan, val);
> -               unreachable();
> +               if (!iio_device_claim_direct(indio_dev))
> +                       return -EBUSY;
> +
> +               ret = ad4000_single_conversion(indio_dev, chan, val);
> +               iio_device_release_direct(indio_dev);
> +               return ret;
> 
> iio_device_claim_direct_mode() returns 0 when the user is able to acquire direct
> mode so !iio_device_claim_direct_mode() evaluates to true when we are be able to
> acquire iio_dev_opaque mlock, but the ADC driver was returning -EBUSY anyway and
> never unlocking mlock. We should do

I'm lost.   I agree iio_device_claim_direct_mode() returns 0 on success, but
the wrapper in this patch effectively inverts that (see explanation of why, but
in short it is to make it look more like other locks and get more reliable
output from sparse.).

+static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)
+{
+	int ret = iio_device_claim_direct_mode(indio_dev);
+
+	if (ret)
//So if anything other than zero we return false
+		return false;
+
+	__acquire(iio_dev);
+
+	return true;
//return true on sucessfully taking the lock.

+}

Hence the check for we did not get the lock should be that new wrapper returning false.

As it is in your code above.

> 
> +               if (iio_device_claim_direct(indio_dev))
> 
> It was when I ran Sparse without negating iio_device_claim_direct() that I got 
> ad4000.c:545:17: warning: context imbalance in 'ad4000_read_raw' - unexpected unlock
> 
> Maybe the warn would have been more useful if it was "suspicious error return
> after lock acquisition" or something like that?

Ok. So it worked, but message unclear?    Fair enough but not much we can do
about it as that is deep in sparse and technically that message is correct
as by inverting the logic the unlock is the point were sparse can tell it is backwards.

> 
> > So for now, we could take your patch with the __cond_acquires() and
> > __releases() attribute removed (since they don't do anything) and leave
> > ourselves a note in a comment that sparse needs to be fixed so that we can use
> > the __cond_acquires() attribute if/when we get rid of
> > iio_device_release_direct_mode() completely and want to make
> > iio_device_release_direct() a regular function.  


