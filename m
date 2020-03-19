Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C79018C1AA
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCSUtn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 16:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSUtn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Mar 2020 16:49:43 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD9D2070A;
        Thu, 19 Mar 2020 20:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584650981;
        bh=vKdI6OECWy/nagyiLG5ic6EuYy2QD7omMLSKhduF+eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jymbb06NZIXwlyY/XObMkxYYA+8WCFL++X30ysXctmN2aNIzAeKYTrQJKB00izCHF
         wU4ho3l1oS74LP/yLeT5MqzrdNax8qV1ZrNg8/yrb5nZeKQVBSghKFmzIw5kwuhAOV
         pCNlLQ/WvOy9yt0oDZ9nIZrxMLwKqxJLkct3YFn8=
Date:   Thu, 19 Mar 2020 21:49:37 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
Message-ID: <20200319204937.GB1564882@lore-desk-wlan>
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
 <20200314124324.GA144176@lore-desk-wlan>
 <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
 <20200319174039.GA1564882@lore-desk-wlan>
 <ef4aa50f-4aa6-cb87-06b6-913e2abbb23c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <ef4aa50f-4aa6-cb87-06b6-913e2abbb23c@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2020-03-19 18:40, Lorenzo Bianconi wrote:
> > > On 2020-03-14 13:43, Lorenzo Bianconi wrote:
> > > > On Mar 11, Jimmy Assarsson wrote:
> > > > > Hi,
> > > > >=20

[...]

> > > > Hi Jimmy,
> > > >=20
> > > > in order to set the full scale on LIS3MDL you can try the following=
 patch (just
> > > > compiled, not tested)
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > >=20
> > > Hi Lorenzo,
> > >=20
> > > Sorry for the late response and thanks for the patch!
> >=20
> > Hi Jimmy,
> >=20
> > ok, I will post the patch, thx for testing.
>=20
> Great, you can add
> Tested-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
>=20
> > > The patches seems to work.
> > > Are there any specific tests that we should carry out?
> > > Via the sysfs interface, we've tested reading raw values of each chan=
nel and
> > > configuring ODR and full scale.
> >=20
> > you can try to enable batching in the hw FIFO doing something like:
> >=20
> > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_x_en
> > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_y_en
> > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_z_en
> > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_timestamp_en
> >=20
> > $watermark=3D64
> > $echo $((2*watermark)) > /sys/bus/iio/devices/<iio-magn>/buffer/length
> > $echo $watermark > /sys/bus/iio/devices/<iio-magn>/buffer/watermark
> >=20
> > $generic_buffer -gn lsm6dsm_magn -c <# of samples>
>=20
> Ok. I don't got any scan_elements nor buffer directory, for any of the de=
vices.
> I guess it is not possible to use the FIFO without configuring any interr=
upt?
> We got the following dts:
> &spi1 {
> 	#address-cells =3D <1>;
> 	#size-cells =3D <0>;
> 	lsm6dsm@0 {
> 		compatible =3D "st,lsm6dsm";
> 		reg =3D <0x0>;
>=20
> 		spi-max-frequency =3D <500000>;
> 		st,pullups =3D "true";

yes, you need to provide the interrupt line doing something like (this is f=
rom
the dts on my rpi):

	lsm6dsm@0 {
		...
		interrupt-parent =3D <&gpio>;
		interrupts =3D <21 0x4>;
		...
	};

> 	};
> };
>=20
> I'll look into this tomorrow or in the beginning of next week, thanks for=
 the help.
