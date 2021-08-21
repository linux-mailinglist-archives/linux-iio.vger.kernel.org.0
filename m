Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67D13F3A50
	for <lists+linux-iio@lfdr.de>; Sat, 21 Aug 2021 12:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhHUKxP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Aug 2021 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUKxP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Aug 2021 06:53:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CDC061575;
        Sat, 21 Aug 2021 03:52:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 17so11793403pgp.4;
        Sat, 21 Aug 2021 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7GHZ71vn1IOyEe5RXN4R0wAt4wO6jCQIg+NGEUM1G7w=;
        b=E77GypFj7f0d6klY5ylnID+eWbmqIPQxTnRVeVE4YvqcbIa6kRk+AjA6qoJk6HL6fV
         Hm5RNXXE6JYNRLCtkAM4jL6KHsPLU8zvZKrKDL+KQI8mLnTn8KE3P+nK6GkDhOA3Q29k
         GhxcruQtC246xFx7P8sfiQ6SzJvnqVYKDWAYM4DkkYtmTC0217zSA5lSZa/zM/8dxTxz
         8XPDcxtevNOq4LNMoY91V0hUz7MFLXSg6O2EnrKBSXVy8T8ushel5tgWQNr/E+nCjQDV
         EWm+V6BOo5NGC1dPEKmuKEGVUu93UfyT2mKpGu6TV5+Rw9E1HO7eo3cXffsy6QbFLtOs
         hHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GHZ71vn1IOyEe5RXN4R0wAt4wO6jCQIg+NGEUM1G7w=;
        b=sE9GV8W3IBE3U2lUf2bY5sgknEgl+k52RDdh1EQOuEKsPaGxHpmZPNLrU6XUhPAH8c
         O3kYoGMXnJ6eVw5vuIEYCkRAktC5OmsiOwP9Okw9/SgDMoI4Q/Rei5R3ZkRoLkQcD0gb
         Mofo6oPNv3A3AE3P+AQrRkyluiomiqErtOD6akXbIK/4s2QG0eswHqmQUrtqLGwXHVzj
         EXDZcWmQoecFq91XjB9TISf5t3olXEbsbYpR8HxAkR846fd/2OGe6UYnuLYwuPfjkcUX
         iT5rEUcIPoknSyWSz9Ktyws6mRdzGVOJFKbZ2Kd18oAJ46lN54+Ua2pnycg7VhUMFnxs
         EAEg==
X-Gm-Message-State: AOAM533ZAgkvLs9tfKXaU4A2gbDlyjgodqyxmYHjOccCPu1PGmhVKVxT
        oHbjCnWKnO44yrl03C85fqw=
X-Google-Smtp-Source: ABdhPJwU1O/fyQ1CgvrQNT+/7EUp2HR/Zk2LYQNY8wRyENOHx6pzwRrzfuDSMopQdhJywkaK95asLQ==
X-Received: by 2002:aa7:9e5d:0:b029:3e0:46a2:1dea with SMTP id z29-20020aa79e5d0000b02903e046a21deamr23891279pfq.77.1629543155036;
        Sat, 21 Aug 2021 03:52:35 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y4sm8740382pjw.57.2021.08.21.03.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 03:52:34 -0700 (PDT)
Date:   Sat, 21 Aug 2021 19:52:27 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v15 07/13] docs: counter: Document character device
 interface
Message-ID: <YSDa667n6pi4O8iT@shinobu>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
 <a6f7be32b8ff7cc1e8e416599820a30fa9aab9f5.1628511445.git.vilhelm.gray@gmail.com>
 <20210815175102.4a10a28f@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FonV+Z3EdOcq0SvO"
