Return-Path: <linux-iio+bounces-14718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3EA221D1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7701218854A3
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEE01442E8;
	Wed, 29 Jan 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkbiZx1g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6012FB6
	for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168458; cv=none; b=EUm83OhDb1yLXaZ+lrTilkeBrxDnHRjKkv4W/j69OD35Ynl3GkWIZFSfBDhdj4U7Kfwhc32QlBlRRBTsQMCpuJKYg0IdrBDwGnFKyQ672GrSW/tkKJO9ol3/h0I/IDyfvLc7DRymUWCB6czCwnP4o3l9sclg0YTNlmJPCXwbQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168458; c=relaxed/simple;
	bh=Ep6iXcsYLGDTBaZBHvvm4Qq8+ht4Z1qfVDJKZbNmEUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVVyck65sTDr+7IBfodAZgrFodYlWLxk0+82mb7QeQeWMq6EzzCwsZjlMRQ2JTAcP2slDp6w4xEfD3i3OLTW5s+3H6F4Q1iZ3VXJ9YmQGhZ3YqBSlMGhzlgI+kqbmK2N8bwzojQuqb3+oNfFd6pK/m6krSWiQ0C831s0+12EluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkbiZx1g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21c2f1b610dso9941005ad.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738168455; x=1738773255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqQC2zqgzxUomL+79V4awGz82wjC9W8llFVw66B7+UQ=;
        b=TkbiZx1gy73Xly0vLxjdpZFbvXYmeY0I3W+oMrzdJucg+IlXSZMdfpMoNrx0K28MEG
         qGyf6qRgng+ZzFLWXFXWqCwy8kQbbYSVzW6v3Ca5quEWuhcoHfb+dOTitcya1+xnRqOz
         +i7lbmjaBkfgJVpvS5l4brrWZ/WTvsA5uolvA1a2kX/yBicr8qCZ7K8MPJXgWcPaRXof
         6qa2VJr1ZjeOu+zEjOMUBTxMTMLXq9duHu9KNea4CgcXAX+/5Q/NOKrxsyuB7pOmWQ19
         r3nadBFLqgNnCQkkIQ4bCc3IFsrAWAMiT4edU4/iZgSixArOq5j3BvVjCmF1enYaoElk
         /npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738168455; x=1738773255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqQC2zqgzxUomL+79V4awGz82wjC9W8llFVw66B7+UQ=;
        b=O3iK6Vkye3qHu1pbZ6BpV2mat6fEbHXezwpZoEmkrh83T43sdGAyNviDOvC/WwTyVv
         XpOXkgngXMDZ4HqlPv9CkfG7qt13Lk64ceVa6oHZYz1DG6dGmBNpAa/KcHA6XL2QWcES
         Qo7+Co6mmrw2sPPEblK1wkkMW76G9HybZmGq+6J+jskEX+DzQtFbvNo841Oo05n7/fN4
         jhO8pUEeVfrlzCPXY8fzosUx3kFZZC6TAcIPxZRpIOT3dQ5Frm6+6i3Nv+GA2bEcKry+
         OSypcfHHnFTPmWoSQ7ORlvYlYiBYyi0RicmET5ZFFuKNOqrJfwSVq7wF9OPnSVEE2ElF
         mOeA==
X-Forwarded-Encrypted: i=1; AJvYcCWbhbqP84niEumIWoVHTD4jwvHSXIFOemBZezVWGIQzKfol4P3v4sKi2PeKg4VIMx25iauz4vmP2Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAP8uh1Hk02ZJkyU9KmTTCifJ6sgLvF1d035W1tdBG56W1l8z
	S47oaQBT90p5B3pyblVottb1d0Jk+86GtBRmADy7EPrFuv2nsfax
X-Gm-Gg: ASbGncvSLID6+r/i0xW96cmR5QwrrbIWnQP7t9r71FBzCENOGE/VqGWF0HwiefAKRHo
	sSOPFUR8SpYgvuF09K8fjFjmVtBkA9VyJH26gtdxDRM219R8zyG7ZXpI4GP6FIIoT8UQNbMwMYV
	1nOPJqdLapBSJRs6/3IVDmIJCOwneUAbb45pBxsHZ6LFTuZJDOVQ08ypHqb1Dsu2X73EBuHrpLq
	jTdH9F662VdjVfka8yAGgSZgEIOnsdQXy2NB98BXWCedzoRS0E1u0GGd+wBnq5jWZHtJTYbcj2X
	M2tUrVqbSKBuYOtOqxJAAf0s
