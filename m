Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2455F6936DC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Feb 2023 11:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBLKW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Feb 2023 05:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLKW0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Feb 2023 05:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4375BB1
        for <linux-iio@vger.kernel.org>; Sun, 12 Feb 2023 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676197301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+ffbI/mVnaa3dNuBr2Nsr0yQ3UvaUYA58ZMXgXDZ9k=;
        b=ijkekk6ye3MUCUOjjM8XZXM+WJ4JirNvIiQx4xGaA+1BcUP8VobN6JWc/9hYDbzYeqzXa7
        96hjJCyFw24WuyzHjl5JJsVtoe5Q1pUV1CJJTJYvo7oFfAh9JtZRs6l1BusQBMBnBxUw9o
        OPeaz7yLuW5uE8xBAPEpQ+QdZWqWWFw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-_KaYFvb8NX2mUG0zdaM0Sw-1; Sun, 12 Feb 2023 05:21:37 -0500
X-MC-Unique: _KaYFvb8NX2mUG0zdaM0Sw-1
Received: by mail-wm1-f69.google.com with SMTP id n4-20020a05600c3b8400b003dfe223de49so7384048wms.5
        for <linux-iio@vger.kernel.org>; Sun, 12 Feb 2023 02:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+ffbI/mVnaa3dNuBr2Nsr0yQ3UvaUYA58ZMXgXDZ9k=;
        b=0ua4ENSbxeuRwnndqJy3nNlL6jjh5dwu8lT7sv3Sozy8+R4UEMb0btIOKT+CfYlODG
         rDiR91BpG8rdLpgOywe65QNwI0egGrwRr/kZ1NiKMYfs9z0UepgqMaqmu633QwY4/G37
         mXVCCP1aHjdVPS6L7kXEXgLT+KF/l/HHYacp0ewwFnrnOqGtLR872IgE8zFYI9scrAlA
         ZrKK56Ql7BjTyUZUUmn+oQX2ANcp7loM5Q8/zMfuPCVl9nYRh1/adHY39I124GZ7sBsd
         1TTf3lbFUz9LQbClh3JD0A1eMAR2JlMlMLLzzt0wVuv5jYTN4fSn6Rq5xDd/l1T+eqfh
         so5A==
X-Gm-Message-State: AO0yUKXbKmeF4AcWD0MOonU9xSwuOmDf2XfSc/8gKZ/NG4NimfPL9Rv9
        ci3zeGhEiKEWju+gBTpryyK45YGtsAjO3tGoJmoq3qOU5ftWyVxbEUQshUTdBaGny2Bd5IyT74n
        T3hBcqIt9AAkyXe5ftYKpeJUDmg==
X-Received: by 2002:a05:600c:a686:b0:3e0:fad:5fa8 with SMTP id ip6-20020a05600ca68600b003e00fad5fa8mr16474009wmb.33.1676197295825;
        Sun, 12 Feb 2023 02:21:35 -0800 (PST)
X-Google-Smtp-Source: AK7set8piOLAOEtoy9k+j48kM5RQX+N1IsjHSBB/0yaSo1DPmhsa7yd0NDkdcOYaPyAXv7sgaVp1hg==
X-Received: by 2002:a05:600c:a686:b0:3e0:fad:5fa8 with SMTP id ip6-20020a05600ca68600b003e00fad5fa8mr16474005wmb.33.1676197295590;
        Sun, 12 Feb 2023 02:21:35 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b003e00c9888besm13684677wmj.30.2023.02.12.02.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 02:21:34 -0800 (PST)
Date:   Sun, 12 Feb 2023 11:21:32 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     jic23@kernel.org, phdm@macq.eu, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
 settling time
Message-ID: <Y+i9rImVqH7iVets@lore-desk>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GI803v822S32dPiG"
Content-Disposition: inline
In-Reply-To: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GI803v822S32dPiG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> During digital filters settling time the driver is expected to drop
> samples since they can be corrupted. Introduce the capability to drop
> a given number of samples according to the configured ODR.
> Add the sample_to_discard data for LSM6DSM sensor.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 11 ++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 58 +++++++++++++++----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 18 ++++++
>  3 files changed, 77 insertions(+), 10 deletions(-)

I forgot to say I tested this patch on my LSM6DSM and it works fine for me.

Regards,
Lorenzo

