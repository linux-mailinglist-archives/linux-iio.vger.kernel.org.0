Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5055A922
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 13:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiFYLAO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 07:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiFYLAO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 07:00:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465733E10
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 04:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B64B80816
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 11:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E6C3411C;
        Sat, 25 Jun 2022 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656154810;
        bh=qtJ8QKd6HeS2OYlDoXmyPWbpC0git+COkPDhrPzl+Uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSPDyq0oQ7oKbtzrVB3+lhaAeLEY4AAOFSWSaTij2KUEcKny0+Wpvl5ms3ujFAa27
         3T8Uw32yGjcvIUzK8UqZ+PbY2APk2mVBln2dGZ3PW/jh+g1AKuGq87k+gB/iOgd1Y2
         wPcQ1Ewjv4GAVfDq6eYoKRdSKP6m9YxxHZUDkmSnSSjtoeRpc9vcMfWMA66EVQhEjj
         KY4isgkz6VtKYs1pVTL6zSi2Xm3CKyA/qPs8kT3xaAcRObmI3w7uYimN8pZKaQNESr
         yu6h25Tjuqihba1LnnsbUJ6sZ50GT0wov27DeCr7OVLqsMVELcW1JXpsQ8/3jUygCv
         2a+N5ykWVaDFw==
Date:   Sat, 25 Jun 2022 12:09:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        wpsmith@google.com, linux-iio@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] iio/hid: Add mount_matrix
Message-ID: <20220625120937.24c51ca4@jic23-huawei>
In-Reply-To: <20220624223341.2625231-1-gwendal@chromium.org>
References: <20220624223341.2625231-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Jun 2022 15:33:41 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> ISH based sensors do not naturally return data in the W3C 'natural'
> orientation.
> They returns all data inverted, to match Microsoft Windows requirement:
> [https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sensors#acc=
elerometer]
> """ If the device has the SimpleOrientation of FaceUp on a table, then
> the accelerometer would read -1 G on the Z axis. """

Probably reference the HID Usage Tables 1.3 spec rather than the MS one.
https://usb.org/sites/default/files/hut1_3_0.pdf
After some waving around of my left and right hand I'm fairly sure that say=
s the same
thing as the MS spec. Section 4.4 Vector Usages=20

> While W3C defines [https://www.w3.org/TR/motion-sensors/#accelerometer-se=
nsor]
> """The Accelerometer sensor is an inertial-frame sensor, this means that
> when the device is in free fall, the acceleration is 0 m/s2 in the
> falling direction, and when a device is laying flat on a table, the
> acceleration in upwards direction will be equal to the Earth gravity,
> i.e. g =E2=89=A1 9.8 m/s2 as it is measuring the force of the table pushi=
ng the
> device upwards."""
>=20
> Fixes all HID sensors that defines IIO_MOD_[XYZ] attributes.
>=20
> Tested on "HP Spectre x360 Convertible 13" and "Dell XPS 13 9365".
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Ah.  Whilst this is a fix, it seems likely to break a whole bunch of existi=
ng
users that are compensating for the wrong orientation in userspace.  Also, =
do
we know how universal this is?  I have a nasty feeling it'll turn out some
HID sensors do it the other way whatever the spec says.  Bastien, are you
carrying a local fix for this in your userspace code?

+CC a few people who are likely to know more on just how bad that will be...

One other thing inline.  The mount matrix you've provided isn't a rotation =
matrix.

I'd forgotten the annoyance of graphics folks using the right handed sensor
axis whilst nearly all other uses are left handed. It drove me mad many yea=
rs
ago - every code base that used sensors and rendered the result needed a
flip of the z axis - it was never well documented, so half the time
the code ended up with many axis flips based on people debugging local
orientation problems.  *sigh*


> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  3 +++
>  .../hid-sensors/hid-sensor-attributes.c       | 21 +++++++++++++++++++
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 +++
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 +++
>  include/linux/hid-sensor-hub.h                |  2 ++
>  5 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index a2def6f9380a3..980bbd7fba502 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -59,6 +59,7 @@ static const struct iio_chan_spec accel_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index =3D CHANNEL_SCAN_INDEX_X,
> +		.ext_info =3D hid_sensor_ext_info,
>  	}, {
>  		.type =3D IIO_ACCEL,
>  		.modified =3D 1,
> @@ -69,6 +70,7 @@ static const struct iio_chan_spec accel_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index =3D CHANNEL_SCAN_INDEX_Y,
> +		.ext_info =3D hid_sensor_ext_info,
>  	}, {
>  		.type =3D IIO_ACCEL,
>  		.modified =3D 1,
> @@ -79,6 +81,7 @@ static const struct iio_chan_spec accel_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index =3D CHANNEL_SCAN_INDEX_Z,
> +		.ext_info =3D hid_sensor_ext_info,
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>  };
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/dri=
vers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 9b279937a24e0..e367e4b482ef0 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -585,6 +585,27 @@ int hid_sensor_parse_common_attributes(struct hid_se=
nsor_hub_device *hsdev,
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, IIO_HID);
> =20
> +static const struct iio_mount_matrix hid_sensor_windows_axis =3D {
> +	.rotation =3D {
> +		"-1", "0", "0",
> +		"0", "-1", "0",
> +		"0", "0", "-1"

Unless my memory of rotation matrices serves me wrong, that's not a rotatio=
n matrix.
(det(R) !=3D 1)

That's a an axis flip from a right handed set of axis to a left handed one.
So to fix this up, you would need to invert the raw readings of at least on=
e axis
rather than rely on the mount matrix or make the scale negative.

Jonathan


> +	}
> +};
> +
> +static const struct iio_mount_matrix *
> +hid_sensor_get_mount_matrix(const struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan)
> +{
> +	return &hid_sensor_windows_axis;
> +}
> +
> +const struct iio_chan_spec_ext_info hid_sensor_ext_info[] =3D {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, hid_sensor_get_mount_matrix),
> +	{ }
> +};
> +EXPORT_SYMBOL(hid_sensor_ext_info);
> +
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_DESCRIPTION("HID Sensor common attribute processing");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
> index 8f0ad022c7f1b..b852f5166bb21 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -58,6 +58,7 @@ static const struct iio_chan_spec gyro_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index =3D CHANNEL_SCAN_INDEX_X,
> +		.ext_info =3D hid_sensor_ext_info,
>  	}, {
>  		.type =3D IIO_ANGL_VEL,
>  		.modified =3D 1,
> @@ -68,6 +69,7 @@ static const struct iio_chan_spec gyro_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index =3D CHANNEL_SCAN_INDEX_Y,
> +		.ext_info =3D hid_sensor_ext_info,
>  	}, {
>  		.type =3D IIO_ANGL_VEL,
>  		.modified =3D 1,
> @@ -78,6 +80,7 @@ static const struct iio_chan_spec gyro_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index =3D CHANNEL_SCAN_INDEX_Z,
> +		.ext_info =3D hid_sensor_ext_info,
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>  };
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/=
magnetometer/hid-sensor-magn-3d.c
> index e85a3a8eea908..aefbdb9b0869a 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -74,6 +74,7 @@ static const struct iio_chan_spec magn_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.ext_info =3D hid_sensor_ext_info,
>  	}, {
>  		.type =3D IIO_MAGN,
>  		.modified =3D 1,
> @@ -83,6 +84,7 @@ static const struct iio_chan_spec magn_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.ext_info =3D hid_sensor_ext_info,
>  	}, {
>  		.type =3D IIO_MAGN,
>  		.modified =3D 1,
> @@ -92,6 +94,7 @@ static const struct iio_chan_spec magn_3d_channels[] =
=3D {
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.ext_info =3D hid_sensor_ext_info,
>  	}, {
>  		.type =3D IIO_ROT,
>  		.modified =3D 1,
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hu=
b.h
> index c27329e2a5ad5..ee7d5b430a785 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -236,6 +236,8 @@ struct hid_sensor_common {
>  	struct work_struct work;
>  };
> =20
> +extern const struct iio_chan_spec_ext_info hid_sensor_ext_info[];
> +
>  /* Convert from hid unit expo to regular exponent */
>  static inline int hid_sensor_convert_exponent(int unit_expo)
>  {

