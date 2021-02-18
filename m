Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734C331E95C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBRLyo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 06:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhBRKdG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 05:33:06 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365C1C061786;
        Thu, 18 Feb 2021 02:32:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z32so980856qtd.8;
        Thu, 18 Feb 2021 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QBpF/UnYAHGf5ye3tF7er160fB31uR/wphWC4wYVvOY=;
        b=hdp5dGdccPpZBRsGUZfrcOO1t19DF1z6ve2rfVbio4eLyNcgMasMEDVu1LWtiXlMHU
         VM/WGerj+KIm+dyw2tbDSldipRhpx4ZHmCIR82MXX57YshOieVIWl6Y2v1+e3TJXu/5H
         E6SmMEVSpeVRPKGL/tUxgJzuSsM/XmQDDu1ntbEPNNJwTVu62ngo8pBMP/M+Tb19PO0c
         BJuM9Ev2dclumrqD7SFsm8f8s22/4M1/sH3zT/Zd1UJRPVlBQHRW+f9Y2E4rcruLdqDR
         rptDH3qeEniByvKgWDgrh442PAu5CmA+yMHL2qAK5ujh+CjH7hVUWH7aBc89sCgpAWPa
         HJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QBpF/UnYAHGf5ye3tF7er160fB31uR/wphWC4wYVvOY=;
        b=emf1OCTIyvVNBPfy8+Zout+qP6IG5HxJSBpCyhXRsHYz9KYwkyyh9V96RKZ381ngi7
         rdDNDCZmbVK6x3gBiberEqEewKKh+7OlauxXdLuFMyQWnUcib2CF3PiooEnL84nui9np
         q+5dkNpVy8RWNnujhg17Vq6yV5URbwnhH4eo7EN7P9sM5splxYx3/pygj7rLD7vVw9bJ
         Ytofix7oVOWYVE1XmbZiLXZPz4SJ3iXF6O4ep70MyCx1gYzONlFW91G3Gsem6JWHy8G5
         qK7I0c6KE6WvD07qVhIVFEMlJNaU+YIl/mC1ztKNTJf20c3/39NiHqwhzcCh9xKZqQ0B
         cUgQ==
X-Gm-Message-State: AOAM532DU5xhCdrvA9rhq1OQbBDMSZHf4N9MqzrJ3RU7ksnBkDC7FFL8
        gYHD4o4xKr7xwYfQwFqspxg=
X-Google-Smtp-Source: ABdhPJxpeJvOxn5+wkohLMk++QGjYXEV+m6sdsuoygdRkAHpXCY4e6XA3/Ti9BNHd5lPJ3ItEYOTOg==
X-Received: by 2002:aed:38e3:: with SMTP id k90mr3438649qte.119.1613644345405;
        Thu, 18 Feb 2021 02:32:25 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id g20sm3090235qtq.35.2021.02.18.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:32:24 -0800 (PST)
Date:   Thu, 18 Feb 2021 19:32:16 +0900
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
Message-ID: <YC5CMLuKnXbkZond@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
 <20210214181146.66d43da7@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9db4GuH0vsB+CvNJ"
