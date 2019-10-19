Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEFDD63C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2019 04:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfJSC6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 22:58:44 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17468 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfJSC6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 22:58:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571453908; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MGFZxQ66JuYwlWwXHpiXSmStXv5g+YXnCWfE8N5Vx7/DhSCtNd5tzYOhbrgnh+38mWOviuL8fe1Lib90p+WSJxe8qjvVfV9pyl8s8C4t2Bhjh5v5RtR23mpM9JCkOeDnSXVJEMLxjYHw90DJMOKOxOigGZ6NDrqMh1WW/bWk92s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571453908; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nkegbizjMS9gEVufZQV4way6ZZmbUYEv8OCBnQbin2w=; 
        b=h1CuDzG9Sk6jnR760/Gy6vlKhUdl2HRpN5dhJRRttL1xlmbliyiXL4iDTB7uIbBNN/KeTYovgoBAEVlyPzBnq3uzuF86e33Hqh+M8OXdCoglwgFo5qU0WoqkMXtCQpk4JTWp4kLp0leEa8i9Y2EQppD/3gMF/cAlOEC7TZ3o/c4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1571453906541374.3479518650121; Fri, 18 Oct 2019 19:58:26 -0700 (PDT)
Date:   Sat, 19 Oct 2019 02:43:51 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191019024351.GB8593@nessie>
References: <20191018031848.18538-1-dan@dlrobertson.com>
 <20191018031848.18538-3-dan@dlrobertson.com>
 <CAHp75VfMW0fvmO9jGTnQumJ9Sm-SgNL0ohjSR4qRQY365aeMBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <CAHp75VfMW0fvmO9jGTnQumJ9Sm-SgNL0ohjSR4qRQY365aeMBw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 10:23:38AM +0300, Andy Shevchenko wrote:
> On Fri, Oct 18, 2019 at 6:44 AM Dan Robertson <dan@dlrobertson.com> wrote:
> > + * bma400.h - Register constants and other forward declarations
> > + *            needed by the bma400 sources.
>
> Including file name in the file is not the best practice. Imagine if
> by some reason we will need to rename it (to support more sensors, for
> example, and reflect it by replacing 00 -> 0x).
> So, please, remove here and everywhere else.

That makes sense.

