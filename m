Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93753236E9
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 06:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhBXFew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 00:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhBXFeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2021 00:34:50 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC58C061574;
        Tue, 23 Feb 2021 21:34:10 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o38so732885pgm.9;
        Tue, 23 Feb 2021 21:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pj/gRe7DjMAiHHqo7PKgieIIARyk/XtT4ao2chhVlV4=;
        b=adL5LWdoCRHwOwWFfK2dH7fCyY2kQvh9gQRSmfUORfCnRh1tWktztEt0SxlIqo5ksW
         OrXbr8GATZ3yf+Ssbn2PzDVPClKfGqP1luLWvRIPdgtnnfjqxJVyNUzu9zEYjnlrtyQe
         CRTXPsac8U4VnVfP4zrTWGDrFHZ+r68WmASfLdOXVE7G9EP6XLX5cpiEN1acanxhFMWQ
         /0mmgazmGF+x1+ytiRVXPNCuAQ8Zfo2WQ81BNw0NYoX3QRhcN3jnz7B5rwR1NCpMDU3+
         rlg7vvLPqBRokg0H0sF+DfawRfBAMur8yOEVyFp3yZOilXvqNAeSikHyk0Af8lNwqv7F
         Xhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pj/gRe7DjMAiHHqo7PKgieIIARyk/XtT4ao2chhVlV4=;
        b=gGXp20yRcYrpJ86iYbxP/FS3+rMujKPy++yaxkGbWm2UFpYwrYYdif3V6rEM6lU2Fk
         UHD9W665DrxlLRkNkZ5KAacL9gMUBI/erAXlXnC0WQfjp62i/cZTKLetWyC9GpIi5WPh
         s8zbc9DWiOCQcpAzZ+Mad0e9IuOVyBav/5OfsJRxjVXHULrL4K6suif5iDU9gek4iXvS
         zpDHwCZ81iCxMDEGU8J9N3R2VinCy9MV8nN/EkLheh4fIkIG5SKFCPQUpL2dQHFZa3S3
         CoHKkfDMfsgcDiOiU1f7GWuYXyC0BteagBNfdBKDfGGJwjE4isdnwqHetUcUje88TpMg
         6xDw==
X-Gm-Message-State: AOAM533kaib4OiPaeIv96NT54uCMbREgRSv1/X5tCR630bA8/ZFetz22
        oLMwKzEmXrt9jdF6NKLufFs=
X-Google-Smtp-Source: ABdhPJzHrQ+FheaWWND3bTe6ZSUITLRg4gVCKAQu1q8Fzw/cH1RsC8Xv0+g5c2kAkCOaZMkMD30JMg==
X-Received: by 2002:a05:6a00:16c7:b029:1bc:6eb9:ee47 with SMTP id l7-20020a056a0016c7b02901bc6eb9ee47mr30958904pfc.0.1614144849581;
        Tue, 23 Feb 2021 21:34:09 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id a9sm912855pjq.17.2021.02.23.21.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 21:34:08 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:34:02 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 17/22] counter: Add character device interface
Message-ID: <YDXlSoNCA3lMieru@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <720278e3aaf3f249657ec18d158eca3f962baf8e.1613131238.git.vilhelm.gray@gmail.com>
 <20210214180612.03af6f0d@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OqkcL2+1hoG/vkFg"
Content-Disposition: inline
In-Reply-To: <20210214180612.03af6f0d@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--OqkcL2+1hoG/vkFg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2021 at 06:06:12PM +0000, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:41 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > This patch introduces a character device interface for the Counter
> > subsystem. Device data is exposed through standard character device read
> > operations. Device data is gathered when a Counter event is pushed by
> > the respective Counter device driver. Configuration is handled via ioctl
> > operations on the respective Counter character device node.
> >=20
> > Cc: David Lechner <david@lechnology.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> Hi William,
>=20
> A few minor comments.  Mostly seems to have come together well and
> makes sense to me.
>=20
> Jonathan
>=20
> > ---
> >  drivers/counter/Makefile         |   2 +-
> >  drivers/counter/counter-chrdev.c | 496 +++++++++++++++++++++++++++++++
> >  drivers/counter/counter-chrdev.h |  16 +
> >  drivers/counter/counter-core.c   |  37 ++-
> >  include/linux/counter.h          |  45 +++
> >  include/uapi/linux/counter.h     |  70 +++++
> >  6 files changed, 661 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/counter/counter-chrdev.c
> >  create mode 100644 drivers/counter/counter-chrdev.h
> >=20
>=20
> ...
>=20
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > index bcf672e1fc0d..c137fcb97d9c 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -5,12 +5,16 @@
> >   */
> >  #include <linux/counter.h>
> >  #include <linux/device.h>
> > +#include <linux/device/bus.h>
> >  #include <linux/export.h>
> > +#include <linux/fs.h>
> >  #include <linux/gfp.h>
> >  #include <linux/idr.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > +#include <linux/types.h>
> > =20
> > +#include "counter-chrdev.h"
> >  #include "counter-sysfs.h"
> > =20
> >  /* Provides a unique ID for each counter device */
> > @@ -33,6 +37,8 @@ static struct bus_type counter_bus_type =3D {
> >  	.name =3D "counter"
> >  };
> > =20
> > +static dev_t counter_devt;
> > +
> >  /**
> >   * counter_register - register Counter to the system
> >   * @counter:	pointer to Counter to register
> > @@ -54,7 +60,6 @@ int counter_register(struct counter_device *const cou=
nter)
> >  	if (counter->id < 0)
> >  		return counter->id;
> > =20
> > -	/* Configure device structure for Counter */
>=20
> Not sure why this comment gets removed here.

