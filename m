Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D046C4344C4
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 07:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhJTFov (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTFou (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 01:44:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71CC06161C;
        Tue, 19 Oct 2021 22:42:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so21502282pgc.6;
        Tue, 19 Oct 2021 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ifN0cxqE/QoI02nqwKUsKcrwVn6J3RV5OLBMXfGT3qo=;
        b=SAxr/n0IsILMQCBwUaFxiBz4EXLbe6CBFXHaCj5yYf9VsHWvdv8swDsMuxfRc3c+1+
         amFv/LhcBaNz5bixV7yFzVZn91XC6QQj2feY1c44qoreUGMZsQodWNZReRxX0EkbY8H1
         pX+AxL3/Ymza1O7HGiG6OpCFiLpE1gTjXP5Q+le+JmBpc/qbY7Mp3rWHPJfnOBtFJUuc
         5LuyvK/kWoJoikV2mJfI6ITQ0ezoE7ckttMXc38SKII/dSdt4lq48GRRMdzqhW9zgBuH
         nToBrHNBwN1QKHliiFbXzrMCAqMoESgi7BJuxg4YPaBbup7Wqxk13O3umFOjsT/gV0tH
         Oa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifN0cxqE/QoI02nqwKUsKcrwVn6J3RV5OLBMXfGT3qo=;
        b=VBJfV+R9RqpyHvppt1Y11mkH2EQ1UBYwxuVfCINhgqnvRRro/9yd8x2GkYTt1pHFKo
         dJzCcS4KmbniZ4QKk/N4t9IrHG7f2SloLcRynfK7xPxGaRJcdB9V1MLBuWWqJTQOoCdM
         CqXKPLz3NBURIDdJl45gwgOZatCLC+09fD/o2IhlsNxYI9Mkml2LFcr6ozz3pm0defwd
         6WZ71/TvLp2zOFfLfSSxtwAF1K5RqhtuxjWXHi1vBqpzL+aMGeEAmGGQzxBSMXc9kl/c
         fX5t726WL4Lfhg682ba7ipkg0R7mbqRSY/3X5J1akIb4to0dM7jTDlEKmjMUxKqDcj44
         4ogQ==
X-Gm-Message-State: AOAM532nZAwFPllZaD2w5s9JZygDyNIeu2ZoogKpwbTFdZn1lHI7HSrt
        Fl0ld+YUyXO8NK1980/non4=
X-Google-Smtp-Source: ABdhPJxC66hGrQ6LK/ZEcOJBetYNNicjFRkY/JOygFGq308F07cRqc9aWxWJdbtXJke3jJ39FFAFMA==
X-Received: by 2002:a05:6a00:1255:b0:44c:dd49:b39a with SMTP id u21-20020a056a00125500b0044cdd49b39amr4288882pfi.66.1634708556298;
        Tue, 19 Oct 2021 22:42:36 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id l29sm916127pgc.47.2021.10.19.22.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 22:42:35 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:42:31 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW+sRz0EQ0uKMDuT@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
 <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
 <YW5rVLrbrVVJ75SY@shinobu>
 <YW5uxIQ1WuW66cf0@kroah.com>
 <YW5xUtWdvW5zHFx5@shinobu>
 <c0a4cd67-6046-b06d-c33c-c0f3374d0b52@lechnology.com>
 <YW8xtA7ZU+80W/N7@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vEWqxqo7oFyNGX06"
Content-Disposition: inline
In-Reply-To: <YW8xtA7ZU+80W/N7@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vEWqxqo7oFyNGX06
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 20, 2021 at 05:59:32AM +0900, William Breathitt Gray wrote:
> On Tue, Oct 19, 2021 at 09:44:04AM -0500, David Lechner wrote:
> > On 10/19/21 2:18 AM, William Breathitt Gray wrote:
> > > On Tue, Oct 19, 2021 at 09:07:48AM +0200, Greg KH wrote:
> > >> On Tue, Oct 19, 2021 at 03:53:08PM +0900, William Breathitt Gray wro=
te:
> > >>> On Mon, Oct 18, 2021 at 11:03:49AM -0500, David Lechner wrote:
> > >>>> On 10/18/21 4:14 AM, William Breathitt Gray wrote:
> > >>>>> On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> > >>>>>> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/c=
ounter-sysfs.c
> > >>>>>> index 1ccd771da25f..7bf8882ff54d 100644
> > >>>>>> --- a/drivers/counter/counter-sysfs.c
> > >>>>>> +++ b/drivers/counter/counter-sysfs.c
> > >>>>>> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write=
(struct counter_device *counter,
> > >>>>>>    					   u64 val)
> > >>>>>>    {
> > >>>>>>    	DECLARE_KFIFO_PTR(events, struct counter_event);
> > >>>>>> -	int err =3D 0;
> > >>>>>> -
> > >>>>>> -	/* Ensure chrdev is not opened more than 1 at a time */
> > >>>>>> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> > >>>>>> -		return -EBUSY;
> > >>>>>> +	int err;
> > >>>>>>   =20
> > >>>>>>    	/* Allocate new events queue */
> > >>>>>>    	err =3D kfifo_alloc(&events, val, GFP_KERNEL);
> > >>>>>>    	if (err)
> > >>>>>> -		goto exit_early;
> > >>>>>> +		return err;
> > >>>>>>   =20
> > >>>>>>    	/* Swap in new events queue */
> > >>>>>>    	kfifo_free(&counter->events);
> > >>>>>>    	counter->events.kfifo =3D events.kfifo;
> > >>>>>
> > >>>>> Do we need to hold the events_lock mutex here for this swap in ca=
se
> > >>>>> counter_chrdev_read() is in the middle of reading the kfifo to
> > >>>>> userspace, or do the kfifo macros already protect us from a race
> > >>>>> condition here?
> > >>>>>
> > >>>> Another possibility might be to disallow changing the size while
> > >>>> events are enabled. Otherwise, we also need to protect against
> > >>>> write after free.
> > >>>>
> > >>>> I considered this:
> > >>>>
> > >>>> 	swap(counter->events.kfifo, events.kfifo);
> > >>>> 	kfifo_free(&events);
> > >>>>
> > >>>> But I'm not sure that would be safe enough.
> > >>>
> > >>> I think it depends on whether it's safe to call kfifo_free() while =
other
> > >>> kfifo_*() calls are executing. I suspect it is not safe because I d=
on't
> > >>> think kfifo_free() waits until all kfifo read/write operations are
> > >>> finished before freeing -- but if I'm wrong here please let me know.
> > >>>
> > >>> Because of that, will need to hold the counter->events_lock afteral=
l so
> > >>> that we don't modify the events fifo while a kfifo read/write is go=
ing
> > >>> on, lest we suffer an address fault. This can happen regardless of
> > >>> whether you swap before or after the kfifo_free() because the old f=
ifo
> > >>> address could still be in use within those uncompleted kfifo_*() ca=
lls
> > >>> if they were called before the swap but don't complete before the
> > >>> kfifo_free().
> > >>>
> > >>> So we have a problem now that I think you have already noticed: the
> > >>> kfifo_in() call in counter_push_events() also needs protection, but=
 it's
> > >>> executing within an interrupt context so we can't try to lock a mut=
ex
> > >>> lest we end up sleeping.
> > >>>
> > >>> One option we have is as you suggested: we disallow changing size w=
hile
> > >>> events are enabled. However, that will require us to keep track of =
when
> > >>> events are disabled and implement a spinlock to ensure that we don't
> > >>> disable events in the middle of a kfifo_in().
> > >>>
> > >>> Alternatively, we could change events_lock to a spinlock and use it=
 to
> > >>> protect all these operations on the counter->events fifo. Would this
> > >>> alternative be a better option so that we avoid creating another
> > >>> separate lock?
> > >>
> > >> I would recommend just having a single lock here if at all possible,
> > >> until you determine that there a performance problem that can be
> > >> measured that would require it to be split up.
> > >>
> > >> thanks,
> > >>
> > >> greg k-h
> > >=20
> > > All right let's go with a single events_lock spinlock then. David, if
> > > you make those changes and submit a v2, I'll be okay with this patch =
and
> > > can provide my ack for it.
> > >=20
> >=20
> > We can't use a spin lock for everything since there are operations
> > that can sleep that need to be in the critical sections. Likewise,
> > we can't use a mutex for everything since some critical sections
> > are in interrupt handlers. But, I suppose we can try combining
> > the existing mutexes. Since the kfifo is accessed from both
> > contexts, it seems like it still needs more consideration than
> > just a mutex or a spin lock, e.g. if events are enabled, don't
> > allow swapping out the kfifo buffer.
>=20
> I think there is a deadlock case if we combine the ops_exists_lock with
> the n_events_list_lock, so this will need further thought. However, at
> the very least the swap occuring in counter_events_queue_size_write()
> and the kfifo_in() in counter_push_events() require some sort of
> locking; it is trivial to cause a page fault with the code in its
> current state.
>=20
> I think this can be fixed if just events_lock is changed to spinlock for
> now without modifying the other locks. We can try to combine the
> remaining locks in a subsequent patch, if they are capable of being
> combined.
>=20
> William Breathitt Gray

After considering this further, kfifo_to_user() could possibly sleep so
we can't use a spinlock here afterall. As such, events_lock should
remain as a mutex and instead we'll only allow swapping out the kfifo
buffer when events are disabled.

William Breathitt Gray

--vEWqxqo7oFyNGX06
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFvrDoACgkQhvpINdm7
VJKqbQ/+Jjh7Uy7/QPR7xOdrvPr2Pb3nngQf9Z3frUl3B6T8iX4a24yNSPoUQfNW
iMjIFEtCkt7mgjPv5KlDMeO1dWDvIyFm5sGT8uVrrZ2S43UtDaRk7LeBnxPILj4/
nG5FjH/J9mTiO+2NxQkJw9otUt8yAY/oOj1+Onz+OloSWv40aaZ9Pwjg0lv2Njew
tcXCPG1UllLPmNNovODea1huwfIbUajE58XmeYiXtLwn0/DQZfsgUEXlF3bYam4V
QpMFbz5MURQ4JEJRwiSEb+9/gE5Um+dMkHAdCJ0IsasxtSnjfV9g9ypdaIGKvCDg
DafEPcjePFD/h/MPU+gjt+W4iNy+J8KirluMI3XUDIqeF+ZkEmmhbWmYowqWhZkC
ZRyqEVcBn4jskKUl+wPtTQLk3dqGyZAOTLVsqyfNpSYkHcNIsj7lDhMht0A2i0Dc
s5JCdpqKi+OT6Np2LBF9TWuaDYUtsNy2NfUbzWVE6fbVWZNKhYxWNtHk5m0mBz9e
Eb0Dpa2SEr1sxF6TxS+H6k6DK+q/DwWpDalG30kACWBM2M6EG9H4MrjaTyHu2E72
BhzF69MLfC4/6zaX7sTz0/A4HBPG8BUKs/UmTC1L4woZyRCtBsGdSHM3ajW/zB0B
TpYfny46aGvdtO16O74Y4lyPDNlGLEZwx5fRb2aXsjih2aGGS0M=
=RljO
-----END PGP SIGNATURE-----

--vEWqxqo7oFyNGX06--
