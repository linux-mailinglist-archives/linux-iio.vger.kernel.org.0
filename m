Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63DA325A83
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 01:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBZAEk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 19:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhBZAEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 19:04:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF950C06174A;
        Thu, 25 Feb 2021 16:03:57 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g4so4980883pgj.0;
        Thu, 25 Feb 2021 16:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6xnb86RhPkQovrbj87oZceQLnvq33XU1nv/cjwf3XRI=;
        b=DrisM3vA7nmsgSAqf45LxyW9UBp3YtQu+vV1WkifsIIv2wfd27mahTLSXUhGQqV8+K
         5RV9E9FIopEmwr1/v7ECuDr94o02uI+7bfAbnxjrgDE/nFvGiamir5Cqv3+ElwV8AHRM
         N1m58ZzinCQ9L5faX9r+B4X0vkG8IzMOt2KJSxK2u5b7vb+EeS3blgIePawlve4ok82B
         cz5rkhtvRUmMMUxiKjtus32eUZjnvUOaPN0m45XrNDZ7A8tli04CPo4RjT9dK+dFt2Iz
         9hlhiaiMmYx1nc51OCVmegDB0dGGAZMqxaw60qoY87nqWqfWZHQzEL0JX7MYS6z7dQBt
         lpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xnb86RhPkQovrbj87oZceQLnvq33XU1nv/cjwf3XRI=;
        b=Kg8cH/R0FJLwPaM6MNokV6mX1EeJiap7JKQ6ACUdmyEXPKK/PEBUCRsTySvyGtpsSu
         zevr+yfngdGQVYIYmgzU2VRVGWwHWAw4q19ZM2setSlYsPVG7v2Jf6Dkxopxb3Lww2RD
         BPD4aXzgbhJsG39Sx0Nh7x/xcyWGDeMrJl/ntZrDLk4/zkv4JVrG6Z9S8HzpCXfg1YHF
         4isGMnZxXqxlYu8VFNR4xkoyegUXEatjFGN612LDS9tQalHDx2km1uNVfMhItOHeseSI
         DXmXlbUycmZYwBZHomRRzx+qazqFaZ5R0Q47MUQ0dln+5zKvDRiHJ7zcHQFL6Gpp+egA
         j1nw==
X-Gm-Message-State: AOAM531rpdxYuhEQvKlkJGzE/0GBYCZxIQK5EIzULiUv24GoHJjBiYqp
        DLLq3IfgCaDWe963VF2Oz7o=
X-Google-Smtp-Source: ABdhPJyZR4ptosE9/NEaiXfthCao0Ri2ZmlqXid10F65SCpm3hmdwAM1dqRgjqlvxTmVJyK0f7qWJQ==
X-Received: by 2002:aa7:9595:0:b029:1ee:8:2b76 with SMTP id z21-20020aa795950000b02901ee00082b76mr224566pfj.57.1614297837209;
        Thu, 25 Feb 2021 16:03:57 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id a19sm6965305pff.186.2021.02.25.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 16:03:56 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:03:48 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 20/22] counter: Implement events_queue_size sysfs
 attribute
Message-ID: <YDg65OmLa05g53qc@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
 <20210214181146.66d43da7@archlinux>
 <YC5CMLuKnXbkZond@shinobu>
 <20210221155140.3e1ef13c@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76Dn/TuCDFUTSoIf"
