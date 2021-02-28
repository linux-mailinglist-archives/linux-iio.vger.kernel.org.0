Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1598327019
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 03:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhB1Crh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 21:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhB1Crg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Feb 2021 21:47:36 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D05C06174A;
        Sat, 27 Feb 2021 18:46:55 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id n3so2824632vkq.0;
        Sat, 27 Feb 2021 18:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31l/lnqbUifU6Dg4hvfS5WIgYBTmn85Mx5y8Nkr10UM=;
        b=f5v1uk3hj7oZW8O45g+xIRysJgAMj0gl2X4RgUy8FektFeAk1hKTFBTHrG3VssSyAd
         bbjNRdQ636Ur0mRBcNvbck2R4jHqpYNRME0R8OM5ctV9G1Z0nPk6b4uBPVOjxyWzmATn
         6bOcBWJ9uc0Q2mMbiV51hXtIOOuwZ9Nv/FUuT7FBIb14B4JCWEqbMxv3G/pboSJEKblz
         FBQZhhfAjalp9UP7p56/ekb/avq392t/rwHhGK4A6fjtDqSgcv2IgUSF0Ke7chY1IZR9
         6bsXzusTX34n6Y7nc5VBJdxOa5HO4LWDuzJgvEvMIqbNEuOQUpdE90dxEMaflnWSt44W
         8nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31l/lnqbUifU6Dg4hvfS5WIgYBTmn85Mx5y8Nkr10UM=;
        b=H7vf3ScdVp/qwmhX6wpFNRdBys8sAV1JoZSs3m+itmaZPqD25PNY9k0WFwgaELc+O6
         7raUfD1bIJF/6UPZoId0b0YZCT6JCsC8u4lyg+ar5IwEN3L71La6nFDgACCNlPCkYnUQ
         3oSkxu+WRzG6YpDW5v+ZQFNbh41hdLdtN6eK9WbHE2JxGavBuwYTqUtAg5d8wm/HmLUv
         bpKhO1vqWBS5l168sEANo0F1nY6rw6yYnOQiqqeJYWF0qfqTRoqNuvPpMujKbKu1x+TT
         52n350jAGgJ/YUS3JD53ktww2dT/ehLyJrrAw5ICZrZKUTMAmEsLqKcz8TxAdJ1FHfW4
         trkw==
X-Gm-Message-State: AOAM530b5fA76Z/Byouye/88QFWY2Y8G7djm32tRoesZRdybnXo06b5x
        c7qjhSBPu/6LZYw1YKsE/Ns=
X-Google-Smtp-Source: ABdhPJzTplQlXWLb9EDdWScETcVIfG6slwgp9MPTrNb7ePipfKjNKIPBG/ON7KHVKxBRznPLbFalMw==
X-Received: by 2002:a05:6122:1058:: with SMTP id z24mr5372446vkn.5.1614480414838;
        Sat, 27 Feb 2021 18:46:54 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id x206sm291346vsx.5.2021.02.27.18.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 18:46:53 -0800 (PST)
Date:   Sun, 28 Feb 2021 11:46:46 +0900
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
Message-ID: <YDsEFgXvSAzBGoAw@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
 <20210214181146.66d43da7@archlinux>
 <YC5CMLuKnXbkZond@shinobu>
 <20210221155140.3e1ef13c@archlinux>
 <YDg65OmLa05g53qc@shinobu>
 <20210227151847.074864df@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6d8kyOSDhuZ1wuv9"
