Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89CA69CB97
	for <lists+linux-iio@lfdr.de>; Mon, 20 Feb 2023 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjBTNHj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Feb 2023 08:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBTNHh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2023 08:07:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF91BACE
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 05:07:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E11860E88
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 13:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7BFC433EF;
        Mon, 20 Feb 2023 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676898454;
        bh=wPX2oYOL91PNOwbXzwFnK5Zrv3w6l6HiWd8IUF82h3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6qhPbcPF6DzQ7Fm6DNZu1y5j9kmjqRU71kN/Ts+/bTmt3EqyBO0gGpHUqETvO0QR
         q0LCgggTPs0nyf7b3tLpG1+ZK3k4Ocy9+ZLenMNRKY9H24PoJc6xcKTpO0gWh6kNra
         arGN9+8Qfd+xZvpFpTU6BO8qo98vAD01LVRk1FaY7JSn2BnlizzXm4gJrPRG1d7GfN
         Ahzrp4wD45eDtDH+Zf0jZj3ATSL+gz2sO8PWQrev6s8f4B/RfxYPVfacv86Bz2o8v+
         rHkCBqt+A2JaPq11mlCgzv0DnGb963mcxMXefD1osRkmRMA6/1pcu94QgAfBcTFj1w
         wtcU1GRW4FwTg==
Date:   Mon, 20 Feb 2023 14:07:30 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, phdm@macq.eu,
        linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
 settling time
Message-ID: <Y/NwkprZDzMfiVmt@lore-desk>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
 <20230218135622.6c5d4569@jic23-huawei>
 <Y/M5feqZB+4JP99M@lore-desk>
 <20230220124108.00001b36@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HDhkBuqYp2mBDbps"
Content-Disposition: inline
In-Reply-To: <20230220124108.00001b36@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--HDhkBuqYp2mBDbps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 20 Feb 2023 10:12:29 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Wed,  8 Feb 2023 15:42:31 +0100
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >  =20
> > > > During digital filters settling time the driver is expected to drop
> > > > samples since they can be corrupted. Introduce the capability to dr=
op
> > > > a given number of samples according to the configured ODR.
> > > > Add the sample_to_discard data for LSM6DSM sensor.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org> =20
> > >=20
> > > Is this only necessary for the particular sensor you have provided
> > > values for?  Or is it more general?
> > >=20
> > > I think the code will currently just set the number of samples to dis=
card
> > > to 0 for other cases (as no value set for those sensor types).
> > > That's fine if 0 is definitely the right value for those other sensor=
s. =20
> >=20
> >  I think all the sensors have this information in the datasheet/applica=
tion
> >  note. However, even if we add sample_to_discard just for LSM6DSM for t=
he moment,
> >  we do not introduce any regression for the other sensors with respect =
to the
> >  previous codebase since sample_to_discard will be just set to 0 (so we=
 do not
> >  discard any sample). I can add sample_to_discard for LSM6DSO but at the
> >  moment I do not have other devices for testing.
> >  For LSM6DSO, do you prefer to add it in v2 or is it fine a follow-up p=
atch?
>=20
> It's fine to do this as and when we can test particular devices
> (or frankly just assume datasheet correct).=20
>=20
> We should call it out in the patch description though so hopefully people
> notice they need to add it for sensors they care about.

ack, I will post v2 adding LSM6DSO in this case and improving commit log.

Regards,
Lorenzo

