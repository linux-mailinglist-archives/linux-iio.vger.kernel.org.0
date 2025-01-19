Return-Path: <linux-iio+bounces-14486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB31A16377
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 19:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C39318855F0
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCE01465B8;
	Sun, 19 Jan 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrpgOh7D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8A18C31
	for <linux-iio@vger.kernel.org>; Sun, 19 Jan 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737309782; cv=none; b=kR9iyErcZ7xfy3jjJ5qzwL45g9Hn4qfp3HCRREHuf/vyYfdBEDxo+jA3NV0qKUs6obBPSQZaoT1iCw+3iak5P1xte08TChR7rNU+crGwVoLhu/BCeFezIpOndWUB/L99IxtYYdI5VJmrRQbRGRKWJqyof+0JQ0zoOvVAuGotND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737309782; c=relaxed/simple;
	bh=wYKQlRQekSffmJVQC8HBUF/7w4+sCwILvJ6Enjbllck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnxXUSN8Kb6mvxg1CIGL7o+x1+tKbZ0n9806tvXfGjossxKY3aLBabGbcUmXAY77aNCvSveoLhO6iDU/QqARCa2Xq12/U++LpifyiDmXUck5JjQyVonKsl6A5KGkoElz+H8v79tgDUt0+yLjLayLUfIwWUsMUka/JImy//HKEk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrpgOh7D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso7453678a91.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jan 2025 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737309780; x=1737914580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30VlWkLh0M1GrQUlickay17Y4sH/XPifYi6cSeifO9I=;
        b=TrpgOh7DA4KvfDMiOmfYQjv4LhiNzHLW9zdj+GWch3S2BAKk3YE6DwZkDap6il+gKA
         YfzgipsvtvBgBdURkgChi7vchu74JzQKWmLrZVrfG3PE83wWLOJt+/YiVp8QzqtMrs85
         IWvVbGy9xBRjcrgf2gb55xF3n8huLq7btvzCXGGWQUpcdEDNhq0CvPk73Ce7AWqbnwiy
         0+zAEBituGs8YtKeh76xSN0sNGeMSrAiQORtzQhQFoPdkWPYIeqZVHFwcl0Mzl1+DB8D
         jZEG2EJyNj/p04Ysc0t/d1ZVoNXhYRNCG2Z22PVO3bDAb4uwZXdoAhHJ2Pfh49BpsWOQ
         D0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737309780; x=1737914580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30VlWkLh0M1GrQUlickay17Y4sH/XPifYi6cSeifO9I=;
        b=Cx2d2Kip7F0101dQGNKtk32Dg8DQF6n+2l1PJ8W4I0zkV7y9fYc9PiZEqtgnWeQ2z5
         5FT2+8b53xNumnKIUkjcE0ebgVIOC9supO63dfCAaxc6cHwfglG6a9cgAt+We78HK466
         ZnL9wwlMgjDV9P/qLifDWHEUVZ6Ojr+6iAQfzZvtx6efpLTxjIpkFDjlR/LYQ/zKdt3G
         LcetBSyTh9yMpoaSMW94yq05C8jTmcKlaex2vet/3Z7sbMjL+ChQYSpsq+9AGiO2Hg/c
         Jg+8IZt0h7XixsF6/yoTCOeaHcD8onvS8nE7HaqiMfcUT2fUdCtSAdr12KSLLIqIbgpU
         Qa5A==
X-Forwarded-Encrypted: i=1; AJvYcCVhzVeOABqnfxaY32JKUV02xlWnGAKu+Wsn7be1s+JqCAyUyaGXV9zVmh+0hULVBApOtnFbQj41CLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4w8VibGU9yNFwmPnUrssjOOhVDt59Fh4A3pAVKld8t6amw7hh
	ydebtXcGOppNVZvjIfMCJ9Wznjs5W4So96hTfga65RnVZ4HG2E6S
X-Gm-Gg: ASbGnctfrQnROdbvfkBku5aW6Mf3FmwPWn27i+TZ54cmBuCqegpBAlz3YELddi4efMH
	at967OVEFlVfs09uyFqes20gBSRXoTgKetFpYkxQXV2VZU+nSEn1J0fCasv25fgko1dWmi69VQY
	aObYmGYq80f34M+zoWg6y/uQzMip0HmMhGAbKwSMTiO3mHSrtQ5jBYCap3TSdnnWMmVLmmadjrF
	wuiK7JPvNwToD3uMgAX5ew7pcTEp9vjmi0JDxeYVXpSHhVb8BeCixG+TGuswuIAdMzxSV9VSSAA
	r5c=
