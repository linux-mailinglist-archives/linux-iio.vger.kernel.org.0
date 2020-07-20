Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F78227381
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 02:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGUAKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 20:10:24 -0400
Received: from sender4-op-o17.zoho.com ([136.143.188.17]:17701 "EHLO
        sender4-op-o17.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGUAKY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 20:10:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1595290202; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cKH4Wo1HiibKhmokUIzQx9OJE/pOsrpMW/hAvLUzX36UkTdZiGojgscXp5AaASJ1IKh+OZNYyPvEEHNKuU6oB/WdcMKtC33vy0fE1/QdiBuPFGOY56OR7o3l3SBGaqm+3Uyt9KUy9WqO5Bu1u7h7vuKods72kEVn2XWHH1onQOw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1595290202; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5fAIcCiENZeYUY+85HQsJ14KuCLvPFwxMbYgoCRA+QE=; 
        b=WwQolUXyJsieZ/7Tn0tsAvXERwTcTWpRuJ9RArK1CyfjvHxMwr5aEYb7V1mbU77cEBSNwZdENTuM7M96TZI7V4RsZI9BQY0UEeAgEB12qCmTf6+vVFWTTS56cF36rAKjy7hNGdhy0gv9u5hL5zXQejYmI4wb/9MYakFTCFQ5a90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-108-28-30-30.washdc.fios.verizon.net [108.28.30.30]) by mx.zohomail.com
        with SMTPS id 1595290197277736.5520462670838; Mon, 20 Jul 2020 17:09:57 -0700 (PDT)
Date:   Mon, 20 Jul 2020 23:50:28 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio: accel: bma400: add PM_SLEEP support
Message-ID: <20200720235028.GA13636@nessie>
References: <20200715050226.9751-1-dan@dlrobertson.com>
 <20200715050226.9751-2-dan@dlrobertson.com>
 <CAHp75Vc0H0C01kBsVHfmD6QbS-6Wh3R7HCua8RQ+2vHrQUqoig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc0H0C01kBsVHfmD6QbS-6Wh3R7HCua8RQ+2vHrQUqoig@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 08:44:59AM +0300, Andy Shevchenko wrote:
> On Wed, Jul 15, 2020 at 8:05 AM Dan Robertson <dan@dlrobertson.com> wrote:
> >
> >  - Add system sleep ops if CONFIG_PM_SLEEP is set.
> >  - Add attribute for setting the power mode of the
> >    device.
>=20
> ...
>=20
> > -static const struct iio_chan_spec_ext_info bma400_ext_info[] =3D {
>=20
> > -};
> > -
> > -#define BMA400_ACC_CHANNEL(_axis) { \
>=20
> > -}
> > -
> > -static const struct iio_chan_spec bma400_channels[] =3D {
>=20
> > -};
> > -
>=20
> I'm not sure how this part is related.
>=20
> ...

Moving things around for the power mode switching endpoint.

> > +static const char * const bma400_power_modes[] =3D {
> > +       "sleep",
> > +       "low-power",
> > +       "normal"
>=20
> Missed comma.
>=20
> > +};
>=20
> ...
>=20
> > +#ifdef CONFIG_PM_SLEEP
>=20
> __maybe_unused looks better.

Good point.

Thanks for the review! I'll address your comments in v2 of the patchset.

Cheers,

 - Dan

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl8WLcQACgkQRcSmUsR+
QqUdjRAAmLyPkQ0ymHHzoWgBK2vn0s2J0HXZX3nVQkPXL4iCwLOdzU5NtSG+FMBg
KGDatFJxYXZfOm2JUIo/oXWbF3v1es52Xa/3KDjv5TrPUwlOWe8XFsHe8gyZDzkt
GamOSRwNZay0tY9yAzfbjdPd1qfyjXOiosO4c9J0oXIbJsdYLPf+b7lWlXxZwPmm
BqQ5eluYdCtJ1FaBTLMAlbNGv6QTT9BIK+0T02NmUvvxO1dk+ks1luNxrpox3tL/
QwOpHWYrTmUW6+ftabtMcoFUhIa7XxZfJCLj/4S2xGMNNt1WxfzUy4YMPhuAwf9e
lSZHga0xQ/IevRqS1fwC7D47cl+Id4T7vLs0PApvCFLZ6suJ9zZ1Ne2PqJULkrJI
JroNHWZ9aU+R5k2uELza27BIaMj7KRaMFZac4/7m2FsnE2iPPvlkgT6W54r85lnh
CJDms+2aaJcR4AyRY6eHa3asgP2YSjPLUbqSwHfEc4Wes+S5NrsGrNM0oa9wOD3o
GTxomxHHqsRUfOzwgQA+tDjOem2CzjcP8jyvO2OSlBz6z9/c7MqXsab7aLCM+AD2
Ze9sx7I22keeG62jhiTDZ4+yKEMD132XGM5QqjAfeIkGcXOHJra+GETomIfeW+Dg
sjdNdkTWIXghkCrnK7+NrQTMFJWkS5uszjsmFA5f5XznkSBXGNU=
=RU+h
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
