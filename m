Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA45268B127
	for <lists+linux-iio@lfdr.de>; Sun,  5 Feb 2023 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjBESHQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 13:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjBESHQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 13:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0C16334
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675620387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjFXisCPqTLghS/IPyq56IAFdVbfNfnU/cFXIQeHxrI=;
        b=SzNr/LvP0YdWqWOBemfJZAgGkTDPk2lERmw/8JvTLq+2ktmXwqnT4F9W6bAhCCCgwE+enw
        ub6aA3Dd2Q2pRBYd+kHfPJcVoIfSZiyFAlOP/5ocpmfg8ENZpOZRytKxBJT8Z/C7YeuQhi
        UDRn01NUbZjZPLmS49PMlTiTxLzK4jE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-7p3LP1VzPv2ydUVpKEwYJQ-1; Sun, 05 Feb 2023 13:06:26 -0500
X-MC-Unique: 7p3LP1VzPv2ydUVpKEwYJQ-1
Received: by mail-ej1-f70.google.com with SMTP id qa17-20020a170907869100b0088ea39742c8so7122162ejc.13
        for <linux-iio@vger.kernel.org>; Sun, 05 Feb 2023 10:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjFXisCPqTLghS/IPyq56IAFdVbfNfnU/cFXIQeHxrI=;
        b=58Z9dZftVFnOYDhZPrwX0xTV7I4jKbHjP21BpPaTA6w5+1xfI0l1wDgenaaJbqC1yL
         s0j9iTnRz/dj2Q799/DFgmQAZ4fJOpal7FaiCnXN2yJalITFZJjBSjARVUZljyGtv+lb
         1lq/uOK46IMRu+BP3aSgTel4U6NHpLSnutsNyijJzxpu2cZBJMq8WlNRRuCgC9aFnOJn
         5Zs9xU5tHRadKODR7V+Bt1dQO40eDHSgCmyEJ2CMMd0enRXDypU1X9rg1e/71Y/1v66N
         l0JtAuCc8negS+iiLm90C1jHFF6Cz+s4GiWrDeAkxcZMVGDS3LP/M3mH10mKGFVR9y7v
         K4rg==
X-Gm-Message-State: AO0yUKUuNNezsQC+YuRlckbfYdKYjpVOZOJrUegzyBG05Sua+cKtLxuW
        Utf79h/gImaugO+HiXqxmzuo7mHhTbQetrFv21XjKPfR43rIebG2UlviJ5l/k2HptAhzqv7LmuT
        2penThc1lUK9lffyvvqCt
X-Received: by 2002:a50:d783:0:b0:4aa:a76b:1ac7 with SMTP id w3-20020a50d783000000b004aaa76b1ac7mr2942950edi.25.1675620384722;
        Sun, 05 Feb 2023 10:06:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/SacSCx+xztZUkJv77/RYJSrbI57FOmo7EIjEPIs00RoRipoecQhnR0sW0gGnLcH9HJrY+VQ==
X-Received: by 2002:a50:d783:0:b0:4aa:a76b:1ac7 with SMTP id w3-20020a50d783000000b004aaa76b1ac7mr2942927edi.25.1675620384377;
        Sun, 05 Feb 2023 10:06:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f28-20020a50a6dc000000b004aaa6a948fcsm1368846edc.37.2023.02.05.10.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 10:06:23 -0800 (PST)
Message-ID: <75729823-e50e-7a44-7271-a1b5bce489ec@redhat.com>
Date:   Sun, 5 Feb 2023 19:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug#1029850: linux: Driver not loaded for ST Microelectronics
 LSM6DS3TR-C accelerometer (acpi:SMO8B30:SMO8B30:)
