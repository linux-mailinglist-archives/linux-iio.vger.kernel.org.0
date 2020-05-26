Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B779A1E1CB2
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgEZH6p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 03:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgEZH6o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 03:58:44 -0400
Received: from localhost (unknown [151.48.148.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A155420776;
        Tue, 26 May 2020 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590479924;
        bh=cEw7GU/Aav18Stu0BxZAhO0SbWlo730gE5xj8ej963U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQNXfRxWe+UhsxUSgMZYGvdGQKQ6A9UujqzBYtyuZVgAMNCsFNRe5P9up+BcM1W+y
         X/s/+UG8duWY9tr/6xzCOxDcJRcAlqBWBzH0ytCgW1QTUWc8T2BHK5dX2Z6gjCDE97
         zJpDaXlVA7jEej27Rmp1w3j/L3BRBM9AZDK/H78E=
Date:   Tue, 26 May 2020 09:58:38 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 12/25] iio:imu:st_lsm6dsx Fix alignment and data leak
 issues
Message-ID: <20200526075838.GC339643@localhost.localdomain>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-13-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20200525170628.503283-13-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Y5rl02BVI9TCfPar
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
> There has been a lot of churn in this driver, so likely backports
> may be needed for stable.
>=20
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  5 ++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 27 ++++++++++---------
>  2 files changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index b56df409ed0f..5bc724eadc83 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -411,6 +411,11 @@ struct st_lsm6dsx_hw {
>  	const struct st_lsm6dsx_settings *settings;
> =20
>  	struct iio_mount_matrix orientation;
> +	/* Ensure natural alignment of buffer elements */
> +	struct {
> +		__le16 channels[3];
> +		s64 ts;
> +	} gyro_scan, acc_scan, ext_scan;
>  };
> =20
>  static __maybe_unused const struct iio_event_spec st_lsm6dsx_event =3D {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index afd00daeefb2..9bcffbfac797 100644
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
> @@ -404,18 +401,21 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> =20
>  		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
>  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> -				memcpy(gyro_buff, &hw->buff[offset],
> -				       ST_LSM6DSX_SAMPLE_SIZE);
> +				memcpy(hw->gyro_scan.channels,
> +				       &hw->buff[offset],
> +				       sizeof(hw->gyro_scan.channels));
>  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;

what about doing?

offset +=3D sizeof(hw->gyro_scan.channels)

it seems easier to follow, what do you think?

>  			}
>  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> -				memcpy(acc_buff, &hw->buff[offset],
> -				       ST_LSM6DSX_SAMPLE_SIZE);
> +				memcpy(hw->acc_scan.channels,
> +				       &hw->buff[offset],
> +				       sizeof(hw->acc_scan.channels));
>  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;

same here

>  			}
>  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> -				memcpy(ext_buff, &hw->buff[offset],
> -				       ST_LSM6DSX_SAMPLE_SIZE);
> +				memcpy(hw->ext_scan.channels,
> +				       &hw->buff[offset],
> +				       sizeof(hw->ext_scan.channels));
>  				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;

same here

Regards,
Lorenzo

>  			}
> =20
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
> --=20
> 2.26.2
>=20

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXszMKwAKCRA6cBh0uS2t
rPLsAQC2yFO0RFkpjCIul/nFRICNzlB5a1rj6/pvhMGElw4nmwD9HQ8+w55PruFz
Fra5BkLOn8HDzHRj7qv2Zib7W3S09g4=
=z+oC
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