X-Google-Smtp-Source: AGHT+IGy9pxi77YM6AdQh579OtkIwARAnJIFCTmtn4kxAVa79z36uQ4+IyOYUFIyeCKEVOJiBtv8Bg==
X-Received: by 2002:a05:6a00:2184:b0:72d:3861:895c with SMTP id d2e1a72fcca58-72fd0bf47f2mr5944366b3a.8.1738168454776;
        Wed, 29 Jan 2025 08:34:14 -0800 (PST)
Received: from localhost ([2804:30c:b39:fa00:e13a:6da3:e9ec:bbcc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a761150sm11338502b3a.119.2025.01.29.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:34:14 -0800 (PST)
Date: Wed, 29 Jan 2025 13:34:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	=?utf-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <Z5pYrnyV87kOekdc@debian-BULLSEYE-live-builder-AMD64>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-2-jic23@kernel.org>
 <88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
 <20250107142451.000021db@huawei.com>
 <c298f1bb-d0a1-42af-b237-9aa8e422ec1b@baylibre.com>
 <20250111133552.2a44c74e@jic23-huawei>
 <61785c12-1a5e-4465-92e9-83d81c02dd59@baylibre.com>
 <Z40-dXoKfy1iQHnB@debian-BULLSEYE-live-builder-AMD64>
 <20250125115923.59c64785@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125115923.59c64785@jic23-huawei>

On 01/25, Jonathan Cameron wrote:
> On Sun, 19 Jan 2025 15:03:33 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 01/11, David Lechner wrote:
> > > On 1/11/25 7:35 AM, Jonathan Cameron wrote:  
> > > > On Tue, 7 Jan 2025 10:09:15 -0600
> > > > David Lechner <dlechner@baylibre.com> wrote:
> > > >  
> > > >> On 1/7/25 8:24 AM, Jonathan Cameron wrote:  
> > > >>> On Mon, 6 Jan 2025 17:14:12 -0600
> > > >>> David Lechner <dlechner@baylibre.com> wrote:
> > > >>>  
> > > >>>> On 1/5/25 11:25 AM, Jonathan Cameron wrote:  
> > > >>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >>>>>
...
> > > >>>>> ---
> > > >>>>>  include/linux/iio/iio.h | 22 ++++++++++++++++++++++
> > > >>>>>  1 file changed, 22 insertions(+)
> > > >>>>>
> > > >>>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > >>>>> index 56161e02f002..4ef2f9893421 100644
> > > >>>>> --- a/include/linux/iio/iio.h
> > > >>>>> +++ b/include/linux/iio/iio.h
> > > >>>>> @@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> > > >>>>>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> > > >>>>>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> > > >>>>>
> > > >>>>> +/*
> > > >>>>> + * Helper functions that allow claim and release of direct mode
> > > >>>>> + * in a fashion that doesn't generate false positives from sparse.
> > > >>>>> + */
> > > >>>>> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)  
> > > >>>>
> > > >>>> Doesn't __cond_acquires depend on this patch [1] that doesn't look like it was
> > > >>>> ever picked up in sparse?
> > > >>>>
> > > >>>> [1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/  
> > 
> > I applied those two patches to iio testing branch. The diffs appear to be
> > duplicated in email patches and patch 1 first hunk applies to line 353 of
> > include/linux/refcount.h instead of line 361. I also didn't re-add
> > __cond_acquires() which is present in current kernel but not in the patch.
> > I then applied patch 1 and patch 9 of this series.
> > 
> > > >>>
> > > >>> I wondered about that. It 'seems' to do the job anyway. I didn't fully
> > > >>> understand that thread so I just blindly tried it instead :)
> > > >>>
> > > >>> This case is simpler that that thread, so maybe those acrobatics aren't
> > > >>> needed?  
> > > >>
> > > >> I was not able to get a sparse warning without applying that patch to sparse
> > > >> first. My test method was to apply this series to my Linux tree and then
> > > >> comment out a iio_device_release_direct() line in a random driver.
> > > >>
> > > >> And looking at the way the check works, this is exactly what I would expect.
> > > >> The negative output argument in __attribute__((context,x,0,-1)) means something
> > > >> different (check = 0) without the spare patch applied.
> > > >>  
> > > > Curious. I wasn't being remotely careful with what sparse version
> > > > i was running so just went with what Arch is carrying which turns out to be
> > > > a bit old.
> > > >
> > > > Same test as you describe gives me:
> > > >   CHECK   drivers/iio/adc/ad4000.c
> > > > drivers/iio/adc/ad4000.c:533:12: warning: context imbalance in 'ad4000_read_raw' - different lock contexts for basic block
> > > >
> > > > So I tried that with latest sparse from kernel.org and I still get that warning
> > > > which is what I'd expect to see.
> > > >
> > > > Simple make C=1 W=1 build
> > > >
> > > > I wonder what we have different?  Maybe it is missing some cases?
> > > >
> > > > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > > > index ef0acaafbcdb..6785d55ff53a 100644
> > > > --- a/drivers/iio/adc/ad4000.c
> > > > +++ b/drivers/iio/adc/ad4000.c
> > > > @@ -543,7 +543,7 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
> > > >                         return -EBUSY;
> > > >
> > > >                 ret = ad4000_single_conversion(indio_dev, chan, val);
> > > > -               iio_device_release_direct(indio_dev);
> > > > +//             iio_device_release_direct(indio_dev);
> > > >                 return ret;
> > > >         case IIO_CHAN_INFO_SCALE:
> > > >                 *val = st->scale_tbl[st->span_comp][0];
> > > >  
> > With the patches from [1], patches 1 and 9 of this series, and the change above,
> > I got the different lock contexts warn as shown above. No change to Sparse.
> > Tested with both Sparse v0.6.4-66-g0196afe1 from [2] and the Sparse version
> > I have from Debian (Sparse 0.6.4 (Debian: 0.6.4-5)).
> > 
> > [1]: https://lore.kernel.org/all/20220630135934.1799248-1-aahringo@redhat.com/
> > [2]: git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> > 
> > > > Was the test I ran today.
> > > >
> > > > Jonathan
> > > >  
> > >
...
> > >  
> > I think the patches changing to iio_device_claim_direct() are bugy.
> > I did something similar while working on ad4170 and got deadlock.
> 
> This needs debugging as there should be no functional change.
> 
> > In the patch updating ad4000 we had
> > 
> >         case IIO_CHAN_INFO_RAW:
> > -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> > -                       return ad4000_single_conversion(indio_dev, chan, val);
> > -               unreachable();
> > +               if (!iio_device_claim_direct(indio_dev))
> > +                       return -EBUSY;
> > +
> > +               ret = ad4000_single_conversion(indio_dev, chan, val);
> > +               iio_device_release_direct(indio_dev);
> > +               return ret;
> > 
> > iio_device_claim_direct_mode() returns 0 when the user is able to acquire direct
> > mode so !iio_device_claim_direct_mode() evaluates to true when we are be able to
> > acquire iio_dev_opaque mlock, but the ADC driver was returning -EBUSY anyway and
> > never unlocking mlock. We should do
> 
> I'm lost.   I agree iio_device_claim_direct_mode() returns 0 on success, but
> the wrapper in this patch effectively inverts that (see explanation of why, but
> in short it is to make it look more like other locks and get more reliable
> output from sparse.).
> 
> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)
> +{
> +	int ret = iio_device_claim_direct_mode(indio_dev);
> +
> +	if (ret)
> //So if anything other than zero we return false
> +		return false;
> +
> +	__acquire(iio_dev);
> +
> +	return true;
> //return true on sucessfully taking the lock.
> 
> +}
> 
> Hence the check for we did not get the lock should be that new wrapper returning false.
> 
> As it is in your code above.

