Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1955D46A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbiF1MdS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbiF1MdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 08:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D83611115E
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656419594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPEgyWhR3gtMllDqYTKqpo/j67wRckz71Yt1iBrcd4k=;
        b=RKKZChYc06ImmH+gEot81O9a/HKmnGmgVQeGcpuOHxtAQafxw1fWUOpfMEJ4Glvc+VNjTY
        YNLZbUXI90Bc/cv34+OedtTjTr20tboJuZzZEbhMvlUkmJxRYV9+ogxsREQABTkr8eaYu1
        UnQThTq3iWHWMwqghdfMaFUDvbE4jAg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-dAEqyLRzM-KwyAt8HqWR2w-1; Tue, 28 Jun 2022 08:33:13 -0400
X-MC-Unique: dAEqyLRzM-KwyAt8HqWR2w-1
Received: by mail-ej1-f72.google.com with SMTP id l2-20020a170906078200b006fed42bfeacso3593803ejc.16
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mPEgyWhR3gtMllDqYTKqpo/j67wRckz71Yt1iBrcd4k=;
        b=6vtipl/mvD8/1WeNI1SWAOtbEwh7l//Hfs5KaLj2/F3CRG2l4Ht7JOzOSHRG/ojqtg
         rJ40m8/m2sR/ln8B1MJ+0aknFGnHgV+cvvp5s3/3gAbXJTEWrUePypwzZOFdyG0jzxkR
         WMTiULG/zbBoj+4FOTTDKyCzXfDaOTlrUTl+oa1wB0mOMj6eGkMhKE/v8IVDPbYMycgu
         KbQmiQmm6nFVTlLcIKuaO3NJjjliirJL/81qUmqQwq5htFztOG1L+LwU1ke7en8eGSE9
         LeMfKZq2F1BHETAHVrstvt3JxkjrJ5seqi3g0E6cuTzP0g/ID4bhByjN1ainW7gjoBdm
         zxAw==
X-Gm-Message-State: AJIora9nckKGSKW0gZZTN2UaetSv8Gk6qIsFMwX3eqZeuycfpBGGiKzD
        sst1BmyUJHZcV8PJKGGU72iiTDTOWdM4INz2pax1//hT97GvlcAGWaVwMHdy9CYLGF/6nEetfAn
        CwrZ7JAou2sbUx6Cy1NNj
X-Received: by 2002:a17:906:106:b0:722:e997:a365 with SMTP id 6-20020a170906010600b00722e997a365mr17683352eje.169.1656419592295;
        Tue, 28 Jun 2022 05:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uNFmRMGnkBmTViDcmFVRMqMs1asUcKkk5yGOwP6vFylrNz84lYBJsizQNwztQYEaohKlbNTw==
X-Received: by 2002:a17:906:106:b0:722:e997:a365 with SMTP id 6-20020a170906010600b00722e997a365mr17683321eje.169.1656419591929;
        Tue, 28 Jun 2022 05:33:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jz27-20020a17090775fb00b006fecf74395bsm6446620ejc.8.2022.06.28.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:33:11 -0700 (PDT)
Message-ID: <c5fda5ad-59fb-c933-c640-4b3e44ec95ca@redhat.com>
Date:   Tue, 28 Jun 2022 14:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iio/hid: Add mount_matrix
Content-Language: en-US
To:     Bastien Nocera <hadess@hadess.net>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, jikos@kernel.org,
        wpsmith@google.com, linux-iio@vger.kernel.org
References: <20220624223341.2625231-1-gwendal@chromium.org>
 <20220625120937.24c51ca4@jic23-huawei>
 <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
 <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
 <CAPUE2usnMyDN5DpgY_dtj73Jb811-9Y6Q8ZLsnqKiA7=q=74UQ@mail.gmail.com>
 <60f39446-a764-2f7f-ec6c-30f49ada3f07@redhat.com>
 <CAPUE2uv-GS2ZMhmzmLzHhUGyrtDJ0GVvk17JafnMSSYdnK8z0g@mail.gmail.com>
 <b0b9beb8440ca40e6673b1ee8473708516d639cb.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b0b9beb8440ca40e6673b1ee8473708516d639cb.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 6/27/22 11:55, Bastien Nocera wrote:
