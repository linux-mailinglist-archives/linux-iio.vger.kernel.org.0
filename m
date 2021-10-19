Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12763433003
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhJSHsZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhJSHsZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 03:48:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9DC06161C;
        Tue, 19 Oct 2021 00:46:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r2so18574392pgl.10;
        Tue, 19 Oct 2021 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sIttBMa8WOKOF9/Nln8NkSFDD5zCvIuI9jo51llxtPk=;
        b=gFcIEA7kShTp+fe3iUTzEpGXizNo4spXtQyzilBDajdUqp4Obn4IOO56Fg1redr9WB
         6N2Rt+vdaFq8fEAkGmUaXlGY0IPJX21jFlO9wcKmnx0DYrqcE97ZHYp6mbjZyl6N0LIQ
         c3LXNmEqptuZRJJnfrLv2ORnTK+9h2nh3lMrzBhnsOSx/W9HsHdf8Gxq12Ng6+B0fuvw
         zI8JM3ns15MQ/QGwebFkG3C9O/dr8GdOVP8+1qQ4b9RxChU9JNZhmQ/1XqwI09y5lF5C
         NmfPLWTbH48hXuvCySm88a9OEyH1l0HpxBJ29O1D0ga+vu5bHmxcbNhbmzTwUXFlcB93
         s0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIttBMa8WOKOF9/Nln8NkSFDD5zCvIuI9jo51llxtPk=;
        b=2iZnxA6mYtzT+aKDWLxbVkM0joKnHmQSq6H7TVnIDRU9WfnP9pfRBXPpjgey9YJCgK
         13bqca4edgn5NCJjD9mfmXupl5/F8erXN8V5ZOb3EbKVNLyetF6CneWjnKFk4hthp0MG
         N9CaWkUcmFz/hMjPRSF8/w96xMMLOaWCnsSSqteT7N4LZ1i2b/M8qswQZCAtU2+mQ4EK
         Ti90KnRXBmz/3L6iji34iCdEKh8/jIvR3U6nMwLcjjxf1+C0EKLxUneChTw5Zoiq5pcS
         1OGlVlQPzYSfph7hk0jgeWiRlgSgLAIXKtQQcUcbzE172qKQciJ8gl0PMLdWjCAur3tv
         xPbg==
X-Gm-Message-State: AOAM530Kty0TxFwd92qgLih7E+Zlui58GcyolVku53l+ZJXkukgdvsVz
        SeRqniRLb1062FyqWuVF6/Qz7mXdUO0=
X-Google-Smtp-Source: ABdhPJxrj/JrB7ggmgv7+TMZmcQGf03PjSXO7UkGiKTQMTI0x1FlCqQuSnWxFeXKBneDT7k6AbfpsQ==
X-Received: by 2002:aa7:9735:0:b0:44c:619f:29fc with SMTP id k21-20020aa79735000000b0044c619f29fcmr33782233pfg.79.1634629572273;
        Tue, 19 Oct 2021 00:46:12 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id p12sm6909184pfh.52.2021.10.19.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 00:46:11 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:46:07 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW53v22RyU/DCBBx@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
 <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
 <YW5rVLrbrVVJ75SY@shinobu>
 <YW5uxIQ1WuW66cf0@kroah.com>
 <YW5xUtWdvW5zHFx5@shinobu>
 <YW5zzVJZ89cFW9bD@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8ab5jLAb/cx7G07S"
