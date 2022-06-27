Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE455C53A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiF0JGI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiF0JGH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 05:06:07 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF176398
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 02:06:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a10so8869884ioe.9
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I1dLXVtkvAOPSIoqrBe51ukdxG+svFiT+9o2W0BBFD0=;
        b=ogkHc61Ny7fDKXPMeRZDQtipMbuN0Ro5cBgA6kHZ79t03WnNvq1NJoHVsuOX4jg0GO
         Pz8h9a1l9EDoD1nfOT4UNUG/32nfun5L4FREroEJCF193db5JYchoPzcBxca8/ECDznK
         psSGfQmp2qPSFePHxHkXm2mK4ZHCjQW/cKm3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I1dLXVtkvAOPSIoqrBe51ukdxG+svFiT+9o2W0BBFD0=;
        b=1bWLFZcevBwJequi36cyDcfGmKIDcjIOHgwSY+VZ4OVqmEautI6fkm1wKwJ2Q/zooh
         0Lde29jnbPhnCJ0TB8m7M5DhAxPnavagoLA8+myIASvNhkToIhhsvzUeUX7W1/y7tHSu
         5Gt1nkOcWgrPiTCdHIP/IHRlfPhs08XUIOScMK5QsuVa3DKxHOCfCZmdeoAOZ3MxpSF+
         Sd4QJNXZNQol7LiHzhNlKuXZEK/c1VOm54y/lSG4QRZkSSbWfpiMJnIFfyrTstO9PU8m
         QvDVR9dcgx3zCZXaBop5UUhvdcEAE95Nio8skmcLOZaCKqxxtQbn3uZ/Sez37BDgXYdy
         /Umw==
X-Gm-Message-State: AJIora98YauubCjbar5kQnIaIqtz6xErGnx0NAE5OtCMQAq8NVrKEnfD
        54A7JNKAvJuzW2fmmNtmpcOSfGwc51Hd0S0GBo/c0g==
X-Google-Smtp-Source: AGRyM1vgd6iSkgZzDjcMdFPuMvtnYWWP6LVT0CK5Tv91ZPhTpDU8vg00jmamRiNXVKbv3nvgj37JUa/Xru25e1/JtO4=
X-Received: by 2002:a05:6638:37a6:b0:339:c91c:76ba with SMTP id
 w38-20020a05663837a600b00339c91c76bamr7187481jal.103.1656320762173; Mon, 27
 Jun 2022 02:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220624223341.2625231-1-gwendal@chromium.org>
 <20220625120937.24c51ca4@jic23-huawei> <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
 <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
 <CAPUE2usnMyDN5DpgY_dtj73Jb811-9Y6Q8ZLsnqKiA7=q=74UQ@mail.gmail.com> <60f39446-a764-2f7f-ec6c-30f49ada3f07@redhat.com>
In-Reply-To: <60f39446-a764-2f7f-ec6c-30f49ada3f07@redhat.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 27 Jun 2022 02:05:50 -0700
Message-ID: <CAPUE2uv-GS2ZMhmzmLzHhUGyrtDJ0GVvk17JafnMSSYdnK8z0g@mail.gmail.com>
Subject: Re: [PATCH] iio/hid: Add mount_matrix
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, jikos@kernel.org,
        wpsmith@google.com, linux-iio@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

 of

