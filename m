Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE252BC0C2
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgKURCD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 12:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKURCC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 12:02:02 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63828C0613CF;
        Sat, 21 Nov 2020 09:02:02 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d28so12126251qka.11;
        Sat, 21 Nov 2020 09:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b47tRijBGMRrjyZdvQwGUkV/0RU29edy34U5L+Fy2Yg=;
        b=bPBwFixZOzNh4bclPxy76rsmr8xP20aYNukT6yJIJyyVDRm296BjS9VigHmQlf2fgM
         yGnnWjPXs6WXwebsEcMl044UBvoynN4b0FNQfyEu4ocWQ69vbWVlL3WoN1I6M8mcK5aI
         jpmEqG36hdy+WL4kRd4cN5xTmdp1kK4136CQMfSNSIYtgR10B3B491znOmsTKvCtjtB/
         XJVlg+lwiHYr37BYgl1pEgk0OdTblVIXo5DwoC4qTVW22sUxzy8i+X4Y+1o0E9Zm9Vcj
         vh2ZVYguDeO3rjoV8nF3NlwoW3G80b/UeEKfGLhFxGZ1syrQ1/K37JP2ghQWzGcZjLf0
         UTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b47tRijBGMRrjyZdvQwGUkV/0RU29edy34U5L+Fy2Yg=;
        b=IOIh2l0GPUjcRwFx+ibo53uzKVwJ6t8oHvrOurdb6RHjVGC3ftgj17M4rjhKdpXFyl
         quNVIcK88DDEwU+ON/sBRGo7pxcjligXwgW1m0nwCJ1rZ9wFPmsNJ+6c3JmyXgRqkyCy
         Q2oBb6frxT92LOUPhsuCQDejV5EQYCq2UB0xsc7kTrGL7PK+c7t52yZ8Jlc9rWANACPB
         lRCpWrplXR3HT9jrqMClEWNhrFZaEMnxHSdh7ukUmFmq2xqnPcQIinFn2CxeyfRTF771
         X/z+6F5tW/LeigdjdejmPeKE75eYg+niABMWkIQjUREIM++DTeEg/+dXrvsNRCJihxp4
         bU9g==
X-Gm-Message-State: AOAM533WHdIjX6UujUr01g9hLrbBlZbF3Cex4ISFRFwzSI+O4woy8mXP
        Nei7JpcztnsIWZfJUUYIzjA=
X-Google-Smtp-Source: ABdhPJxFAYhk3oqx1pShTLfb1UTfGotPARuR37jyNVpEfx7eZEBbVBrrvBswlCnwZpbpap42Lp1CrQ==
X-Received: by 2002:a37:4552:: with SMTP id s79mr21650121qka.6.1605978121654;
        Sat, 21 Nov 2020 09:02:01 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u14sm1251440qta.4.2020.11.21.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 09:02:00 -0800 (PST)
Date:   Sat, 21 Nov 2020 12:01:58 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
Message-ID: <X7lIBkqspjUmTbgr@shinobu>
References: <20201116131141.3985-1-vilhelm.gray@gmail.com>
 <20201121161902.5ede1a23@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i+ElQXCcUksXloOI"
Content-Disposition: inline
In-Reply-To: <20201121161902.5ede1a23@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--i+ElQXCcUksXloOI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2020 at 04:19:02PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Nov 2020 08:11:41 -0500
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Purely for the record, Kamel, would you mind giving an
> Acked-by for this?
>=20
> Thanks,
>=20
> Jonathan

Kamel,

Let me know as well if I should add any additional information
(additional mailing lists, reviewers, etc.), and I'll submit a v2 of
this patch with it included.

Thanks,

William Breathitt Gray

> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 913b5eb64e44..18d34536c4bd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2095,6 +2095,12 @@ X:	drivers/net/wireless/atmel/
> >  N:	at91
> >  N:	atmel
> > =20
> > +Microchip Timer Counter Block (TCB) Capture Driver
> > +M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/counter/microchip-tcb-capture.c
> > +
> >  ARM/Microchip Sparx5 SoC support
> >  M:	Lars Povlsen <lars.povlsen@microchip.com>
> >  M:	Steen Hegelund <Steen.Hegelund@microchip.com>
>=20

--i+ElQXCcUksXloOI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+5R/gACgkQhvpINdm7
VJLbohAAiPQiE1c2lFVV9+ofihgY9paYGkNhTi/+M668Prxy10lQDn0IKeqy0ekG
YP+72D3AqTEvNiOL9z6KDAWbTOFLO8t9+J5RJ1ZRNVYAhu5E/Bvcf0ZHNKhov33F
+rPeYWTQzDe6UTv9GyQM6zYtQHdlze5ekNs2RGnR188CbBYahleSO9bgq4YeqFNp
TyT8PbFT3Er7IAmvTCiufmXOka5B4qZNSUKg/aeZGXiXalQB3OjyS4cC/B4fRj7k
68Jb8JipWXWXL2KNb1ZJGv7vFUM9aws2hB9VpHOHnUBT/YfHY1TCXpifKTI5X861
i5k1W2K+rzvFYrNd3nzJl6Ok3LOlWHJJPV9SI/v2TqjQruAhxg6uxXUq2IFVB/im
a4pPtqf0+vX19fk+prBtMhvcV0iNgRcTlvoJJ6mnY/2dS3agAVmdj7EKRcFdgs9g
nmMO3GzmyFWDWi3dwBCtwFuyFdqd1v1PuXpc50m40qpOQtBWKNNGrZ4qwd3tuqQp
1VGML7JXEkhY0zh45SR5exIleBJV2qcdRNzm1cGHiMC0Xd5smRRQ7W8LtMe44QQe
MVZs5HayPjESU0nniXlQREl4caoNK1yjK7qZXayq3Zpp7l01JOgRhXKPLkLgQebS
lCpdv4DrhfixQfbAyat9xuWdZHfSknBY/CvVeB0jYgXfgIrkxZ8=
=Nsv4
-----END PGP SIGNATURE-----

--i+ElQXCcUksXloOI--
