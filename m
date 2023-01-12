Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDA8666F4E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jan 2023 11:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjALKQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Jan 2023 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjALKOM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2023 05:14:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6368BE05
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 02:12:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53EE9B81DEB
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 10:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35E0C433EF;
        Thu, 12 Jan 2023 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673518376;
        bh=wT0F7hlDMHqA5Qb6BUNkIa/lvP2d5FF31F3cTBT/q2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZ+0IVdHlyEB2ECjVdhDdLt2eWAvYyORz9zNmLKAEq+D/DgX3+Q9oDiSrHUEvtqKZ
         9HnIeaq62/VHB0MnG1+ywbQ2/fB5gaUUrY9/WrpmIDClzwl3H5erCH86BcftcWZwI7
         lJ1Dz6EXZPM9WHnEJvX/MA5lXiV4v5O0r0HcbY+e2nrH7WXDNEcQUALMVcHDwBhx/F
         8+eZUFSC/gxGCIHF6FD76Ys3Q/HEB+tBjvAJVfvOiqTDWxAaoAc+WM/7LwXkPVngFW
         +ZU168Or0sUeJMampdHBzzdgf4K5SzM/dqyPIirLU7Jghb5+IVr7g7eUuvnFQ/WcWf
         JiakwINB5t36g==
Date:   Thu, 12 Jan 2023 11:12:52 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org
Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <Y7/dJDbHXtlid8SD@lore-desk>
References: <20230111120940.GA23351@frolo.macqel>
 <20230111171732.00006941@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kI3Bn19H2MtQK7nA"
Content-Disposition: inline
In-Reply-To: <20230111171732.00006941@Huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--kI3Bn19H2MtQK7nA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 11 Jan 2023 13:09:40 +0100
> Philippe De Muyter <phdm@macq.eu> wrote:
>=20
> > Hello Lorenzo and list,
> >=20
> > I do not find a "*mount_matrix" entry in sysfs for a 'ism330dlc_gyro'
> > iio device.
> > Is that normal ?
> > Is a fix available ?
>=20
> Looks like the channel definition for the gyro does not include an
> appropriate ext_info entry unlike the accelerometer channels which
> have one with mount_matrix support.
>=20
> From a quick glance looks like a simple fix. Add that entry.

something like (per-sensor mount_matrix):

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_l=
sm6dsx/st_lsm6dsx.h
index 5b6f195748fc..5e0c184e1055 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -113,6 +113,8 @@ enum st_lsm6dsx_hw_id {
 		.storagebits =3D 16,					\
 		.endianness =3D IIO_LE,					\
 	},								\
+	.ext_info =3D st_lsm6dsx_gyro_ext_info,				\
+	.num_event_specs =3D 1,						\
 }
