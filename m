Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49EE434012
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJSVBv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhJSVBu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 17:01:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACB8C06161C;
        Tue, 19 Oct 2021 13:59:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k26so1052529pfi.5;
        Tue, 19 Oct 2021 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Dw+uVOyJlb9aFOWm6n360WlgpZegmpZfooFYCFiJGQ=;
        b=fMNWbgsXfcisqqrcafS+t+UacLTfjYxY2kFXba58K6pg8e53xdM5t8kLzWJHXMsbMn
         0GgGE4DgsiyAHUbb4fXZAsmFu/9+GFkPm8hVGR5z28NE5QX+OyQL5iFaDpFCSfDSEAY4
         id2kK7s8wOJxeW2hWfMUgXOwIQTgY0XtBzNY7cqo8xPmXbrdVbus6bdmoXf890soR3Ch
         G3F+i6ZojB0IbN8lvWQGaIxVfA35LuEIdY5NcoH2ATgmN0EkpUGzjGMUxavOBGNQp2vm
         0dNhufCoJwERT+Cj/ilYlk/dwjCVR7WgFeSY/Ymw1rLnL5WqLCtZwMlQbFrJvb8MwTWH
         q0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Dw+uVOyJlb9aFOWm6n360WlgpZegmpZfooFYCFiJGQ=;
        b=QKYKv+gPuqtQqHUkQBxqJiNpRO0utdcawWos8310TcT1sa5D5LOn50E3BJYNq3v0kP
         E9kmpbKjmxHEfD2KAswOlZDSUOD5ti9nNa0zxXsC6j9V0PcKt9OKETl5cacsNXo51Xz1
         WOYR1uDwLFR9/jGb89lNzauB1R/2TteJ3Uv5HlJDu9GC/AQMjmqKati825P9lwRWdTJT
         j3sXiHUMqw0iSGzbP9L8/SBdhHfedd7Fb+oXqcZZS7I7JmFMRqwIESWjFDaeyMCy0D+G
         t13toFTKIQ/tHaPrRo/Y5FuoGWiYuI6+pJUyaBk6jz1wCWXJoxIUWjSVfS97lWYSpY1r
         swqw==
X-Gm-Message-State: AOAM532DYO9EDq0XUqsI8ucpJKSEFy/LrGiH2surbbJCLQUmuTmB+56+
        j+Ceq/I4Jh0V3Cux5T4ry0AafdKU9Pg=
X-Google-Smtp-Source: ABdhPJzbiOpgqE19zNmkF4w1D+A95HpgsZL/Aa8PyOgs1pZr4gd7uRl/Z3wFgPmLpWa4tBb4NZrBoQ==
X-Received: by 2002:a63:ec57:: with SMTP id r23mr30299984pgj.17.1634677177355;
        Tue, 19 Oct 2021 13:59:37 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id nr14sm69414pjb.24.2021.10.19.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:59:36 -0700 (PDT)
Date:   Wed, 20 Oct 2021 05:59:32 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW8xtA7ZU+80W/N7@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
 <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
 <YW5rVLrbrVVJ75SY@shinobu>
 <YW5uxIQ1WuW66cf0@kroah.com>
 <YW5xUtWdvW5zHFx5@shinobu>
 <c0a4cd67-6046-b06d-c33c-c0f3374d0b52@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dyPAG807ie2QS01r"