Content-Disposition: inline
In-Reply-To: <YW5zzVJZ89cFW9bD@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--8ab5jLAb/cx7G07S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 09:29:17AM +0200, Greg KH wrote:
> On Tue, Oct 19, 2021 at 04:18:42PM +0900, William Breathitt Gray wrote:
> > On Tue, Oct 19, 2021 at 09:07:48AM +0200, Greg KH wrote:
> > > On Tue, Oct 19, 2021 at 03:53:08PM +0900, William Breathitt Gray wrot=
e:
> > > > On Mon, Oct 18, 2021 at 11:03:49AM -0500, David Lechner wrote:
> > > > > On 10/18/21 4:14 AM, William Breathitt Gray wrote:
> > > > > > On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> > > > > >> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter=
/counter-sysfs.c
> > > > > >> index 1ccd771da25f..7bf8882ff54d 100644
> > > > > >> --- a/drivers/counter/counter-sysfs.c
> > > > > >> +++ b/drivers/counter/counter-sysfs.c
> > > > > >> @@ -796,25 +796,18 @@ static int counter_events_queue_size_wri=
te(struct counter_device *counter,
> > > > > >>   					   u64 val)
> > > > > >>   {
> > > > > >>   	DECLARE_KFIFO_PTR(events, struct counter_event);
> > > > > >> -	int err =3D 0;
> > > > > >> -
> > > > > >> -	/* Ensure chrdev is not opened more than 1 at a time */
> > > > > >> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> > > > > >> -		return -EBUSY;
> > > > > >> +	int err;
> > > > > >>  =20
> > > > > >>   	/* Allocate new events queue */
> > > > > >>   	err =3D kfifo_alloc(&events, val, GFP_KERNEL);
> > > > > >>   	if (err)
> > > > > >> -		goto exit_early;
> > > > > >> +		return err;
> > > > > >>  =20
> > > > > >>   	/* Swap in new events queue */
> > > > > >>   	kfifo_free(&counter->events);
> > > > > >>   	counter->events.kfifo =3D events.kfifo;
> > > > > >=20
> > > > > > Do we need to hold the events_lock mutex here for this swap in =
case
> > > > > > counter_chrdev_read() is in the middle of reading the kfifo to
> > > > > > userspace, or do the kfifo macros already protect us from a race
> > > > > > condition here?
> > > > > >=20
> > > > > Another possibility might be to disallow changing the size while
> > > > > events are enabled. Otherwise, we also need to protect against
> > > > > write after free.
> > > > >=20
> > > > > I considered this:
> > > > >=20
> > > > > 	swap(counter->events.kfifo, events.kfifo);
> > > > > 	kfifo_free(&events);
> > > > >=20
> > > > > But I'm not sure that would be safe enough.
> > > >=20
> > > > I think it depends on whether it's safe to call kfifo_free() while =
other
> > > > kfifo_*() calls are executing. I suspect it is not safe because I d=
on't
> > > > think kfifo_free() waits until all kfifo read/write operations are
> > > > finished before freeing -- but if I'm wrong here please let me know.
> > > >=20
> > > > Because of that, will need to hold the counter->events_lock afteral=
l so
> > > > that we don't modify the events fifo while a kfifo read/write is go=
ing
> > > > on, lest we suffer an address fault. This can happen regardless of
> > > > whether you swap before or after the kfifo_free() because the old f=
ifo
> > > > address could still be in use within those uncompleted kfifo_*() ca=
lls
> > > > if they were called before the swap but don't complete before the
> > > > kfifo_free().
> > > >=20
> > > > So we have a problem now that I think you have already noticed: the
> > > > kfifo_in() call in counter_push_events() also needs protection, but=
 it's
> > > > executing within an interrupt context so we can't try to lock a mut=
ex
> > > > lest we end up sleeping.
> > > >=20
> > > > One option we have is as you suggested: we disallow changing size w=
hile
> > > > events are enabled. However, that will require us to keep track of =
when
> > > > events are disabled and implement a spinlock to ensure that we don't
> > > > disable events in the middle of a kfifo_in().
> > > >=20
> > > > Alternatively, we could change events_lock to a spinlock and use it=
 to
> > > > protect all these operations on the counter->events fifo. Would this
> > > > alternative be a better option so that we avoid creating another
> > > > separate lock?
> > >=20
> > > I would recommend just having a single lock here if at all possible,
> > > until you determine that there a performance problem that can be
> > > measured that would require it to be split up.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > All right let's go with a single events_lock spinlock then. David, if
> > you make those changes and submit a v2, I'll be okay with this patch and
> > can provide my ack for it.
>=20
> Wait, no, you need one patch to remove the atomic lock for the open
> "protection" and then another one for the other locks.  The original
> patch here was fine, but can be part of a patch series, don't lump them
> all together into one huge change.
>=20
> thanks,
>=20
> greg k-h

Understood. I'll provide my ack for this patch here then.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--8ab5jLAb/cx7G07S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFud78ACgkQhvpINdm7
VJI1yQ//fmORXWo6fjixRwH2TJ2orY1jCff9OXcE7TG3PTh+60RFXbnYvkpFt6nC
q/59KP5OUw10XVEkG2TExG8BfBm0T8MtzA4WXnz5pf/Zjrk8eLnrEgQEBxYvHF/w
ad3kcHfj/dKDCoezUJ0nakn3njSXDmQROE35w0oi6PHfm1sgdRhLym1z/Mc7kaQU
i7/aIRHFCd4xApe2Bd4uQY1r1+TddvRKK9Hij49/1wD+4bIdrZRLI/v+d6G6skVD
6S37/SAtn50fL+rK1mKwLhIMb2dpcjF8qoeWBXuKMVxMHnr5OZnNsZH/e9+ufEwu
0QqR1QwZH75xQAi6TwdugqDzRLtANLcS2DzdlG7rGfMRHa+aj2Nos6+pE6NM/hhc
QgaogE2oPU+kAABj4w/P0YcGJCLV7Wvjdlhbgg8arpLnJBPcJk0l8CXJlZplxSad
nsxxFPDuJLyM7mmvVNZ93x1+GGI1EgI+cA0Cx3XT8lq8avvp25SQlrkPh8AVCLJv
VvU12aDhS9raE2OKuVZyasker4ZmXqchfMkCAa2b0qBJxSaZhh1dqaZENzXrOCfE
yDsaOnZ+hA7Dj1CgcULOm2eoR8tMfo6jA4WQj1RseXT4LGC8jnQ5dKxyssuYNhjG
aVqQrB1Bc+4Ug4mRGYYdm9fNzUOP5R2NTGcTByopqm8IP8/mnI8=
=jXch
-----END PGP SIGNATURE-----

--8ab5jLAb/cx7G07S--