This comment wasn't suppose to be removed. I'll revert this.

> >  	dev->type =3D &counter_device_type;
> >  	dev->bus =3D &counter_bus_type;
> >  	if (counter->parent) {
> > @@ -65,18 +70,25 @@ int counter_register(struct counter_device *const c=
ounter)
> >  	device_initialize(dev);
> >  	dev_set_drvdata(dev, counter);
> > =20
> > +	/* Add Counter character device */
> > +	err =3D counter_chrdev_add(counter, counter_devt);
> > +	if (err < 0)
> > +		goto err_free_id;
> > +
> >  	/* Add Counter sysfs attributes */
> >  	err =3D counter_sysfs_add(counter);
> >  	if (err < 0)
> > -		goto err_free_id;
> > +		goto err_remove_chrdev;
> > =20
> >  	/* Add device to system */
> >  	err =3D device_add(dev);
> >  	if (err < 0)
> > -		goto err_free_id;
> > +		goto err_remove_chrdev;
>=20
> It might be worth thinking about using cdev_device_add()
> though will require a slightly different order of adding.

I think using cdev_device_add() should be possible. I'll adjust
counter_chrdev_add() accordingly to account for this.
=20
> > =20
> >  	return 0;
> > =20
> > +err_remove_chrdev:
> > +	counter_chrdev_remove(counter);
> >  err_free_id:
> >  	put_device(dev);
> >  	return err;
> > @@ -138,13 +150,30 @@ int devm_counter_register(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_counter_register);
> > =20
> > +#define COUNTER_DEV_MAX 256
> > +
> >  static int __init counter_init(void)
> >  {
> > -	return bus_register(&counter_bus_type);
> > +	int err;
> > +
> > +	err =3D bus_register(&counter_bus_type);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX, "count=
er");
> > +	if (err < 0)
> > +		goto err_unregister_bus;
> > +
> > +	return 0;
> > +
> > +err_unregister_bus:
> > +	bus_unregister(&counter_bus_type);
> > +	return err;
> >  }
> > =20
> >  static void __exit counter_exit(void)
> >  {
> > +	unregister_chrdev_region(counter_devt, COUNTER_DEV_MAX);
> >  	bus_unregister(&counter_bus_type);
> >  }
> > =20
>=20
> ...
>=20
> > diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> > index 6113938a6044..3d647a5383b8 100644
> > --- a/include/uapi/linux/counter.h
> > +++ b/include/uapi/linux/counter.h
> > @@ -6,6 +6,19 @@
> >  #ifndef _UAPI_COUNTER_H_
> >  #define _UAPI_COUNTER_H_
> > =20
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +/* Component type definitions */
> > +enum counter_component_type {
> > +	COUNTER_COMPONENT_NONE,
> > +	COUNTER_COMPONENT_SIGNAL,
> > +	COUNTER_COMPONENT_COUNT,
> > +	COUNTER_COMPONENT_FUNCTION,
> > +	COUNTER_COMPONENT_SYNAPSE_ACTION,
> > +	COUNTER_COMPONENT_EXTENSION,
> > +};
> > +
> >  /* Component scope definitions */
> >  enum counter_scope {
> >  	COUNTER_SCOPE_DEVICE,
> > @@ -13,6 +26,63 @@ enum counter_scope {
> >  	COUNTER_SCOPE_COUNT,
> >  };
> > =20
> > +/**
> > + * struct counter_component - Counter component identification
> > + * @type: component type (one of enum counter_component_type)
> > + * @scope: component scope (one of enum counter_scope)
> > + * @parent: parent component ID (matching the Y/Z suffix of the respec=
tive sysfs
> > + *	    path as described in Documentation/ABI/testing/sysfs-bus-counte=
r)
>=20
> Probably good to give an example here as well as the cross reference.

Ack.

William Breathitt Gray

--OqkcL2+1hoG/vkFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA15UoACgkQhvpINdm7
VJKF9BAAhN/ttlp4nisjDvTa8Xbitarr8qwdHsQVA4DPvGgGWL3fCzBPB9OwBsA7
TEnR9XtWKsjsnzXoiERkihwZ9kVAjJMjvuoXp6D975A+6iOE1NfMr9iILt2aCsQ/
y4i/92+TOJ3LB9oVTVkEUHrcpNjLqFfg0G4Aua8ywlvSWe5oLad1hy9iMuHfL4oZ
cAV54mT9r4UCI6zosdrPEAYc79abGB3i8vXWOw0gpZJCROx+OZY1f8ya1kSOXxO9
4/SbVjAVQeS30Hztyeq/q1/+nRnazMJqJHLpfv48xltMsWRjxcedU7rXTry4E1Zb
TOfcW6pm2myoGq37rSYE7lFb+Ye4IhXRElmvbKC22CRa0kRiMDKpRSivIEJwC9EX
u5nMRtzZgCcDwjy+VUwBxKh77xr30amFzwGuON0x4I1tznac4ZdgX5CJAbVHJuP+
XCTim4hsbJOfhg567d8sApCgiHM2yisS+Kr+4jIYbG5X7VA9PiiROSZoUHBk8qSk
Nly08M1PAjzjC+3yikqlUgevqXmrKyPGGAWpKIQRLbpBmrAVC6kqsojgdq9XB3Mh
FcErcr5Mm2zZ/AinPKBZ/f/EMsIoE2pWfIVGC9dsZsjrlMc1/DDOp0iQ/mYxaILO
NCrbN5oERZVwyORAZSe1P7zksp4HKBso/h1x9vENOwmzdS3Cs+8=
=AoYC
-----END PGP SIGNATURE-----

--OqkcL2+1hoG/vkFg--
