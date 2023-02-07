Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7467F68E475
	for <lists+linux-iio@lfdr.de>; Wed,  8 Feb 2023 00:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBGXd7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Feb 2023 18:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGXd6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Feb 2023 18:33:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3A27D59
        for <linux-iio@vger.kernel.org>; Tue,  7 Feb 2023 15:33:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0C7DB816D4
        for <linux-iio@vger.kernel.org>; Tue,  7 Feb 2023 23:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD41C433D2;
        Tue,  7 Feb 2023 23:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675812833;
        bh=VaakGH7vUpJLkUH4fM3GnBKEThTrgmLUtJ971NrkhxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ko3tHzrbm8Vnqxbg29ettlj+qQOaTHUdiYAZhPECKs/REAoQnEcDV6pQXWfPhJ5Tt
         1lJ+gPyo8tSMoIuEcZ2S6Z3xw3SHRjb6HkImhhirtf6lqFmzZGD0i0gmiV2+RgF5s7
         wqBPSLGQETCZ5StoIjhykzgSTkIKcEFvWqTp33SpqOypJoqgCH7z8fsVmIbi1swB6n
         wHJpBwsUt9iSX8OJtQ23UP9EpvKAL3luETaWOaGxY69XTnDTqEFxvPTIndr8uBUMWv
         POFjqcv5qD2z/DPyashl/a/vkFDRG+zVk7Ev0ZgOCxdVKemzIDlGc9qSIj9ZK7+hJz
         XUtMThHehO+/Q==
Date:   Wed, 8 Feb 2023 00:33:49 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: st_lsm6dsx : first two values of ism330dlc_gyro are wrong
Message-ID: <Y+Lf3YRLDvGmIOtA@lore-desk>
References: <20230205101223.GA10729@frolo.macqel>
 <20230205141342.10dbc447@jic23-huawei>
 <Y+DPMBFHo9UxU+fK@lore-desk>
 <20230206143328.000056cc@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8jdkM4TA5IQd+Us8"
Content-Disposition: inline
In-Reply-To: <20230206143328.000056cc@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--8jdkM4TA5IQd+Us8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 6 Feb 2023 10:58:08 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Sun, 5 Feb 2023 11:12:23 +0100
> > > Philippe De Muyter <phdm@macq.eu> wrote:
> > >  =20
> > > > Hello Lorenzo and list,
> > > >=20
> > > > I use the imu/st_lsm6dsx (i2c) driver to drive a ism330dlc imu.
> > > >=20
> > > > Every time I start a new acquisition of gyro values, the first two
> > > > values read are wrong, as can be see here :
> > > >=20
> > > >  $ sudo ./iio_generic_buffer -n ism330dlc_gyro -g -c 10 -a
> > > >  iio device number being used is 1
> > > >  trigger-less mode selected
> > > >  No channels are enabled, enabling all channels
> > > >  Enabling: in_anglvel_z_en
> > > >  Enabling: in_timestamp_en
> > > >  Enabling: in_anglvel_y_en
> > > >  Enabling: in_anglvel_x_en
> > > >  -0.138924 -0.915246 0.470628 1675591514696125669
> > > >  -0.012699 -0.362151 0.143208 1675591514772675669
> > > >  0.001989 -0.076500 0.035190 1675591514849250669
> > > >  0.002295 -0.076194 0.035343 1675591514925825669
> > > >  0.002142 -0.076041 0.035343 1675591515002400669
> > > >  0.001989 -0.076041 0.035343 1675591515078975669
> > > >  0.001836 -0.076347 0.035649 1675591515155525669
> > > >  0.001836 -0.076500 0.035649 1675591515232075669
> > > >  0.001989 -0.076500 0.035649 1675591515308625669
> > > >  0.001989 -0.076347 0.035649 1675591515385200669
> > > >  Disabling: in_anglvel_z_en
> > > >  Disabling: in_timestamp_en
> > > >  Disabling: in_anglvel_y_en
> > > >  Disabling: in_anglvel_x_en
> > > >  $
> > > >=20
> > > > Is that a normal behaviour for a gyro in that family or is it be ca=
used
> > > > by a software or hardware bug ? =20
> > >=20
> > > So, some random thoughts on what might be going on...
> > > 1) Stale data in the fifo.  Could you run this experiment twice whils=
t being
> > >    careful not to move the device between the runs.  If we still see =
the wrong
> > >    values at the start then it's not that... =20
> >=20
> > When the device is powered-down we set the FIFO in bypass mode and in-f=
light
> > samples are discarded.
> >=20
> > >=20
> > > 2) Device takes a little whilst to stabilize. Possibly this is down t=
o the
> > >    low pass filters requiring a few samples before they deliver stabl=
e output.
> > >    From a quick glance I don't think we provide any userspace control=
 of those
