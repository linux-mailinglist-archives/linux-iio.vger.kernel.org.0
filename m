Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED424573A82
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jul 2022 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiGMPtT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jul 2022 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiGMPtL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2022 11:49:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BA1C931
        for <linux-iio@vger.kernel.org>; Wed, 13 Jul 2022 08:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC0ABB820C1
        for <linux-iio@vger.kernel.org>; Wed, 13 Jul 2022 15:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1377DC341C8;
        Wed, 13 Jul 2022 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657727346;
        bh=Ji3Gvdu3ul/VIlUZZN7/npqxBOizUSzAPVucMqI0NgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTCVspAwbi0HRHRJvL+aug9YqZC9g+MriFL10GT7JyL/c7dMvEu3DNTxdhcbNSlHQ
         8bZuHlZUV52vmgmQx5aHgjNT/R7qeaiHiBhK0stxzdgPsxk6wltwM8aMIjYwqJKzfS
         4Wq0oR/1n2QuvmZjEZBej7IH5kQ4bMuMUOXpnOz3hQeuJsUalzgx1LX7OtLnCVSwPG
         +s5jZt199lc7Yh+uw3rvRhQ8s0oCUlQEpIDnF8RY0Rhi+ACvsfOas1xIt8nf82EOCa
         R0KiJ/XvaxKkBRlgYMPwNuuL3kz6DpARbW+zsz1tKiX/uwhqlNgeaeF2dWxiCAQ/48
         8XC8yRM7WD8iw==
Date:   Wed, 13 Jul 2022 16:58:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org, wpsmith@google.com, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] iio/hid: Add mount_matrix
Message-ID: <20220713165854.27828d0c@jic23-huawei>
In-Reply-To: <c5fda5ad-59fb-c933-c640-4b3e44ec95ca@redhat.com>
References: <20220624223341.2625231-1-gwendal@chromium.org>
        <20220625120937.24c51ca4@jic23-huawei>
        <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
        <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
        <CAPUE2usnMyDN5DpgY_dtj73Jb811-9Y6Q8ZLsnqKiA7=q=74UQ@mail.gmail.com>
        <60f39446-a764-2f7f-ec6c-30f49ada3f07@redhat.com>
        <CAPUE2uv-GS2ZMhmzmLzHhUGyrtDJ0GVvk17JafnMSSYdnK8z0g@mail.gmail.com>
        <b0b9beb8440ca40e6673b1ee8473708516d639cb.camel@hadess.net>
        <c5fda5ad-59fb-c933-c640-4b3e44ec95ca@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jun 2022 14:33:09 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