>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 499fcf8875b4..8e119d78730b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -137,6 +137,13 @@ struct st_lsm6dsx_odr_table_entry {
>  	int odr_len;
>  };
> =20
> +struct st_lsm6dsx_samples_to_discard {
> +	struct {
> +		u32 milli_hz;
> +		u16 samples;
> +	} val[ST_LSM6DSX_ODR_LIST_SIZE];
> +};
> +
>  struct st_lsm6dsx_fs {
>  	u32 gain;
>  	u8 val;
> @@ -291,6 +298,7 @@ struct st_lsm6dsx_ext_dev_settings {
>   * @irq_config: interrupts related registers.
>   * @drdy_mask: register info for data-ready mask (addr + mask).
>   * @odr_table: Hw sensors odr table (Hz + val).
> + * @samples_to_discard: Number of samples to discard for filters settlin=
g time.
>   * @fs_table: Hw sensors gain table (gain + val).
>   * @decimator: List of decimator register info (addr + mask).
>   * @batch: List of FIFO batching register info (addr + mask).
> @@ -323,6 +331,7 @@ struct st_lsm6dsx_settings {
>  	} irq_config;
>  	struct st_lsm6dsx_reg drdy_mask;
>  	struct st_lsm6dsx_odr_table_entry odr_table[2];
> +	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
>  	struct st_lsm6dsx_fs_table_entry fs_table[2];
>  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> @@ -353,6 +362,7 @@ enum st_lsm6dsx_fifo_mode {
>   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
>   * @gain: Configured sensor sensitivity.
>   * @odr: Output data rate of the sensor [Hz].
> + * @samples_to_discard: Number of samples to discard for filters settlin=
g time.
>   * @watermark: Sensor watermark level.
>   * @decimator: Sensor decimation factor.
>   * @sip: Number of samples in a given pattern.
> @@ -367,6 +377,7 @@ struct st_lsm6dsx_sensor {
>  	u32 gain;
>  	u32 odr;
> =20
> +	u16 samples_to_discard;
>  	u16 watermark;
>  	u8 decimator;
>  	u8 sip;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 7dd5205aea5b..c1059a79f5ff 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -457,17 +457,29 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  			}
> =20
>  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> -				iio_push_to_buffers_with_timestamp(
> -					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> -					&hw->scan[ST_LSM6DSX_ID_GYRO],
> -					gyro_sensor->ts_ref + ts);
> +				/* We need to discards gyro samples during
> +				 * filters settling time
> +				 */
> +				if (gyro_sensor->samples_to_discard > 0)
> +					gyro_sensor->samples_to_discard--;
> +				else
> +					iio_push_to_buffers_with_timestamp(
> +						hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> +						&hw->scan[ST_LSM6DSX_ID_GYRO],
> +						gyro_sensor->ts_ref + ts);
>  				gyro_sip--;
>  			}
>  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> -				iio_push_to_buffers_with_timestamp(
> -					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> -					&hw->scan[ST_LSM6DSX_ID_ACC],
> -					acc_sensor->ts_ref + ts);
> +				/* We need to discards accel samples during
> +				 * filters settling time
> +				 */
> +				if (acc_sensor->samples_to_discard > 0)
> +					acc_sensor->samples_to_discard--;
> +				else
> +					iio_push_to_buffers_with_timestamp(
> +						hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +						&hw->scan[ST_LSM6DSX_ID_ACC],
> +						acc_sensor->ts_ref + ts);
>  				acc_sip--;
>  			}
>  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> @@ -541,8 +553,12 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw=
, u8 tag,
>  	}
> =20
>  	sensor =3D iio_priv(iio_dev);
> -	iio_push_to_buffers_with_timestamp(iio_dev, data,
> -					   ts + sensor->ts_ref);
> +	/* We need to discards gyro samples during filters settling time */
> +	if (sensor->samples_to_discard > 0)
> +		sensor->samples_to_discard--;
> +	else
> +		iio_push_to_buffers_with_timestamp(iio_dev, data,
> +						   ts + sensor->ts_ref);
> =20
>  	return 0;
>  }
> @@ -654,6 +670,25 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  	return err;
>  }
> =20
> +static void
> +st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sensor)
> +{
> +	const struct st_lsm6dsx_samples_to_discard *data;
> +	int i;
> +
> +	if (sensor->id !=3D ST_LSM6DSX_ID_GYRO &&
> +	    sensor->id !=3D ST_LSM6DSX_ID_ACC)
> +		return;
> +
> +	data =3D &sensor->hw->settings->samples_to_discard[sensor->id];
> +	for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> +		if (data->val[i].milli_hz =3D=3D sensor->odr) {
> +			sensor->samples_to_discard =3D data->val[i].samples;
> +			return;
> +		}
> +	}
> +}
> +
>  int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  {
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> @@ -673,6 +708,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *=
sensor, bool enable)
>  			goto out;
>  	}
> =20
> +	if (enable)
> +		st_lsm6dsx_update_samples_to_discard(sensor);
> +
>  	err =3D st_lsm6dsx_device_set_enable(sensor, enable);
>  	if (err < 0)
>  		goto out;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 3f6060c64f32..966df6ffe874 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -634,6 +634,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.fs_len =3D 4,
>  			},
>  		},
> +		.samples_to_discard =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D {
> +				.val[0] =3D {  12500, 1 },
> +				.val[1] =3D {  26000, 1 },
> +				.val[2] =3D {  52000, 1 },
> +				.val[3] =3D { 104000, 2 },
> +				.val[4] =3D { 208000, 2 },
> +				.val[5] =3D { 416000, 2 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] =3D {
> +				.val[0] =3D {  12500,  2 },
> +				.val[1] =3D {  26000,  5 },
> +				.val[2] =3D {  52000,  7 },
> +				.val[3] =3D { 104000, 12 },
> +				.val[4] =3D { 208000, 20 },
> +				.val[5] =3D { 416000, 36 },
> +			},
> +		},
>  		.irq_config =3D {
>  			.irq1 =3D {
>  				.addr =3D 0x0d,
> --=20
> 2.39.1
>=20

--GI803v822S32dPiG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+i9rAAKCRA6cBh0uS2t
rMFNAP94JvUry6XvxJRSV6VVGVECt8XOe8rrVHz4/U0jfg7hRAEAyhdGoer4P6mp
taEmvl8hapxXpSofb/uPCyREUq6bJAA=
=7k4i
-----END PGP SIGNATURE-----

--GI803v822S32dPiG--