> > >    filters and I think LPR1 is left in default state of disabled. =20
> >=20
> > I would say this issue is related to the "Accelerometer and gyroscope
> > turn-on/off time" (section 3.9 in the sensor application note).
> >=20
> > https://www.st.com/resource/en/application_note/an5125-ism330dlc-3d-acc=
elerometer-and-3d-gyroscope-with-digital-output-for-industrial-applications=
-stmicroelectronics.pdf
> >=20
> > @Jonathan: do you think we should discard these sample in the driver or=
 in the
> > user-space app? I would say this can be a general issue. What do you th=
ink?
>=20
> In driver.  This isn't an uncommon problem for sensors and userspace woul=
d in=20
> general have no idea how many samples to drop.  Also dependent on the sam=
pling
> rates etc so if we support control of those, we'll want to have the driver
> drop the right number of samples.  Though yikes at the top end. You can h=
ave
> to drop 540 samples... Ah well. That is at 6kHz sampling so still not ver=
y long.
>=20
> The only alternative would be to expose the current number to drop to use=
rspace
> but then existing userspace code would not drop them.  Hence I think it n=
eeds
> to be in driver.
>=20
> Jonathan
>=20
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > You could try messing with the sampling frequency as that may affect =
the number
> > > of bad samples you see and give us more of a clue (it affects lpf2 di=
rectly).
> > >=20
> > > Jonathan
> > >  =20
> > > >=20
> > > > Best regards
> > > >=20
> > > > Philippe

Hi Philippe,

can you please test the patch below? Please note it is just compiled tested.

Regards,
Lorenzo

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_l=
sm6dsx/st_lsm6dsx.h
index 499fcf8875b4..2fb4d75ad096 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -137,6 +137,13 @@ struct st_lsm6dsx_odr_table_entry {
 	int odr_len;
 };
=20
+struct st_lsm6dsx_samples_to_discard {
+	struct {
+		u32 milli_hz;
+		u16 samples;
+	} map[ST_LSM6DSX_ODR_LIST_SIZE];
+};
+
 struct st_lsm6dsx_fs {
 	u32 gain;
 	u8 val;
@@ -323,6 +330,7 @@ struct st_lsm6dsx_settings {
 	} irq_config;
 	struct st_lsm6dsx_reg drdy_mask;
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
+	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
@@ -353,6 +361,7 @@ enum st_lsm6dsx_fifo_mode {
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
  * @odr: Output data rate of the sensor [Hz].
+ * @samples_to_discard: Number of samples to discard for filters transitor=
y.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
  * @sip: Number of samples in a given pattern.
@@ -367,6 +376,7 @@ struct st_lsm6dsx_sensor {
 	u32 gain;
 	u32 odr;
=20
+	u16 samples_to_discard;
 	u16 watermark;
 	u8 decimator;
 	u8 sip;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 7dd5205aea5b..1b78238db388 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -418,12 +418,22 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				       &hw->buff[offset],
 				       sizeof(hw->scan[ST_LSM6DSX_ID_GYRO].channels));
 				offset +=3D sizeof(hw->scan[ST_LSM6DSX_ID_GYRO].channels);
+				/* We need to discards gyro samples during
+				 * filters settiling time
+				 */
+				if (gyro_sensor->samples_to_discard)
+					gyro_sensor->samples_to_discard--;
 			}
 			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
 				memcpy(hw->scan[ST_LSM6DSX_ID_ACC].channels,
 				       &hw->buff[offset],
 				       sizeof(hw->scan[ST_LSM6DSX_ID_ACC].channels));
 				offset +=3D sizeof(hw->scan[ST_LSM6DSX_ID_ACC].channels);
+				/* We need to discards accel samples during
+				 * filters settiling time
+				 */
+				if (acc_sensor->samples_to_discard)
+					acc_sensor->samples_to_discard--;
 			}
 			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
 				memcpy(hw->scan[ST_LSM6DSX_ID_EXT0].channels,
@@ -456,14 +466,16 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				offset +=3D ST_LSM6DSX_SAMPLE_SIZE;
 			}
