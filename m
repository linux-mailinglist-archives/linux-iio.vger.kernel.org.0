Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1619E58F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgDDObY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 10:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDDObX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:31:23 -0400
Received: from localhost.localdomain (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2648020659;
        Sat,  4 Apr 2020 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586010683;
        bh=3VhPNL0Qs/YptoRCzkNM9hN9avbBdpWkh8+9XzbsEFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/w3qBAJ2acokCO86qR96PhybKdjgLuE+F9Znivr9C0NavDXsxB+GglhDpwpbONYW
         XPFpcvgQjPDp7jhDzzQcAXEMOAkqsGzMFnWGV9XgPAvEFxUnVu1Wi/DStqBD+s4QiD
         oj0bxHzu0vk7uD6RhqNpoWpW1XnSaqkIsS6jxpxM=
Date:   Sat, 4 Apr 2020 16:31:18 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jimmyassarsson@gmail.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: configure full scale on slave
 device if supported
Message-ID: <20200404143118.GE629474@localhost.localdomain>
References: <cb3059b1ef8a5f0ebbd68a11db9931d6a2e4f44d.1584651650.git.lorenzo@kernel.org>
 <20200404152415.53cc596e@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
In-Reply-To: <20200404152415.53cc596e@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 19 Mar 2020 22:02:45 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Introduce st_lsm6dsx_shub_set_full_scale routine in order to configure
> > the i2c slave device sensitivity
> >=20
> > Tested-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> I've lost track of what is going on around this driver.
> One thing is clear though, this doesn't currently apply to my togreg
> tree.  I'll assume that's because I'm missing something (maybe a fix,
> or maybe another series).
>=20
> Give me a poke if I seem to have lost this in a few weeks once all the
> trees catch up properly after the merge window.
>=20
> Thanks,
>=20
> Jonathan

Hi Jonathan,

since this is not a fix but a new feature, does it apply to your testing tr=
ee?
Anyway I guess this patch is important when you apply LIS3MDL support to se=
nsor
hub driver.
https://patchwork.kernel.org/patch/11463761/

Regards,
Lorenzo

>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 33 ++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index 64ef07a30726..fec1dbd5f00d 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -518,6 +518,36 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
> >  	return ret;
> >  }
> > =20
> > +static int
> > +st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
> > +			       u32 gain)
> > +{
> > +	const struct st_lsm6dsx_fs_table_entry *fs_table;
> > +	int i, err;
> > +
> > +	fs_table =3D &sensor->ext_info.settings->fs_table;
> > +	if (!fs_table->reg.addr)
> > +		return -ENOTSUPP;
> > +
> > +	for (i =3D 0; i < fs_table->fs_len; i++) {
> > +		if (fs_table->fs_avl[i].gain =3D=3D gain)
> > +			break;
> > +	}
> > +
> > +	if (i =3D=3D fs_table->fs_len)
> > +		return -EINVAL;
> > +
> > +	err =3D st_lsm6dsx_shub_write_with_mask(sensor, fs_table->reg.addr,
> > +					      fs_table->reg.mask,
> > +					      fs_table->fs_avl[i].val);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	sensor->gain =3D gain;
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> >  			  struct iio_chan_spec const *chan,
> > @@ -552,6 +582,9 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> >  		}
> >  		break;
> >  	}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		err =3D st_lsm6dsx_shub_set_full_scale(sensor, val2);
> > +		break;
> >  	default:
> >  		err =3D -EINVAL;
> >  		break;
>=20

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXoiaMwAKCRA6cBh0uS2t
rEjsAP9Dm2NOXerxHGd/r2wXDAJ2uY156jFPuHGusR3RmivlvAD+KUVCZtIYEJRp
1nxIrd3q2Khn1Wac2ok3MYA1oy3noQE=
=I/fH
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
