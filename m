Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC5B36F3
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfIPJQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbfIPJQ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 05:16:56 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E0320650;
        Mon, 16 Sep 2019 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568625416;
        bh=ULn6i/ckRirdqNTdXmH2pBa3EIf0/6T1hdDD6NJNZbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXndNj06jwVMhejlgkIHRI1gN0+QaJZLbAvrQUceaqHOCl4bPzUY8+lZ6O78smq4c
         uVm1s+V20FhNILTu1zZQP+jaaffmXNDcr7/5wtkizhnqGtroGcT9jYdKUpa9sfKem9
         kuaO++ZLJLVD1fdMeuPcPuYWua2Zf/I6tdERwF50=
Date:   Mon, 16 Sep 2019 11:16:49 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [RFC PATCH] iio: imu: st_lsm6dsx: filter motion events in driver
Message-ID: <20190916091649.GA16063@localhost.localdomain>
References: <20190915143548.25383eb4@archlinux>
 <20190916090222.597444-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20190916090222.597444-1-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Do not report non enabled motion events.
> Wakeup will still be on all channels as it's not possible to do the
> filtering in hw.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Hope it's okay to do this as an RFC. To get the most obvious stuff
> reviewed before v9
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 20 ++++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 938192212485..dd46209f94e8 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -362,6 +362,7 @@ struct st_lsm6dsx_hw {
> =20
>  	u8 event_threshold;
>  	bool enable_event;
> +	u8 event_en_mask;

I think we do not need it, you could just use enable_event as bitmask (just
convert it in u8)

>  	struct st_lsm6dsx_reg irq_routing;
> =20
>  	u8 *buff;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 7596a6ed7d97..2d66e3758921 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1377,9 +1377,12 @@ static int st_lsm6dsx_write_event_config(struct ii=
o_dev *iio_dev,
>  	if (type !=3D IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
> =20
> +	if (hw->event_en_mask & BIT(chan->channel2))
> +		goto out;

Why do we need this?

> +
>  	/* do not enable events if they are already enabled */
>  	if (state && hw->enable_event)
> -		return 0;
> +		goto out;
> =20
>  	err =3D st_lsm6dsx_event_setup(hw, state);
>  	if (err < 0)
> @@ -1391,6 +1394,12 @@ static int st_lsm6dsx_write_event_config(struct ii=
o_dev *iio_dev,
> =20
>  	hw->enable_event =3D state;
> =20
> +out:
> +	if (state)
> +		hw->event_en_mask |=3D BIT(chan->channel2);
> +	else
> +		hw->event_en_mask &=3D ~BIT(chan->channel2);

you can use enable_event here instead of event_en_mask

> +
>  	return 0;
>  }
> =20
> @@ -1746,7 +1755,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6d=
sx_hw *hw, int data)
>  {
>  	s64 timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> =20
> -	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> +	if (data & hw->settings->event_settings.wakeup_src_z_mask &&
> +	    hw->event_en_mask & BIT(IIO_MOD_Z))

please add ()=20

if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
    (hw->event_en_mask & BIT(IIO_MOD_Z))

>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1755,7 +1765,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6d=
sx_hw *hw, int data)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if (data & hw->settings->event_settings.wakeup_src_y_mask)
> +	if (data & hw->settings->event_settings.wakeup_src_y_mask &&
> +	    hw->event_en_mask & BIT(IIO_MOD_Y))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1764,7 +1775,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6d=
sx_hw *hw, int data)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +	if (data & hw->settings->event_settings.wakeup_src_x_mask &&
> +	    hw->event_en_mask & BIT(IIO_MOD_X))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> --=20
> 2.23.0
>=20

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX9S/wAKCRA6cBh0uS2t
rGZxAP0Q72/dLWE1Bx5kQFboy2ALiB1YapMZPi7XCaGUs4gxggEAjGnP0x3aScXW
a9BJUQiBFGJCy/jY2VX5aP1XcdMKSAE=
=Nr+L
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