The patches in this series are correct. I have messed up while working on ad4170
and probably had replaced _claim_direct_scoped() in that driver with
_claim_direct_mode() and a return check similar to the one for _claim_direct().
I've applied all the patches from this series, built, and tested ad4000 driver
with AD7687 and it worked fine. Also, Sparse warns about context imbalance when
_release_direct() is omitted.

Sorry for the false bug alert.

> 
> > 
> > +               if (iio_device_claim_direct(indio_dev))
> > 
> > It was when I ran Sparse without negating iio_device_claim_direct() that I got 
> > ad4000.c:545:17: warning: context imbalance in 'ad4000_read_raw' - unexpected unlock
> > 
> > Maybe the warn would have been more useful if it was "suspicious error return
> > after lock acquisition" or something like that?
> 
> Ok. So it worked, but message unclear?    Fair enough but not much we can do
> about it as that is deep in sparse and technically that message is correct
> as by inverting the logic the unlock is the point were sparse can tell it is backwards.
> 
> > 
> > > So for now, we could take your patch with the __cond_acquires() and
> > > __releases() attribute removed (since they don't do anything) and leave
> > > ourselves a note in a comment that sparse needs to be fixed so that we can use
> > > the __cond_acquires() attribute if/when we get rid of
> > > iio_device_release_direct_mode() completely and want to make
> > > iio_device_release_direct() a regular function.  
> 

