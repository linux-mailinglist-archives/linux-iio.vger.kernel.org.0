Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7565A3213E5
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 11:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhBVKNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Feb 2021 05:13:32 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56712 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhBVKMS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Feb 2021 05:12:18 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8B3741C0B7F; Mon, 22 Feb 2021 11:11:34 +0100 (CET)
Date:   Mon, 22 Feb 2021 11:11:33 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 18/22] docs: counter: Document character device
 interface
Message-ID: <20210222101133.GB14587@amd>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <350cafba81d3220b64efdb019bd76c08eb1e5d10.1613131238.git.vilhelm.gray@gmail.com>
 <20210214174819.6757e2b0@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20210214174819.6757e2b0@archlinux>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +* COUNTER_ENABLE_EVENTS_IOCTL:
> > +  Enables monitoring the events specified by the Counter watches that
> > +  were queued by ``COUNTER_ADD_WATCH_IOCTL``. If events are already
> > +  enabled, the new set of watches replaces the old one. Calling this
> > +  ioctl also has the effect of clearing the queue of watches added by
> > +  ``COUNTER_ADD_WATCH_IOCTL``.
> > +
> > +* COUNTER_DISABLE_EVENTS_IOCTL:
> > +  Stops monitoring the previously enabled events.
>=20
> Is there a way to remove a watch?=20

Is there a way to eat all kernel memory and crash the system by adding
too many watches?

> > +For example, the following userspace code opens ``/dev/counter0``,
> > +configures the ``COUNTER_EVENT_INDEX`` event channel 0 to gather Count=
 0
> > +and Count 1, and prints out the data as it becomes available on the
> > +character device node::
> > +
>=20
> Consider adding an example program under tools/
>=20
> > +        #include <fcntl.h>
> > +        #include <linux/counter.h>
> > +        #include <stdio.h>
> > +        #include <string.h>
> > +        #include <sys/ioctl.h>
> > +        #include <unistd.h>
> > +
> > +        struct counter_watch watches[2] =3D {
> > +                {
> > +                        .component.type =3D COUNTER_COMPONENT_COUNT,
> > +                        .component.scope =3D COUNTER_SCOPE_COUNT,
> > +                        .component.parent =3D 0,
>=20
> Good to add comments on what these elements actually are?

> > +                fd =3D open("/dev/counter0", O_RDWR);
> > +
> > +                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> > +                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
> > +                ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);

> > +                for (;;) {
> > +                        read(fd, event_data, sizeof(event_data));

If this goes to tools it really should have error handling and
handling of short read.

Best regards,
							Pavel

--=20
http://www.livejournal.com/~pavelmachek

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAzg1UACgkQMOfwapXb+vJsaACffCOe28RqjxELfyTkP8K3Wy+h
SeYAn26EGcT9n9wUACiesQqsPDqCDl31
=ku3H
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
