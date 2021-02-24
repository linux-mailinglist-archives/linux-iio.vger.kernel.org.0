Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781D532387C
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhBXIVM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 03:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhBXIVK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2021 03:21:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA6C061574;
        Wed, 24 Feb 2021 00:20:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t5so2986075pjd.0;
        Wed, 24 Feb 2021 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AiI+JQDNQPv4m7iMBMCRcu16w4oChxUIOx+Z04AmRwo=;
        b=ZAA8z+a+eGgPefWZ59f4E8tZHDUtS7S4o7L0Edtg1cMVJDZ2d3KynBdbCYgQC/U8HW
         /VOqr9SwIUplipy3Kpt9NxvH76pqcEDnPcYtIrXrYm3yiyrJt+G00PCAV1tAx/ZB5RSG
         afQKB5Zw9Ruie50tHLUpqPAt6Y+vzJ7KEARIbyQyVSvIXFGF3ZoUNSnE90FjVdw4PxxQ
         IQllujm3+BZbli+YycIKEoD2srU/PJ0LXHjltqUvLsa2PJwNlsfvxwBkwfPeHfOj1kST
         xUds5h5yH2X8WPaZxRa5Wc3I4pEWl3G2psA0pfaU1bbDqvLQ2byntkQh5W81K4XRLrw5
         F6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AiI+JQDNQPv4m7iMBMCRcu16w4oChxUIOx+Z04AmRwo=;
        b=R8DuVQ7doHYKcX4MPYw0YzB3H46VSuc7nAUnkQfiRrRn2/3SsIRKts3DtkdlPmvspP
         wvnERkPQrgvPUkYXbNcPpJnePQeE07KTyHDn/AAOhk3foqUJVq5BcqC+u3uLvOFpOaNi
         lnDTkIrxPUWlc3fvdjkjYb9o1I1Ty2dWFJCoTzOsQTFQxvMtLOWQf31I+dU29wx0Xv4j
         2fjeB/P5VrQwXBpblMkZqO8c/tzxCUh6FuoSAKWBu8OXQ3fp2oDg+JtSReWcqn0vUMHu
         ZJTJiVjgWp2DqvvXfMm38fuct4HbvxfEyEQefqmeAqTkLVvpBFDD5OXLwSKnovB+U2+c
         jX9w==
X-Gm-Message-State: AOAM532XNlcj0dx9K5b0Sbhr1fHowTd8f/GDO7b4BDRYw6dr/19YQ4SD
        j1ZZH/5ns6tcg7Y8gYNqsak=
X-Google-Smtp-Source: ABdhPJzArhS9wxejthnVeUTfevY1+e44/JUfWJ4quLkHrATx9jv8adLi0LX9CFIh/wiCKVzx2KHTJw==
X-Received: by 2002:a17:90a:2ec6:: with SMTP id h6mr3351903pjs.103.1614154829278;
        Wed, 24 Feb 2021 00:20:29 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id n6sm1728112pfo.201.2021.02.24.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:20:28 -0800 (PST)
Date:   Wed, 24 Feb 2021 17:20:21 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <YDYMRVgC3BrjISKU@shinobu>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
 <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
 <YDMMJJ985Zq9oEOv@shinobu>
 <20210223100656.efbshsh5bz66uhj5@pengutronix.de>
 <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
 <YDW7Hihg0gGQh8UR@shinobu>
 <20210224073506.GA24260@pengutronix.de>
 <YDYKF7zdyjZX30gX@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/BAJX8Q7j9z0hddt"
Content-Disposition: inline
In-Reply-To: <YDYKF7zdyjZX30gX@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/BAJX8Q7j9z0hddt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 05:11:03PM +0900, William Breathitt Gray wrote:
> On Wed, Feb 24, 2021 at 08:35:06AM +0100, Oleksij Rempel wrote:
> > On Wed, Feb 24, 2021 at 11:34:06AM +0900, William Breathitt Gray wrote:
> > > Alternatively, we can take a more generic approach: ignore the GPIO
> > > names and focus solely on the IRQ lines; because the GPIO lines will
> > > always be tied to respective IRQ lines here, using the IRQ as the bas=
is
> > > of the name should always be valid. The "name" member of the struct
> > > irq_chip can work for this. I haven't tested this, but I think someth=
ing
> > > like this would work:
> > >=20
> > > 	cnt_signals[0].name =3D irq_get_chip(priv->irq)->name;
> >=20
> > ok, i'll take a look at it.
>=20
> If that doesn't work, then use devm_kasprintf() to generate the name
> based on the IRQ line number. The idea here is that the user should be
> able to identify that the Signal component for this Count is the
> respective IRQ.
>=20
> William Breathitt Gray

I realized that these irq_chip names are often just the device name
which isn't very useful either. :-(

In that case, I suppose we really are just left with generating the name
based on the IRQ line number then. This should be fine then:

	cnt_signals[0].name =3D devm_kasprintf(dev, GFP_KERNEL, "IRQ %d",
					     priv->irq);
	if (!cnt_signals[0].name)
		return -ENOMEM;

I think this would make it clear to the user that this Signal is the
respective IRQ (whether sourced from GPIO or not).

William Breathitt Gray

--/BAJX8Q7j9z0hddt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA2DEUACgkQhvpINdm7
VJImuA/9FhUJFLm1+UOrQJ31XDXZ018AgRi2LO5elphbM52xgMdV8e7bpkn9Ujbt
Wacl5jV5XAZ6QHF5kKi/L1GCwblG4KH7yKaFOPG2Us0WuIE+AvokiW5sSEwIZSs1
LOnEvgOlH1vtiFKwCQ4sTyOSp+yUciOYYmZcEbcdejkzzdEJktt15d7aVrMsDTFT
eR/7RyXpgGoxVjTz2kEzhXbBLVpvOBniPtewd74CueFfy3vpm+PddALnQRp4loCF
WT8Tl9f8rhk8QG5uhWxkmxTJtlbp0x8cygbNIdn3goi2B0U/K9KviUNHfw+ERbLs
OlGGh3mewT+uyaiElAvRgsePIUmaZyEC8WB/bT7F7bK0D2WeQvbwQ8wcUi2otDC0
P/HonFa93IBmQ775f60so+f1Vx51VWWO+zt8/1D//Nvdx4owBsYJXTE5TACL+Byc
nmdWiwlKk2M0njyizP9s1awc/gCEPXvgFfCnZcSXrJvo+uaSHJTAVt8rujVn1Nry
O4FIiC5EkoTcO/GX6+6xx958Ac2Og8Ky8tXT0+l7xlFrK4ILxs/kXq3159Hws2SV
DTyrlU0zbQtssS2brBydYIAaREokYrM2hMHqzfusvZ1qnkBX+XMYvM/iWcyCBYNm
OrjJ/tgh1evtkFRK6164sJRvr+obpOOZke5v/o36z80nCZKMIVA=
=FZy6
-----END PGP SIGNATURE-----

--/BAJX8Q7j9z0hddt--
