Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8C18BE51
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 18:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgCSRkp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 13:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbgCSRkp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Mar 2020 13:40:45 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3569D2071C;
        Thu, 19 Mar 2020 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584639644;
        bh=vTCr2kLPisdR/t7hwfNP3+scoVV0sNqQmzf1paBmYoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQqGKXYu9h8ARTueekub6W+ZvjyFyGpGAIbhDN7fodLnISn9Fd/y18ht59gvh1HTp
         taLfLKSKVnJR6/bLnPEQDJ3GN4NGjIcitKZiOWRaaOyZ/ud1iKKPHSTxGUwCDKB+aG
         sesmSe9ekO0dkCJyDHDi0YsIBodYclDRgczuC/DI=
Date:   Thu, 19 Mar 2020 18:40:39 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
Message-ID: <20200319174039.GA1564882@lore-desk-wlan>
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
 <20200314124324.GA144176@lore-desk-wlan>
 <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2020-03-14 13:43, Lorenzo Bianconi wrote:
> > On Mar 11, Jimmy Assarsson wrote:
> > > Hi,
> > >=20
> > > We are working on a project where we want to connect LS6DSM (via SPI)=
, and
> > > connect LIS3MDL via the sensor hub, as I2C slave device.
> > >=20
> > > We would like to add settings/configuration for LIS3MDL, to the shub
> > > source, since currently only LIS2MDL is supported. We've made an atte=
mpt,
> > > see diff at end of this mail.
> > >=20
> > > 1. LIS2MDL only got a single full scale setting, hence it is not poss=
ible
> > >     to change. While LIS3MDL got four possible settings. Is it enough=
 to add
> > >     a corresponding function like st_lsm6dsx_shub_set_fs_val() and ca=
ll it
> > >     from st_lsm6dsx_shub_write_raw(), when mask =3D=3D IIO_CHAN_INFO_=
SCALE?
> > > 2. LIS3MDL got 8 possible ODR settings, however ST_LSM6DSX_ODR_LIST_S=
IZE is
> > >     defined to 6 (st_lsm6dsx.h). Is it fine to increase
> > >     ST_LSM6DSX_ODR_LIST_SIZE to 8? This will also affect odr_table in
> > >     struct st_lsm6dsx_settings.
> > > 3. In the patch, we've tried to copy the correct registers and values=
 from
> > >     magnetometer/st_magn_core.c, does it look ok?
> > >=20
> > > The IIO subsystem is new to use, we possibly miss fundamental knowled=
ge.
> > >=20
> > > Regards,
> > > jimmy
> >=20
> > Hi Jimmy,
> >=20
> > in order to set the full scale on LIS3MDL you can try the following pat=
ch (just
> > compiled, not tested)
> >=20
> > Regards,
> > Lorenzo
>=20
> Hi Lorenzo,
>=20
> Sorry for the late response and thanks for the patch!

Hi Jimmy,

ok, I will post the patch, thx for testing.

>=20
> The patches seems to work.
> Are there any specific tests that we should carry out?
> Via the sysfs interface, we've tested reading raw values of each channel =
and
> configuring ODR and full scale.

you can try to enable batching in the hw FIFO doing something like:

$echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_x_en
$echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_y_en
$echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_z_en
$echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_timestamp_en

$watermark=3D64
$echo $((2*watermark)) > /sys/bus/iio/devices/<iio-magn>/buffer/length
$echo $watermark > /sys/bus/iio/devices/<iio-magn>/buffer/watermark

$generic_buffer -gn lsm6dsm_magn -c <# of samples>

Regards,
Lorenzo

>=20
> Regards,
> jimmy
>=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index 64ef07a30726..fec1dbd5f00d 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -518,6 +518,36 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
> >   	return ret;
> >   }
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
> >   static int
> >   st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> >   			  struct iio_chan_spec const *chan,
> > @@ -552,6 +582,9 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> >   		}
> >   		break;
> >   	}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		err =3D st_lsm6dsx_shub_set_full_scale(sensor, val2);
> > +		break;
> >   	default:
> >   		err =3D -EINVAL;
> >   		break;
> >=20
> > >=20
> > > ---
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > index eea5556..8621dba 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > @@ -88,6 +88,69 @@ static const struct st_lsm6dsx_ext_dev_settings st=
_lsm6dsx_ext_dev_table[] =3D {
> > >   			.len =3D 6,
> > >   		},
> > >   	},
> > > +	/* LIS3MDL */
> > > +	{
> > > +		.i2c_addr =3D { 0x1e },
> > > +		.wai =3D {
> > > +			.addr =3D 0x0f,
> > > +			.val =3D 0x3d,
> > > +		},
> > > +		.id =3D ST_LSM6DSX_ID_MAGN,
> > > +		.odr_table =3D {
> > > +			.reg =3D {
> > > +				.addr =3D 0x20,
> > > +				.mask =3D GENMASK(4, 2),
> > > +			},
> > > +			.odr_avl[0] =3D {  1000, 0x0 },
> > > +			.odr_avl[1] =3D {  2000, 0x1 },
> > > +			.odr_avl[2] =3D {  3000, 0x2 },
> > > +			.odr_avl[3] =3D {  5000, 0x3 },
> > > +			.odr_avl[4] =3D { 10000, 0x4 },
> > > +			.odr_avl[5] =3D { 20000, 0x5 },
> > > +			.odr_avl[6] =3D { 40000, 0x6 },
> > > +			.odr_avl[7] =3D { 80000, 0x7 },
> > > +			.odr_len =3D 8,
> > > +		},
> > > +		.fs_table =3D {
> > > +			.reg =3D {
> > > +				.addr =3D 0x21,
> > > +				.mask =3D GENMASK(6, 5),
> > > +			},
> > > +			.fs_avl[0] =3D {
> > > +				.gain =3D 146,
> > > +				.val =3D 0x00,
> > > +			}, /* 4000 uG/LSB */
> > > +			.fs_avl[1] =3D {
> > > +				.gain =3D 292,
> > > +				.val =3D 0x01,
> > > +			}, /* 8000 uG/LSB */
> > > +			.fs_avl[2] =3D {
> > > +				.gain =3D 438,
> > > +				.val =3D 0x02,
> > > +			}, /* 12000 uG/LSB */
> > > +			.fs_avl[3] =3D {
> > > +				.gain =3D 584,
> > > +				.val =3D 0x03,
> > > +			}, /* 16000 uG/LSB */
> > > +			.fs_len =3D 4,
> > > +		},
> > > +		.pwr_table =3D {
> > > +			.reg =3D {
> > > +				.addr =3D 0x22,
> > > +				.mask =3D GENMASK(1, 0),
> > > +			},
> > > +			.off_val =3D 0x2,
> > > +			.on_val =3D 0x0,
> > > +		},
> > > +		.bdu =3D {
> > > +			.addr =3D 0x24,
> > > +			.mask =3D BIT(6),
> > > +		},
> > > +		.out =3D {
> > > +			.addr =3D 0x28,
> > > +			.len =3D 6,
> > > +		},
> > > +	},
> > >   };

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXnOulAAKCRA6cBh0uS2t
rDrrAQCd+yoxxie7CMHLMg63CD9ZNE2DvjZNDicJJMSti5wmjwD/ZgykRvronoaw
0edhQjKgiff0Y/mdQvP1lUMo2cYN+g8=
=03j3
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
