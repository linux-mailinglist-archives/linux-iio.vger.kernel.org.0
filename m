Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B629D325AED
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 01:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhBZA2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 19:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZA2I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 19:28:08 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF66C061574;
        Thu, 25 Feb 2021 16:27:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so4782703pjs.4;
        Thu, 25 Feb 2021 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s+E1myvL+FQNMLBHh7YhNNO6xrcap4dEx+GlOPcwYn0=;
        b=eqbKJ6bIiWeOJUgULqrl1KIIkrtbyYy+Q6N60mi+a7TonVXtuRDW47W+klAkHew56a
         2W5OMyFOTJmXsVT5ETL7ck42vyFPTugKtM9M5pxmfAloxRQo4kqtZE+7Ig9bAlilN6N+
         Xj48m0+LYl6kOx+D7P5/MUB7wVWiOKlpm+1FiXLjDNfv14jPHAVxPZF+4NbyOWMkyajt
         NfYif2Jp42/SPKVTI6o0GzYcv+jJVpbP8qCbbR9qJ41+02K7X2oDtocSruSSHI+wfzE4
         6zNhoUPLJcWgLpngoIcl9nOmuRYUOKl6UtA85P8na522ytOHPZn2/UxSSbYS7lN0ryp1
         YAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+E1myvL+FQNMLBHh7YhNNO6xrcap4dEx+GlOPcwYn0=;
        b=gA/OMO/VGUOU9VBEGvKAeFUuOy62bGQdFidrih+c9f5augW4Ct/7RQuN5/AA0E7B/j
         J95uYt+iWUlHxwUD2JEVU30JWQXLItmqwxFTevtnlFi9BQ3brpRot2J1sbuC+e6w6Ynr
         +ZZi4QEGFNvHm27aqr4VeKmyYTw7PhkeXJ7sTfbWGhjuw+SkMLb37mxpsO6xRSLn9PO+
         0h96kkUvnXyTzFxLTW+JfLUTLdSMCcho5OBHbk+6GfoAnal20DNEVGfeONZYjaAts2CU
         hlhnNbrJ2XLGxcbycgEc6A76a7t2j6Wpo865NdZvXXEHz7dTFSqDZGFNCkSgUEeZiWIO
         v//w==
X-Gm-Message-State: AOAM531HLtPkwowqE3SFl9/wSZZ7SUBdSZSmaEH9qDArA7t+UVVSp1pL
        IbKXl1tFdZCIxQjko2DBTkE=
X-Google-Smtp-Source: ABdhPJyBWK8l+Vs9F7nSxWHA9Ox00Bl2mkrTMaen0lTs6mgq6C+dK8ZKuwfA4zP9ufteNrOiEt1yzw==
X-Received: by 2002:a17:90b:4a0b:: with SMTP id kk11mr514890pjb.95.1614299248296;
        Thu, 25 Feb 2021 16:27:28 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id q4sm7800846pfq.103.2021.02.25.16.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 16:27:27 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:27:19 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v8 18/22] docs: counter: Document character device
 interface
Message-ID: <YDhAZ5bQ9fqd3FWB@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <350cafba81d3220b64efdb019bd76c08eb1e5d10.1613131238.git.vilhelm.gray@gmail.com>
 <20210214174819.6757e2b0@archlinux>
 <20210222101133.GB14587@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EjvxlyKqXuKwBAVF"
Content-Disposition: inline
In-Reply-To: <20210222101133.GB14587@amd>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--EjvxlyKqXuKwBAVF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 11:11:33AM +0100, Pavel Machek wrote:
> Hi!
>=20
> > > +* COUNTER_ENABLE_EVENTS_IOCTL:
> > > +  Enables monitoring the events specified by the Counter watches that
> > > +  were queued by ``COUNTER_ADD_WATCH_IOCTL``. If events are already
> > > +  enabled, the new set of watches replaces the old one. Calling this
> > > +  ioctl also has the effect of clearing the queue of watches added by
> > > +  ``COUNTER_ADD_WATCH_IOCTL``.
> > > +
> > > +* COUNTER_DISABLE_EVENTS_IOCTL:
> > > +  Stops monitoring the previously enabled events.
> >=20
> > Is there a way to remove a watch?=20
>=20
> Is there a way to eat all kernel memory and crash the system by adding
> too many watches?