X-Google-Smtp-Source: AGHT+IGot+pMe5uYVEyG1r4Lm34aGnpyAWI2YWX4vnmzh1JrJrxWEujy3qe4hESPz3f4zQmIKq3RlA==
X-Received: by 2002:a17:90b:350a:b0:2ef:e063:b3f8 with SMTP id 98e67ed59e1d1-2f728dc0772mr27085533a91.7.1737309779938;
        Sun, 19 Jan 2025 10:02:59 -0800 (PST)
Received: from localhost ([2804:30c:b6f:6000:977f:d193:3cfb:25c6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd4f70adsm5315832a12.58.2025.01.19.10.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 10:02:58 -0800 (PST)
Date: Sun, 19 Jan 2025 15:03:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	=?utf-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <Z40-dXoKfy1iQHnB@debian-BULLSEYE-live-builder-AMD64>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-2-jic23@kernel.org>
 <88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
 <20250107142451.000021db@huawei.com>
 <c298f1bb-d0a1-42af-b237-9aa8e422ec1b@baylibre.com>
 <20250111133552.2a44c74e@jic23-huawei>
 <61785c12-1a5e-4465-92e9-83d81c02dd59@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61785c12-1a5e-4465-92e9-83d81c02dd59@baylibre.com>

On 01/11, David Lechner wrote:
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

I applied those two patches to iio testing branch. The diffs appear to be
duplicated in email patches and patch 1 first hunk applies to line 353 of
include/linux/refcount.h instead of line 361. I also didn't re-add
__cond_acquires() which is present in current kernel but not in the patch.
I then applied patch 1 and patch 9 of this series.

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
With the patches from [1], patches 1 and 9 of this series, and the change above,
I got the different lock contexts warn as shown above. No change to Sparse.
Tested with both Sparse v0.6.4-66-g0196afe1 from [2] and the Sparse version
I have from Debian (Sparse 0.6.4 (Debian: 0.6.4-5)).

[1]: https://lore.kernel.org/all/20220630135934.1799248-1-aahringo@redhat.com/
[2]: git://git.kernel.org/pub/scm/devel/sparse/sparse.git

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
>
> I think what I had done locally is make iio_device_claim_direct() and
> iio_device_release_direct() regular functions instead of static inline so that
> it had to actually make use of __cond_acquires(). In that case, with an
> unpatched sparse, we get "unexpected unlock" warnings for all calls to
> iio_device_release_direct(). With patched sparse, this warning goes away.
>
I think the patches changing to iio_device_claim_direct() are bugy.
I did something similar while working on ad4170 and got deadlock.
In the patch updating ad4000 we had

        case IIO_CHAN_INFO_RAW:
-               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-                       return ad4000_single_conversion(indio_dev, chan, val);
-               unreachable();
+               if (!iio_device_claim_direct(indio_dev))
+                       return -EBUSY;
+
+               ret = ad4000_single_conversion(indio_dev, chan, val);
+               iio_device_release_direct(indio_dev);
+               return ret;

iio_device_claim_direct_mode() returns 0 when the user is able to acquire direct
mode so !iio_device_claim_direct_mode() evaluates to true when we are be able to
acquire iio_dev_opaque mlock, but the ADC driver was returning -EBUSY anyway and
never unlocking mlock. We should do

+               if (iio_device_claim_direct(indio_dev))

It was when I ran Sparse without negating iio_device_claim_direct() that I got 
ad4000.c:545:17: warning: context imbalance in 'ad4000_read_raw' - unexpected unlock

Maybe the warn would have been more useful if it was "suspicious error return
after lock acquisition" or something like that?

> So for now, we could take your patch with the __cond_acquires() and
> __releases() attribute removed (since they don't do anything) and leave
> ourselves a note in a comment that sparse needs to be fixed so that we can use
> the __cond_acquires() attribute if/when we get rid of
> iio_device_release_direct_mode() completely and want to make
> iio_device_release_direct() a regular function.