> On Mon, 2022-06-27 at 02:05 -0700, Gwendal Grignou wrote:
>>  of
>>
>> On Sun, Jun 26, 2022 at 7:42 AM Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 6/25/22 22:52, Gwendal Grignou wrote:
>>>> On Sat, Jun 25, 2022 at 11:27 AM srinivas pandruvada
>>>> <srinivas.pandruvada@linux.intel.com> wrote:
>>>>>
>>>>> On Sat, 2022-06-25 at 14:33 +0200, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Jonathan, thanks for Cc-ing me on this.
>>>>>>
>>>>>> On 6/25/22 13:09, Jonathan Cameron wrote:
>>>>>>> On Fri, 24 Jun 2022 15:33:41 -0700
>>>>>>> Gwendal Grignou <gwendal@chromium.org> wrote:
>>>>>>>
>>>>>>>> ISH based sensors do not naturally return data in the W3C
>>>>>>>> 'natural'
>>>>>>>> orientation.
>>>>>>>> They returns all data inverted, to match Microsoft
>>>>>>>> Windows
>>>>>>>> requirement:
>>>>>>>> [
>>>>>>>> https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/senso
>>>>>>>> rs#accelerometer]
>>>>>>>> """ If the device has the SimpleOrientation of FaceUp on
>>>>>>>> a table,
>>>>>>>> then
>>>>>>>> the accelerometer would read -1 G on the Z axis. """
>>>>>>>
>>>>>>> Probably reference the HID Usage Tables 1.3 spec rather
>>>>>>> than the MS
>>>>>>> one.
>>>>>>> https://usb.org/sites/default/files/hut1_3_0.pdf
>>>> That document does not clearly defined what the accelerometer
>>>> should return.
>>>>>>> After some waving around of my left and right hand I'm
>>>>>>> fairly sure
>>>>>>> that says the same
>>>>>>> thing as the MS spec. Section 4.4 Vector Usages
>>>>>>>
>>>>>>>> While W3C defines
>>>>>>>> [
>>>>>>>> https://www.w3.org/TR/motion-sensors/#accelerometer-sensor
>>>>>>>> ]
>>>>>>>> """The Accelerometer sensor is an inertial-frame sensor,
>>>>>>>> this
>>>>>>>> means that
>>>>>>>> when the device is in free fall, the acceleration is 0
>>>>>>>> m/s2 in
>>>>>>>> the
>>>>>>>> falling direction, and when a device is laying flat on a
>>>>>>>> table,
>>>>>>>> the
>>>>>>>> acceleration in upwards direction will be equal to the
>>>>>>>> Earth
>>>>>>>> gravity,
>>>>>>>> i.e. g ≡ 9.8 m/s2 as it is measuring the force of the
>>>>>>>> table
>>>>>>>> pushing the
>>>>>>>> device upwards."""
>>>>>>>>
>>>>>>>> Fixes all HID sensors that defines IIO_MOD_[XYZ]
>>>>>>>> attributes.
>>>>>>>>
>>>>>>>> Tested on "HP Spectre x360 Convertible 13" and "Dell XPS
>>>>>>>> 13
>>>>>>>> 9365".
>>>>>>>>
>>>>>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>>>>>>
>>>>>>> Ah.  Whilst this is a fix, it seems likely to break a whole
>>>>>>> bunch
>>>>>>> of existing
>>>>>>> users that are compensating for the wrong orientation in
>>>>>>> userspace.  Also, do
>>>>>>> we know how universal this is?  I have a nasty feeling
>>>>>>> it'll turn
>>>>>>> out some
>>>>>>> HID sensors do it the other way whatever the spec says. 
>>>>>>> Bastien,
>>>>>>> are you
>>>>>>> carrying a local fix for this in your userspace code?
>>>>>>>
>>>>>>> +CC a few people who are likely to know more on just how
>>>>>>> bad that
>>>>>>> will be...
>>>>>>
>>>>>> Right, so Linux userspace expects an axis system similar to
>>>>>> the
>>>>>> Android one,
>>>>>> which is actually the one which seems to be described here.
>>>>>>
>>>>>> The axis system expect is that when a tablet is layed flat on
>>>>>> the
>>>>>> table,
>>>>>> the x and y axis are as one would expect when drawing a
>>>>>> mathematics
>>>>>> graph on the surface of the tablet.
>>>>>>
>>>>>> So X-axis goes from left to right, with left side being lower
>>>>>> numbers
>>>>>> and
>>>>>> right side higher numbers.
>>>>>>
>>>>>> And Y-axis goes from bottom to top, with the bottom being
>>>>>> lower
>>>>>> numbers and
>>>>>> the top higher numbers.
>>>>>>
>>>>>> That leaves the Z-axis which comes out of the screen at a 90°
>>>>>> angle
>>>>>> (to both
>>>>>> the X and Y axis) and the vector coming out of the screen
>>>>>> towards to
>>>>>> the user /
>>>>>> observer of the screen indicates positive numbers where as
>>>>>> imagining
>>>>>> the same
>>>>>> axis pointing down through the table on which the tables is
>>>>>> lying
>>>>>> towards
>>>>>> the floor represents negative numbers.
>>>>>>
>>>>>> This means that the accel values of a tablet resting on a
>>>>>> table,
>>>>>> expresses
>>>>>> in units of 1G are: [ 0, 0, -1 ] and I've seen quite a few
>>>>>> HID
>>>>>> sensors
>>>> But W3C and Android expect [ 0, 0, 1g ] when resting on the
>>>> table. See
>>>> commit message for W3C and for Android, see
>>>> https://source.android.com/devices/sensors/sensor-types#accelerometer
>>>> """When the device lies flat on a table, the acceleration value
>>>> along
>>>> z is +9.81 alo, which corresponds to the acceleration of the
>>>> device (0
>>>> m/s^2) minus the force of gravity (-9.81 m/s^2)."""". That is why
>>>> we
>>>> need to change the sign to be consistent with these standards.
>>>
>>> Windows and HID devices use [ 0, 0, -1 ] for device face up on
>>> a flat table and
>>> this is what Linux has been reporting to userspace for many many
>>> years now.
>> This is not true. Most drivers for standalone sensor report [ 0, 0,
>> 1]
>> when the accelerometer sits face up on a table. For instance:
>> - in driver drivers/iio/accel/kxcjk-1013.c, read INFO_RAW reports the
>> raw accelerometer for sensor KX023 (see datasheet
>> https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf
>> page 17), as the scale is a positive value.
>> - same for sensor BMI160 in driver
>> drivers/iio/imu/bmi160/bmi160_core.c. The BMI160 axis conforms to W3C
>> and Android requirement (see
>> https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi160-ds000.pdf
>> page 107).
> 
> Accelerometers can be installed in any orientation inside the shell of
> the device, which means that raw data reported from the device needs to
> be checked against how it's implemented.
> 
>>> Auto-display-rotation based in accel
>>> reading was first supported in GNOME through iio-sensor-proxy
>>> in 2014 !
>>>
>>> And iio-sensor-proxy expects the Windows/HID sign of the axis
>>> you can NOT just go and change this, that would break 8 years
>>> of precedent of using the current Windows/HID sign (+/-) for
>>> the axis!
>>>
>>> Also besides the kernel reporting a matrix it is also possible
>>> for userspace to provide a matrix using udev's hwdb:
>>>
>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb
>> Note that the determinant of most of the matrices in this file equals
>> -1. It means these matrices do not just describe a rotation, they
>> first invert the axis (see
>> https://en.wikipedia.org/wiki/Determinant#Orientation_of_a_basis)
>> 136 out of 160 matrices invert the axes. In particular, entries with
>> acpi:KIOX... 42 out of 45 are inverted, with acpi:BOSC0200*, 22 out
>> 31
>> are, with acpi:SMO8500* 25 out 27 are.
>>
>> The matrices for directly connected accelerometers/IMU where axes are
>> not inverted may be errors and confirm that some IIO drivers do
>> report
>> [ 0, 0, 1 ] for accelerometer ICs face up. I will send a more
>> detailed
>> message with my findings on the systemd mailing list.
> 
> You're already in touch with the people who have worked on that code
> here (that'd be Hans and myself).
> 
>>
>>>
>>> This has been in place since 2016 and this sets a matrix adjusting
>>> readings of non HID sensors to match the *HID/windows* definition
>>> of the axis.
>>>
>>>>>> with accel reporting on various devices and they all adhere
>>>>>> to this
>>>>>> without applying any accel matrix. Or in other words, HID
>>>>>> sensors
>>>>>> behave
>>>>>> as expected by userspace when applying the norm matrix of:
>>>>>>
>>>>>>         .rotation = {
>>>>>>                 "1", "0", "0",
>>>>>>                 "0", "1", "0",
>>>>>>                 "0", "0", "1"
>>>>>>
>>>>>> And this patch will cause the image to be upside down (no
>>>>>> matter what
>>>>>> the
>>>>>> rotation) when using auto-rotation with iio-sensor-proxy.
>>>>>>
>>>>>> So big NACK from me for this patch.
>>>>>>
>>>>>> I'm not sure what this patch is trying to fix but it looks to
>>>>>> me like
>>>>>> it
>>>>>> is a bug in the HID sensors implementation of the specific
>>>>>> device.
>>>> This is a not a bug since HID sensors from 2 laptops from
>>>> different
>>>> manufacturers (HP and Dell) report the same values.
>>>
>>> Right, I wrongly assumed the Android definition would match the
>>> IMHO much saner / much more intuitive HID/Windows definitions,
>>> since the arrows in the phone image in the Android docs point
>>> in the same direction as the Windows docs.
>>>
>>> But I have tested on an Android phone now and I see that
>>> Android indeed has all the axis inverted.
>>>
>>>>>> Again HID-sensors already work fine on tons of existing
>>>>>> devices
>>>>>> without
>>>>>> any matrix getting applied.
>>>> Note this patch does not change the value reported by the sensor,
>>>> just
>>>> define a matrix to make sure the sensors values are consistent
>>>> with
>>>> Android/W3C.
>>>
>>> And iio-sensor-proxy will read the kernel provided matrix, apply it
>>> and then put the image upside down since you've just mirrored both
>>> the X and Y axis, breaking rotation for all existing GNOME and KDE
>>> users.
>>>
>>> So still a big NACK from me.
>>>
>>> If Android needs the axis to be flipped, then it should do so
>>> in the iio-sensor HAL inside android, not add a matrix which
>>> breaks 8 years of userspace API convention.
>>>
>>> Breaking userspace is simply not acceptible, we have a very clear
>>> no regressions policy. So this patch simply cannot be merged: NACK.
>> I agree this patch is not right, but it has at least the merit to
>> reveal an inconsistency among IIO drivers. As Jonathan suggested,
>> some
>> drivers should return a negative scale. We need to choose which ones
>> should: either the group of drivers that reports unaltered data from
>> the hardware sensors and conform to W3C standard and android
>> specification, or the ones that conform to the HID specification.
> 
> You need to realise that the drivers aren't created equal.
> 
> Whether a driver returns:
> - the raw readings from the sensor (which might or might not be aligned
> with the Android, Windows 8 or IIO docs),
> - adjusted readings (meant to be used as-is if the sensor is mounted
> with the right orientation inside the right component of the device),
> - or completely ludicrous readings because the sensor is in the wrong
> part of the system, or tracks something else (all the HP "disk fall"
> sensors)
> 
> all those are essentially API. You can't "fix" this after the fact. I,
> and others who contributed to the systemd quirks file, expected the
> kernel readings to not change with the kernel version.
> 
> The right approach would be to define which is the expected orientation
> in the IIO docs, although that already seems to be done[1], and
> actually make sure this is respected in *new* implementations.
> 
> Finally, I'll also add that the implementation in iio-sensor-proxy
> expects a single authoritative mount matrix to be provided for a
> device, as a mount matrix is supposed to correct the readings for the
> way a sensor was mounted inside the chassis/display of a particular
> device.
> 
> Cheers
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n1838
> An implementor might consider that for a hand-held device, a
> 'natural' orientation would be 'front facing camera at the top'.
> The main hardware reference frame could then be described as :
> * Y is in the plane of the screen and is positive towards the
>   top of the screen ;
> * X is in the plane of the screen, perpendicular to Y axis, and
>   positive towards the right hand side of the screen ;
> * Z is perpendicular to the screen plane and positive out of the
>   screen.

Note though that this does not clearly define what
e.g. "positive towards the top of the screen" means if
you look at the axis illustrations in both the Windows,
Android and W3C docs they all have an arrow pointing
towards the top of the screen for the Y axis, which
matches the "positive towards the top of the screen"
wording.

Yet Android / W3C expect a positive reading when
the G force vector is pointing down. Which I still
find confusing.

This means that we to add a text similar to the Windows
docs here, say something like (made up by me not copy
pasted from Windows docs):

"The Z-axis reading will be -1G when a device is laying
flat on a table with its display facing up"

To fix the are we measuring gravity or force countering
gravity confusion.

Jonathan, shall I submit a patch to add this, maybe with
some extra text that we are following the Windows/HID
convention and that Android/W3C do things differently?

Regards,

Hans











> 

