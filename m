Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F9D4313D2
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhJRJxi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhJRJxh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 05:53:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7542C06161C;
        Mon, 18 Oct 2021 02:51:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ls18so11821744pjb.3;
        Mon, 18 Oct 2021 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tt0mPta5yxxX2ueeEOdB2EZQiW3Y1MxNxkayFW2FAUQ=;
        b=EmhLL9DBoMEWSsAYhrahWHYj/jIpr2qP0TItBZdshyV8ZqsMJEuukFXLVDdozC4KSQ
         tlP8uElIojxcbc+Dy57CceVzs4IPg36yUniiDoMmzvLSGMIGe+FOclBmohQdA3EMDSQU
         rv/+qnJSfvOW1BBYUHSSgbCKgiqjarrzsv570O0ZmJC7VeICRzYpB7Px8qf/CxynHRIE
         7NVLRyz+FlF1IaYesvrBKg4mN64eZGCds8qLcauRBX5uK7M346vK3upzcmd77j8ScNLr
         wfu1hYjKc44WZ3BXQUxu2G9umAYo/kzvaA6VuSucxOq6fsIXAZMAdA5W5QtzfLAowoK1
         ICIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tt0mPta5yxxX2ueeEOdB2EZQiW3Y1MxNxkayFW2FAUQ=;
        b=msIpkK0jMNHWKBUgOG3fkS4h7MelNIjshSbem5w4nADqrhvftIEG+TjApg7kZaIzan
         5ichxOqEUFJtj73c0WfNDK1O65mkHVgMI44tCO9GHHr7h0y/nMoVTZMcxAZ6flTTcA+6
         E71639TMf1dLw+sB8pchlCRJj54cCSO9HVGKpSXZCeo7tV6VtAgDomkduTjNuz8wvwdA
         WwptK0KjfyYUcBi/zcCdNVBnzhKR/0JUdfena4XC9CmjTzTZoQMVKl+i1yjvPWJM/62K
         iXvwFEgtgKZFVbq4UwPzhBO8qCS8EA6SXDIo4iglxmPb5/6m19amHsPB/+QxED2/DLJf
         jGbw==
X-Gm-Message-State: AOAM533F4Pe5TgZ/CchlgndEsTjpDLZzeYwL3t6pe8hXICMIBddEEKz0
        ELKI631TTqa6zn16qZ/eDYurpyAt17A=
X-Google-Smtp-Source: ABdhPJy1aBh2FGQXqmtJZLycGnCJW4KcU8bvF+ecxQ/CkguoQ8pq73mLDfKI0U8Ra/XknITzCG8Inw==
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr31821528pjb.212.1634550686419;
        Mon, 18 Oct 2021 02:51:26 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id e12sm12310739pfl.67.2021.10.18.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 02:51:25 -0700 (PDT)
Date:   Mon, 18 Oct 2021 18:51:19 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW1Dl7ylRqyPxH2c@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0PVYT/GCKAnjN9@kroah.com>
 <YW03PSmpMkMVnHdp@shinobu>
 <YW06rLixA2Uush+n@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b/WiIL/XjSIPxFRO"
Content-Disposition: inline
In-Reply-To: <YW06rLixA2Uush+n@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--b/WiIL/XjSIPxFRO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2021 at 11:13:16AM +0200, Greg KH wrote:
> On Mon, Oct 18, 2021 at 05:58:37PM +0900, William Breathitt Gray wrote:
> > On Mon, Oct 18, 2021 at 08:08:21AM +0200, Greg KH wrote:
> > > On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> > > > This removes the chrdev_lock from the counter subsystem. This was
> > > > intended to prevent opening the chrdev more than once. However, this
> > > > doesn't work in practice since userspace can duplicate file descrip=
tors
> > > > and pass file descriptors to other processes. Since this protection
> > > > can't be relied on, it is best to just remove it.
> > >=20
> > > Much better, thanks!
> > >=20
> > > One remaining question:
> > >=20
> > > > --- a/include/linux/counter.h
> > > > +++ b/include/linux/counter.h
> > > > @@ -297,7 +297,6 @@ struct counter_ops {
> > > >   * @events:		queue of detected Counter events
> > > >   * @events_wait:	wait queue to allow blocking reads of Counter eve=
nts
> > > >   * @events_lock:	lock to protect Counter events queue read operati=
ons
> > > > - * @chrdev_lock:	lock to limit chrdev to a single open at a time
> > > >   * @ops_exist_lock:	lock to prevent use during removal
> > >=20
> > > Why do you still need 2 locks for the same structure?
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > Originally there was only the events_lock mutex. Initially I tried using
> > it to also limit the chrdev to a single open, but then came across a
> > "lock held when returning to user space" warning:
> > https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m6=
072133d418d598a5f368bb942c945e46cfab9a5
> >=20
> > Instead of losing the benefits of a mutex lock for protecting the
> > events, I ultimately implemented the chrdev_lock separately as an
> > atomic_t. If the chrdev_lock is removed, then we'll use events_lock
> > solely from now on for this structure.
>=20
> chrdev_lock should be removed, it doesn't really do what you think it
> does, as per the thread yesterday :)
>=20
> So does this mean you can also drop the ops_exist_lock?
>=20
> thanks,
>=20
> greg k-h

When counter_unregister is called, the ops member is set to NULL to
indicate that the driver will be removed and that no new device
operations should occur (because the ops callbacks will no longer be
valid). The ops_exist_lock is used to allow existing ops callback
dereferences to complete before the driver is removed so that we do not
suffer a page fault.

I don't believe we can remove this protection (or can we?) but perhaps
we can merge the three mutex locks (n_events_list_lock, events_lock, and
ops_exist_lock) into a single "counter_lock" that handles all mutex
locking for this structure.

William Breathitt Gray

--b/WiIL/XjSIPxFRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFtQ4cACgkQhvpINdm7
VJIdLw/+NJ6vxzJ1hqNe0bg0a2+07MpkSTwiIJOAvnu8ajer9IgnYYaARf8D5jWr
0HHUShHtK4PpzDGnPlgMybJWn4fBnqyHNLUI0fqa4RK+sksasKBy+aaQEz4/rYTr
BiJfhnjWp4qBR8eTATrUhUvfFhvYiqWaY7W6sgwwV8J8qQG1yIjm2ufBKD03oWEo
66CpeMq9OiBFo/BBs8yqXoN+9Hz9s60dX+ydHi/cQviyAC89Zqlyn55iI6jObrO3
q4pTRLQPpplngv0EJkSybT5w8J23m6kHdfGreUSsSpWA4UKRD6kBGt6sVlWeeJLz
WLjXcsFjwRV235f40O9tjPtH46+h22caF2qBID456yC3Gw0CFKiDgJBBl3CuESN5
86vskWdzqEuHMGMek1dGEFhl6O3cqXtd54PBq3a2Dma8oil/NhNJLJmtIsO7aXFT
fq4o5+tisoKIvd4GPHNeXFHDzfJcvvBEy1OMeHmnQGhrOj22WCLk1Ac6sfH+EoWK
ujBWf4GNFA9qJkwj2fTILXk47g4E7qyeRN83CqYfCyVeU4100e4SInMSJrCmTpKi
+TAWFMg521rRXrMJV6K0IzAbNKJVvdgkfpYJcSiCduR5zAPQpQfM4fYiXmQkuOha
bjH4iTjLROUWCeJm3PEY88dLz2Lnbl1Nm20f83TAHfgIbnFRGXI=
=U9hd
-----END PGP SIGNATURE-----

--b/WiIL/XjSIPxFRO--