Content-Disposition: inline
In-Reply-To: <20210221155140.3e1ef13c@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--76Dn/TuCDFUTSoIf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 21, 2021 at 03:51:40PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Feb 2021 19:32:16 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Sun, Feb 14, 2021 at 06:11:46PM +0000, Jonathan Cameron wrote:
> > > On Fri, 12 Feb 2021 21:13:44 +0900
> > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >  =20
> > > > The events_queue_size sysfs attribute provides a way for users to
> > > > dynamically configure the Counter events queue size for the Counter
> > > > character device interface. The size is in number of struct
> > > > counter_event data structures. The number of elements will be round=
ed-up
> > > > to a power of 2 due to a requirement of the kfifo_alloc function ca=
lled
> > > > during reallocation of the queue.
> > > >=20
> > > > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
> > > >  drivers/counter/counter-chrdev.c            | 23 +++++++++++++++++=
++
> > > >  drivers/counter/counter-chrdev.h            |  2 ++
> > > >  drivers/counter/counter-sysfs.c             | 25 +++++++++++++++++=
++++
> > > >  4 files changed, 58 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Document=
ation/ABI/testing/sysfs-bus-counter
> > > > index 847e96f19d19..f6cb2a8b08a7 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > > > @@ -212,6 +212,14 @@ Description:
> > > >  		both edges:
> > > >  			Any state transition.
> > > > =20
> > > > +What:		/sys/bus/counter/devices/counterX/events_queue_size
> > > > +KernelVersion:	5.13
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Size of the Counter events queue in number of struct
> > > > +		counter_event data structures. The number of elements will be
> > > > +		rounded-up to a power of 2.
> > > > +
> > > >  What:		/sys/bus/counter/devices/counterX/name
> > > >  KernelVersion:	5.2
> > > >  Contact:	linux-iio@vger.kernel.org
> > > > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/cou=
nter-chrdev.c
> > > > index 16f02df7f73d..53eea894e13f 100644
> > > > --- a/drivers/counter/counter-chrdev.c
> > > > +++ b/drivers/counter/counter-chrdev.c
> > > > @@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_devi=
ce *const counter)
> > > >  	cdev_del(&counter->chrdev);
> > > >  }
> > > > =20
> > > > +int counter_chrdev_realloc_queue(struct counter_device *const coun=
ter,
> > > > +				 size_t queue_size)
> > > > +{
> > > > +	int err;
> > > > +	DECLARE_KFIFO_PTR(events, struct counter_event);
> > > > +	unsigned long flags;
> > > > +
> > > > +	/* Allocate new events queue */
> > > > +	err =3D kfifo_alloc(&events, queue_size, GFP_ATOMIC); =20
> > >=20
> > > Is there any potential for losing events? =20
> >=20
> > We take the events_list_lock down below so we're safe against missing an
> > event, but past events currently unread in the queue will be lost.
> >=20
> > Shortening the size of the queue is inherently a destructive process if
> > we have more events in the current queue than can fit in the new queue.
> > Because we a liable to lose some events in such a case, I think it's
> > best to keep the behavior of this reallocation consistent and have it
> > provide a fresh empty queue every time, as opposed to sometimes dropping
> > events and sometimes not.
> >=20
> > I also suspect an actual user would be setting the size of their queue
> > to the required amount before they begin watching events, rather than
> > adjusting it sporadically during a live operation.
> >
>=20
> Absolutely agree.   As such I wonder if you are better off enforcing this
> behaviour?  If the cdev is open for reading, don't allow the fifo to be
> resized.=20
>=20
> Jonathan

I can't really think of a good reason not to, so let's enforce it: if
the cdev is open, then we'll return an EINVAL if the user attempts to
resize the queue.

What is a good way to check for this condition? Should I just call
kref_read() and see if it's greater than 1? For example, in
counter_chrdev_realloc_queue():

	if (kref_read(&counter->dev.kobj.kref) > 1)
		return -EINVAL;

William Breathitt Gray

--76Dn/TuCDFUTSoIf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA4OswACgkQhvpINdm7
VJI4LBAApcdc9OT2tNICqKgjdL9fnN1UvMR4Mymto4r9OKzes/KKt7jFjbmqsaPU
IpFVtpG2apdrK7LcCnvxnSAxCwOIkM1r0TOUQjiiWKggpibCOJCXcI1UWu6FTxtX
3FcYUZZMmjFWvijm0LG3I/7UEo+wf3BcatoYSEERpok3IiPhzag+bG1WQhoirpbK
3UdOHyRkYN8kyU4pfFK+T6A2pHO09fFmSJJB2oQ9d90avrJikMkBGQp6/qpIvhPM
gMxbYwDxuSG7zCqkIU/GW22VvwhehfGQaoc5u/WlCks271YWPNcMyq94479EM7q7
SP5STZczS/Jxc5Wq5HHuFsCQaSGTJ6uFIqjey88gjlkyvJ+Vzznj6OfBBRFFPPPe
KL8UUXk7E9AM17u+Zoj8xV3NnBKixWTKcUnazPsM7QZSPH3fvLmdUbODFhU20gkf
yYLSMZgxvkZSe3jHwaQn92MRCMPgqK2vDUIGVnvAYi+nmPQ/ly4VHwcpRi0iS2Pd
p95tFoo2gD8vCwoUm4qm/h+n3WYbQZ44D53fUSAR4yQfdntmCueSFKQ1Cty/03uL
BVDbwQs+GfKzPttZoChC2I4oNAyjnqrS861Q0Uz5Go1aqFE5GvfJluSrmsIYNf0u
XiuOzzN/i9NOBe4GaeCeaaVQAznfbfat6Ym4nuXMOu4sV5twIJg=
=vTG+
-----END PGP SIGNATURE-----

--76Dn/TuCDFUTSoIf--