>=20
> On 6/27/22 11:55, Bastien Nocera wrote:
> > On Mon, 2022-06-27 at 02:05 -0700, Gwendal Grignou wrote: =20
> >> =C2=A0of
> >>
> >> On Sun, Jun 26, 2022 at 7:42 AM Hans de Goede <hdegoede@redhat.com>
> >> wrote: =20
> >>>
> >>> Hi,
> >>>
> >>> On 6/25/22 22:52, Gwendal Grignou wrote: =20
> >>>> On Sat, Jun 25, 2022 at 11:27 AM srinivas pandruvada
> >>>> <srinivas.pandruvada@linux.intel.com> wrote: =20
> >>>>>
> >>>>> On Sat, 2022-06-25 at 14:33 +0200, Hans de Goede wrote: =20
> >>>>>> Hi,
> >>>>>>
> >>>>>> Jonathan, thanks for Cc-ing me on this.
> >>>>>>
> >>>>>> On 6/25/22 13:09, Jonathan Cameron wrote: =20
> >>>>>>> On Fri, 24 Jun 2022 15:33:41 -0700
> >>>>>>> Gwendal Grignou <gwendal@chromium.org> wrote:
> >>>>>>> =20
> >>>>>>>> ISH based sensors do not naturally return data in the W3C
> >>>>>>>> 'natural'
> >>>>>>>> orientation.
> >>>>>>>> They returns all data inverted, to match Microsoft
> >>>>>>>> Windows
> >>>>>>>> requirement:
> >>>>>>>> [
> >>>>>>>> https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sen=
so
> >>>>>>>> rs#accelerometer]
> >>>>>>>> """ If the device has the SimpleOrientation of FaceUp on
> >>>>>>>> a table,
> >>>>>>>> then
> >>>>>>>> the accelerometer would read -1 G on the Z axis. """ =20
> >>>>>>>
> >>>>>>> Probably reference the HID Usage Tables 1.3 spec rather
> >>>>>>> than the MS
> >>>>>>> one.
> >>>>>>> https://usb.org/sites/default/files/hut1_3_0.pdf =20
> >>>> That document does not clearly defined what the accelerometer
> >>>> should return. =20
> >>>>>>> After some waving around of my left and right hand I'm
> >>>>>>> fairly sure
> >>>>>>> that says the same
> >>>>>>> thing as the MS spec. Section 4.4 Vector Usages
> >>>>>>> =20
> >>>>>>>> While W3C defines
> >>>>>>>> [
> >>>>>>>> https://www.w3.org/TR/motion-sensors/#accelerometer-sensor
> >>>>>>>> ]
> >>>>>>>> """The Accelerometer sensor is an inertial-frame sensor,
> >>>>>>>> this
> >>>>>>>> means that
> >>>>>>>> when the device is in free fall, the acceleration is 0
> >>>>>>>> m/s2 in
> >>>>>>>> the
> >>>>>>>> falling direction, and when a device is laying flat on a
> >>>>>>>> table,
> >>>>>>>> the
> >>>>>>>> acceleration in upwards direction will be equal to the
> >>>>>>>> Earth
> >>>>>>>> gravity,
> >>>>>>>> i.e. g =E2=89=A1 9.8 m/s2 as it is measuring the force of the
> >>>>>>>> table
> >>>>>>>> pushing the
> >>>>>>>> device upwards."""
> >>>>>>>>
> >>>>>>>> Fixes all HID sensors that defines IIO_MOD_[XYZ]
> >>>>>>>> attributes.
> >>>>>>>>
> >>>>>>>> Tested on "HP Spectre x360 Convertible 13" and "Dell XPS
> >>>>>>>> 13
> >>>>>>>> 9365".
> >>>>>>>>
> >>>>>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org> =20
> >>>>>>>
> >>>>>>> Ah.=C2=A0 Whilst this is a fix, it seems likely to break a whole
> >>>>>>> bunch
> >>>>>>> of existing
> >>>>>>> users that are compensating for the wrong orientation in
> >>>>>>> userspace.=C2=A0 Also, do
> >>>>>>> we know how universal this is?=C2=A0 I have a nasty feeling
> >>>>>>> it'll turn
> >>>>>>> out some
> >>>>>>> HID sensors do it the other way whatever the spec says.=C2=A0
> >>>>>>> Bastien,
> >>>>>>> are you
> >>>>>>> carrying a local fix for this in your userspace code?
> >>>>>>>
> >>>>>>> +CC a few people who are likely to know more on just how
> >>>>>>> bad that
> >>>>>>> will be... =20
> >>>>>>
> >>>>>> Right, so Linux userspace expects an axis system similar to
> >>>>>> the
> >>>>>> Android one,
> >>>>>> which is actually the one which seems to be described here.
> >>>>>>
> >>>>>> The axis system expect is that when a tablet is layed flat on
> >>>>>> the
> >>>>>> table,
> >>>>>> the x and y axis are as one would expect when drawing a
> >>>>>> mathematics
> >>>>>> graph on the surface of the tablet.
> >>>>>>
> >>>>>> So X-axis goes from left to right, with left side being lower
> >>>>>> numbers
> >>>>>> and
> >>>>>> right side higher numbers.
> >>>>>>
> >>>>>> And Y-axis goes from bottom to top, with the bottom being
> >>>>>> lower
> >>>>>> numbers and
> >>>>>> the top higher numbers.
> >>>>>>
> >>>>>> That leaves the Z-axis which comes out of the screen at a 90=C2=B0
> >>>>>> angle
> >>>>>> (to both
> >>>>>> the X and Y axis) and the vector coming out of the screen
> >>>>>> towards to
> >>>>>> the user /
> >>>>>> observer of the screen indicates positive numbers where as
> >>>>>> imagining
> >>>>>> the same
> >>>>>> axis pointing down through the table on which the tables is
> >>>>>> lying
> >>>>>> towards
> >>>>>> the floor represents negative numbers.
> >>>>>>
> >>>>>> This means that the accel values of a tablet resting on a
> >>>>>> table,
> >>>>>> expresses
> >>>>>> in units of 1G are: [ 0, 0, -1 ] and I've seen quite a few
> >>>>>> HID
> >>>>>> sensors =20
> >>>> But W3C and Android expect [ 0, 0, 1g ] when resting on the
> >>>> table. See
> >>>> commit message for W3C and for Android, see
> >>>> https://source.android.com/devices/sensors/sensor-types#accelerometer
> >>>> """When the device lies flat on a table, the acceleration value
> >>>> along
> >>>> z is +9.81 alo, which corresponds to the acceleration of the
> >>>> device (0
> >>>> m/s^2) minus the force of gravity (-9.81 m/s^2)."""". That is why
> >>>> we
> >>>> need to change the sign to be consistent with these standards. =20
> >>>
> >>> Windows and HID devices use [ 0, 0, -1 ] for device face up on
> >>> a flat table and
> >>> this is what Linux has been reporting to userspace for many many
> >>> years now. =20
> >> This is not true. Most drivers for standalone sensor report [ 0, 0,
> >> 1]
> >> when the accelerometer sits face up on a table. For instance:
> >> - in driver drivers/iio/accel/kxcjk-1013.c, read INFO_RAW reports the
> >> raw accelerometer for sensor KX023 (see datasheet
> >> https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specification=
s%20Rev%2012.0.pdf
> >> page 17), as the scale is a positive value.
> >> - same for sensor BMI160 in driver
> >> drivers/iio/imu/bmi160/bmi160_core.c. The BMI160 axis conforms to W3C
> >> and Android requirement (see
> >> https://www.bosch-sensortec.com/media/boschsensortec/downloads/datashe=
ets/bst-bmi160-ds000.pdf
> >> page 107). =20
> >=20
> > Accelerometers can be installed in any orientation inside the shell of
> > the device, which means that raw data reported from the device needs to
> > be checked against how it's implemented.
> >  =20
> >>> Auto-display-rotation based in accel
> >>> reading was first supported in GNOME through iio-sensor-proxy
> >>> in 2014 !
> >>>
> >>> And iio-sensor-proxy expects the Windows/HID sign of the axis
> >>> you can NOT just go and change this, that would break 8 years
> >>> of precedent of using the current Windows/HID sign (+/-) for
> >>> the axis!
> >>>
> >>> Also besides the kernel reporting a matrix it is also possible
> >>> for userspace to provide a matrix using udev's hwdb:
> >>>
> >>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb =20
> >> Note that the determinant of most of the matrices in this file equals
> >> -1. It means these matrices do not just describe a rotation, they
> >> first invert the axis (see
> >> https://en.wikipedia.org/wiki/Determinant#Orientation_of_a_basis)
> >> 136 out of 160 matrices invert the axes. In particular, entries with
> >> acpi:KIOX... 42 out of 45 are inverted, with acpi:BOSC0200*, 22 out
> >> 31
> >> are, with acpi:SMO8500* 25 out 27 are.
> >>
> >> The matrices for directly connected accelerometers/IMU where axes are
> >> not inverted may be errors and confirm that some IIO drivers do
> >> report
> >> [ 0, 0, 1 ] for accelerometer ICs face up. I will send a more
> >> detailed
> >> message with my findings on the systemd mailing list. =20
> >=20
> > You're already in touch with the people who have worked on that code
> > here (that'd be Hans and myself).
> >  =20
> >> =20
> >>>
> >>> This has been in place since 2016 and this sets a matrix adjusting
> >>> readings of non HID sensors to match the *HID/windows* definition
> >>> of the axis.
> >>> =20
> >>>>>> with accel reporting on various devices and they all adhere
> >>>>>> to this
> >>>>>> without applying any accel matrix. Or in other words, HID
> >>>>>> sensors
> >>>>>> behave
> >>>>>> as expected by userspace when applying the norm matrix of:
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rotation =3D {
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "1", "0", "0",
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "0", "1", "0",
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "0", "0", "1"
> >>>>>>
> >>>>>> And this patch will cause the image to be upside down (no
> >>>>>> matter what
> >>>>>> the
> >>>>>> rotation) when using auto-rotation with iio-sensor-proxy.
> >>>>>>
> >>>>>> So big NACK from me for this patch.
> >>>>>>
> >>>>>> I'm not sure what this patch is trying to fix but it looks to
> >>>>>> me like
> >>>>>> it
> >>>>>> is a bug in the HID sensors implementation of the specific
> >>>>>> device. =20
> >>>> This is a not a bug since HID sensors from 2 laptops from
> >>>> different
> >>>> manufacturers (HP and Dell) report the same values. =20
> >>>
> >>> Right, I wrongly assumed the Android definition would match the
> >>> IMHO much saner / much more intuitive HID/Windows definitions,
> >>> since the arrows in the phone image in the Android docs point
> >>> in the same direction as the Windows docs.
> >>>
> >>> But I have tested on an Android phone now and I see that
> >>> Android indeed has all the axis inverted.
> >>> =20
> >>>>>> Again HID-sensors already work fine on tons of existing
> >>>>>> devices
> >>>>>> without
> >>>>>> any matrix getting applied. =20
> >>>> Note this patch does not change the value reported by the sensor,
> >>>> just
> >>>> define a matrix to make sure the sensors values are consistent
> >>>> with
> >>>> Android/W3C. =20
> >>>
> >>> And iio-sensor-proxy will read the kernel provided matrix, apply it
> >>> and then put the image upside down since you've just mirrored both
> >>> the X and Y axis, breaking rotation for all existing GNOME and KDE
> >>> users.
> >>>
> >>> So still a big NACK from me.
> >>>
> >>> If Android needs the axis to be flipped, then it should do so
> >>> in the iio-sensor HAL inside android, not add a matrix which
> >>> breaks 8 years of userspace API convention.
> >>>
> >>> Breaking userspace is simply not acceptible, we have a very clear
> >>> no regressions policy. So this patch simply cannot be merged: NACK. =
=20
> >> I agree this patch is not right, but it has at least the merit to
> >> reveal an inconsistency among IIO drivers. As Jonathan suggested,
> >> some
> >> drivers should return a negative scale. We need to choose which ones
> >> should: either the group of drivers that reports unaltered data from
> >> the hardware sensors and conform to W3C standard and android
> >> specification, or the ones that conform to the HID specification. =20
> >=20
> > You need to realise that the drivers aren't created equal.
> >=20
> > Whether a driver returns:
> > - the raw readings from the sensor (which might or might not be aligned
> > with the Android, Windows 8 or IIO docs),
> > - adjusted readings (meant to be used as-is if the sensor is mounted
> > with the right orientation inside the right component of the device),
> > - or completely ludicrous readings because the sensor is in the wrong
> > part of the system, or tracks something else (all the HP "disk fall"
> > sensors)
> >=20
> > all those are essentially API. You can't "fix" this after the fact. I,
> > and others who contributed to the systemd quirks file, expected the
> > kernel readings to not change with the kernel version.
> >=20
> > The right approach would be to define which is the expected orientation
> > in the IIO docs, although that already seems to be done[1], and
> > actually make sure this is respected in *new* implementations.
> >=20
> > Finally, I'll also add that the implementation in iio-sensor-proxy
> > expects a single authoritative mount matrix to be provided for a
> > device, as a mount matrix is supposed to correct the readings for the
> > way a sensor was mounted inside the chassis/display of a particular
> > device.
> >=20
> > Cheers
> >=20
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Docu=
mentation/ABI/testing/sysfs-bus-iio#n1838
> > An implementor might consider that for a hand-held device, a
> > 'natural' orientation would be 'front facing camera at the top'.
> > The main hardware reference frame could then be described as :
> > * Y is in the plane of the screen and is positive towards the
> >   top of the screen ;
> > * X is in the plane of the screen, perpendicular to Y axis, and
> >   positive towards the right hand side of the screen ;
> > * Z is perpendicular to the screen plane and positive out of the
> >   screen. =20
>=20
> Note though that this does not clearly define what
> e.g. "positive towards the top of the screen" means if
> you look at the axis illustrations in both the Windows,
> Android and W3C docs they all have an arrow pointing
> towards the top of the screen for the Y axis, which
> matches the "positive towards the top of the screen"
> wording.
>=20
> Yet Android / W3C expect a positive reading when
> the G force vector is pointing down. Which I still
> find confusing.
>=20
> This means that we to add a text similar to the Windows
> docs here, say something like (made up by me not copy
> pasted from Windows docs):
>=20
> "The Z-axis reading will be -1G when a device is laying
> flat on a table with its display facing up"
>=20
> To fix the are we measuring gravity or force countering
> gravity confusion.
>=20
> Jonathan, shall I submit a patch to add this, maybe with
> some extra text that we are following the Windows/HID
> convention and that Android/W3C do things differently?

I'm not going to rush this through late in a cycle.
So propose a text update and let's carry on the discussion
around that. (you may already have done so - I'm way behind!)

Given we have a bunch of mount matrices that aren't rotation
matrices out in the wild, we probably want to cover that as
well, potentially by relaxing the definition to allow
rotoinversions, or at least state they are out there even if
we actively discourage them going forwards.=20

Also, I just remembered Linus w wrote the docs in the first
place and there was a long discussion at the time so +CC

Thanks,

Jonathan



>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> >  =20
>=20

