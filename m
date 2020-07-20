Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AD227382
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 02:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGUANR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 20:13:17 -0400
Received: from sender4-op-o17.zoho.com ([136.143.188.17]:17718 "EHLO
        sender4-op-o17.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGUANQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 20:13:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1595290376; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=c04feixwmw0ORsyd7m6B9G7PbELzILNo1izJv3+LCP3dglJYVTFxXvy+dcJlehp1uM8hzoyi50oaujpJBlaaSSQ25L/CiJ8vFs/MyGnpCck40vBGvX72q925DfKkOC2npphZr+lBoG/sTknAzZmRnhs9FAJ+ZFa2DXGy+6S3sJQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1595290376; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=HBh18ZeFYGnXvJ8nPFVO1avWOOm1oiKqv5JY3tNV4Xs=; 
        b=IwSkvm6kQl4ld7f40chb0UEqxP8+cCk1bnAZFdc48rqdNimf4EO1KNk1Y3uvhC0QJhKpGKivGvwiBKWUbcHG8UZ9wZega82dEvsY971h7obstDqdiD7XA0DfEM3B5C2gQdtUUMaBCU7zS1yrQ/hAPA0tIjYwYbs34wmO5C20/2Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-108-28-30-30.washdc.fios.verizon.net [108.28.30.30]) by mx.zohomail.com
        with SMTPS id 1595290372884776.3553577938961; Mon, 20 Jul 2020 17:12:52 -0700 (PDT)
Date:   Mon, 20 Jul 2020 23:53:25 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: accel: bma400: add PM_SLEEP support
Message-ID: <20200720235325.GB13636@nessie>
References: <20200715050226.9751-1-dan@dlrobertson.com>
 <20200715050226.9751-2-dan@dlrobertson.com>
 <20200720122352.56846215@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20200720122352.56846215@archlinux>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 12:23:52PM +0100, Jonathan Cameron wrote:
> On Wed, 15 Jul 2020 01:02:26 -0400
> Dan Robertson <dan@dlrobertson.com> wrote:
>=20
> >  - Add system sleep ops if CONFIG_PM_SLEEP is set.
> >  - Add attribute for setting the power mode of the
> >    device.
>=20
> This second part is a problem because power modes tend to be extremely
> device specific.  Hence generic userspace is near impossible.
>=20
> So what we try to do is to map these as much as possible to
> things that the driver can figure out for itself, such as switching
> parameters of how things are captured (sampling frequency etc) or
> runtime pm.
>=20
> Whilst this may not cover 'all' usecases, it will cover a lot more
> than implementing a custom attribute.

That makes sense. I'll drop this for now and think about it a bit, but
I think runtime pm would make sense.

