Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698A82C0BA5
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 14:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgKWN2g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 08:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgKWMai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 07:30:38 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF6C0613CF;
        Mon, 23 Nov 2020 04:30:38 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id k3so1813463qvz.4;
        Mon, 23 Nov 2020 04:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OHoUqTFWWE+Wvyk/7Fm8SlSjmG5RijlPgr0GGsxt+Sg=;
        b=sytGcyw1eZnl0TbXkzQuBT5tqfRXi2j1Zogk0VHDe6xvZ3P0+mal89v+FjPjC1i2LQ
         eykf2AOKhm5qUbHr8xh/oG3XhhAm9XQj7hiUvkmHj7w2FfFKkEHie2CZpWhtXH7Olxd8
         3geSXljAn9pzKiKWvsH8lBraoLpz1VN//ZTl0DmAmzpYckIFAd5j1BWLEXGelIMSadcy
         EfrhBLCY19YMRpjzYnhfziop/gaCwmxoEgb61h0oTS9z8LgYUO6+XRHuMAvOkE2lqLn8
         U6U4rcUO+Ry7W+BscgHLa26jhZUllxvIUEbsEPOnLWJv6fX0igETyuhkyA2xrOEwNAMm
         c5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OHoUqTFWWE+Wvyk/7Fm8SlSjmG5RijlPgr0GGsxt+Sg=;
        b=dYUNAFVNrO+L1mSo/UviE42DBfe4inQCzVKgbT2Psn045ilMyLuvSsxSDrDjFHoTZw
         FSP1gvmILoaUJwmI5ZxhVQyTb5HDjoy7HUz7Yj41Cm1+P33LkmQM0D0qGzQtq8nA1gBe
         +3EsHXYtxPq5vcrIcPCX0zzw5z5vF+NnC9/HbmbKGKQWjwNO20BR1KW94jtSQd8Nqczz
         Q0BzbpfT5P2e6tjnuDRlJneaNFKeaB9NdG1i/JYXpDCgaLAlYV4oDWKcnCfRZPGK7MSf
         mk98NqDRqFC0aGCtz6wq2TluFxKupuiB5mQmFOOcimnp3loHV/tWMpfHiCNcGrG9JTqs
         TQcQ==
X-Gm-Message-State: AOAM530UcoF75+4s1ZdcxcDgI/QxXgdemTUwN8SwRTdzjKQYqg4H/XHh
        z2FGBwQxhOW3dmWi2tGcFgU=
X-Google-Smtp-Source: ABdhPJxImrSVZi/1EIy3edDOInFPq3eMKoEzlTqNhC6F3EZnAcIw057TQTcWqIal0rgxcMvSSuKm0Q==
X-Received: by 2002:a05:6214:20e4:: with SMTP id 4mr29601182qvk.37.1606134637593;
        Mon, 23 Nov 2020 04:30:37 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id h142sm9320133qke.104.2020.11.23.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 04:30:36 -0800 (PST)
Date:   Mon, 23 Nov 2020 07:30:34 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     Nicolas.Ferre@microchip.com, kamel.bouhara@bootlin.com,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
Message-ID: <X7uragBU7qwcs62L@shinobu>
References: <20201121185824.451477-1-vilhelm.gray@gmail.com>
 <df14f643-e80e-6ae6-dcef-90adefe6d733@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKBXnqDtWJCMEsOZ"
Content-Disposition: inline
In-Reply-To: <df14f643-e80e-6ae6-dcef-90adefe6d733@microchip.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bKBXnqDtWJCMEsOZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 09:50:34AM +0000, Nicolas.Ferre@microchip.com wrote:
> On 21/11/2020 at 19:58, William Breathitt Gray wrote:
> > Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >   Changes in v3:
> >    - Reorder entries to match preferred MAINTAINERS ordering
> >=20
> >   MAINTAINERS | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 913b5eb64e44..1ee380dfe189 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2104,6 +2104,13 @@ S:       Supported
> >   F:     arch/arm64/boot/dts/microchip/
> >   N:     sparx5
> >=20
> > +ARM/Microchip Timer Counter Block (TCB) Capture Driver
>=20
> Nit: we don't use the ARM/Microchip string for drivers which could be=20
> multi-architecture. Only AT91 and Sparx5 families have these entries.
>=20
> I'm not holding the patch for this:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Jonathan,

If you would like me to submit a v4 with the "ARM/" string removed, just
let me know. Otherwise, feel free to make an adjustment if you want when
you merge this.

Thanks,

William Breathitt Gray

> > +M:     Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> > +L:     linux-iio@vger.kernel.org
> > +S:     Maintained
> > +F:     drivers/counter/microchip-tcb-capture.c
> > +
> >   ARM/MIOA701 MACHINE SUPPORT
> >   M:     Robert Jarzmik <robert.jarzmik@free.fr>
> >   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscr=
ibers)
> > --
> > 2.29.2
> >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >=20
>=20
>=20
> --=20
> Nicolas Ferre

--bKBXnqDtWJCMEsOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+7q18ACgkQhvpINdm7
VJJbYhAAjacdtakChubYIw7KbWdBNeTSz8pllrkDAeJ669W2z02064sQR7TSa8Ne
ToxOztGYN8puIvwzss3NDhUCuFHGa+dhzbPZ5w6g8Sr4yv+REJvAAEfJlPKREJIN
XZOAGmPbHJUMo+lrf7sTx0XXS2Lsc08PB/a4FAhb90ET2mphBZHfT+piE7sz6KAu
iP+gjz9Iow/4jciRIIcx2t7KCyk96dZ8aWe1WdhoSmD8lP7L04+BB6//DaMXBd4c
m706d0lEEJRxa1KhrgmwnsChksCJXVxGb067iE7rN8eE5nxiFxSuD7OB/s5OM/y8
bdr25gXhfbwT9dRE5rq6sNbM595l3MznqIDPADIxpCgyqYJ8nb0vKmWlaoZ2wxYN
2ExKXkJRjX88WozPh/MGe7SdaRDUYYeg9T4otjytTS8Fqs5VOwNda/o3dZqsF5YL
jq3pQaCRgnAJ0wTs5QbPZugtzwK8+nUzIq4WPKWewAmHvBi18l4UWnEalPrKKydQ
Kn5vdKhhqhGadex6RlGUEq9upth+mSCPBNjVql8rYGQzwA0QTRjCHZojd/pF4SWf
/Ezp21s+Bc53DmZnWPzKlDl+DCLD1Prr/GxMznUL2pbpItW0Ew3A6f5bbexijsb/
Dz+cRYFMjOQr/1lTE0WHioOSfKPW2tDW6AzROIIGjB5+s5ZveMU=
=w8oh
-----END PGP SIGNATURE-----

--bKBXnqDtWJCMEsOZ--
