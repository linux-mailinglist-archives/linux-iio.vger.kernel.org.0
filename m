Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627055E388
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiF1Mow (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiF1Mov (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 08:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D66BC193ED
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656420288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJ3GwoAS+CXX9VkPr4fZrWq1/vg/5WBG9/7BSu23a/0=;
        b=POrS3J+VSs4khyPSzm8nAEif9gtELtMCF+xwlR7o6weATa+iUBoIFK5cT7C3HkcmKyffsn
        aiQOiq167NTSAIxbvdi861AS2hShJivdOMb+PIH7hvHhjsQpnfLJANkx6YqMOhTtu4S+j9
        xW+UcVZyhU380bxa78e0liH8OaGFQyc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-MSVifDeLNzuIc3bWuZQY-A-1; Tue, 28 Jun 2022 08:44:47 -0400
X-MC-Unique: MSVifDeLNzuIc3bWuZQY-A-1
Received: by mail-ed1-f69.google.com with SMTP id h4-20020a056402280400b00435abcf8f2dso9490194ede.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gJ3GwoAS+CXX9VkPr4fZrWq1/vg/5WBG9/7BSu23a/0=;
        b=Zw0xq56O3gNcXtXQtfBkZ54Tm8TpwFjtYtvyskBukcsGiOgCQ4chKZtoFVD6lES8Bk
         w1BQGhTJhLKvryWefqyHUc0Fl7HKV/Xth8+ftpnokWeVbxJJLg5D0iSBX+bgsH8iHTHR
         z42VrmpAchQ2ITu3p97hOAINDi4MGd2HZn5717ONFMWrgMDUEQ5YARsuR/+ncTa7yhMo
         7gnLOZJXcjptCFMRDygXaJW6FY1mviRgtn9A/8rrYC7O1JQq7zsNO8dnWDKutr4aMN7d
         aYsywjw88BKa8C5zDLsdA59y/FmB13TkyMIWKjTtd7Te6vCtBTZvKDH1j35H29sloCe5
         Bvdg==
X-Gm-Message-State: AJIora/Xc/bN9Isoa39Vsc0fjwVJ30cnsnbbjCM4inufZjFGNI5v2tcH
        AgMmxQ57h9y8D3uQHftJLyGz0koZh2bRSOw/pu6d5U94fl0WcxYKN2zIDyl1/HsoCddx7NK9zbl
        Tq9TyoAuBQDZeaGBhpxY3
X-Received: by 2002:a17:906:9b8a:b0:722:e6e0:33d with SMTP id dd10-20020a1709069b8a00b00722e6e0033dmr17345898ejc.317.1656420286359;
        Tue, 28 Jun 2022 05:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tp/RwCAQuOHVBOsR4QbrH1TeUAj0JC5W9B2ZEV0ajs1YMkkyZ4Pah27UMSoOPPycaAsIx4Cw==
X-Received: by 2002:a17:906:9b8a:b0:722:e6e0:33d with SMTP id dd10-20020a1709069b8a00b00722e6e0033dmr17345871ejc.317.1656420285983;
        Tue, 28 Jun 2022 05:44:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id t7-20020aa7d707000000b0043173ab6728sm9480047edq.7.2022.06.28.05.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:44:45 -0700 (PDT)
Message-ID: <3d866f68-6bbd-b6bb-a209-214313d74ec5@redhat.com>
Date:   Tue, 28 Jun 2022 14:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iio/hid: Add mount_matrix
Content-Language: en-US
To:     Gwendal Grignou <gwendal@chromium.org>,
        Bastien Nocera <hadess@hadess.net>
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
 <CAPUE2usZS2ww6r67kppn-4WGR7h++c6ioRu-A-ag=h7DpaVSYA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAPUE2usZS2ww6r67kppn-4WGR7h++c6ioRu-A-ag=h7DpaVSYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 6/27/22 22:23, Gwendal Grignou wrote:
> On Mon, Jun 27, 2022 at 2:55 AM Bastien Nocera <hadess@hadess.net> wrote:
>>
>> On Mon, 2022-06-27 at 02:05 -0700, Gwendal Grignou wrote:
>>>  of
>>>
>>> On Sun, Jun 26, 2022 at 7:42 AM Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 6/25/22 22:52, Gwendal Grignou wrote:
>>>>> On Sat, Jun 25, 2022 at 11:27 AM srinivas pandruvada
>>>>> <srinivas.pandruvada@linux.intel.com> wrote:
>>>>>>
>>>>>> On Sat, 2022-06-25 at 14:33 +0200, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Jonathan, thanks for Cc-ing me on this.
>>>>>>>
>>>>>>> On 6/25/22 13:09, Jonathan Cameron wrote:
>>>>>>>> On Fri, 24 Jun 2022 15:33:41 -0700
>>>>>>>> Gwendal Grignou <gwendal@chromium.org> wrote:
>>>>>>>>
>>>>>>>>> ISH based sensors do not naturally return data in the W3C
>>>>>>>>> 'natural'
>>>>>>>>> orientation.
>>>>>>>>> They returns all data inverted, to match Microsoft
>>>>>>>>> Windows
>>>>>>>>> requirement:
>>>>>>>>> [
>>>>>>>>> https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/senso
>>>>>>>>> rs#accelerometer]
>>>>>>>>> """ If the device has the SimpleOrientation of FaceUp on
>>>>>>>>> a table,
>>>>>>>>> then
>>>>>>>>> the accelerometer would read -1 G on the Z axis. """
>>>>>>>>
>>>>>>>> Probably reference the HID Usage Tables 1.3 spec rather
>>>>>>>> than the MS
>>>>>>>> one.
>>>>>>>> https://usb.org/sites/default/files/hut1_3_0.pdf
>>>>> That document does not clearly defined what the accelerometer
>>>>> should return.
>>>>>>>> After some waving around of my left and right hand I'm
>>>>>>>> fairly sure
>>>>>>>> that says the same
>>>>>>>> thing as the MS spec. Section 4.4 Vector Usages
>>>>>>>>
>>>>>>>>> While W3C defines
>>>>>>>>> [
>>>>>>>>> https://www.w3.org/TR/motion-sensors/#accelerometer-sensor
>>>>>>>>> ]
>>>>>>>>> """The Accelerometer sensor is an inertial-frame sensor,
>>>>>>>>> this
>>>>>>>>> means that
>>>>>>>>> when the device is in free fall, the acceleration is 0
>>>>>>>>> m/s2 in
>>>>>>>>> the
>>>>>>>>> falling direction, and when a device is laying flat on a
>>>>>>>>> table,
>>>>>>>>> the
>>>>>>>>> acceleration in upwards direction will be equal to the
>>>>>>>>> Earth
>>>>>>>>> gravity,
>>>>>>>>> i.e. g ≡ 9.8 m/s2 as it is measuring the force of the
>>>>>>>>> table
>>>>>>>>> pushing the
>>>>>>>>> device upwards."""
>>>>>>>>>
>>>>>>>>> Fixes all HID sensors that defines IIO_MOD_[XYZ]
>>>>>>>>> attributes.
>>>>>>>>>
>>>>>>>>> Tested on "HP Spectre x360 Convertible 13" and "Dell XPS
>>>>>>>>> 13
>>>>>>>>> 9365".
>>>>>>>>>
>>>>>>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>>>>>>>
>>>>>>>> Ah.  Whilst this is a fix, it seems likely to break a whole
>>>>>>>> bunch
>>>>>>>> of existing
>>>>>>>> users that are compensating for the wrong orientation in
>>>>>>>> userspace.  Also, do
>>>>>>>> we know how universal this is?  I have a nasty feeling
>>>>>>>> it'll turn
>>>>>>>> out some
>>>>>>>> HID sensors do it the other way whatever the spec says.
>>>>>>>> Bastien,
>>>>>>>> are you
>>>>>>>> carrying a local fix for this in your userspace code?
>>>>>>>>
>>>>>>>> +CC a few people who are likely to know more on just how
>>>>>>>> bad that
>>>>>>>> will be...
>>>>>>>
>>>>>>> Right, so Linux userspace expects an axis system similar to
>>>>>>> the
>>>>>>> Android one,
>>>>>>> which is actually the one which seems to be described here.
>>>>>>>
>>>>>>> The axis system expect is that when a tablet is layed flat on
>>>>>>> the
>>>>>>> table,
>>>>>>> the x and y axis are as one would expect when drawing a
>>>>>>> mathematics
>>>>>>> graph on the surface of the tablet.
>>>>>>>
>>>>>>> So X-axis goes from left to right, with left side being lower
>>>>>>> numbers
>>>>>>> and
>>>>>>> right side higher numbers.
>>>>>>>
>>>>>>> And Y-axis goes from bottom to top, with the bottom being
>>>>>>> lower
>>>>>>> numbers and
>>>>>>> the top higher numbers.
>>>>>>>
>>>>>>> That leaves the Z-axis which comes out of the screen at a 90°
>>>>>>> angle
>>>>>>> (to both
>>>>>>> the X and Y axis) and the vector coming out of the screen
>>>>>>> towards to
>>>>>>> the user /
>>>>>>> observer of the screen indicates positive numbers where as
>>>>>>> imagining
>>>>>>> the same
>>>>>>> axis pointing down through the table on which the tables is
>>>>>>> lying
>>>>>>> towards
>>>>>>> the floor represents negative numbers.
>>>>>>>
>>>>>>> This means that the accel values of a tablet resting on a
>>>>>>> table,
>>>>>>> expresses
>>>>>>> in units of 1G are: [ 0, 0, -1 ] and I've seen quite a few
>>>>>>> HID
>>>>>>> sensors
>>>>> But W3C and Android expect [ 0, 0, 1g ] when resting on the
>>>>> table. See
>>>>> commit message for W3C and for Android, see
>>>>> https://source.android.com/devices/sensors/sensor-types#accelerometer
>>>>> """When the device lies flat on a table, the acceleration value
>>>>> along
>>>>> z is +9.81 alo, which corresponds to the acceleration of the
>>>>> device (0
>>>>> m/s^2) minus the force of gravity (-9.81 m/s^2)."""". That is why
>>>>> we
>>>>> need to change the sign to be consistent with these standards.
>>>>
>>>> Windows and HID devices use [ 0, 0, -1 ] for device face up on
>>>> a flat table and
>>>> this is what Linux has been reporting to userspace for many many
>>>> years now.
>>> This is not true. Most drivers for standalone sensor report [ 0, 0,
>>> 1]
>>> when the accelerometer sits face up on a table. For instance:
>>> - in driver drivers/iio/accel/kxcjk-1013.c, read INFO_RAW reports the
>>> raw accelerometer for sensor KX023 (see datasheet
>>> https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf
>>> page 17), as the scale is a positive value.
>>> - same for sensor BMI160 in driver
>>> drivers/iio/imu/bmi160/bmi160_core.c. The BMI160 axis conforms to W3C
>>> and Android requirement (see
>>> https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi160-ds000.pdf
>>> page 107).
>>
>> Accelerometers can be installed in any orientation inside the shell of
>> the device, which means that raw data reported from the device needs to
>> be checked against how it's implemented.
>>
>>>> Auto-display-rotation based in accel
>>>> reading was first supported in GNOME through iio-sensor-proxy
>>>> in 2014 !
>>>>
>>>> And iio-sensor-proxy expects the Windows/HID sign of the axis
>>>> you can NOT just go and change this, that would break 8 years
>>>> of precedent of using the current Windows/HID sign (+/-) for
>>>> the axis!
>>>>
>>>> Also besides the kernel reporting a matrix it is also possible
>>>> for userspace to provide a matrix using udev's hwdb:
>>>>
>>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb
>>> Note that the determinant of most of the matrices in this file equals
>>> -1. It means these matrices do not just describe a rotation, they
>>> first invert the axis (see
>>> https://en.wikipedia.org/wiki/Determinant#Orientation_of_a_basis)
>>> 136 out of 160 matrices invert the axes. In particular, entries with
>>> acpi:KIOX... 42 out of 45 are inverted, with acpi:BOSC0200*, 22 out
>>> 31
>>> are, with acpi:SMO8500* 25 out 27 are.
>>>
>>> The matrices for directly connected accelerometers/IMU where axes are
>>> not inverted may be errors and confirm that some IIO drivers do
>>> report
>>> [ 0, 0, 1 ] for accelerometer ICs face up. I will send a more
>>> detailed
>>> message with my findings on the systemd mailing list.
>>
>> You're already in touch with the people who have worked on that code
>> here (that'd be Hans and myself).
>>
>>>
>>>>
>>>> This has been in place since 2016 and this sets a matrix adjusting
>>>> readings of non HID sensors to match the *HID/windows* definition
>>>> of the axis.
>>>>
>>>>>>> with accel reporting on various devices and they all adhere
>>>>>>> to this
>>>>>>> without applying any accel matrix. Or in other words, HID
>>>>>>> sensors
>>>>>>> behave
>>>>>>> as expected by userspace when applying the norm matrix of:
>>>>>>>
>>>>>>>         .rotation = {
>>>>>>>                 "1", "0", "0",
>>>>>>>                 "0", "1", "0",
>>>>>>>                 "0", "0", "1"
>>>>>>>
>>>>>>> And this patch will cause the image to be upside down (no
>>>>>>> matter what
>>>>>>> the
>>>>>>> rotation) when using auto-rotation with iio-sensor-proxy.
>>>>>>>
>>>>>>> So big NACK from me for this patch.
>>>>>>>
>>>>>>> I'm not sure what this patch is trying to fix but it looks to
>>>>>>> me like
>>>>>>> it
>>>>>>> is a bug in the HID sensors implementation of the specific
>>>>>>> device.
>>>>> This is a not a bug since HID sensors from 2 laptops from
>>>>> different
>>>>> manufacturers (HP and Dell) report the same values.
>>>>
>>>> Right, I wrongly assumed the Android definition would match the
>>>> IMHO much saner / much more intuitive HID/Windows definitions,
>>>> since the arrows in the phone image in the Android docs point
>>>> in the same direction as the Windows docs.
>>>>
>>>> But I have tested on an Android phone now and I see that
>>>> Android indeed has all the axis inverted.
>>>>
>>>>>>> Again HID-sensors already work fine on tons of existing
>>>>>>> devices
>>>>>>> without
>>>>>>> any matrix getting applied.
>>>>> Note this patch does not change the value reported by the sensor,
>>>>> just
>>>>> define a matrix to make sure the sensors values are consistent
>>>>> with
>>>>> Android/W3C.
>>>>
>>>> And iio-sensor-proxy will read the kernel provided matrix, apply it
>>>> and then put the image upside down since you've just mirrored both
>>>> the X and Y axis, breaking rotation for all existing GNOME and KDE
>>>> users.
>>>>
>>>> So still a big NACK from me.
>>>>
>>>> If Android needs the axis to be flipped, then it should do so
>>>> in the iio-sensor HAL inside android, not add a matrix which
>>>> breaks 8 years of userspace API convention.
>>>>
>>>> Breaking userspace is simply not acceptible, we have a very clear
>>>> no regressions policy. So this patch simply cannot be merged: NACK.
>>> I agree this patch is not right, but it has at least the merit to
>>> reveal an inconsistency among IIO drivers. As Jonathan suggested,
>>> some
>>> drivers should return a negative scale. We need to choose which ones
>>> should: either the group of drivers that reports unaltered data from
>>> the hardware sensors and conform to W3C standard and android
>>> specification, or the ones that conform to the HID specification.
>>
>> You need to realise that the drivers aren't created equal.
>>
>> Whether a driver returns:
>> - the raw readings from the sensor (which might or might not be aligned
>> with the Android, Windows 8 or IIO docs),
>> - adjusted readings (meant to be used as-is if the sensor is mounted
>> with the right orientation inside the right component of the device),
>> - or completely ludicrous readings because the sensor is in the wrong
>> part of the system, or tracks something else (all the HP "disk fall"
>> sensors)
>>
>> all those are essentially API. You can't "fix" this after the fact. I,
>> and others who contributed to the systemd quirks file, expected the
>> kernel readings to not change with the kernel version.
> Relying on a quirk file for all standalone sensors is not sustainable
> IMHO. I agree changing existing output in newer kernels is also very
> difficult.
> Should we add a new iio sysfs attribute to indicate the sensors report
> data according to either the W3C specification or HID specification?

Gwendal, I appreciate that you are trying to be flexible and come
up with a solution here.

But adding this attribute will just make things more confusion and
causing breakage when running a userspace which does not know
about this on a newer kernel.

> If present, and set to W3C, iio-sensor-proxy would invert the axis
> first before applying [new] rotation matrices which will never change
> the basis.

This means that using a non-updated iio-sensor-proxy with a new-kernel
which sets the W3C flag will break and we never break userspace API,
so also NACK for this proposal.

IMHO you really need to just *accept* that the IIO subsystem and
both kernel (e.g. from ACPI / devicetree) + udev hwdb exported
mount-matrices all will report the axis in Windows/HID handedness
(after applying the mount-matrix).

I realize this is not properly documented, I plan to submit
a patch to Documentation/ABI/testing/sysfs-bus-iio#n1838 to spell
this out clearly.

>> The right approach would be to define which is the expected orientation
>> in the IIO docs, although that already seems to be done[1], and
>> actually make sure this is respected in *new* implementations.
> All standalone sensors respect the 'natural' orientation. But when
> flat on a table they return the force exercised by the table to
> prevent further fall, as defined by W3C, while the HID sensor hub
> reports the gravity vector itself.
> This discrepancy should be fixed at the kernel level.

No just *no*, full stop. There is no reason what soever why this
cannot be done inside the Android sensor HAL. And there is
8 years of precedence for using the Windows/HID handedness.

So again please just accept that kernel provided (ACPI / devicetree)
mount-matrices will result in the axis values being reported
in Windows/HID handedness and adjust your userspace consumers
accordingly.

Regards,

Hans


>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n1838
>> An implementor might consider that for a hand-held device, a
>> 'natural' orientation would be 'front facing camera at the top'.
>> The main hardware reference frame could then be described as :
>> * Y is in the plane of the screen and is positive towards the
>>   top of the screen ;
>> * X is in the plane of the screen, perpendicular to Y axis, and
>>   positive towards the right hand side of the screen ;
>> * Z is perpendicular to the screen plane and positive out of the
>>   screen.
> 