=20
 struct st_lsm6dsx_reg {
@@ -356,6 +358,7 @@ enum st_lsm6dsx_fifo_mode {
  * @decimator: Sensor decimation factor.
  * @sip: Number of samples in a given pattern.
  * @ts_ref: Sensor timestamp reference for hw one.
+ * @orientation: sensor chip orientation relative to main hardware.
  * @ext_info: Sensor settings if it is connected to i2c controller
  */
 struct st_lsm6dsx_sensor {
@@ -371,6 +374,8 @@ struct st_lsm6dsx_sensor {
 	u8 sip;
 	s64 ts_ref;
=20
+	struct iio_mount_matrix orientation;
+
 	struct {
 		const struct st_lsm6dsx_ext_dev_settings *settings;
 		u32 slv_odr;
@@ -398,7 +403,6 @@ struct st_lsm6dsx_sensor {
  * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
- * @orientation: sensor chip orientation relative to main hardware.
  * @scan: Temporary buffers used to align data before iio_push_to_buffers()
  */
 struct st_lsm6dsx_hw {
@@ -427,7 +431,6 @@ struct st_lsm6dsx_hw {
=20
 	const struct st_lsm6dsx_settings *settings;
=20
-	struct iio_mount_matrix orientation;
 	/* Ensure natural alignment of buffer elements */
 	struct {
 		__le16 channels[3];
@@ -511,9 +514,8 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_d=
ev,
 			    const struct iio_chan_spec *chan)
 {
 	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
-	struct st_lsm6dsx_hw *hw =3D sensor->hw;
=20
-	return &hw->orientation;
+	return &sensor->orientation;
 }
=20
 static inline int
@@ -533,4 +535,10 @@ struct iio_chan_spec_ext_info __maybe_unused st_lsm6ds=
x_accel_ext_info[] =3D {
 	{ }
 };
=20
+static const
+struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_gyro_ext_info[] =
=3D {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
+	{ }
+};
+
 #endif /* ST_LSM6DSX_H */
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 3f6060c64f32..15c7184a1895 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2359,6 +2359,9 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct=
 st_lsm6dsx_hw *hw,
 	sensor->gain =3D hw->settings->fs_table[id].fs_avl[0].gain;
 	sensor->watermark =3D 1;
=20
+	if (iio_read_mount_matrix(hw->dev, &sensor->orientation))
+		return NULL;
+
 	switch (id) {
 	case ST_LSM6DSX_ID_ACC:
 		iio_dev->info =3D &st_lsm6dsx_acc_info;
@@ -2676,10 +2679,6 @@ int st_lsm6dsx_probe(struct device *dev, int irq, in=
t hw_id,
 			return err;
 	}
=20
-	err =3D iio_read_mount_matrix(hw->dev, &hw->orientation);
-	if (err)
-		return err;
-
 	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		if (!hw->iio_devs[i])
 			continue;

> >=20
> > Some more info :
> >=20
> > I have backported  drivers/iio/imu/st_lsm6dsx to linux-4.9 in order
> > to drive a ism330dlc imu on a custom board.  The chip is correctly
> > detected and two devices are created in /sys/bus/iio/devices/
> >=20
> > the first one (where name is 'ism330dlc_gyro') has the following entrie=
s :
> >=20
> >  me@proto4:~$ ls /sys/bus/iio/devices/iio\:device1/
> >  buffer                      in_anglvel_x_raw  sampling_frequency
> >  current_timestamp_clock     in_anglvel_y_raw  sampling_frequency_avail=
able
> >  dev                         in_anglvel_z_raw  scan_elements
> >  in_anglvel_scale            name              subsystem
> >  in_anglvel_scale_available  power             uevent
> >  me@proto4:~$
> >=20
> > the second one (where name is 'ism330dlc_accel') has those entries :
> >=20
> >  me@proto4:~$ ls /sys/bus/iio/devices/iio\:device2
> >  buffer                    in_accel_x_raw  sampling_frequency
> >  current_timestamp_clock   in_accel_y_raw  sampling_frequency_available
> >  dev                       in_accel_z_raw  scan_elements
> >  events                    mount_matrix    subsystem
> >  in_accel_scale            name            uevent
> >  in_accel_scale_available  power
> >  me@proto4:~$
> >=20
> > The 'mount_matrix' entry is only present in the 'ism330dlc_accel' device
> > but not in the 'ism330dlc_gyro' device.
> >=20
> > On a similar board, but with mpu9250 imu, I get only one iio:deviceX
> > entry but with two *mount_matrix entries :=20
> >=20
> > 	in_accel_mount_matrix
> > 	in_anglvel_mount_matrix
> >=20
> > In both cases, I would have expected only one 'iio:deviceX' entry with
> > only one 'mount_matrix' entry.
>=20
> There are multiple devices because the driver predates the addition
> of multiple buffer support to IIO and IIRC is capable of producing data
> at different sampling rates for the accelerometer and the gyros.
> Hence when it was implemented the only choice was to register multiple
> devices in order to get the multiple buffers. It's ABI now so we can't
> fix it in an old driver unfortunately.  We'd do this differently today..
>=20
> The double mount_matrix for the mpu9250 is a little odd and I can't
> immediately spot why that one is happening.
>=20
>=20
> >=20
> > Best regards
> >=20
> > Philippe
> >=20
>=20

--kI3Bn19H2MtQK7nA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY7/dJAAKCRA6cBh0uS2t
rHxbAQDt+DRLM/hrIenMytn2jO1zx3uzyxdmSgUoyhQ+kN5GfQD+OZDvIv43XtkK
AXpMX9vtcz69Rrmltj+BxpmaG5dwFQs=
=JaAK
-----END PGP SIGNATURE-----

--kI3Bn19H2MtQK7nA--
