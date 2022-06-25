Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C155ACAC
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiFYUwS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiFYUwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 16:52:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC51513D25
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 13:52:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a10so6014201ioe.9
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UqkWdV7lgI86ZkpmkUh3I/QUz796mPnpY2jmjGrl/8U=;
        b=WGCdkQMd8IA6IUFxz2hRoF/BpJGomfeFAqDEzAXT5i067IxakmmUfQyh01YpEZlifg
         FM0kcBf8c3IkrmlUywSck/8zIKamUQ3Ft9+bklYBebAiYOqz+UzQUh/pFHoReLC2MtIe
         2n1C3cCmUVAqxmPP3G/5PP5C2UM5r0HiIJgq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UqkWdV7lgI86ZkpmkUh3I/QUz796mPnpY2jmjGrl/8U=;
        b=0yJelOTbDXdGIbUt1oL5u3dDYpQK+BwX+W8Dwlb+07OJ6csOcg9BsvOGFFKLjbHK9e
         tphQWWRU5QbNKFlHAq3rffMB/Jb+4NPy6HVGkhUMxdmEASPfjat4WWzXRqYeG+JaLEWg
         xlyzEbiV8eeFYVvT8wA+kwyNBxGMK/sBe91w7oWzYGJ/OfYV3qbSS1h8IG3jfSANwP/c
         EXe6gfyebZxmSVLisxiihiHHV9jAlqglem8e1WDNg5i2fsjJOVoVdpgs41gM/uSqJ7cv
         SiNCLPwjeBkJxSMt6nl/ktDF0W/HNJbsg4F/gCV9VWVlvo8I18e/2g/4y9WhyGU7DASW
         iPog==
X-Gm-Message-State: AJIora+vAgvHTWjlHR8/23ZsOFGcANAjKcLJGGqyYw88LyT/EMVLhEUN
        GnhK+a+zVrJYq80c/P+Po/HXBcqEAY4eL8RfpKx5lcuoy4rPBA==
X-Google-Smtp-Source: AGRyM1vh2kUb9teYnoG4VfRolisf7niQDgm7ztHzavG/oU3yQIT4Mvs3MoplaG1w78OFGBnwIQ/wkq2Zr60jBfoJ++w=
X-Received: by 2002:a5d:9d9b:0:b0:669:cd74:7e0d with SMTP id
 ay27-20020a5d9d9b000000b00669cd747e0dmr2881011iob.7.1656190335912; Sat, 25
 Jun 2022 13:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220624223341.2625231-1-gwendal@chromium.org>
 <20220625120937.24c51ca4@jic23-huawei> <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
 <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
In-Reply-To: <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 25 Jun 2022 13:52:03 -0700
Message-ID: <CAPUE2usnMyDN5DpgY_dtj73Jb811-9Y6Q8ZLsnqKiA7=q=74UQ@mail.gmail.com>
Subject: Re: [PATCH] iio/hid: Add mount_matrix
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>, jikos@kernel.org,
        wpsmith@google.com, linux-iio@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 25, 2022 at 11:27 AM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sat, 2022-06-25 at 14:33 +0200, Hans de Goede wrote:
> > Hi,
> >
> > Jonathan, thanks for Cc-ing me on this.
> >
> > On 6/25/22 13:09, Jonathan Cameron wrote:
> > > On Fri, 24 Jun 2022 15:33:41 -0700
> > > Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > > ISH based sensors do not naturally return data in the W3C
> > > > 'natural'
> > > > orientation.
> > > > They returns all data inverted, to match Microsoft Windows
> > > > requirement:
> > > > [
> > > > https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/senso
> > > > rs#accelerometer]
> > > > """ If the device has the SimpleOrientation of FaceUp on a table,
> > > > then
> > > > the accelerometer would read -1 G on the Z axis. """
> > >
> > > Probably reference the HID Usage Tables 1.3 spec rather than the MS
> > > one.
> > > https://usb.org/sites/default/files/hut1_3_0.pdf
That document does not clearly defined what the accelerometer should return=
.
> > > After some waving around of my left and right hand I'm fairly sure
> > > that says the same
> > > thing as the MS spec. Section 4.4 Vector Usages
> > >
> > > > While W3C defines
> > > > [https://www.w3.org/TR/motion-sensors/#accelerometer-sensor]
> > > > """The Accelerometer sensor is an inertial-frame sensor, this
> > > > means that
> > > > when the device is in free fall, the acceleration is 0 m/s2 in
> > > > the
> > > > falling direction, and when a device is laying flat on a table,
> > > > the
> > > > acceleration in upwards direction will be equal to the Earth
> > > > gravity,
> > > > i.e. g =E2=89=A1 9.8 m/s2 as it is measuring the force of the table
> > > > pushing the
> > > > device upwards."""
> > > >
> > > > Fixes all HID sensors that defines IIO_MOD_[XYZ] attributes.
> > > >
> > > > Tested on "HP Spectre x360 Convertible 13" and "Dell XPS 13
> > > > 9365".
> > > >
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > >
> > > Ah.  Whilst this is a fix, it seems likely to break a whole bunch
> > > of existing
> > > users that are compensating for the wrong orientation in
> > > userspace.  Also, do
> > > we know how universal this is?  I have a nasty feeling it'll turn
> > > out some
> > > HID sensors do it the other way whatever the spec says.  Bastien,
> > > are you
> > > carrying a local fix for this in your userspace code?
> > >
> > > +CC a few people who are likely to know more on just how bad that
> > > will be...
> >
> > Right, so Linux userspace expects an axis system similar to the
> > Android one,
> > which is actually the one which seems to be described here.
> >
> > The axis system expect is that when a tablet is layed flat on the
> > table,
> > the x and y axis are as one would expect when drawing a mathematics
> > graph on the surface of the tablet.
> >
> > So X-axis goes from left to right, with left side being lower numbers
> > and
> > right side higher numbers.
> >
> > And Y-axis goes from bottom to top, with the bottom being lower
> > numbers and
> > the top higher numbers.
> >
> > That leaves the Z-axis which comes out of the screen at a 90=C2=B0 angl=
e
> > (to both
> > the X and Y axis) and the vector coming out of the screen towards to
> > the user /
> > observer of the screen indicates positive numbers where as imagining
> > the same
> > axis pointing down through the table on which the tables is lying
> > towards
> > the floor represents negative numbers.
> >
> > This means that the accel values of a tablet resting on a table,
> > expresses
> > in units of 1G are: [ 0, 0, -1 ] and I've seen quite a few HID
> > sensors
But W3C and Android expect [ 0, 0, 1g ] when resting on the table. See
commit message for W3C and for Android, see
https://source.android.com/devices/sensors/sensor-types#accelerometer
"""When the device lies flat on a table, the acceleration value along
z is +9.81 alo, which corresponds to the acceleration of the device (0
m/s^2) minus the force of gravity (-9.81 m/s^2)."""". That is why we
need to change the sign to be consistent with these standards.
> > with accel reporting on various devices and they all adhere to this
> > without applying any accel matrix. Or in other words, HID sensors
> > behave
> > as expected by userspace when applying the norm matrix of:
> >
> >         .rotation =3D {
> >                 "1", "0", "0",
> >                 "0", "1", "0",
> >                 "0", "0", "1"
> >
> > And this patch will cause the image to be upside down (no matter what
> > the
> > rotation) when using auto-rotation with iio-sensor-proxy.
> >
> > So big NACK from me for this patch.
> >
> > I'm not sure what this patch is trying to fix but it looks to me like
> > it
> > is a bug in the HID sensors implementation of the specific device.
This is a not a bug since HID sensors from 2 laptops from different
manufacturers (HP and Dell) report the same values.
> >
> > Again HID-sensors already work fine on tons of existing devices
> > without
> > any matrix getting applied.
Note this patch does not change the value reported by the sensor, just
define a matrix to make sure the sensors values are consistent with
Android/W3C.
> >
> > Merging this patch would break existing userspace on tons of devices!
Since the user space application may not use the defined matrix, it
would not affect existing them. Inverting the scale definitely will.
> >
> Yes, it will. We have devices from 5+ years with this feature. So not
> practical to test every device.
>
> Thanks,
> Srinivas
>
> > Regards,
> >
> > Hans
> >
> >
> >
> >
> >
> > >
> > > One other thing inline.  The mount matrix you've provided isn't a
> > > rotation matrix.
> > >
> > > I'd forgotten the annoyance of graphics folks using the right
> > > handed sensor
> > > axis whilst nearly all other uses are left handed. It drove me mad
> > > many years
> > > ago - every code base that used sensors and rendered the result
> > > needed a
> > > flip of the z axis - it was never well documented, so half the time
> > > the code ended up with many axis flips based on people debugging
> > > local
> > > orientation problems.  *sigh*
> > >
> > >
> > > > ---
> > > >  drivers/iio/accel/hid-sensor-accel-3d.c       |  3 +++
> > > >  .../hid-sensors/hid-sensor-attributes.c       | 21
> > > > +++++++++++++++++++
> > > >  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 +++
> > > >  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 +++
> > > >  include/linux/hid-sensor-hub.h                |  2 ++
> > > >  5 files changed, 32 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > b/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > index a2def6f9380a3..980bbd7fba502 100644
> > > > --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> > > > @@ -59,6 +59,7 @@ static const struct iio_chan_spec
> > > > accel_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > >                 .scan_index =3D CHANNEL_SCAN_INDEX_X,
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         }, {
> > > >                 .type =3D IIO_ACCEL,
> > > >                 .modified =3D 1,
> > > > @@ -69,6 +70,7 @@ static const struct iio_chan_spec
> > > > accel_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > >                 .scan_index =3D CHANNEL_SCAN_INDEX_Y,
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         }, {
> > > >                 .type =3D IIO_ACCEL,
> > > >                 .modified =3D 1,
> > > > @@ -79,6 +81,7 @@ static const struct iio_chan_spec
> > > > accel_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > >                 .scan_index =3D CHANNEL_SCAN_INDEX_Z,
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         },
> > > >         IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> > > >  };
> > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-
> > > > attributes.c
> > > > index 9b279937a24e0..e367e4b482ef0 100644
> > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > @@ -585,6 +585,27 @@ int
> > > > hid_sensor_parse_common_attributes(struct hid_sensor_hub_device
> > > > *hsdev,
> > > >  }
> > > >  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, IIO_HID);
> > > >
> > > > +static const struct iio_mount_matrix hid_sensor_windows_axis =3D {
> > > > +       .rotation =3D {
> > > > +               "-1", "0", "0",
> > > > +               "0", "-1", "0",
> > > > +               "0", "0", "-1"
> > >
> > > Unless my memory of rotation matrices serves me wrong, that's not a
> > > rotation matrix.
> > > (det(R) !=3D 1)
This is indeed not a rotation matrix.
What I observed is when laying flat on the table (open at 180 degree),
using the sysfs interface the value reported by the laptops along the
Z axis is -1g, while using an android phone, the reported value is 1g.
Same thing when the device is lying on this left side (reported value
along the X axis -1g instead of 1g for an android phone), and when
resting on the front lip (reported value along the Y axis is -1g
instead of 1g).

> > >
> > > That's a an axis flip from a right handed set of axis to a left
> > > handed one.
> > > So to fix this up, you would need to invert the raw readings of at
> > > least one axis
> > > rather than rely on the mount matrix or make the scale negative.
Negative scale is a good option, but it will definitely break user
space applications, when the mount matrix may not be used today.

Gwendal.
> > >
> > > Jonathan
> > >
> > >
> > > > +       }
> > > > +};
> > > > +
> > > > +static const struct iio_mount_matrix *
> > > > +hid_sensor_get_mount_matrix(const struct iio_dev *indio_dev,
> > > > +                               const struct iio_chan_spec *chan)
> > > > +{
> > > > +       return &hid_sensor_windows_axis;
> > > > +}
> > > > +
> > > > +const struct iio_chan_spec_ext_info hid_sensor_ext_info[] =3D {
> > > > +       IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE,
> > > > hid_sensor_get_mount_matrix),
> > > > +       { }
> > > > +};
> > > > +EXPORT_SYMBOL(hid_sensor_ext_info);
> > > > +
> > > >  MODULE_AUTHOR("Srinivas Pandruvada
> > > > <srinivas.pandruvada@intel.com>");
> > > >  MODULE_DESCRIPTION("HID Sensor common attribute processing");
> > > >  MODULE_LICENSE("GPL");
> > > > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > index 8f0ad022c7f1b..b852f5166bb21 100644
> > > > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > @@ -58,6 +58,7 @@ static const struct iio_chan_spec
> > > > gyro_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > >                 .scan_index =3D CHANNEL_SCAN_INDEX_X,
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         }, {
> > > >                 .type =3D IIO_ANGL_VEL,
> > > >                 .modified =3D 1,
> > > > @@ -68,6 +69,7 @@ static const struct iio_chan_spec
> > > > gyro_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > >                 .scan_index =3D CHANNEL_SCAN_INDEX_Y,
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         }, {
> > > >                 .type =3D IIO_ANGL_VEL,
> > > >                 .modified =3D 1,
> > > > @@ -78,6 +80,7 @@ static const struct iio_chan_spec
> > > > gyro_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > >                 .scan_index =3D CHANNEL_SCAN_INDEX_Z,
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         },
> > > >         IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> > > >  };
> > > > diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > index e85a3a8eea908..aefbdb9b0869a 100644
> > > > --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > > @@ -74,6 +74,7 @@ static const struct iio_chan_spec
> > > > magn_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SCALE) |
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         }, {
> > > >                 .type =3D IIO_MAGN,
> > > >                 .modified =3D 1,
> > > > @@ -83,6 +84,7 @@ static const struct iio_chan_spec
> > > > magn_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SCALE) |
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         }, {
> > > >                 .type =3D IIO_MAGN,
> > > >                 .modified =3D 1,
> > > > @@ -92,6 +94,7 @@ static const struct iio_chan_spec
> > > > magn_3d_channels[] =3D {
> > > >                 BIT(IIO_CHAN_INFO_SCALE) |
> > > >                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > >                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > > +               .ext_info =3D hid_sensor_ext_info,
> > > >         }, {
> > > >                 .type =3D IIO_ROT,
> > > >                 .modified =3D 1,
> > > > diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-
> > > > sensor-hub.h
> > > > index c27329e2a5ad5..ee7d5b430a785 100644
> > > > --- a/include/linux/hid-sensor-hub.h
> > > > +++ b/include/linux/hid-sensor-hub.h
> > > > @@ -236,6 +236,8 @@ struct hid_sensor_common {
> > > >         struct work_struct work;
> > > >  };
> > > >
> > > > +extern const struct iio_chan_spec_ext_info
> > > > hid_sensor_ext_info[];
> > > > +
> > > >  /* Convert from hid unit expo to regular exponent */
> > > >  static inline int hid_sensor_convert_exponent(int unit_expo)
> > > >  {
> > >
> >
>