=20
-			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
+			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator) &&
+			    !gyro_sensor->samples_to_discard) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
 					&hw->scan[ST_LSM6DSX_ID_GYRO],
 					gyro_sensor->ts_ref + ts);
 				gyro_sip--;
 			}
-			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
+			if (acc_sip > 0 && !(sip % acc_sensor->decimator) &&
+			    !acc_sensor->samples_to_discard) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_ACC],
 					&hw->scan[ST_LSM6DSX_ID_ACC],
@@ -541,8 +553,12 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, =
u8 tag,
 	}
=20
 	sensor =3D iio_priv(iio_dev);
-	iio_push_to_buffers_with_timestamp(iio_dev, data,
-					   ts + sensor->ts_ref);
+	/* We need to discards gyro samples during filters settiling time */
+	if (!sensor->samples_to_discard)
+		iio_push_to_buffers_with_timestamp(iio_dev, data,
+						   ts + sensor->ts_ref);
+	else
+		sensor->samples_to_discard--;
=20
 	return 0;
 }
@@ -654,6 +670,25 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
 	return err;
 }
=20
+static void
+st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sensor)
+{
+	const struct st_lsm6dsx_samples_to_discard *data;
+	int i;
+
+	if (sensor->id !=3D ST_LSM6DSX_ID_GYRO &&
+	    sensor->id !=3D ST_LSM6DSX_ID_ACC)
+		return;
+
+	data =3D &sensor->hw->settings->samples_to_discard[sensor->id];
+	for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
+		if (data->map[i].milli_hz =3D=3D sensor->odr) {
+			sensor->samples_to_discard =3D data->map[i].samples;
+			return;
+		}
+	}
+}
+
 int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 {
 	struct st_lsm6dsx_hw *hw =3D sensor->hw;
@@ -673,6 +708,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *se=
nsor, bool enable)
 			goto out;
 	}
=20
+	if (enable)
+		st_lsm6dsx_update_samples_to_discard(sensor);
+
 	err =3D st_lsm6dsx_device_set_enable(sensor, enable);
 	if (err < 0)
 		goto out;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 3f6060c64f32..a74a702205e8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -610,6 +610,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sen=
sor_settings[] =3D {
 				.odr_len =3D 6,
 			},
 		},
+		.samples_to_discard =3D {
+			[ST_LSM6DSX_ID_ACC] =3D {
+				.map[0] =3D {  12500, 1 },
+				.map[1] =3D {  26000, 1 },
+				.map[2] =3D {  52000, 1 },
+				.map[3] =3D { 104000, 2 },
+				.map[4] =3D { 208000, 2 },
+				.map[5] =3D { 416000, 2 },
+			},
+			[ST_LSM6DSX_ID_GYRO] =3D {
+				.map[0] =3D {  12500, 2 },
+				.map[1] =3D {  26000, 3 },
+				.map[2] =3D {  52000, 3 },
+				.map[3] =3D { 104000, 4 },
+				.map[4] =3D { 208000, 5 },
+				.map[5] =3D { 416000, 6 },
+			},
+		},
 		.fs_table =3D {
 			[ST_LSM6DSX_ID_ACC] =3D {
 				.reg =3D {

> > > >  =20
> > >  =20
> >=20
>=20

--8jdkM4TA5IQd+Us8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+Lf3QAKCRA6cBh0uS2t
rEDCAP4rvkay/XeSZVElhgvHQW4cc121K7cs/oIQPR9IjXiLhwD9Ed8APTJmIGOp
mkTjR/W3DFaGHossfi4TBLSmphHDpAg=
=LHIi
-----END PGP SIGNATURE-----

--8jdkM4TA5IQd+Us8--
