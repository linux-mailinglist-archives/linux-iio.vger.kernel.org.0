Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF3185C3D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgCOMFU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgCOMFU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:05:20 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3830205ED;
        Sun, 15 Mar 2020 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584273919;
        bh=8IG8Ep/kbCUBwYVCO/EWT4DDma5YWKTeG1W1i68y/kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+fxg/rTu6esvyDSYYAm00BMnSZ2CMQYTb+RxZ+Ux7Olyi9W6hRIg6Gi2abNZPD53
         YPbScAoktfLWAYfPVf8LlHNOGf4iIRLL5WfJwPQEIXu206XPXmQjMF0W6rdwVC0zxP
         wmmUB1GKjf5ofI2i6rINVVaC7/l9o2gR9aX3hpck=
Date:   Sun, 15 Mar 2020 13:05:13 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: fix read misalignment on
 untagged FIFO
Message-ID: <20200315120513.GA1580958@lore-desk-wlan>
References: <cover.1584121851.git.lorenzo@kernel.org>
 <f9cdf1a1f69013417a5aaaf11a548e9585bdac20.1584121851.git.lorenzo@kernel.org>
 <20200315111151.6bb864eb@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200315111151.6bb864eb@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 15, Jonathan Cameron wrote:
> On Fri, 13 Mar 2020 18:54:41 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > st_lsm6dsx suffers of a read misalignment on untagged FIFO when
> > all 3 supported sensors (accel, gyro and ext device) are running
> > at different ODRs (the use-case is reported in the LSM6DSM Application
> > Note at pag 100).
> > Fix the issue taking into account decimation factor reading the FIFO
> > pattern.
> >=20
> > Fixes: e485e2a2cfd6 ("iio: imu: st_lsm6dsx: enable sensor-hub support f=
or lsm6dsm")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Queued up.  Not totally sure which branch this will through, but may
> well be in next merge window because of timing.

I guess on the stable branch since e485e2a2cfd6 is already in Linus's tree

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 ++
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 +++++++++++++------
> >  2 files changed, 18 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index f2113a63721a..e9e756b1e92f 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -337,6 +337,7 @@ enum st_lsm6dsx_fifo_mode {
> >   * @gain: Configured sensor sensitivity.
> >   * @odr: Output data rate of the sensor [Hz].
> >   * @watermark: Sensor watermark level.
> > + * @decimator: Sensor decimation factor.
> >   * @sip: Number of samples in a given pattern.
> >   * @ts_ref: Sensor timestamp reference for hw one.
> >   * @ext_info: Sensor settings if it is connected to i2c controller
> > @@ -350,6 +351,7 @@ struct st_lsm6dsx_sensor {
> >  	u32 odr;
> > =20
> >  	u16 watermark;
> > +	u8 decimator;
> >  	u8 sip;
> >  	s64 ts_ref;
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index bb899345f2bb..afd00daeefb2 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -93,6 +93,7 @@ st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor=
 *sensor, u32 max_odr)
> >  			break;
> >  	}
> > =20
> > +	sensor->decimator =3D decimator;
> >  	return i =3D=3D max_size ? 0 : st_lsm6dsx_decimator_table[i].val;
> >  }
> > =20
> > @@ -337,7 +338,7 @@ static inline int st_lsm6dsx_read_block(struct st_l=
sm6dsx_hw *hw, u8 addr,
> >  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  {
> >  	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor, *ext_sensor =3D N=
ULL;
> > -	int err, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
> > +	int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
> >  	u16 fifo_len, pattern_len =3D hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
> >  	u16 fifo_diff_mask =3D hw->settings->fifo_ops.fifo_diff.mask;
> >  	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> > @@ -399,19 +400,20 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  		acc_sip =3D acc_sensor->sip;
> >  		ts_sip =3D hw->ts_sip;
> >  		offset =3D 0;
> > +		sip =3D 0;
> > =20
> >  		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
> > -			if (gyro_sip > 0) {
> > +			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> >  				memcpy(gyro_buff, &hw->buff[offset],
> >  				       ST_LSM6DSX_SAMPLE_SIZE);
> >  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> >  			}
> > -			if (acc_sip > 0) {
> > +			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> >  				memcpy(acc_buff, &hw->buff[offset],
> >  				       ST_LSM6DSX_SAMPLE_SIZE);
> >  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> >  			}
> > -			if (ext_sip > 0) {
> > +			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> >  				memcpy(ext_buff, &hw->buff[offset],
> >  				       ST_LSM6DSX_SAMPLE_SIZE);
> >  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> > @@ -441,18 +443,25 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> >  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> >  			}
> > =20
> > -			if (gyro_sip-- > 0)
> > +			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> >  				iio_push_to_buffers_with_timestamp(
> >  					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> >  					gyro_buff, gyro_sensor->ts_ref + ts);
> > -			if (acc_sip-- > 0)
> > +				gyro_sip--;
> > +			}
> > +			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> >  				iio_push_to_buffers_with_timestamp(
> >  					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> >  					acc_buff, acc_sensor->ts_ref + ts);
> > -			if (ext_sip-- > 0)
> > +				acc_sip--;
> > +			}
> > +			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> >  				iio_push_to_buffers_with_timestamp(
> >  					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
> >  					ext_buff, ext_sensor->ts_ref + ts);
> > +				ext_sip--;
> > +			}
> > +			sip++;
> >  		}
> >  	}
> > =20
>=20

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXm4Z9wAKCRA6cBh0uS2t
rPlOAQCj6MCCzc3i04Rc9YPHnptXmM77V+w/MiDhshjJL/MUqQEAoRg8xmZDK8pS
o6qGVPJUjzQ+w3cCdjcn7cjmdEgM6A0=
=O9kh
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