>=20
> Regards,
> jimmy
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Regards,
> > > jimmy
> > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > > index 64ef07a30726..fec1dbd5f00d 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > > @@ -518,6 +518,36 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_d=
ev,
> > > >    	return ret;
> > > >    }
> > > > +static int
> > > > +st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
> > > > +			       u32 gain)
> > > > +{
> > > > +	const struct st_lsm6dsx_fs_table_entry *fs_table;
> > > > +	int i, err;
> > > > +
> > > > +	fs_table =3D &sensor->ext_info.settings->fs_table;
> > > > +	if (!fs_table->reg.addr)
> > > > +		return -ENOTSUPP;
> > > > +
> > > > +	for (i =3D 0; i < fs_table->fs_len; i++) {
> > > > +		if (fs_table->fs_avl[i].gain =3D=3D gain)
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	if (i =3D=3D fs_table->fs_len)
> > > > +		return -EINVAL;
> > > > +
> > > > +	err =3D st_lsm6dsx_shub_write_with_mask(sensor, fs_table->reg.add=
r,
> > > > +					      fs_table->reg.mask,
> > > > +					      fs_table->fs_avl[i].val);
> > > > +	if (err < 0)
> > > > +		return err;
> > > > +
> > > > +	sensor->gain =3D gain;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >    static int
> > > >    st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> > > >    			  struct iio_chan_spec const *chan,
> > > > @@ -552,6 +582,9 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_d=
ev,
> > > >    		}
> > > >    		break;
> > > >    	}
> > > > +	case IIO_CHAN_INFO_SCALE:
> > > > +		err =3D st_lsm6dsx_shub_set_full_scale(sensor, val2);
> > > > +		break;
> > > >    	default:
> > > >    		err =3D -EINVAL;
> > > >    		break;
> > > >=20
> > > > >=20
> > > > > ---
> > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drive=
rs/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > > > index eea5556..8621dba 100644
> > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > > > @@ -88,6 +88,69 @@ static const struct st_lsm6dsx_ext_dev_setting=
s st_lsm6dsx_ext_dev_table[] =3D {
> > > > >    			.len =3D 6,
> > > > >    		},
> > > > >    	},
> > > > > +	/* LIS3MDL */
> > > > > +	{
> > > > > +		.i2c_addr =3D { 0x1e },
> > > > > +		.wai =3D {
> > > > > +			.addr =3D 0x0f,
> > > > > +			.val =3D 0x3d,
> > > > > +		},
> > > > > +		.id =3D ST_LSM6DSX_ID_MAGN,
> > > > > +		.odr_table =3D {
> > > > > +			.reg =3D {
> > > > > +				.addr =3D 0x20,
> > > > > +				.mask =3D GENMASK(4, 2),
> > > > > +			},
> > > > > +			.odr_avl[0] =3D {  1000, 0x0 },
> > > > > +			.odr_avl[1] =3D {  2000, 0x1 },
> > > > > +			.odr_avl[2] =3D {  3000, 0x2 },
> > > > > +			.odr_avl[3] =3D {  5000, 0x3 },
> > > > > +			.odr_avl[4] =3D { 10000, 0x4 },
> > > > > +			.odr_avl[5] =3D { 20000, 0x5 },
> > > > > +			.odr_avl[6] =3D { 40000, 0x6 },
> > > > > +			.odr_avl[7] =3D { 80000, 0x7 },
> > > > > +			.odr_len =3D 8,
> > > > > +		},
> > > > > +		.fs_table =3D {
> > > > > +			.reg =3D {
> > > > > +				.addr =3D 0x21,
> > > > > +				.mask =3D GENMASK(6, 5),
> > > > > +			},
> > > > > +			.fs_avl[0] =3D {
> > > > > +				.gain =3D 146,
> > > > > +				.val =3D 0x00,
> > > > > +			}, /* 4000 uG/LSB */
> > > > > +			.fs_avl[1] =3D {
> > > > > +				.gain =3D 292,
> > > > > +				.val =3D 0x01,
> > > > > +			}, /* 8000 uG/LSB */
> > > > > +			.fs_avl[2] =3D {
> > > > > +				.gain =3D 438,
> > > > > +				.val =3D 0x02,
> > > > > +			}, /* 12000 uG/LSB */
> > > > > +			.fs_avl[3] =3D {
> > > > > +				.gain =3D 584,
> > > > > +				.val =3D 0x03,
> > > > > +			}, /* 16000 uG/LSB */
> > > > > +			.fs_len =3D 4,
> > > > > +		},
> > > > > +		.pwr_table =3D {
> > > > > +			.reg =3D {
> > > > > +				.addr =3D 0x22,
> > > > > +				.mask =3D GENMASK(1, 0),
> > > > > +			},
> > > > > +			.off_val =3D 0x2,
> > > > > +			.on_val =3D 0x0,
> > > > > +		},
> > > > > +		.bdu =3D {
> > > > > +			.addr =3D 0x24,
> > > > > +			.mask =3D BIT(6),
> > > > > +		},
> > > > > +		.out =3D {
> > > > > +			.addr =3D 0x28,
> > > > > +			.len =3D 6,
> > > > > +		},
> > > > > +	},
> > > > >    };

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXnPa3gAKCRA6cBh0uS2t
rIbjAP9cgICdMRIPND+WSycKg8bT/F1IlJ8n7JKQo6soG8qSiwD/TST7zMbcRaWh
Y6/QuTecGGN6L6DTK85Rr4yi9dd/sww=
=JrRP
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