Content-Disposition: inline
In-Reply-To: <c0a4cd67-6046-b06d-c33c-c0f3374d0b52@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--dyPAG807ie2QS01r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 09:44:04AM -0500, David Lechner wrote:
> On 10/19/21 2:18 AM, William Breathitt Gray wrote:
> > On Tue, Oct 19, 2021 at 09:07:48AM +0200, Greg KH wrote:
> >> On Tue, Oct 19, 2021 at 03:53:08PM +0900, William Breathitt Gray wrote:
> >>> On Mon, Oct 18, 2021 at 11:03:49AM -0500, David Lechner wrote:
> >>>> On 10/18/21 4:14 AM, William Breathitt Gray wrote:
> >>>>> On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> >>>>>> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/cou=
nter-sysfs.c
> >>>>>> index 1ccd771da25f..7bf8882ff54d 100644
> >>>>>> --- a/drivers/counter/counter-sysfs.c
> >>>>>> +++ b/drivers/counter/counter-sysfs.c
> >>>>>> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write(s=
truct counter_device *counter,
> >>>>>>    					   u64 val)
> >>>>>>    {
> >>>>>>    	DECLARE_KFIFO_PTR(events, struct counter_event);
> >>>>>> -	int err =3D 0;
> >>>>>> -
> >>>>>> -	/* Ensure chrdev is not opened more than 1 at a time */
> >>>>>> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> >>>>>> -		return -EBUSY;
> >>>>>> +	int err;
> >>>>>>   =20
> >>>>>>    	/* Allocate new events queue */
> >>>>>>    	err =3D kfifo_alloc(&events, val, GFP_KERNEL);
> >>>>>>    	if (err)
> >>>>>> -		goto exit_early;
> >>>>>> +		return err;
> >>>>>>   =20
> >>>>>>    	/* Swap in new events queue */
> >>>>>>    	kfifo_free(&counter->events);
> >>>>>>    	counter->events.kfifo =3D events.kfifo;
> >>>>>
> >>>>> Do we need to hold the events_lock mutex here for this swap in case
> >>>>> counter_chrdev_read() is in the middle of reading the kfifo to
> >>>>> userspace, or do the kfifo macros already protect us from a race
> >>>>> condition here?
> >>>>>
> >>>> Another possibility might be to disallow changing the size while
> >>>> events are enabled. Otherwise, we also need to protect against
> >>>> write after free.
> >>>>
> >>>> I considered this:
> >>>>
> >>>> 	swap(counter->events.kfifo, events.kfifo);
> >>>> 	kfifo_free(&events);
> >>>>
> >>>> But I'm not sure that would be safe enough.
> >>>
> >>> I think it depends on whether it's safe to call kfifo_free() while ot=
her
> >>> kfifo_*() calls are executing. I suspect it is not safe because I don=
't
> >>> think kfifo_free() waits until all kfifo read/write operations are
> >>> finished before freeing -- but if I'm wrong here please let me know.
> >>>
> >>> Because of that, will need to hold the counter->events_lock afterall =
so
> >>> that we don't modify the events fifo while a kfifo read/write is going
> >>> on, lest we suffer an address fault. This can happen regardless of
> >>> whether you swap before or after the kfifo_free() because the old fifo
> >>> address could still be in use within those uncompleted kfifo_*() calls
> >>> if they were called before the swap but don't complete before the
> >>> kfifo_free().
> >>>
> >>> So we have a problem now that I think you have already noticed: the
> >>> kfifo_in() call in counter_push_events() also needs protection, but i=
t's
> >>> executing within an interrupt context so we can't try to lock a mutex
> >>> lest we end up sleeping.
> >>>
> >>> One option we have is as you suggested: we disallow changing size whi=
le
> >>> events are enabled. However, that will require us to keep track of wh=
en
> >>> events are disabled and implement a spinlock to ensure that we don't
> >>> disable events in the middle of a kfifo_in().
> >>>
> >>> Alternatively, we could change events_lock to a spinlock and use it to
> >>> protect all these operations on the counter->events fifo. Would this
> >>> alternative be a better option so that we avoid creating another
> >>> separate lock?
> >>
> >> I would recommend just having a single lock here if at all possible,
> >> until you determine that there a performance problem that can be
> >> measured that would require it to be split up.
> >>
> >> thanks,
> >>
> >> greg k-h
> >=20
> > All right let's go with a single events_lock spinlock then. David, if
> > you make those changes and submit a v2, I'll be okay with this patch and
> > can provide my ack for it.
> >=20
>=20
> We can't use a spin lock for everything since there are operations
> that can sleep that need to be in the critical sections. Likewise,
> we can't use a mutex for everything since some critical sections
> are in interrupt handlers. But, I suppose we can try combining
> the existing mutexes. Since the kfifo is accessed from both
> contexts, it seems like it still needs more consideration than
> just a mutex or a spin lock, e.g. if events are enabled, don't
> allow swapping out the kfifo buffer.

I think there is a deadlock case if we combine the ops_exists_lock with
the n_events_list_lock, so this will need further thought. However, at
the very least the swap occuring in counter_events_queue_size_write()
and the kfifo_in() in counter_push_events() require some sort of
locking; it is trivial to cause a page fault with the code in its
current state.

I think this can be fixed if just events_lock is changed to spinlock for
now without modifying the other locks. We can try to combine the
remaining locks in a subsequent patch, if they are capable of being
combined.

William Breathitt Gray

--dyPAG807ie2QS01r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFvMZgACgkQhvpINdm7
VJJNwBAAmLHl+r0pL0sAo3OFPa3WckXw4tQXnRyPPQ+J+En/7e2XR/4C+Ua3PD2K
TxDj+A3Zg518aofZNzfzWlcYdMmYvJQjZ8Zlnvh0zEqGa48I7s/yiGi4LJ64DQBj
LusEIzZek7WofknmPgGiOYaDHaVdHCXd3FdsTt03g/F0YikSF6Y8fwjeOLMc7ezA
ytPoteaFgAlKj5kqta7uj8azfHHXXExU1XRfcNY81+L4l7ezIZ/DxVyvEri48Pdy
Wgx1IWv8GNtBMXxuwYKnDONTMDAJdIOPvzvKTumOkXk9EWk5A/c8pIoN06Nw5Q1K
T1Af3kjc+8a6teLTEPVReWRenRDr+8PQuBqJkN9oEIAtzViYV7XS00XCSV7upAXB
e84ckcNqv8ogJiVLM9DOGRo9lJZaJiz+eThSwkM2xb7Oka3ULqV3VZWVLRQl692P
+NxmLnB5biZ3wm9ME3kfHG90HknvbRO0R5iUCI4DXZRxlPwP7AT9FREDh2Bumdru
sBLyZeTFeafGWPq20a2uvXoVGJTqL3Z4baLebRcIXwBVZFL+jggomF3JqxEOSm0I
xXV3ev7Lskdum/7Ss19RUabHVkk1/rMVdxV3aUJUg2yOIkPjNHMCtjcJ/Jx18ScZ
8NlhVdCNUTZJnlEfrhNw5qDJbLOhQ4m4ugMv95Y5FJGGXnSOtkk=
=PcJq
-----END PGP SIGNATURE-----

--dyPAG807ie2QS01r--