Content-Disposition: inline
In-Reply-To: <20210815175102.4a10a28f@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--FonV+Z3EdOcq0SvO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 15, 2021 at 05:51:02PM +0100, Jonathan Cameron wrote:
> On Mon,  9 Aug 2021 21:37:32 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > This patch adds high-level documentation about the Counter subsystem
> > character device interface.
> >=20
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> Hi William,
>=20
> Trivial probable typo inline.
>=20
> I'm struggling somewhat with these interfaces because I simply don't know
> enough about how people use counters to know whether they provide everyth=
ing
> people will want. They feel similar to the event handling type functions =
you
> can set up in motor drives, so they may well make sense, but ideally
> we need review from someone (other than yourself!) who actually uses this
> stuff on a regular basis.
>=20
> If we don't get any additional review I guess we go ahead anyway
> next cycle.
>=20
> Jonathan
>=20
> > ---
>=20
> > +
> > +Counter events can be configured by users to report various Counter
> > +data of interest. This can be conceptualized as a list of Counter
> > +component read calls to perform. For example:
> > +
> > +        +-------------------------------------------------+
> > +        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
> > +        +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> > +        | Channel 0              | Channel 0              |
> > +        +------------------------+------------------------+
> > +        | * Count 0              | * Signal 0             |
> > +        | * Count 1              | * Signal 0 Extension 0 |
> > +        | * Signal 3             | * Extension 4          |
> > +        | * Count 4 Extension 2  +------------------------+
> > +        | * Signal 5 Extension 0 | Channel 1              |
> > +        |                        +------------------------+
> > +        |                        | * Signal 4             |
> > +        |                        | * Signal 4 Extension 0 |
> > +        |                        | * Count 7              |
> > +        +------------------------+------------------------+
> > +
> > +When ``counter_push_event(counter, COUNTER_EVENT_INDEX, 1)`` is called
> > +for example, it will go down the list for the ``COUNTER_EVENT_INDEX``
> > +event channel 1 and execute the read callbacks for Signal 4, Signal 4
> > +Extension 0, and Count 4 -- the data returned for each is pushed to a
>=20
> Count 7?

Looks like my finger slipped on my numpad and hit 4 when I intended 7.
I'll fix this for v16, thanks.

William Breathitt Gray

--FonV+Z3EdOcq0SvO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmEg2usACgkQhvpINdm7
VJLlrBAA5ef/1u/fl55aa7bo8Y2TRZq13h+0JMoMFw+JkZff7ubiQ0NaVAfOZNQN
zG9PNIwOsfw0dhWrWhPgyyQDtXewP27ISLqBjKvlXStIT6gaE/RL1IqAdR2b7PXn
oK1LOh89aAWmD6fWX4qB/NABJ0gUnrHi7AfWU9TKfbCyYfCt6GCCvXovaol0OVLY
9/ZZo6vgE0leqpkIYDEWUEUdVMz48GNEWlKHfRE3ajwyHVXkUKoIAVvzP+Bdo7ON
Cwu3GdFpSGzG/f6tvOlQN3+HTyiO8F5TOe954tCCpSY27N2GLBgF3s93mFJtmYmy
sAdtyEgEj6GhWF12gQKcnvcVt08uC1eSbg1Gh7ZUiZ9F3v4cyLUqHhTFPtxM+PyH
flghDGTfyHgcBD3Zt66cVBJvN1v29hQVc4/Q+x7q4YDXYk5c5LKBUNThfdVsAR+x
475bGsvth6Uq4qzOdOPfdMh8+IHJ3x6JygmxvyGdWiDaBGWk5XrgilEkVUdsf4NR
cFvlEv7ElzQpNjsm3atDkSTYKw29QiTZzAihXPbB1WXMbGEA2B5n6wuPUFF5tgrR
0nFVsG84EleG+u/KwZkIMWhlRpEl8e1OiJETtlObjMvwybwNn5JLlnsFvTWnsVq6
4j4EBNsdllCs2NPTQVa5eJRXa7WsChfEYegahqRQCB0fqNQnGVg=
=glsn
-----END PGP SIGNATURE-----

--FonV+Z3EdOcq0SvO--