>=20
> As a side note, a custom attribute also need Docs
> in Documentation/ABI/testing/sysfs-bus-iio-*
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> >=20
> > Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> > ---
> >  drivers/iio/accel/bma400.h      |   3 +
> >  drivers/iio/accel/bma400_core.c | 132 ++++++++++++++++++++++++--------
> >  drivers/iio/accel/bma400_i2c.c  |   1 +
> >  drivers/iio/accel/bma400_spi.c  |   1 +
> >  4 files changed, 107 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index 5ad10db9819f..e9dd9e918aac 100644
> > --- a/drivers/iio/accel/bma400.h
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -10,6 +10,7 @@
> >  #define _BMA400_H_
> > =20
> >  #include <linux/bits.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> > =20
> >  /*
> > @@ -96,4 +97,6 @@ int bma400_probe(struct device *dev, struct regmap *r=
egmap, const char *name);
> > =20
> >  int bma400_remove(struct device *dev);
> > =20
> > +extern const struct dev_pm_ops bma400_pm_ops;
> > +
> >  #endif
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400=
_core.c
> > index cc77f89c048b..5af57b8e1fd7 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -147,36 +147,6 @@ bma400_accel_get_mount_matrix(const struct iio_dev=
 *indio_dev,
> >  	return &data->orientation;
> >  }
> > =20
> > -static const struct iio_chan_spec_ext_info bma400_ext_info[] =3D {
> > -	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
> > -	{ }
> > -};
>=20
> It would be helpful to do this reorganizing as a precursor patch where
> nothing functional changes.   Then we can see very quickly what is new
> in the functional changes.

I'll drop it for now. It isn't needed without the custom attribute.

> > -
> > -#define BMA400_ACC_CHANNEL(_axis) { \
> > -	.type =3D IIO_ACCEL, \
> > -	.modified =3D 1, \
> > -	.channel2 =3D IIO_MOD_##_axis, \
> > -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> > -	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > -		BIT(IIO_CHAN_INFO_SCALE) | \
> > -		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> > -	.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) =
| \
> > -		BIT(IIO_CHAN_INFO_SCALE) | \
> > -		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> > -	.ext_info =3D bma400_ext_info, \
> > -}
> > -
> > -static const struct iio_chan_spec bma400_channels[] =3D {
> > -	BMA400_ACC_CHANNEL(X),
> > -	BMA400_ACC_CHANNEL(Y),
> > -	BMA400_ACC_CHANNEL(Z),
> > -	{
> > -		.type =3D IIO_TEMP,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> > -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > -	},
> > -};
> > -
> >  static int bma400_get_temp_reg(struct bma400_data *data, int *val, int=
 *val2)
> >  {
> >  	unsigned int raw_temp;
> > @@ -542,6 +512,73 @@ static int bma400_set_power_mode(struct bma400_dat=
a *data,
> >  	return 0;
> >  }
> > =20
> > +static const char * const bma400_power_modes[] =3D {
> > +	"sleep",
> > +	"low-power",
> > +	"normal"
> > +};
> > +
> > +int bma400_power_mode_enum_get(struct iio_dev *dev,
> > +			       const struct iio_chan_spec *chan)
> > +{
> > +	struct bma400_data *data =3D iio_priv(dev);
> > +
> > +	return data->power_mode;
> > +}
> > +
> > +int bma400_power_mode_enum_set(struct iio_dev *dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       unsigned int mode)
> > +{
> > +	struct bma400_data *data =3D iio_priv(dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret =3D bma400_set_power_mode(data, mode);
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_enum bma400_power_mode_enum =3D {
> > +	.items =3D bma400_power_modes,
> > +	.num_items =3D ARRAY_SIZE(bma400_power_modes),
> > +	.get =3D bma400_power_mode_enum_get,
> > +	.set =3D bma400_power_mode_enum_set,
> > +};
> > +
> > +static const struct iio_chan_spec_ext_info bma400_ext_info[] =3D {
> > +	IIO_ENUM("power_mode", true, &bma400_power_mode_enum),
> > +	IIO_ENUM_AVAILABLE("power_mode", &bma400_power_mode_enum),
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
> > +	{ }
> > +};
> > +
> > +#define BMA400_ACC_CHANNEL(_axis) { \
> > +	.type =3D IIO_ACCEL, \
> > +	.modified =3D 1, \
> > +	.channel2 =3D IIO_MOD_##_axis, \
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > +		BIT(IIO_CHAN_INFO_SCALE) | \
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> > +	.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) =
| \
> > +		BIT(IIO_CHAN_INFO_SCALE) | \
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> > +	.ext_info =3D bma400_ext_info, \
> > +}
> > +
> > +static const struct iio_chan_spec bma400_channels[] =3D {
> > +	BMA400_ACC_CHANNEL(X),
> > +	BMA400_ACC_CHANNEL(Y),
> > +	BMA400_ACC_CHANNEL(Z),
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +	},
> > +};
> > +
> >  static void bma400_init_tables(void)
> >  {
> >  	int raw;
> > @@ -848,6 +885,41 @@ int bma400_remove(struct device *dev)
> >  }
> >  EXPORT_SYMBOL(bma400_remove);
> > =20
> > +#ifdef CONFIG_PM_SLEEP
>=20
> Ifdef protections around PM functions tend to go wrong so usually
> better to just mark them __maybe_unused and rely on the
> linker removing them if they aren't.

Sounds good.

Cheers,

 - Dan

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl8WLnQACgkQRcSmUsR+
QqWMgQ/9E+qDTqK5UQnqRHAStva0gEpwZgRlvlJ6RidrAYBGEnPwxq5kUChEHQb6
J96pZnmtkIsLpEWCm/u3vbzirMFQPzT3iaZuhAS9A2VMR5PwFt+GCiKpfri2fBhy
M9AM76T5iK1GE/eEqkvTBBdqrNyEVAcX1JRtDe3UmzjJ87ZfroqujWzJFvob1HN4
3LQG5Pb7KO4F81SFahFo5xub/OQFS1UmuXg6lbr9utZ0owd2IGMdEtizpSkWyKV+
gsDrqeojQRE5t7+TuqTiJSdLcSNhr3yrW3wOkfo5SreC7KTvlclndVbbKCuNZBUd
/mIgA3eAjVVVXJFkVnwHmTwMeOSlh+id8NGjtlFGzaosKHWpGNdxh57+fmgf88/2
nq10HM+0l8v1zeg6C+0FaO6HfR5HwM3N0Ln2mJAOzYZTiYrX8p+S/nepxoTQ/CYF
TZDxTIwX+pijmMBS8B+0Nw6UQBAPTzZKxi76RTMZP6ODM/YQkH5ZVKORXW/kUGss
mvIzwnUXCLgykRNCvBWFjzcIyu1Lmj7Dj7NTFgtzwOZKAR2plUGR3Ehpw7fCb3hW
2v1uV+DMtvgIsDh8OsUC9aqOVOMea1tt00liOS3JrXigxJlR6aI9l0RXKa8WM4mN
IE52Vk+FQOVpyxrnMbsGraQCkuCG+nHj6i8nQDQT9m/jLnN34MY=
=hDs2
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