>=20
> >=20
> >  Regards,
> >  Lorenzo
> >=20
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan
> > >=20
> > >  =20
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 11 ++++
> > > >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 58 +++++++++++++++=
----
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 18 ++++++
> > > >  3 files changed, 77 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx.h
> > > > index 499fcf8875b4..8e119d78730b 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > @@ -137,6 +137,13 @@ struct st_lsm6dsx_odr_table_entry {
> > > >  	int odr_len;
> > > >  };
> > > > =20
> > > > +struct st_lsm6dsx_samples_to_discard {
> > > > +	struct {
> > > > +		u32 milli_hz;
> > > > +		u16 samples;
> > > > +	} val[ST_LSM6DSX_ODR_LIST_SIZE];
> > > > +};
> > > > +
> > > >  struct st_lsm6dsx_fs {
> > > >  	u32 gain;
> > > >  	u8 val;
> > > > @@ -291,6 +298,7 @@ struct st_lsm6dsx_ext_dev_settings {
> > > >   * @irq_config: interrupts related registers.
> > > >   * @drdy_mask: register info for data-ready mask (addr + mask).
> > > >   * @odr_table: Hw sensors odr table (Hz + val).
> > > > + * @samples_to_discard: Number of samples to discard for filters s=
ettling time.
> > > >   * @fs_table: Hw sensors gain table (gain + val).
> > > >   * @decimator: List of decimator register info (addr + mask).
> > > >   * @batch: List of FIFO batching register info (addr + mask).
> > > > @@ -323,6 +331,7 @@ struct st_lsm6dsx_settings {
> > > >  	} irq_config;
> > > >  	struct st_lsm6dsx_reg drdy_mask;
> > > >  	struct st_lsm6dsx_odr_table_entry odr_table[2];
> > > > +	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
> > > >  	struct st_lsm6dsx_fs_table_entry fs_table[2];
> > > >  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> > > >  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> > > > @@ -353,6 +362,7 @@ enum st_lsm6dsx_fifo_mode {
> > > >   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
> > > >   * @gain: Configured sensor sensitivity.
> > > >   * @odr: Output data rate of the sensor [Hz].
> > > > + * @samples_to_discard: Number of samples to discard for filters s=
ettling time.
> > > >   * @watermark: Sensor watermark level.
> > > >   * @decimator: Sensor decimation factor.
> > > >   * @sip: Number of samples in a given pattern.
> > > > @@ -367,6 +377,7 @@ struct st_lsm6dsx_sensor {
> > > >  	u32 gain;
> > > >  	u32 odr;
> > > > =20
> > > > +	u16 samples_to_discard;
> > > >  	u16 watermark;
> > > >  	u8 decimator;
> > > >  	u8 sip;
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drive=
rs/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > index 7dd5205aea5b..c1059a79f5ff 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > @@ -457,17 +457,29 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw=
 *hw)
> > > >  			}
> > > > =20
> > > >  			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
> > > > -				iio_push_to_buffers_with_timestamp(
> > > > -					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> > > > -					&hw->scan[ST_LSM6DSX_ID_GYRO],
> > > > -					gyro_sensor->ts_ref + ts);
> > > > +				/* We need to discards gyro samples during =20
> > >=20
> > > Trivial but wrong comment syntax. If that's all that comes up I'll fi=
x it here
> > > and in other instances below when applying.
> > >  =20
> > > > +				 * filters settling time
> > > > +				 */
> > > > +				if (gyro_sensor->samples_to_discard > 0)
> > > > +					gyro_sensor->samples_to_discard--;
> > > > +				else
> > > > +					iio_push_to_buffers_with_timestamp(
> > > > +						hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> > > > +						&hw->scan[ST_LSM6DSX_ID_GYRO],
> > > > +						gyro_sensor->ts_ref + ts);
> > > >  				gyro_sip--;
> > > >  			}
> > > >  			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
> > > > -				iio_push_to_buffers_with_timestamp(
> > > > -					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > > > -					&hw->scan[ST_LSM6DSX_ID_ACC],
> > > > -					acc_sensor->ts_ref + ts);
> > > > +				/* We need to discards accel samples during
> > > > +				 * filters settling time
> > > > +				 */
> > > > +				if (acc_sensor->samples_to_discard > 0)
> > > > +					acc_sensor->samples_to_discard--;
> > > > +				else
> > > > +					iio_push_to_buffers_with_timestamp(
> > > > +						hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > > > +						&hw->scan[ST_LSM6DSX_ID_ACC],
> > > > +						acc_sensor->ts_ref + ts);
> > > >  				acc_sip--;
> > > >  			}
> > > >  			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
> > > > @@ -541,8 +553,12 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_=
hw *hw, u8 tag,
> > > >  	}
> > > > =20
> > > >  	sensor =3D iio_priv(iio_dev);
> > > > -	iio_push_to_buffers_with_timestamp(iio_dev, data,
> > > > -					   ts + sensor->ts_ref);
> > > > +	/* We need to discards gyro samples during filters settling time =
*/
> > > > +	if (sensor->samples_to_discard > 0)
> > > > +		sensor->samples_to_discard--;
> > > > +	else
> > > > +		iio_push_to_buffers_with_timestamp(iio_dev, data,
> > > > +						   ts + sensor->ts_ref);
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > @@ -654,6 +670,25 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw=
 *hw)