Content-Disposition: inline
In-Reply-To: <20210227151847.074864df@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--6d8kyOSDhuZ1wuv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 27, 2021 at 03:18:47PM +0000, Jonathan Cameron wrote:
> On Fri, 26 Feb 2021 09:03:48 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Sun, Feb 21, 2021 at 03:51:40PM +0000, Jonathan Cameron wrote:
> > > On Thu, 18 Feb 2021 19:32:16 +0900
> > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >  =20
> > > > On Sun, Feb 14, 2021 at 06:11:46PM +0000, Jonathan Cameron wrote: =
=20
> > > > > On Fri, 12 Feb 2021 21:13:44 +0900
> > > > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > > > >    =20
> > > > > > The events_queue_size sysfs attribute provides a way for users =
to
> > > > > > dynamically configure the Counter events queue size for the Cou=
nter
> > > > > > character device interface. The size is in number of struct
> > > > > > counter_event data structures. The number of elements will be r=
ounded-up
> > > > > > to a power of 2 due to a requirement of the kfifo_alloc functio=
n called
> > > > > > during reallocation of the queue.
> > > > > >=20
> > > > > > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > > > > ---
> > > > > >  Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
> > > > > >  drivers/counter/counter-chrdev.c            | 23 +++++++++++++=
++++++
> > > > > >  drivers/counter/counter-chrdev.h            |  2 ++
> > > > > >  drivers/counter/counter-sysfs.c             | 25 +++++++++++++=
++++++++
> > > > > >  4 files changed, 58 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Docu=
mentation/ABI/testing/sysfs-bus-counter
> > > > > > index 847e96f19d19..f6cb2a8b08a7 100644
> > > > > > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > > > > > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > > > > > @@ -212,6 +212,14 @@ Description:
> > > > > >  		both edges:
> > > > > >  			Any state transition.
> > > > > > =20
> > > > > > +What:		/sys/bus/counter/devices/counterX/events_queue_size
> > > > > > +KernelVersion:	5.13
> > > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > > +Description:
> > > > > > +		Size of the Counter events queue in number of struct
> > > > > > +		counter_event data structures. The number of elements will be
> > > > > > +		rounded-up to a power of 2.
> > > > > > +
> > > > > >  What:		/sys/bus/counter/devices/counterX/name
> > > > > >  KernelVersion:	5.2
> > > > > >  Contact:	linux-iio@vger.kernel.org
> > > > > > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter=
/counter-chrdev.c
> > > > > > index 16f02df7f73d..53eea894e13f 100644
> > > > > > --- a/drivers/counter/counter-chrdev.c
> > > > > > +++ b/drivers/counter/counter-chrdev.c
> > > > > > @@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_=
device *const counter)
> > > > > >  	cdev_del(&counter->chrdev);
> > > > > >  }
> > > > > > =20
> > > > > > +int counter_chrdev_realloc_queue(struct counter_device *const =
counter,
> > > > > > +				 size_t queue_size)
> > > > > > +{
> > > > > > +	int err;
> > > > > > +	DECLARE_KFIFO_PTR(events, struct counter_event);
> > > > > > +	unsigned long flags;
> > > > > > +
> > > > > > +	/* Allocate new events queue */
> > > > > > +	err =3D kfifo_alloc(&events, queue_size, GFP_ATOMIC);   =20
> > > > >=20
> > > > > Is there any potential for losing events?   =20
> > > >=20
> > > > We take the events_list_lock down below so we're safe against missi=
ng an
> > > > event, but past events currently unread in the queue will be lost.
> > > >=20
> > > > Shortening the size of the queue is inherently a destructive proces=
s if
> > > > we have more events in the current queue than can fit in the new qu=
eue.
> > > > Because we a liable to lose some events in such a case, I think it's
> > > > best to keep the behavior of this reallocation consistent and have =
it
> > > > provide a fresh empty queue every time, as opposed to sometimes dro=
pping
> > > > events and sometimes not.
> > > >=20
> > > > I also suspect an actual user would be setting the size of their qu=
eue
> > > > to the required amount before they begin watching events, rather th=
an
> > > > adjusting it sporadically during a live operation.
> > > > =20
> > >=20
> > > Absolutely agree.   As such I wonder if you are better off enforcing =
this
> > > behaviour?  If the cdev is open for reading, don't allow the fifo to =
be
> > > resized.=20
> > >=20
> > > Jonathan =20
> >=20
> > I can't really think of a good reason not to, so let's enforce it: if
> > the cdev is open, then we'll return an EINVAL if the user attempts to
> > resize the queue.
> >=20
> > What is a good way to check for this condition? Should I just call
> > kref_read() and see if it's greater than 1? For example, in
> > counter_chrdev_realloc_queue():
> >=20
> > 	if (kref_read(&counter->dev.kobj.kref) > 1)
> > 		return -EINVAL;
> In theory at least you might want the kobj.kref to be incremented
> for other reasons than just open.   So to keep different concepts
> separate, perhaps it's worth a separate variable somewhere to
> track whether the file is open currently.
>=20
> However, it's reasonable (I think) to assume the kref will have a
> minimum value if open, so perhaps what you suggest works fine.
>=20
> Jonathan

I noticed an open() operation could occur right after this check, so
we'll need a mutex here to ensure the the queue size is not modified
during use. Because of that, I'll create a separate variable to track
this and use a mutex_trylock() instead of the kref to test whether to
return -EBUSY.

William Breathitt Gray

--6d8kyOSDhuZ1wuv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA7BBYACgkQhvpINdm7
VJIZaBAAtfzHPcYQo2dhRO+1Fhe8SpWJXu3Ff1Da5SBMeZhLArBBsVz/N/pm9ByZ
NrVUyy4UfzzzixdyAM4RXvQtF8PfLzgEukF/CiukANKjcUQT8Lj5/JUocQj2vwj9
BPgy+osNwzHmUZ096kLIpNRs+9kwCiKU6nS4TF0YMlEYReCxF//APNpr5J6K7EZM
3kWGaIBAyxmngcDiWBK8nG980r9x90w9mLv7OEYJkfDO8HlWMNFSEYOvBJAoJ6Fu
RU/XZCpAMpVVSAJD0TnfgrkfvRY9EwwPaSUGQjHWA0zTYxH8lQxyDQe0Mv/rKT+Y
9kkeXsLungqUH0/v2MoewD8IwIstpEcBiaUW0GwS2R4V7hD3rttMKXIRWJwvNbgw
YXcOWAeT8Oz7yonA8RDRtnJ7BT8UGjw2KXpkOgsoiUt51dee2F03TXnGQ3mhY6jr
kQcXEYNifkG9T4T7WVsXfRP188QgppZKfju7yCm29fWFaKK1u07thMbvF4CcKxnL
ko8hVP+po79eI+h4f33AaamnBIw/2FAaj1wgVK1X6qw/DE9ptgIYFpbFpF/1sY4e
YJJcwx1F6P6+yeB6ejkGqJn9UkPBCTqb/Xjew7EDXRZNsaNfONs8/j5z4q/jDqP1
ZyOGx32DXLNSA0JNeTiIpWmKB+7xs43giJENcJbAUzfE0/5zBA0=
=NNgg
-----END PGP SIGNATURE-----

--6d8kyOSDhuZ1wuv9--