Content-Disposition: inline
In-Reply-To: <20210214181146.66d43da7@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9db4GuH0vsB+CvNJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2021 at 06:11:46PM +0000, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:44 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > The events_queue_size sysfs attribute provides a way for users to
> > dynamically configure the Counter events queue size for the Counter
> > character device interface. The size is in number of struct
> > counter_event data structures. The number of elements will be rounded-up
> > to a power of 2 due to a requirement of the kfifo_alloc function called
> > during reallocation of the queue.
> >=20
> > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
> >  drivers/counter/counter-chrdev.c            | 23 +++++++++++++++++++
> >  drivers/counter/counter-chrdev.h            |  2 ++
> >  drivers/counter/counter-sysfs.c             | 25 +++++++++++++++++++++
> >  4 files changed, 58 insertions(+)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentatio=
n/ABI/testing/sysfs-bus-counter
> > index 847e96f19d19..f6cb2a8b08a7 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -212,6 +212,14 @@ Description:
> >  		both edges:
> >  			Any state transition.
> > =20
> > +What:		/sys/bus/counter/devices/counterX/events_queue_size
> > +KernelVersion:	5.13
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Size of the Counter events queue in number of struct
> > +		counter_event data structures. The number of elements will be
> > +		rounded-up to a power of 2.
> > +
> >  What:		/sys/bus/counter/devices/counterX/name
> >  KernelVersion:	5.2
> >  Contact:	linux-iio@vger.kernel.org
> > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter=
-chrdev.c
> > index 16f02df7f73d..53eea894e13f 100644
> > --- a/drivers/counter/counter-chrdev.c
> > +++ b/drivers/counter/counter-chrdev.c
> > @@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_device *=
const counter)
> >  	cdev_del(&counter->chrdev);
> >  }
> > =20
> > +int counter_chrdev_realloc_queue(struct counter_device *const counter,
> > +				 size_t queue_size)
> > +{
> > +	int err;
> > +	DECLARE_KFIFO_PTR(events, struct counter_event);
> > +	unsigned long flags;
> > +
> > +	/* Allocate new events queue */
> > +	err =3D kfifo_alloc(&events, queue_size, GFP_ATOMIC);
>=20
> Is there any potential for losing events?

We take the events_list_lock down below so we're safe against missing an
event, but past events currently unread in the queue will be lost.

Shortening the size of the queue is inherently a destructive process if
we have more events in the current queue than can fit in the new queue.
Because we a liable to lose some events in such a case, I think it's
best to keep the behavior of this reallocation consistent and have it
provide a fresh empty queue every time, as opposed to sometimes dropping
events and sometimes not.

I also suspect an actual user would be setting the size of their queue
to the required amount before they begin watching events, rather than
adjusting it sporadically during a live operation.

> > +	if (err)
> > +		return err;
> > +
> > +	raw_spin_lock_irqsave(&counter->events_list_lock, flags);
> > +
> > +	/* Swap in new events queue */
> > +	kfifo_free(&counter->events);
> > +	counter->events.kfifo =3D events.kfifo;
> > +
> > +	raw_spin_unlock_irqrestore(&counter->events_list_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> >  static int counter_get_data(struct counter_device *const counter,
> >  			    const struct counter_comp_node *const comp_node,
> >  			    u64 *const value)
> > diff --git a/drivers/counter/counter-chrdev.h b/drivers/counter/counter=
-chrdev.h
> > index cf5a318fe540..ff7fb0191852 100644
> > --- a/drivers/counter/counter-chrdev.h
> > +++ b/drivers/counter/counter-chrdev.h
> > @@ -12,5 +12,7 @@
> >  int counter_chrdev_add(struct counter_device *const counter,
> >  		       const dev_t counter_devt);
> >  void counter_chrdev_remove(struct counter_device *const counter);
> > +int counter_chrdev_realloc_queue(struct counter_device *const counter,
> > +				 size_t queue_size);
> > =20
> >  #endif /* _COUNTER_CHRDEV_H_ */
> > diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-=
sysfs.c
> > index 0cb3dba950bc..9abc821a3871 100644
> > --- a/drivers/counter/counter-sysfs.c
> > +++ b/drivers/counter/counter-sysfs.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/types.h>
> > =20
> > +#include "counter-chrdev.h"
> >  #include "counter-sysfs.h"
> > =20
> >  /**
> > @@ -737,12 +738,30 @@ static int counter_num_counts_read(struct counter=
_device *counter, u8 *val)
> >  	return 0;
> >  }
> > =20
> > +static int counter_events_queue_size_read(struct counter_device *count=
er,
> > +					  u64 *val)
> > +{
> > +	*val =3D counter->events.kfifo.mask + 1;
>=20
> kfifo_size() rather than open coding it?

Ack.

William Breathitt Gray

> > +	return 0;
> > +}
> > +
> > +static int counter_events_queue_size_write(struct counter_device *coun=
ter,
> > +					   u64 val)
> > +{
> > +	return counter_chrdev_realloc_queue(counter, val);
> > +}
> > +
> >  static struct counter_comp counter_num_signals_comp =3D
> >  	COUNTER_COMP_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
> > =20
> >  static struct counter_comp counter_num_counts_comp =3D
> >  	COUNTER_COMP_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
> > =20
> > +static struct counter_comp counter_events_queue_size_comp =3D
> > +	COUNTER_COMP_DEVICE_U64("events_queue_size",
> > +				counter_events_queue_size_read,
> > +				counter_events_queue_size_write);
> > +
> >  static int counter_sysfs_attr_add(struct counter_device *const counter,
> >  				  struct counter_attribute_group *group)
> >  {
> > @@ -781,6 +800,12 @@ static int counter_sysfs_attr_add(struct counter_d=
evice *const counter,
> >  	if (err < 0)
> >  		return err;
> > =20
> > +	/* Create num_counts attribute */
> > +	err =3D counter_attr_create(dev, group, &counter_events_queue_size_co=
mp,
> > +				  scope, NULL);
> > +	if (err < 0)
> > +		return err;
> > +
> >  	/* Create an attribute for each extension */
> >  	for (i =3D 0; i < counter->num_ext; i++) {
> >  		ext =3D counter->ext + i;
>=20

--9db4GuH0vsB+CvNJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAuQjAACgkQhvpINdm7
VJLb4w//XoS0cfe5nK5uwMVsnyoHPugIaFvxzK5Bm+98z+78pkVC3MPScsWvip1T
thzsY6SVy1LnrYkIihPnyFMzs+xwg6B2uyViHdXBjlQyKbEyTBsMUpHJbCsqlJDU
I91rt3gP3SKYhg5e+bN0y2jFgXohy/3glP8vMoeWaUh7aJXsjnNUWNdvb4zJzn7A
RlnfRvL8q0E7cU/gZ7ra0GgdTyTTTIYzdIGPyf/W9BdJxdZsr8fUStaXDWD+vutF
7TgNBJ0dLnBJotIFe9CUegCn232vmpls68SCM2eRWoo9UOJIa+IzislxvQoVOj+w
gJOd1VKwmVphRc6j9myvqe8NlVeFt5bnkQdvw9Vle9qjerlUxkE5ObXH95H178uA
a6QrI5REZnRU5ggfQCF9kGqy49O0ealT/+fIvrkawdd8x7Km4/Ua5h1vxzZroW2x
J0P8j2+SQC0+ZiVryWAl8BL2ochZBaNdCulYAF+X5Na/ynw+WCZ8ds/dwAoY9M27
DJYvS2odf1RzZ7iOTA5l5QmFOx7r//n4eh9ViYYobB71rGDE0BYPFu+IhDod30wr
TopXRBcepDLGgCRaYcmrjmXUCqIKqBqX8tC7dJqMSAQiI59bTwqQtYeb9Z54g5GL
XeDYmgpZBmAp5qGgt0BMnglb/qemGvYEzqwXeOwkIe9iZoYTnW8=
=ARu2
-----END PGP SIGNATURE-----

--9db4GuH0vsB+CvNJ--