> > > >  	return err;
> > > >  }
> > > > =20
> > > > +static void
> > > > +st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sen=
sor)
> > > > +{
> > > > +	const struct st_lsm6dsx_samples_to_discard *data;
> > > > +	int i;
> > > > +
> > > > +	if (sensor->id !=3D ST_LSM6DSX_ID_GYRO &&
> > > > +	    sensor->id !=3D ST_LSM6DSX_ID_ACC)
> > > > +		return;
> > > > +
> > > > +	data =3D &sensor->hw->settings->samples_to_discard[sensor->id];
> > > > +	for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> > > > +		if (data->val[i].milli_hz =3D=3D sensor->odr) {
> > > > +			sensor->samples_to_discard =3D data->val[i].samples;
> > > > +			return;
> > > > +		}
> > > > +	}
> > > > +}
> > > > +
> > > >  int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool =
enable)
> > > >  {
> > > >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > > > @@ -673,6 +708,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_se=
nsor *sensor, bool enable)
> > > >  			goto out;
> > > >  	}
> > > > =20
> > > > +	if (enable)
> > > > +		st_lsm6dsx_update_samples_to_discard(sensor);
> > > > +
> > > >  	err =3D st_lsm6dsx_device_set_enable(sensor, enable);
> > > >  	if (err < 0)
> > > >  		goto out;
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 3f6060c64f32..966df6ffe874 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -634,6 +634,24 @@ static const struct st_lsm6dsx_settings st_lsm=
6dsx_sensor_settings[] =3D {
> > > >  				.fs_len =3D 4,
> > > >  			},
> > > >  		},
> > > > +		.samples_to_discard =3D {
> > > > +			[ST_LSM6DSX_ID_ACC] =3D {
> > > > +				.val[0] =3D {  12500, 1 },
> > > > +				.val[1] =3D {  26000, 1 },
> > > > +				.val[2] =3D {  52000, 1 },
> > > > +				.val[3] =3D { 104000, 2 },
> > > > +				.val[4] =3D { 208000, 2 },
> > > > +				.val[5] =3D { 416000, 2 },
> > > > +			},
> > > > +			[ST_LSM6DSX_ID_GYRO] =3D {
> > > > +				.val[0] =3D {  12500,  2 },
> > > > +				.val[1] =3D {  26000,  5 },
> > > > +				.val[2] =3D {  52000,  7 },
> > > > +				.val[3] =3D { 104000, 12 },
> > > > +				.val[4] =3D { 208000, 20 },
> > > > +				.val[5] =3D { 416000, 36 },
> > > > +			},
> > > > +		},
> > > >  		.irq_config =3D {
> > > >  			.irq1 =3D {
> > > >  				.addr =3D 0x0d, =20
> > >  =20
> >=20
>=20

--HDhkBuqYp2mBDbps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/NwkQAKCRA6cBh0uS2t
rGhwAPwM8+m3Jcaee/GDwC1DbbNuAEkG91nnPLDk8VBIUYmBaAD/YGJ2WY+bkfEE
rqSgeyH/ZYbagYTCpe05yDorZomDMQ0=
=OoAc
-----END PGP SIGNATURE-----

--HDhkBuqYp2mBDbps--