To:     Darrell Kavanagh <darrell.kavanagh@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <167493679618.4533.12181720504943588640.reportbug@debian-duet>
 <20230130203110.60c96f37@jic23-huawei>
 <CAMxBKG1+Vcaic2WzVvZZSrVDO7+PTYJZgPP77s_GPOdo+BKJAQ@mail.gmail.com>
 <CAMxBKG0Q4H6Dv9a=oOAX8c5TS08ZJBBO0tTLRaUY9h-W1FTHCQ@mail.gmail.com>
 <20230201102824.00002044@Huawei.com>
 <c3207f3a-ecb9-0e69-e26a-71dc1b06db6a@redhat.com>
 <d9cec163f93922e59378a4aa351934ba1d702817.camel@hadess.net>
 <CAMxBKG3Nh5C1N5_SAftQxStkkj2Y0YRuymB4Z2av79p=1HPuMQ@mail.gmail.com>
 <7005e022-dd4c-835c-bdc2-11bbbd214071@redhat.com>
 <CAMxBKG1s5pqU08w2keOxf7J9UJakiwbCVve9iSDr1Vis0=6biQ@mail.gmail.com>
 <CAMxBKG1EUgJqMtrxBVOWP9GnZkc518HU2xUnLW4UUWH+8_u=cQ@mail.gmail.com>
 <f256b437-7495-1115-7eea-619b6e241e02@redhat.com>
 <CAMxBKG1AAaN7zuwS-ukTEYRm2hC=AcejWbWJSmucHcXS+=-Jfg@mail.gmail.com>
 <9bd76c94-0705-38e5-baf5-32be31652156@redhat.com>
 <20230205143621.47f3de9a@jic23-huawei>
 <CAMxBKG3-f5+j+=5mXQccBkWfa3cwUTY=mSb8n88A1e0rXk8cnQ@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMxBKG3-f5+j+=5mXQccBkWfa3cwUTY=mSb8n88A1e0rXk8cnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/5/23 17:06, Darrell Kavanagh wrote:
> So does this mean that the least worst (only?) option is to get my
> hwdb mount matrix entry added to systemd? I can raise a bug as
> suggested in hwdb.d/60-sensor.hwdb if so.

Yes you should add a hwdb entry for this, note just submitting
a pull-req with the fix is better then filing an issue for this.

Regards,

Hans