On Sun, Jun 26, 2022 at 7:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/25/22 22:52, Gwendal Grignou wrote:
> > On Sat, Jun 25, 2022 at 11:27 AM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> >>
> >> On Sat, 2022-06-25 at 14:33 +0200, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> Jonathan, thanks for Cc-ing me on this.
> >>>
> >>> On 6/25/22 13:09, Jonathan Cameron wrote:
> >>>> On Fri, 24 Jun 2022 15:33:41 -0700
> >>>> Gwendal Grignou <gwendal@chromium.org> wrote:
> >>>>
> >>>>> ISH based sensors do not naturally return data in the W3C
> >>>>> 'natural'
> >>>>> orientation.
> >>>>> They returns all data inverted, to match Microsoft Windows
> >>>>> requirement:
> >>>>> [
> >>>>> https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/senso
> >>>>> rs#accelerometer]
> >>>>> """ If the device has the SimpleOrientation of FaceUp on a table,
> >>>>> then
> >>>>> the accelerometer would read -1 G on the Z axis. """
> >>>>
> >>>> Probably reference the HID Usage Tables 1.3 spec rather than the MS
> >>>> one.
> >>>> https://usb.org/sites/default/files/hut1_3_0.pdf
> > That document does not clearly defined what the accelerometer should re=
turn.
> >>>> After some waving around of my left and right hand I'm fairly sure
> >>>> that says the same
> >>>> thing as the MS spec. Section 4.4 Vector Usages
> >>>>
> >>>>> While W3C defines
> >>>>> [https://www.w3.org/TR/motion-sensors/#accelerometer-sensor]
> >>>>> """The Accelerometer sensor is an inertial-frame sensor, this
> >>>>> means that
> >>>>> when the device is in free fall, the acceleration is 0 m/s2 in
> >>>>> the
> >>>>> falling direction, and when a device is laying flat on a table,
> >>>>> the
> >>>>> acceleration in upwards direction will be equal to the Earth
> >>>>> gravity,
> >>>>> i.e. g =E2=89=A1 9.8 m/s2 as it is measuring the force of the table
> >>>>> pushing the
> >>>>> device upwards."""
> >>>>>
> >>>>> Fixes all HID sensors that defines IIO_MOD_[XYZ] attributes.
> >>>>>
> >>>>> Tested on "HP Spectre x360 Convertible 13" and "Dell XPS 13
> >>>>> 9365".
> >>>>>
> >>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >>>>
> >>>> Ah.  Whilst this is a fix, it seems likely to break a whole bunch
> >>>> of existing
> >>>> users that are compensating for the wrong orientation in
> >>>> userspace.  Also, do
> >>>> we know how universal this is?  I have a nasty feeling it'll turn
> >>>> out some
> >>>> HID sensors do it the other way whatever the spec says.  Bastien,
> >>>> are you
> >>>> carrying a local fix for this in your userspace code?
> >>>>
> >>>> +CC a few people who are likely to know more on just how bad that
> >>>> will be...
> >>>
> >>> Right, so Linux userspace expects an axis system similar to the
> >>> Android one,
> >>> which is actually the one which seems to be described here.
> >>>
> >>> The axis system expect is that when a tablet is layed flat on the
> >>> table,
> >>> the x and y axis are as one would expect when drawing a mathematics
> >>> graph on the surface of the tablet.
> >>>
> >>> So X-axis goes from left to right, with left side being lower numbers
> >>> and
> >>> right side higher numbers.
> >>>
> >>> And Y-axis goes from bottom to top, with the bottom being lower
> >>> numbers and
> >>> the top higher numbers.
> >>>
> >>> That leaves the Z-axis which comes out of the screen at a 90=C2=B0 an=
gle
> >>> (to both
> >>> the X and Y axis) and the vector coming out of the screen towards to
> >>> the user /
> >>> observer of the screen indicates positive numbers where as imagining
> >>> the same
> >>> axis pointing down through the table on which the tables is lying
> >>> towards
> >>> the floor represents negative numbers.
> >>>
> >>> This means that the accel values of a tablet resting on a table,
> >>> expresses
> >>> in units of 1G are: [ 0, 0, -1 ] and I've seen quite a few HID
> >>> sensors
> > But W3C and Android expect [ 0, 0, 1g ] when resting on the table. See
> > commit message for W3C and for Android, see
> > https://source.android.com/devices/sensors/sensor-types#accelerometer
> > """When the device lies flat on a table, the acceleration value along
> > z is +9.81 alo, which corresponds to the acceleration of the device (0
> > m/s^2) minus the force of gravity (-9.81 m/s^2)."""". That is why we
> > need to change the sign to be consistent with these standards.
>
> Windows and HID devices use [ 0, 0, -1 ] for device face up on
> a flat table and
> this is what Linux has been reporting to userspace for many many years no=
w.
This is not true. Most drivers for standalone sensor report [ 0, 0, 1]
when the accelerometer sits face up on a table. For instance:
- in driver drivers/iio/accel/kxcjk-1013.c, read INFO_RAW reports the
raw accelerometer for sensor KX023 (see datasheet
https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20R=
ev%2012.0.pdf
page 17), as the scale is a positive value.
- same for sensor BMI160 in driver
drivers/iio/imu/bmi160/bmi160_core.c. The BMI160 axis conforms to W3C
and Android requirement (see
https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/b=
st-bmi160-ds000.pdf
page 107).
> Auto-display-rotation based in accel
> reading was first supported in GNOME through iio-sensor-proxy
> in 2014 !
>
> And iio-sensor-proxy expects the Windows/HID sign of the axis
> you can NOT just go and change this, that would break 8 years
> of precedent of using the current Windows/HID sign (+/-) for
> the axis!
>
> Also besides the kernel reporting a matrix it is also possible
> for userspace to provide a matrix using udev's hwdb:
>
> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb
Note that the determinant of most of the matrices in this file equals
-1. It means these matrices do not just describe a rotation, they
first invert the axis (see
https://en.wikipedia.org/wiki/Determinant#Orientation_of_a_basis)
136 out of 160 matrices invert the axes. In particular, entries with
acpi:KIOX... 42 out of 45 are inverted, with acpi:BOSC0200*, 22 out 31
are, with acpi:SMO8500* 25 out 27 are.

The matrices for directly connected accelerometers/IMU where axes are
not inverted may be errors and confirm that some IIO drivers do report
[ 0, 0, 1 ] for accelerometer ICs face up. I will send a more detailed
message with my findings on the systemd mailing list.

>
> This has been in place since 2016 and this sets a matrix adjusting
> readings of non HID sensors to match the *HID/windows* definition
> of the axis.
>
> >>> with accel reporting on various devices and they all adhere to this
> >>> without applying any accel matrix. Or in other words, HID sensors
> >>> behave
> >>> as expected by userspace when applying the norm matrix of:
> >>>
> >>>         .rotation =3D {
> >>>                 "1", "0", "0",
> >>>                 "0", "1", "0",
> >>>                 "0", "0", "1"
> >>>
> >>> And this patch will cause the image to be upside down (no matter what
> >>> the
> >>> rotation) when using auto-rotation with iio-sensor-proxy.
> >>>
> >>> So big NACK from me for this patch.
> >>>
> >>> I'm not sure what this patch is trying to fix but it looks to me like
> >>> it
> >>> is a bug in the HID sensors implementation of the specific device.
> > This is a not a bug since HID sensors from 2 laptops from different
> > manufacturers (HP and Dell) report the same values.
>
> Right, I wrongly assumed the Android definition would match the
> IMHO much saner / much more intuitive HID/Windows definitions,
> since the arrows in the phone image in the Android docs point
> in the same direction as the Windows docs.
>
> But I have tested on an Android phone now and I see that
> Android indeed has all the axis inverted.
>
> >>> Again HID-sensors already work fine on tons of existing devices
> >>> without
> >>> any matrix getting applied.
> > Note this patch does not change the value reported by the sensor, just
> > define a matrix to make sure the sensors values are consistent with
> > Android/W3C.
>
> And iio-sensor-proxy will read the kernel provided matrix, apply it
> and then put the image upside down since you've just mirrored both
> the X and Y axis, breaking rotation for all existing GNOME and KDE
> users.
>
> So still a big NACK from me.
>
> If Android needs the axis to be flipped, then it should do so
> in the iio-sensor HAL inside android, not add a matrix which
> breaks 8 years of userspace API convention.
>
> Breaking userspace is simply not acceptible, we have a very clear
> no regressions policy. So this patch simply cannot be merged: NACK.
I agree this patch is not right, but it has at least the merit to
reveal an inconsistency among IIO drivers. As Jonathan suggested, some
drivers should return a negative scale. We need to choose which ones
should: either the group of drivers that reports unaltered data from
the hardware sensors and conform to W3C standard and android
specification, or the ones that conform to the HID specification.

Regards,

Gwendal.
>
> Regards,
>
> Hans
>
>
>
>
> >>>> One other thing inline.  The mount matrix you've provided isn't a
> >>>> rotation matrix.
> >>>>
> >>>> I'd forgotten the annoyance of graphics folks using the right
> >>>> handed sensor
> >>>> axis whilst nearly all other uses are left handed. It drove me mad
> >>>> many years
> >>>> ago - every code base that used sensors and rendered the result
> >>>> needed a
> >>>> flip of the z axis - it was never well documented, so half the time
> >>>> the code ended up with many axis flips based on people debugging
> >>>> local
> >>>> orientation problems.  *sigh*
> >>>>
> >>>>
> >>>>> ---
> >>>>>  drivers/iio/accel/hid-sensor-accel-3d.c       |  3 +++
> >>>>>  .../hid-sensors/hid-sensor-attributes.c       | 21
> >>>>> +++++++++++++++++++
> >>>>>  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 +++
> >>>>>  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 +++
> >>>>>  include/linux/hid-sensor-hub.h                |  2 ++
> >>>>>  5 files changed, 32 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
> >>>>> b/drivers/iio/accel/hid-sensor-accel-3d.c
> >>>>> index a2def6f9380a3..980bbd7fba502 100644
> >>>>> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> >>>>> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> >>>>> @@ -59,6 +59,7 @@ static const struct iio_chan_spec
> >>>>> accel_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>                 .scan_index =3D CHANNEL_SCAN_INDEX_X,
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         }, {
> >>>>>                 .type =3D IIO_ACCEL,
> >>>>>                 .modified =3D 1,
> >>>>> @@ -69,6 +70,7 @@ static const struct iio_chan_spec
> >>>>> accel_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>                 .scan_index =3D CHANNEL_SCAN_INDEX_Y,
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         }, {
> >>>>>                 .type =3D IIO_ACCEL,
> >>>>>                 .modified =3D 1,
> >>>>> @@ -79,6 +81,7 @@ static const struct iio_chan_spec
> >>>>> accel_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>                 .scan_index =3D CHANNEL_SCAN_INDEX_Z,
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         },
> >>>>>         IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> >>>>>  };
> >>>>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> >>>>> attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-
> >>>>> attributes.c
> >>>>> index 9b279937a24e0..e367e4b482ef0 100644
> >>>>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> >>>>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> >>>>> @@ -585,6 +585,27 @@ int
> >>>>> hid_sensor_parse_common_attributes(struct hid_sensor_hub_device
> >>>>> *hsdev,
> >>>>>  }
> >>>>>  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, IIO_HID);
> >>>>>
> >>>>> +static const struct iio_mount_matrix hid_sensor_windows_axis =3D {
> >>>>> +       .rotation =3D {
> >>>>> +               "-1", "0", "0",
> >>>>> +               "0", "-1", "0",
> >>>>> +               "0", "0", "-1"
> >>>>
> >>>> Unless my memory of rotation matrices serves me wrong, that's not a
> >>>> rotation matrix.
> >>>> (det(R) !=3D 1)
> > This is indeed not a rotation matrix.
> > What I observed is when laying flat on the table (open at 180 degree),
> > using the sysfs interface the value reported by the laptops along the
> > Z axis is -1g, while using an android phone, the reported value is 1g.
> > Same thing when the device is lying on this left side (reported value
> > along the X axis -1g instead of 1g for an android phone), and when
> > resting on the front lip (reported value along the Y axis is -1g
> > instead of 1g).
> >
> >>>>
> >>>> That's a an axis flip from a right handed set of axis to a left
> >>>> handed one.
> >>>> So to fix this up, you would need to invert the raw readings of at
> >>>> least one axis
> >>>> rather than rely on the mount matrix or make the scale negative.
> > Negative scale is a good option, but it will definitely break user
> > space applications, when the mount matrix may not be used today.
> >
> > Gwendal.
> >>>>
> >>>> Jonathan
> >>>>
> >>>>
> >>>>> +       }
> >>>>> +};
> >>>>> +
> >>>>> +static const struct iio_mount_matrix *
> >>>>> +hid_sensor_get_mount_matrix(const struct iio_dev *indio_dev,
> >>>>> +                               const struct iio_chan_spec *chan)
> >>>>> +{
> >>>>> +       return &hid_sensor_windows_axis;
> >>>>> +}
> >>>>> +
> >>>>> +const struct iio_chan_spec_ext_info hid_sensor_ext_info[] =3D {
> >>>>> +       IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE,
> >>>>> hid_sensor_get_mount_matrix),
> >>>>> +       { }
> >>>>> +};
> >>>>> +EXPORT_SYMBOL(hid_sensor_ext_info);
> >>>>> +
> >>>>>  MODULE_AUTHOR("Srinivas Pandruvada
> >>>>> <srinivas.pandruvada@intel.com>");
> >>>>>  MODULE_DESCRIPTION("HID Sensor common attribute processing");
> >>>>>  MODULE_LICENSE("GPL");
> >>>>> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> >>>>> b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> >>>>> index 8f0ad022c7f1b..b852f5166bb21 100644
> >>>>> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> >>>>> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> >>>>> @@ -58,6 +58,7 @@ static const struct iio_chan_spec
> >>>>> gyro_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>                 .scan_index =3D CHANNEL_SCAN_INDEX_X,
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         }, {
> >>>>>                 .type =3D IIO_ANGL_VEL,
> >>>>>                 .modified =3D 1,
> >>>>> @@ -68,6 +69,7 @@ static const struct iio_chan_spec
> >>>>> gyro_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>                 .scan_index =3D CHANNEL_SCAN_INDEX_Y,
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         }, {
> >>>>>                 .type =3D IIO_ANGL_VEL,
> >>>>>                 .modified =3D 1,
> >>>>> @@ -78,6 +80,7 @@ static const struct iio_chan_spec
> >>>>> gyro_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>>                 .scan_index =3D CHANNEL_SCAN_INDEX_Z,
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         },
> >>>>>         IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> >>>>>  };
> >>>>> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> >>>>> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> >>>>> index e85a3a8eea908..aefbdb9b0869a 100644
> >>>>> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> >>>>> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> >>>>> @@ -74,6 +74,7 @@ static const struct iio_chan_spec
> >>>>> magn_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         }, {
> >>>>>                 .type =3D IIO_MAGN,
> >>>>>                 .modified =3D 1,
> >>>>> @@ -83,6 +84,7 @@ static const struct iio_chan_spec
> >>>>> magn_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         }, {
> >>>>>                 .type =3D IIO_MAGN,
> >>>>>                 .modified =3D 1,
> >>>>> @@ -92,6 +94,7 @@ static const struct iio_chan_spec
> >>>>> magn_3d_channels[] =3D {
> >>>>>                 BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>>>>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
> >>>>> +               .ext_info =3D hid_sensor_ext_info,
> >>>>>         }, {
> >>>>>                 .type =3D IIO_ROT,
> >>>>>                 .modified =3D 1,
> >>>>> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-
> >>>>> sensor-hub.h
> >>>>> index c27329e2a5ad5..ee7d5b430a785 100644
> >>>>> --- a/include/linux/hid-sensor-hub.h
> >>>>> +++ b/include/linux/hid-sensor-hub.h
> >>>>> @@ -236,6 +236,8 @@ struct hid_sensor_common {
> >>>>>         struct work_struct work;
> >>>>>  };
> >>>>>
> >>>>> +extern const struct iio_chan_spec_ext_info
> >>>>> hid_sensor_ext_info[];
> >>>>> +
> >>>>>  /* Convert from hid unit expo to regular exponent */
> >>>>>  static inline int hid_sensor_convert_exponent(int unit_expo)
> >>>>>  {
> >>>>
> >>>
> >>
> >
>
