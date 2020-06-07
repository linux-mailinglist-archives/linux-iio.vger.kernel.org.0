Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D11F1046
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 00:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgFGWd6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 18:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgFGWd6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 18:33:58 -0400
Received: from localhost (unknown [151.48.128.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102CB206F6;
        Sun,  7 Jun 2020 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591569236;
        bh=OuhXRnz1XUwkcOeWescU0cHhWP6Nx48Q8GrFaKy7d0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNqT2TPCUWR1Dj4PY4oWWKUDUSbAdiiD/5LVX05yZ7kvDZLwO4LjSSAdcJ9YRLuwZ
         90KEOMJtuk5BKcMiDVB60thoY3Vd/0f/ouqy+Q5Dt4lO/PGwwq3qF/cnjdBFDAguXR
         x3OKeP8rcS2PC73/gH/BDxSdlHQJ0TMsCI2TWAlA=
Date:   Mon, 8 Jun 2020 00:33:51 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 19/32] iio:imu:st_lsm6dsx Fix alignment and data leak
 issues
Message-ID: <20200607223351.GB893522@lore-desk.lan>
References: <20200607155408.958437-1-jic23@kernel.org>
 <20200607155408.958437-20-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <20200607155408.958437-20-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a set of suitable structures in the iio_priv() data.
>=20
> This data is allocated with kzalloc so no data can leak apart from
> previous readings.
>=20
> For the tagged path the data is aligned by using __aligned(8) for
> the buffer on the stack.
>=20
> There has been a lot of churn in this driver, so likely backports
> may be needed for stable.

Hi Jonathan,

I added just some nitpicks inline, but it seems to me the patch is fine.
I guess we can address them with a followup patch if you agree, no need to
resend this huge series :)

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  5 +++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 36 ++++++++++---------
>  2 files changed, 25 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index b56df409ed0f..5f821ef467da 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -411,6 +411,11 @@ struct st_lsm6dsx_hw {
>  	const struct st_lsm6dsx_settings *settings;
> =20
>  	struct iio_mount_matrix orientation;
> +	/* Ensure natural alignment of buffer elements */
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} gyro_scan, acc_scan, ext_scan;
>  };

it seems to me doing something like:

struct {
	__le16 channels[3];
	s64 ts __aligned(8);
} scan[3];

would be better if for example we want to add support for more external dev=
ices
for untagged FIFO devices

> =20
>  static __maybe_unused const struct iio_event_spec st_lsm6dsx_event =3D {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index afd00daeefb2..bebbc2bb37f7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -341,9 +341,6 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
>  	u16 fifo_len, pattern_len =3D hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
>  	u16 fifo_diff_mask =3D hw->settings->fifo_ops.fifo_diff.mask;
> -	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> -	u8 acc_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
> -	u8 ext_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
>  	bool reset_ts =3D false;
>  	__le16 fifo_status;
>  	s64 ts =3D 0;
> @@ -404,19 +401,22 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> =20
>  		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
>  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> -				memcpy(gyro_buff, &hw->buff[offset],
> -				       ST_LSM6DSX_SAMPLE_SIZE);
> -				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> +				memcpy(hw->gyro_scan.channels,
> +				       &hw->buff[offset],
> +				       sizeof(hw->gyro_scan.channels));
> +				offset +=3D sizeof(hw->gyro_scan.channels);
>  			}
>  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> -				memcpy(acc_buff, &hw->buff[offset],
> -				       ST_LSM6DSX_SAMPLE_SIZE);
> -				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> +				memcpy(hw->acc_scan.channels,
> +				       &hw->buff[offset],
> +				       sizeof(hw->acc_scan.channels));
> +				offset +=3D sizeof(hw->acc_scan.channels);
>  			}
>  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> -				memcpy(ext_buff, &hw->buff[offset],
> -				       ST_LSM6DSX_SAMPLE_SIZE);
> -				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
> +				memcpy(hw->ext_scan.channels,
> +				       &hw->buff[offset],
> +				       sizeof(hw->ext_scan.channels));
> +				offset +=3D sizeof(hw->ext_scan.channels);
>  			}
> =20
>  			if (ts_sip-- > 0) {
> @@ -446,19 +446,22 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
>  				iio_push_to_buffers_with_timestamp(
>  					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> -					gyro_buff, gyro_sensor->ts_ref + ts);
> +					&hw->gyro_scan,
> +					gyro_sensor->ts_ref + ts);
>  				gyro_sip--;
>  			}
>  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
>  				iio_push_to_buffers_with_timestamp(
>  					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> -					acc_buff, acc_sensor->ts_ref + ts);
> +					&hw->acc_scan,
> +					acc_sensor->ts_ref + ts);
>  				acc_sip--;
>  			}
>  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
>  				iio_push_to_buffers_with_timestamp(
>  					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
> -					ext_buff, ext_sensor->ts_ref + ts);
> +					&hw->ext_scan,
> +					ext_sensor->ts_ref + ts);
>  				ext_sip--;
>  			}
>  			sip++;
> @@ -543,7 +546,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw =
*hw)
>  {
>  	u16 pattern_len =3D hw->sip * ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
>  	u16 fifo_len, fifo_diff_mask;
> -	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE], tag;
> +	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);

here we can use hw->scan[0] and drop the array on the stack

> +	u8 tag;
>  	bool reset_ts =3D false;
>  	int i, err, read_len;
>  	__le16 fifo_status;
> --=20
> 2.26.2
>=20

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXt1rTAAKCRA6cBh0uS2t
rHk1AQCtQUkajfC6T7FtQZw1H6IB6ZNOU5/dQ86cUO989gCH7gD6A/oTRgWIWI5X
q912sYFIyrMVzh21OkgfBhlnRxv77gk=
=X+8R
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