> On Sun, 5 Feb 2023 at 14:22, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Sun, 5 Feb 2023 09:50:51 +0100
>> Hans de Goede <hdegoede@redhat.com> wrote:
>>
>>> Hi,
>>>
>>> On 2/4/23 23:15, Darrell Kavanagh wrote:
>>>> Yes, I understand that.
>>>>
>>>> What I mean is that the matrix read from the DSDT by Jonathan's
>>>> amended driver is
>>>>
>>>>  0 -1  0
>>>>  1  0  0
>>>>  0  0  1
>>>>
>>>> and the (correct) matrix created with my new hwdb entry is
>>>>
>>>>  0  1  0
>>>> -1  0  0
>>>>  0  0  1
>>
>> May be concidence, but I think that's the inverse of the one we are reading
>> from ROTM - so represents the transform in the other direction.
>>
>> The way ROTM is defined is that first row represents the direction of
>> the x axis in device coordinates - so it's the transform from sensor
>> to device space.
>>
>> I wonder if the hwdb matrix is defined from world space to sensor?  Seems
>> unlikely.
>>
>> The IIO ABI docs describe mount matrix as being what you apply to data to
>> tranform into device space (oh for a diagram in the docs).  Anyhow my reading
>> is that matches with ROTM definition but maybe I'm reading that wrong...
>>
>> For extra annoyance, the ROTM matrix on this device isn't a rotation matrix.
>> It's flipping the handedness of the sensor.  Determinant isn't -1 which it
>> should be.  I guess the sensor itself might have an axis backwards from
>> windows convention though *sigh*  I think windows uses left handed convention
>> and looks like sensor is using right handed (which I think is what Android and
>> similar use).
>>
>>>>
>>>> which is the algebraic transposition (ie reflection in the diagonal)
>>>> of the DSDT one.
>>>>
>>>> In other words, though the DST matrix is wrong, it is wrong in a
>>>> specific way - the rows should be the columns, and vv. I was just
>>>> wondering if this was a DSDT bug that might have been seen elsewhere
>>>> before.
>>>
>>> No this does not ring a bell, but the x and y axis being swapped
>>> does seem related to the LCD panel being 90° rotated.
>>>
>>>> BTW, there is another matrix in the DSTD, but I can't find the
>>>> associated HID (10EC5280) anywhere (Linux sysfs or Windows Powershell
>>>> system data extract). It's not a correct matrix, though - could it be
>>>> just a bit of redundant code in the DST?
>>>
>>> Yes that is likely there often is a bunch of dead stuff DSDT leftover
>>> from other device models.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>
>>>>
>>>> Darrell
>>>>
>>>> On Sat, 4 Feb 2023 at 21:31, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 2/4/23 18:09, Darrell Kavanagh wrote:
>>>>>> I've just noticed that the working mount matrix that I added to my
>>>>>> hwdb is the matrix retrieved from the ACPI ROTM call in the amended
>>>>>> driver, transposed.
>>>>>
>>>>> An other word for the mount matrix would be a rotation matrix,
>>>>> since it defines how the physical sensor is mounted on the PCB
>>>>> in a rotated fashion compared to its standard orientation.
>>>>>
>>>>> The x, y, z axis relationship underling of course does
>>>>> not change by the rotation, so yes all mount matrices
>>>>> are a transposition of the standard:
>>>>>
>>>>> 1, 0, 0 : 0, 1, 0 : 0, 0, 1
>>>>>
>>>>> matrix, that is expected. Where that to not be the case
>>>>> then there would be a bug in the accelerometer driver itself
>>>>> where the driver itself is swapping or inverting axis.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>> On Fri, 3 Feb 2023 at 18:23, Darrell Kavanagh
>>>>>> <darrell.kavanagh@gmail.com> wrote:
>>>>>>>
>>>>>>> Finally got a 6.2.0-rc6 kernel built and installed, with the following
>>>>>>> patch, and everything is working as expected.
>>>>>>>
>>>>>>> Moving on now to look at Bastien's suggestion.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Darrell
>>>>>>>
>>>>>>> diff --git a/kernel/drm_panel_orientation_quirks.c
>>>>>>> b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
>>>>>>> index 3659f04..590bb7b 100644
>>>>>>> --- a/kernel/drm_panel_orientation_quirks.c
>>>>>>> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
>>>>>>> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
>>>>>>>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad
>>>>>>> D330-10IGM"),
>>>>>>>                 },
>>>>>>>                 .driver_data = (void *)&lcd1200x1920_rightside_up,
>>>>>>> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
>>>>>>> +               .matches = {
>>>>>>> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>>>>> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
>>>>>>> +               },
>>>>>>> +               .driver_data = (void *)&lcd1200x1920_rightside_up,
>>>>>>>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
>>>>>>>                 .matches = {
>>>>>>>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>>>>>
>>>>>>> On Wed, 1 Feb 2023 at 17:55, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 2/1/23 18:50, Darrell Kavanagh wrote:
>>>>>>>>> Thank you. I don't have anything that could be called a big machine.
>>>>>>>>> The fastest processor I have access to is a Core m3-8100Y - that's in
>>>>>>>>> a Chromebook with 4GB memory - it can run Linux in a chroot or
>>>>>>>>> officially in Google's VM. I also have an ancient gen 2 core i5-2410M
>>>>>>>>> machine which is slower than the m3 in theory, but that has 6GB of
>>>>>>>>> memory.
>>>>>>>>>
>>>>>>>>> Is the kernel build more processor or memory bound?
>>>>>>>>
>>>>>>>> It is mostly processor bound, esp. wtih something like make -j4,
>>>>>>>> make -j16 will start taking some RAM, but with make -j4 I expect you
>>>>>>>> to be fully CPU bound.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>
>>>>>>>> Hans
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> On Wed, 1 Feb 2023 at 16:12, Bastien Nocera <hadess@hadess.net> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, 2023-02-01 at 12:00 +0100, Hans de Goede wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On 2/1/23 11:28, Jonathan Cameron wrote:
>>>>>>>>>>>> On Wed, 1 Feb 2023 01:40:49 +0000
>>>>>>>>>>>> Darrell Kavanagh <darrell.kavanagh@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> Hello, all.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I've finally reached a conclusion on this, after testing all the
>>>>>>>>>>>>> combinations of the patches (with and without reading the acpi
>>>>>>>>>>>>> mounting matrix), window managers (wayland, xorg) and the
>>>>>>>>>>>>> presence or
>>>>>>>>>>>>> not of my custom kernel parms.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What works well is the full set of patches with the custom kernel
>>>>>>>>>>>>> parms and a new hwdb entry for the sensor:
>>>>>>>>>>>>>
>>>>>>>>>>>>> sensor:modalias:acpi:SMO8B30*:dmi:*:svnLENOVO*:pn82AT:*
>>>>>>>>>>>>>  ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, 1
>>>>>>>>>>>>>
>>>>>>>>>>>>> The autorotate then works correctly in wayland and xorg, but for
>>>>>>>>>>>>> xorg,
>>>>>>>>>>>>> the settings say the screen is "portrait left" when in actual
>>>>>>>>>>>>> fact it
>>>>>>>>>>>>> is in standard laptop landscape orientation. Wayland does not
>>>>>>>>>>>>> have
>>>>>>>>>>>>> this problem (I guess because wayland's view of the screen is
>>>>>>>>>>>>> straight
>>>>>>>>>>>>> from the kernel).
>>>>>>>>>>>>>
>>>>>>>>>>>>> Without the hwdb entry, the orientation is 90 degrees out without
>>>>>>>>>>>>> using the acpi matrix and 180 degrees out when using it. I could
>>>>>>>>>>>>> have
>>>>>>>>>>>>> gone either way here with appropriate hwdb entries, but my view
>>>>>>>>>>>>> is
>>>>>>>>>>>>> that we *should* be using the matrix.
>>>>>>>>>>>>
>>>>>>>>>>>> Added Hans de Goede as he has probably run into more of this mess
>>>>>>>>>>>> than anyone else.  Hans, any thoughts on if we are doing something
>>>>>>>>>>>> wrong on kernel side?  Or is the matrix just wrong *sigh*
>>>>>>>>>>>
>>>>>>>>>>> I see below that this laptop has a panel which is mounted 90 degrees
>>>>>>>>>>> rotated, that likely explains why the ACPI matrix does not work.
>>>>>>>>>>> So the best thing to do here is to just override it with a hwdb
>>>>>>>>>>> entries.
>>>>>>>>>>>
>>>>>>>>>>> IIRC there are already 1 or 2 other hwdb entries which actually
>>>>>>>>>>> override the ACPI provided matrix because of similar issues.
>>>>>>>>>>>
>>>>>>>>>>> Linux userspace expects the matrix in this case to be set so that
>>>>>>>>>>> it causes e.g. gnome's auto-rotation to put the image upright
>>>>>>>>>>> even with older gnome versions / mate / xfce which don't know about
>>>>>>>>>>> the panel being mounted 90 degrees.
>>>>>>>>>>>
>>>>>>>>>>> So e.g. "monitor-sensor" will report left-side-up or right-side-up
>>>>>>>>>>> while the device is actually in normal clamshell mode with the
>>>>>>>>>>> display up-right.
>>>>>>>>>>>
>>>>>>>>>>> This reporting of left-side-up or right-side-up is actually "correct"
>>>>>>>>>>> looking from the native LCD panel orientation and as mentioned is
>>>>>>>>>>> done for backward compatibility. This is documented here:
>>>>>>>>>>>
>>>>>>>>>>> https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb#L54
>>>>>>>>>>>
>>>>>>>>>>> The way we are handling this is likely incompatible with how Windows
>>>>>>>>>>> handles this special case of 90° rotated screen + ROTM. Or the
>>>>>>>>>>> matrix in the ACPI tables could be just wrong...
>>>>>>>>>>>
>>>>>>>>>>>> I think 'ROTM' is defined by MS.
>>>>>>>>>>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
>>>>>>>>>>>
>>>>>>>>>>> Right and as such it would be good if we can still add support to
>>>>>>>>>>> it to the sensor driver in question. Because the ROTM info usually
>>>>>>>>>>> is correct and avoids the need for adding more and more hwdb entries.
>>>>>>>>>>>
>>>>>>>>>>> Note there already is existing support in some other sensor drivers.
>>>>>>>>>>>
>>>>>>>>>>> So we probably need to factor out some helper code for this and share
>>>>>>>>>>> that between sensor drivers.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>> The only thing that concerns me is the need for custom kernel
>>>>>>>>>>>>> parms.
>>>>>>>>>>>>> It would be better if there was a way to avoid this, so that the
>>>>>>>>>>>>> user
>>>>>>>>>>>>> didn't have to mess around with their grub config. Though having
>>>>>>>>>>>>> said
>>>>>>>>>>>>> that, the sensors fix as we have it doesn't make things worse -
>>>>>>>>>>>>> under
>>>>>>>>>>>>> currently released kernels the screen always starts up sideways
>>>>>>>>>>>>> unless
>>>>>>>>>>>>> custom parms are added in grub.
>>>>>>>>>>>
>>>>>>>>>>> We actually have a quirk mechanism in the kernel for specifying
>>>>>>>>>>> the need for: video=DSI-1:panel_orientation=right_side_up  and this
>>>>>>>>>>> will also automatically fix the fbcon orientation, see:
>>>>>>>>>>>
>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_panel_orientation_quirks.c
>>>>>>>>>>>
>>>>>>>>>>> If you submit a patch for this upstream please Cc me.
>>>>>>>>>>
>>>>>>>>>> And if after that change, and copy/pasting the orientation from the
>>>>>>>>>> DSDT into hwdb the sensor and screen move in the expected ways, then
>>>>>>>>>> maybe stealing the BMC150 driver's
>>>>>>>>>> bmc150_apply_bosc0200_acpi_orientation() might be a good idea.
>>>>>>>>>>
>>>>>>>>>> Once exported through "mount_matrix", iio-sensor-proxy should see it
>>>>>>>>>> and read it without the need for a hwdb entry.
>>>>>>>>>>
>>>>>>>>>> Cheers
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

