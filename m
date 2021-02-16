Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1843731C55A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 03:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBPCQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 21:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBPCQv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 21:16:51 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E5C061574;
        Mon, 15 Feb 2021 18:16:11 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w18so5242357pfu.9;
        Mon, 15 Feb 2021 18:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lb/pFWHszNknFvlysVhnuzVrA5hrw2/iv1f49uuCHHc=;
        b=JI8bTZ/ZGvq50e31unyKdwZwCoOB4y8l9dgZK/MuqjfNS6yi/nhSsRotwpkjqroAOQ
         7ZizadhCd0etnXIkksrH6rBq1MPC5tg8tKoHMMHhha1LV6RDNUSxMocBxKX+6yCBlB9i
         CF2WblOFfA4PuN39N3WBdcIJX4KtMTduaEG6IXYuRwMeZRSmjGcIlDaA+PVs1qZ8DFOX
         F05hvCPi8IwGPxfPLvPw+juA884nIzZhOfS+Ha+VGwQa4X0cyPhF9Eqs5rt4f9VawxwV
         1FGYJoJilbIXAYyAAbgXEpC2arpzt44bEoS6FWlXno5q/jhS+2VjSfeBfgP10ihDRUt9
         MeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lb/pFWHszNknFvlysVhnuzVrA5hrw2/iv1f49uuCHHc=;
        b=uYSrq4iHd+Gzp7CR73f6QzE++8cs3O84cHgTzwEwX2fgmQl6JQGs77mMh4gRMSb2Mv
         B+5aNKlrE22JKGP03JCwrUeoMh6EhLM+li57qnoF6F9AfScVXK8S8Pxcyo/+nMOcto2Y
         py1q7z0CMfukDgEHxDskjbzlnB4+smRkcdId1tLGIE9Gn77S9qnbL4H7W6pPzVUXvmOl
         BT95fUn5PZuXhyrtM+YgrqOwMRIN8NGjGN9wd9kyTm7qighs0zUezJ/5dejEHf6Sd+E9
         17thaTR2IcyPsyi//GHYw0cCQV/hrqkr/NWolp6y2Fpmx/ClBchBSyqxepFRowWObDcy
         0GAw==
X-Gm-Message-State: AOAM532R5A0y9JsyBodO0wfGHIE9elUc96aGZfxYQ9uMRM+fYP8ftck0
        3NQ/CEFFnBX+DyZnzukG2HeyK5MxjGLV/A==
X-Google-Smtp-Source: ABdhPJzp7SNhYqSVr36CPjTlOyyOihZNlM6Knf+LNC3ReY54DeKBGRIElDZZIw4HLFNecR6kVUhd0g==
X-Received: by 2002:a62:c719:0:b029:1ec:c587:3c5a with SMTP id w25-20020a62c7190000b02901ecc5873c5amr1320838pfg.27.1613441770889;
        Mon, 15 Feb 2021 18:16:10 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id b17sm18608375pfl.190.2021.02.15.18.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 18:16:10 -0800 (PST)
Date:   Tue, 16 Feb 2021 11:16:03 +0900
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
Subject: Re: [PATCH v8 21/22] counter: 104-quad-8: Replace mutex with spinlock
Message-ID: <YCsq42hXqdRWrSEd@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <d2e72eac404ca5b7c99d8a642f2c07ebb2eb240a.1613131238.git.vilhelm.gray@gmail.com>
 <20210214181946.1d2f7e78@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HfLQjWKfp3+aIQDU"
Content-Disposition: inline
In-Reply-To: <20210214181946.1d2f7e78@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--HfLQjWKfp3+aIQDU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2021 at 06:19:46PM +0000, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:45 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > This patch replaces the mutex I/O lock with a spinlock. This is in
> > preparation for a subsequent patch adding IRQ support for 104-QUAD-8
> > devices; we can't sleep in an interrupt context, so we'll need to use a
> > spinlock instead.
> >=20
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> Why do these need to be raw_spin_locks?
> Normally only need to do that if in code related to interrupt chips etc,
> not their use.
>=20
> Jonathan

This lock can be taken in an interrupt context in a subsequent patch:
counter_push_event() called by quad8_irq_handler() can end up calling
the Counter component callbacks which take this lock. We can't use a
mutex nor a regular spinlock because those can sleep on RT setups [1]
which would result in a deadlock due to the interrupt context here -- so
therefore we're left with using raw_spin_lock.

[1] https://lwn.net/Articles/367219/

William Breathitt Gray

--HfLQjWKfp3+aIQDU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmArKuMACgkQhvpINdm7
VJKp3BAAlS2Vs6gAvh5SArki6q5IaQsXcy9P9ApPJpGXN1aw41Ww/OOyJ8HutGNE
jzKXcr4QxWrtrHBeM4S9hz9R4Wo3M+LbGSu8HUz/MY5DyGGglcI6PAb5LDoQS7vQ
4/N1ymMuu5Pmht/uA4ZWA6ZeU54Y0Dor+IXmit1BPBwo7ooYctbNvh+vdoNlZSxg
0sWQPD9m95Vd3FwCuhQ4vzyZXy/FEr5PFiyy0fwa+5Wndof9DbA+5VYcrRBZdB7v
a1xiIT8B+0eq7eElaAYM3clZdJwF9utTYMi6oqkrZCU6iMYLZD+W0BhyOcxA4LTO
s7KjhqBwS7sDObxEx0JD5OHh+mGU8h7QzZ3hF9o2git8cL3Y22bKMMamTnJRGWay
vlU5B7KF8l6Rg8Hf8cfspWC6cwp0iXhA/fNCIjxVDikQr/GxqdkMDHvIxzz7KID5
YCWz1UCBRxOe9hBOBPSa7p/QbPKnk2DFP3RSgwEknaRZag0/6PO4aou0yxFSsGJO
f0bI3cp64xK5sE74Mv5T0OFNPdcgtftKi1hES711uJZwyWdoIdz7T4mikmVt2r7D
0N1oeEckjiFzF4wzvMU4KX2NImw/8ef0Dz/XTvSvI6Ae1FVnshCj7sZ4RfrO9W/L
4x84eyP5JTdZeLHhH7M8Fuw2XOYmF/+8Jeye5Os7njSB4+DU6Ig=
=Zljx
-----END PGP SIGNATURE-----

--HfLQjWKfp3+aIQDU--
