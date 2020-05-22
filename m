Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE7F1DE703
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgEVMhZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 08:37:25 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17346 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEVMhZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 08:37:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590151021; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hrktIqzAJv9FqVY5Ikr5sqX2LE0lcYlc/1JMo44Wfn/Rv80T3msq8wCapWT6Y81fhRtHhqEKdoTeFQ51wbxV171UQ7mFK3C0U/gIscZkzAdK+bqiubMHAqtE9zbWllVo21z436M51VMWhhNywLqrUgYg2hD5rKAkTL9107VXFok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1590151021; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=mZ1e0SXgvMzbRIQI4bvRhkr1mCC9QcS23a6YhVvzefw=; 
        b=GA68pHH+pV1itIEBKJUJOewbGn2QiZDIAu++YlOPyqMJ5m45xdJBwDSBiSk/hh6t6SbGChh2+xfpfbYLCUWhVsBwxoC5U6Nrops9/q5v5PdDy9h6BwAAO4QT0PCrgSb+Fsy23oeMx8Kntl/gvMn5GI8FEtoK93NJ/m0i12w5Ecw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-96-255-47-18.washdc.fios.verizon.net [96.255.47.18]) by mx.zohomail.com
        with SMTPS id 1590151019691533.96810357392; Fri, 22 May 2020 05:36:59 -0700 (PDT)
Date:   Fri, 22 May 2020 12:36:55 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio: accel: bma400: add support for bma400 spi
Message-ID: <20200522123655.GA28754@gothmog.test>
References: <20200522014634.28505-1-dan@dlrobertson.com>
 <20200522014634.28505-2-dan@dlrobertson.com>
 <CAHp75Ve-ub+CAo2Q3XEAL1diph+7EVh=3L-wdnst-WJ8aM6Yxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve-ub+CAo2Q3XEAL1diph+7EVh=3L-wdnst-WJ8aM6Yxg@mail.gmail.com>
X-Zoho-Virus-Status: 2
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 11:50:37AM +0300, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 4:48 AM Dan Robertson <dan@dlrobertson.com> wrote:
> >
> > Add basic support for the Bosch Sensortec BMA400 3-axes ultra-low power
> > accelerometer when configured to use SPI.
>=20
> ...
>=20
> >         tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> >         select REGMAP
> >         select BMA400_I2C if I2C
>=20
> > +       select BMA400_SPI if I2C
>=20
> This is not right.

Will fix in the second version.

> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
>=20
> What's the point of dups (see below)?

An error on my part.

> > +#define BMA400_SPI_READ_BUFFER_SIZE (BMA400_MAX_SPI_READ + 1)
>=20
> Do wee need separate macro? It seems longer than explicit use.
> Do we need the original macro either?

I was just trying to avoid magic values. I have no problem with removing th=
is
though.

> > +       /*
> > +        * TODO(dlrobertson): What is a reasonable length to cap
> > +        * this at.
> > +        */
>=20
> Either drop this or fulfill. There is no way to leave such in the
> non-staging code.

I'll drop this in the next patchset version if we stick with regmap_bus
implementation. We never read more than two bytes in bma400_core, so
this size should be fine.

> > +       .read_flag_mask =3D BIT(7),
>=20
> #include <linux/bits.h>

Good catch.

Thanks for the review. I will make the changes for the next patchset versio=
n.

Cheers,

 - Dan

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJlBAABCABPFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl7Hx2IxFIAAAAAAFQAT
cGthLWFkZHJlc3NAZ251cGcub3JnZGFuQGRscm9iZXJ0c29uLmNvbQAKCRBFxKZS
xH5CpW/FEAChmvcfsfqSkjv2hBtVIhE3XCokeVnBfQGgmmRjptLCl2Oi9DsPgPqE
eeq6Fw1d3ud+MNGXa4aE+M6KMkPKcipNWjrGvjGOxqkdh9IUioNCdhO5eLRakf2p
8oYI21/GGrclORGghigzQhQB+8TTY/csqhmoNp5VYx/6L2F6DMayjZS/c8pb44cW
a38FLwak0lkOU5ovi3w6lfqftN8FzcSv5lF7miG+FPKPkwFRxynjXfqWxYcCwEPS
e0An5DQt6Xe3dBoLazV4Sn9Olhr9v24EH9a1ya5l33ZRIDJHiHT/gJrTkNKwldrh
dOjOGmonQBE3jVUlBm94FqCq4ZQ+VRu7paJEouQRCI99Fj77vbVfx+THUAa3d+ZL
yTb/mqif7IdseG2hJcMDVPaKBfagWeXVStD/Kjz7qw/TU4Lv93agH3FwlCACWAhW
vQLUAOEg+eRb7369w9Clhe6V4+qrj7G+FKUziXgGgkmiN1wa0jQM8nkjqRjmqLoR
Y6CbHeQHAxNDc6KNifsb9jrwWxSSEPVfN3vTIzPOXqYgTWw4Ncrkkos8GvAFyba9
xn6aQwzSHvjw4na+oA0q4dt8hyUxhLlN5IFoYaj2axqxdIfvjRMLsn/2s6NsKcmU
qDjF/L2YTgM8B7mN3GrdWcukpvHNUOTJOkYn2yCcncyrlOh6t7dddQ==
=cjpz
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