There can only ever be as many watches as there are Counter components
for the respective Counter device. This is enforced by
counter_set_event_node() which checks whether a particular watch has
been created before and returns an EINVAL if it so has.

> > > +For example, the following userspace code opens ``/dev/counter0``,
> > > +configures the ``COUNTER_EVENT_INDEX`` event channel 0 to gather Cou=
nt 0
> > > +and Count 1, and prints out the data as it becomes available on the
> > > +character device node::
> > > +
> >=20
> > Consider adding an example program under tools/
> >=20
> > > +        #include <fcntl.h>
> > > +        #include <linux/counter.h>
> > > +        #include <stdio.h>
> > > +        #include <string.h>
> > > +        #include <sys/ioctl.h>
> > > +        #include <unistd.h>
> > > +
> > > +        struct counter_watch watches[2] =3D {
> > > +                {
> > > +                        .component.type =3D COUNTER_COMPONENT_COUNT,
> > > +                        .component.scope =3D COUNTER_SCOPE_COUNT,
> > > +                        .component.parent =3D 0,
> >=20
> > Good to add comments on what these elements actually are?
>=20
> > > +                fd =3D open("/dev/counter0", O_RDWR);
> > > +
> > > +                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> > > +                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
> > > +                ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
>=20
> > > +                for (;;) {
> > > +                        read(fd, event_data, sizeof(event_data));
>=20
> If this goes to tools it really should have error handling and
> handling of short read.
>=20
> Best regards,
> 							Pavel
>=20
> --=20
> http://www.livejournal.com/~pavelmachek

Ack. I'll improve the error handling for this.

William Breathitt Gray

--EjvxlyKqXuKwBAVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA4QGcACgkQhvpINdm7
VJKWJw/9GRJWjfb/0hc9uFqEfRRMHfpTYcUMnoHAZLdRvq4x0y+IvSO+GwI+knBV
/peeZ3Pb7Y+LgR859jKBq3eGAjQutYpTGf06a8KyWFBmC8mZklZGfMrxNRsQfvCJ
Ug2UrJRi/pfFN+/NuFBws/oEORNMkra+xF81HOc877HJXVchWEwoHos7mNVGrBeZ
iLJOOLW6s5o4CrjJE9voDUthSCkZBvqjZo6Y0ulFyX/Z2rMv9Ey0v/+rRzAbWRRo
4/T4ITdlDxN56OX0HV5CMMt1gZhACQDdNLO8owXc+8qXxGPsKnyHhYbswFVk7iv6
xS05D4XJnic6orhBlvWq6WJ43IgHGtLTmOrbdpeuP8DBpHBZx50EDpNysajG2sr9
5v7twAvRJGVe1boJryMZ1sfb0/07CxvifSeJNzvrK/wHjHQyZk62w3Jx9eZ5t45c
8mqSyUbpSFdoUN2XivYYXpAu+m0myUKFr2iGT9uATuW+xLFb1T6qv4sKwgQpNv7c
hLS1OFzLHSy9QsOOM0/oU4Ian53VZKMk+BNck2shidCXIYzt8vsqJgqHYpOV41MK
YpnCriW4/fTS1LQoBDJKPNREtN7X7+QA3O+TvsPwnIxlBgnDmzuK85N3ofg55Eyy
N51/6UHDZLWvqY+jrzrB1ZHHDiMQfNYmbMqEfl3nha1c4hC02QU=
=ULaJ
-----END PGP SIGNATURE-----

--EjvxlyKqXuKwBAVF--