> > +#define BMA400_TWO_BITS_MASK    0x03
> > +#define BMA400_LP_OSR_MASK      0x60
> > +#define BMA400_NP_OSR_MASK      0x30
> > +#define BMA400_ACC_ODR_MASK     0x0f
> > +#define BMA400_ACC_SCALE_MASK   0xc0
>=20
> GENMASK()
> (Don't forget to include bits.h for it)

Thanks.

> > +static const int bma400_scale_table[] =3D {
> > +       0, 38344,
> > +       0, 76590,
> > +       0, 153277,
>=20
> > +       0, 306457
>=20
> Better to leave comma here. It doesn't matter for this device, but
> make of use the better practices.
> > +};
>=20
> Also, I'm wondering why values are not exactly multiply by 2. Is in DS
> of the chip any explanation for this?

It would be a multiply by 2. I tried to follow the bma180 driver here, but =
I'm
starting to think that may be the wrong approach.

> > +static const int bma400_osr_table[] =3D { 0, 1, 3 };
>=20
> > +/* See the ACC_CONFIG1 section of the datasheet */
> > +static const int bma400_sample_freqs[] =3D {
> > +       12,  500000,
> > +       25,  0,
> > +       50,  0,
> > +       100, 0,
> > +       200, 0,
> > +       400, 0,
> > +       800, 0,
> > +};
>=20
> This can be replaced by a formula(s).

Yeah I think I can implement the get, set, and read functions for sample_fr=
eq
with a formula, but the scale and sample frequency tables are needed by the
implementation of read_avail. A implementation of read_avail with a range a=
nd
a step would be ideal, but I couldn't find any documentation on implementing
read_avail where the step value of the range is a multiple. Please correct
me if I've missed something.

Note that this applies to the scale table as well.

> > +struct bma400_sample_freq {
> > +       int hz;
> > +       int uhz;
> > +};
>=20
> I'm wondering why above table is not using this struct.

Originally it did, but I changed this in the second version when I added su=
pport
for iio_info read_avail to try to be a little closer to other implementatio=
ns of
iio_read avail.

> > +const struct regmap_config bma400_regmap_config =3D {
> > +       .reg_bits =3D 8,
> > +       .val_bits =3D 8,
> > +       .max_register =3D BMA400_CMD_REG,
> > +       .cache_type =3D REGCACHE_RBTREE,
> > +       .writeable_reg =3D bma400_is_writable_reg,
> > +       .volatile_reg =3D bma400_is_volatile_reg,
> > +};
>=20
> > +EXPORT_SYMBOL(bma400_regmap_config);
>=20
> Why? And why it's not _GPL?

This is used by the bma400_i2c module.

> > +       int ret;
> > +       int host_temp;
> > +       unsigned int raw_temp;
>=20
> Better reversed xmas tree order.

Sounds good.

>=20
> > +               if (idx + 1 >=3D ARRAY_SIZE(bma400_sample_freqs)) {
>=20
> Why do you need this churn with +1 and =3D ?

Since we've "flattened" the array of sample frequency we need to ensure tha=
t the
Hz (bma400_sample_freqs[idx]) and uHz (bma400_sample_freqs[idx + 1]) are bo=
th
valid. This will be negated in the next version as I'll switch to a formula.
Instead I'll ensure the returned ODR value is not above 0x0b.

> > +                       dev_err(data->dev, "sample freq index is too hi=
gh");
> > +                       ret =3D -EINVAL;
> > +                       goto error;
> > +               }
>=20
>=20
> > +       for (i =3D 0; i + 1 < ARRAY_SIZE(bma400_sample_freqs); i +=3D 2=
) {
>=20
> Using defined struct will guarantee you to have always 2x members in
> the array. So, drop this arithmetic churn.

I should be able to figure out how to use a formula here, but I see where y=
ou're
coming from and I agree.

> > +       if (ret < 0) {
> > +               dev_err(data->dev, "Failed to read chip id register: %x=
!", ret);
>=20
> %x for returned error code is too hackerish.

Makes sense. I'll change this in the update.

> > +               return ret;
>=20
> > +       } else if (val !=3D BMA400_ID_REG_VAL) {
>=20
> Redundant 'else'

> > +               dev_err(data->dev, "CHIP ID MISMATCH: %x!", ret);
>=20
> Hacker detected!

:)

> > +               return -ENODEV;
> > +       }
>=20
> > +               /*
> > +                * TODO: The datasheet waits 1500us here in the example=
, but
> > +                * lists 2/ODR as the wakeup time.
> > +                */
> > +               usleep_range(1500, 20000);
>=20
> These range values are too sparse. Usually the second one is less than
> first one * 2.
> Fix it now.

Good to know. I'll fix this in the update.

> > +EXPORT_SYMBOL(bma400_probe);
>=20
> Why is not GPL?

Ah, saw in the docs "GPL" means GPL-2.0.

>=20
> > +EXPORT_SYMBOL(bma400_remove);
>=20
> Ditto.

This symbol is used in bma400_i2c.

>=20
> P.S. I probably missed some places with the same mistake as commented
> above. Please address all places in the code where my comments are
> applicable.

Noted. Thanks for the feedback!

Cheers,

 - Dan

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl2qeGMACgkQRcSmUsR+
QqXlLxAAngIJqHuQPQE4Pomg3ODxV1HAm1gle9GHarijuwkUPQa91c5Atfx2hI74
4CtCl7LK/6dzwfs3uIprBJ0/ZQveMW6sdbSv4Bj3nLBAhsT6mZVKK8+MUMyEl3ZT
L12D2mPk0CZlmdEilfThA9mhMCz3sMSJ1a0P4yhxJxbF7myXqihSfMN5dVXy8NHM
jcINv020uSqWZeQxG48Z7FAMuFAWQBTFqTjWGb04fhzd35tgB2HcchYNyJbQ78ey
ofr1WFTXBKb4YQT8tzbMIDabF8p3yq6ToiTsKLPl/fwoARY3BP4bn5IzP8RQbCep
+yyVqu6UrFmfxd0Wa0qHsM5dOg02BejrjJGOTkE+J2XtK7CXYjYBB+lfhdT6vb1k
kiiqHNCNVHmqUUCDTxc08Q2/S/9PWdOIggEIuyy1CxcQPdeyZTuNDkV5XP0/fFlf
bQCrVqihyRz+4/2nXI34y8IrhqOyN6obpnd/rqhWxVqChkXo96+tPyOUT9frUab3
BAPuvL63Bq/olgZcOMbOxGhN0DCIMWHd5Tp8U+p1wFWgoMJoQilq/pgdrU3GBLZI
t8jJR9+7i4W5V4rUs/NTRIu/dUGzM/TiBqjfe9zFyWFczjWuwqKRf5Q/uL4GUAcj
6o9fKBYsf/iPcZ7yF8WayaJH2nyBK/0MfYx/RyIJlOVTLYGIUXA=
=t8Xs
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

