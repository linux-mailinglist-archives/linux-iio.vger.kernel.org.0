Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD78B3B74
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfIPNdC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 09:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfIPNdC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 09:33:02 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD85120644;
        Mon, 16 Sep 2019 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568640780;
        bh=IxKQzfbdpR6+BMTEsKaJV4mIjJGZiHWHCloesF4UWVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z23JPpo7UHKKT3cNAGoxRdgmsros/fM6/Wu6Sfc7kRHwXHEsWbCNb3lX9ZhqXH2ms
         8V2Mu64pWHqgJlx+MnWffgqBE0YBpIMPzVip4k7em0x4RLB6oSWbbr7KuB8+lz9sxh
         m57yqgVKhcy6qJKikzfyMroyOuCDkTe29wGWtB70=
Date:   Mon, 16 Sep 2019 15:32:55 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v9 6/6] iio: imu: st_lsm6dsx: filter motion events in
 driver
Message-ID: <20190916133255.GE16063@localhost.localdomain>
References: <20190916123456.1742253-1-sean@geanix.com>
 <20190916123456.1742253-6-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <20190916123456.1742253-6-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Do not report non enabled motion events.
> Wakeup will still be on all channels as it's not possible to do the
> filtering in hw.

I do not see why we need a different patch to take care of this, I think th=
is
patch should be squashed with patch 2/6 and 5/6

>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 38 +++++++++++++++-----
>  2 files changed, 31 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 0a782af9445b..fd02d0e184f3 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -360,7 +360,7 @@ struct st_lsm6dsx_hw {
>  	u8 sip;
> =20
>  	u8 event_threshold;
> -	bool enable_event;
> +	u8 enable_event;

this should be merged in patch 2/6

>  	struct st_lsm6dsx_reg irq_routing;
> =20
>  	u8 *buff;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 6b88d93dca2a..92fee4555dd5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1202,7 +1202,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6ds=
x_sensor *sensor,
>  	if (err < 0)
>  		return err;
> =20
> -	if (!hw->enable_event)
> +	if (0 =3D=3D hw->enable_event)

why do we need this?

>  		st_lsm6dsx_sensor_set_enable(sensor, false);
> =20
>  	*val =3D (s16)le16_to_cpu(data);
> @@ -1360,7 +1360,10 @@ static int st_lsm6dsx_read_event_config(struct iio=
_dev *iio_dev,
>  	if (type !=3D IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
> =20
> -	return hw->enable_event;
> +	if (hw->enable_event & BIT(chan->channel2))
> +		return 1;
> +
> +	return 0;

please just do:

	return !!(hw->enable_event & BIT(chan->channel2));

>  }
> =20
>  static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> @@ -1371,13 +1374,28 @@ static int st_lsm6dsx_write_event_config(struct i=
io_dev *iio_dev,
>  {
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	u8 enable_event;
>  	int err =3D 0;
> =20
>  	if (type !=3D IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
> =20
> -	/* do not enable events if they are already enabled */
> -	if (state && hw->enable_event)
> +	if (state) {
> +		enable_event =3D hw->enable_event | BIT(chan->channel2);
> +
> +		/* do not enable events if they are already enabled */
> +		if (hw->enable_event)
> +			goto out;
> +	} else {
> +		enable_event =3D hw->enable_event & ~BIT(chan->channel2);
> +
> +		/* only turn off sensor if no events is enabled */
> +		if (enable_event)
> +			goto out;
> +	}
> +
> +	/* stop here if no changes have been made */
> +	if (hw->enable_event =3D=3D enable_event)
>  		return 0;
> =20
>  	err =3D st_lsm6dsx_event_setup(hw, state);
> @@ -1388,7 +1406,8 @@ static int st_lsm6dsx_write_event_config(struct iio=
_dev *iio_dev,
>  	if (err < 0)
>  		return err;
> =20
> -	hw->enable_event =3D state;
> +out:
> +	hw->enable_event =3D enable_event;
> =20
>  	return 0;
>  }
> @@ -1745,7 +1764,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6d=
sx_hw *hw, int data)
>  {
>  	s64 timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> =20
> -	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> +	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
> +	    (hw->enable_event & BIT(IIO_MOD_Z)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,

this should be merged in patch 5/6

>  						  0,
> @@ -1754,7 +1774,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6d=
sx_hw *hw, int data)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if (data & hw->settings->event_settings.wakeup_src_y_mask)
> +	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
> +	    (hw->enable_event & BIT(IIO_MOD_Y)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1763,7 +1784,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6d=
sx_hw *hw, int data)
>  						  IIO_EV_DIR_EITHER),
>  						  timestamp);
> =20
> -	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
> +	    (hw->enable_event & BIT(IIO_MOD_X)))
>  		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> --=20
> 2.23.0
>=20

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX+PBAAKCRA6cBh0uS2t
rAPyAQD5xe6zyhR+M89IvwgsXpBLvORtpXJnfIjS5Hww/xr1uQD/c7NvkPo3Z48t
qKmdOCiHduxDGLaNUMLCJ5G+aONUgwM=
=Yiws
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
