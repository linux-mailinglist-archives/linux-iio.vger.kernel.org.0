Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085D22FC4E1
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 00:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbhASXhG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 18:37:06 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:18764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393342AbhASOJT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 09:09:19 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JE2XpC005713;
        Tue, 19 Jan 2021 15:07:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=J7QJWM/jW9ss57xPTtzribUGpZQKJ8PyKQYG7P76TLU=;
 b=TUsSqNp5t9T6HtR/GwIryG1e3M+qyEHDc+syX+2YEMBL5Rxmw/c7YgDHw2ezmdisZDwf
 nzVB/cDE9KAIPBUKTLh4wcEHrfbbXMLDyy6WYQMHWDnGqORolzbejPaAAktXOMt0ixGQ
 ZWkWX/bVz9+Gwz8T8S/35meGw7lWPPueo4HjUmHfr/31fkgRgK8xUTh88ZSnQ7vXesRN
 UrsZYE0vDiRGQ3rrCDFTe/tGejcywro+82pptU0mkklTsqVTOln3znDkBMJggBbleHIR
 qoFxlXdI/8aY+feOA+L0U1czZcyOWO27FoI9UD+3nzzjwKOMENWYaR7VImZ+XWkiAykA gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 363pg6r90c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 15:07:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ADAFE10002A;
        Tue, 19 Jan 2021 15:07:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 97C77250739;
        Tue, 19 Jan 2021 15:07:20 +0100 (CET)
Received: from [10.211.11.124] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 15:07:19 +0100
Subject: Re: [PATCH 00/10] Fix documentation warnings at linux-next
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
References: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
 <20210115104947.71d99e87@coco.lan> <20210115134720.000011f9@Huawei.com>
 <20210117154218.634dd5fa@archlinux> <YAajkfaXPqkZUB/2@shinobu>
 <20210119104105.000010df@Huawei.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <bb6d9854-5b24-c1ff-c4cf-4f9e7bafbe11@foss.st.com>
Date:   Tue, 19 Jan 2021 15:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119104105.000010df@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_04:2021-01-18,2021-01-19 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/19/21 11:41 AM, Jonathan Cameron wrote:
> On Tue, 19 Jan 2021 18:17:05 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
>> On Sun, Jan 17, 2021 at 03:42:18PM +0000, Jonathan Cameron wrote:
>>> On Fri, 15 Jan 2021 13:47:20 +0000
>>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>>   
>>>> On Fri, 15 Jan 2021 10:49:47 +0100
>>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>>>>   
>>>>> Hi Lukas,
>>>>>
>>>>> Em Fri, 15 Jan 2021 07:12:38 +0100
>>>>> Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
>>>>>     
>>>>>> [reduced the recipient list to the main responsible ones and list]
>>>>>>
>>>>>> Hi Mauro, hi Jonathan,
>>>>>>
>>>>>> We both, Mauro and I, have been submitting patches to address the
>>>>>> documentation warnings on linux-next. If it is okay with you, Mauro, I
>>>>>> would like to take responsibility for the task to send out the patches
>>>>>> to address all warnings on linux-next in make htmldocs and follow up
>>>>>> with all the discussions. I can also provide a short weekly summary
>>>>>> (probably always on Friday) on what is pending where and what I could
>>>>>> not resolve by myself.
>>>>>>
>>>>>> Is that okay for you?
>>>>>>
>>>>>> If at some point I do not have the time to take care anymore, I will
>>>>>> let you know.      
>>>>>
>>>>> Yeah, sure!
>>>>>
>>>>> Anyway, after applying the patches I sent this week, the warnings
>>>>> I'm getting are all due to the validation scripts I wrote. So, if 
>>>>> everything gets merged (either yours or my version), we'll have zero
>>>>> Sphinx/kernel-doc warnings again.
>>>>>
>>>>> The script-validation warnings are:
>>>>>
>>>>> 1. Broken cross references
>>>>> --------------------------
>>>>>
>>>>> $ scripts/documentation-file-ref-check
>>>>> Warning: Documentation/arm/booting.rst references a file that doesn't exist: Documentation/devicetree/booting-without-of.rst
>>>>> Warning: Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt references a file that doesn't exist: Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>>> Warning: Documentation/devicetree/bindings/input/adc-joystick.yaml references a file that doesn't exist: Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>>> Warning: Documentation/devicetree/bindings/power/supply/da9150-charger.txt references a file that doesn't exist: Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>>> Warning: Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
>>>>> Warning: Documentation/translations/zh_CN/arm/Booting references a file that doesn't exist: Documentation/devicetree/booting-without-of.rst
>>>>> Warning: Documentation/virt/kvm/vcpu-requests.rst references a file that doesn't exist: Documentation/core-api/atomic_ops.rst
>>>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
>>>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
>>>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/intel,kmb_display.yaml
>>>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/media/i2c/ov2680.yaml
>>>>> Warning: include/linux/rculist_nulls.h references a file that doesn't exist: Documentation/core-api/atomic_ops.rst
>>>>> Warning: tools/memory-model/Documentation/simple.txt references a file that doesn't exist: Documentation/core-api/atomic_ops.rst
>>>>>
>>>>> It sounds that part of the above is due to DT patches that weren't
>>>>> merged yet, but there are a few others that can be solved, but may
>>>>> require discussions with some Kernel developers/maintainers.
>>>>>
>>>>> 2. Duplicated ABI definitions
>>>>> -----------------------------
>>>>>
>>>>> $ scripts/get_abi.pl validate
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  ./Documentation/ABI/testing/sysfs-bus-iio:394
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  ./Documentation/ABI/testing/sysfs-bus-iio:395
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  ./Documentation/ABI/testing/sysfs-bus-iio:396
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  ./Documentation/ABI/testing/sysfs-bus-iio:397
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  ./Documentation/ABI/testing/sysfs-bus-iio:398
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  ./Documentation/ABI/testing/sysfs-bus-iio:399
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:2  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:8
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:0  ./Documentation/ABI/testing/sysfs-bus-iio:599
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:36  ./Documentation/ABI/testing/sysfs-bus-iio:588
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/out_currentY_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als:43  ./Documentation/ABI/testing/sysfs-bus-iio-health-afe440x:38
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:0  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:1  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1
>>>>> Warning: /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-distance-srf08:0  ./Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935:8
>>>>> Warning: /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Documentation/ABI/testing/sysfs-bus-iio:45
>>>>> Warning: /sys/class/backlight/<backlight>/l1_daylight_max is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-backlight-adp8860:12  ./Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870:4
>>>>> Warning: /sys/class/leds/<led>/repeat is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-led-trigger-pattern:28  ./Documentation/ABI/testing/sysfs-class-led-driver-el15203000:0
>>>>> Warning: /sys/kernel/iommu_groups/reserved_regions is defined 2 times:  ./Documentation/ABI/testing/sysfs-kernel-iommu_groups:15  ./Documentation/ABI/testing/sysfs-kernel-iommu_groups:27
>>>>>
>>>>> Perhaps you could check with Jonathan Cameron some strategy to address
>>>>> the IIO warnings.    
>>>>
>>>> I'm being a bit rubbish on those ones. All need a bit of thought...
>>>>
>>>> I'll try to kill off a few of them this weekend as *touch wood* my
>>>> review queue is looking fairly short.  
>>>
>>> As I mentioned in the cover letter for the series I've just sent out, I ran into
>>> a bit of an understanding gap around the two counter cases.  This isn't helped
>>> by the fact it is at least partly deprecated ABI given the counter subsystem
>>> has much richer ABI for these types of devices.
>>>
>>> @Fabrice, Benjamin and William.
>>> What do we do about that one?
>>>
>>> Thanks,
>>>
>>> Jonathan  
>>
>> I'd consider the IIO counter ABI as entirely deprecated -- the Counter
>> subsystem supports all the functionality that's provided by the IIO
>> counter ABI, as well as additional functionality that is missing. 
>>
>> Regarding the iio:deviceX/in_count_quadrature_mode_available attribute:
>> superseded by the Counter subsystem counterX/countY/function attribute.
>> The IIO counter ABI allows users to select between a quadrature counting
>> mode or a non-quadrature counting mode; unfortunately, it does not
>> specify what kind of quadrature or what kind of non-quadrature counting
>> is actually being performed by the device.
>>
>> Because the 104-quad-8 and stm32-lptimer-cnt drivers were the only ones
>> to use this attribute, they are luckily in sync -- both define the same
>> possible modes available: "quadrature" and "non-quadrature". You could
>> simply consolidate this attribute to the main sys-bus-iio file in order
>> to resolve this warning.
>>
>> Given that it has already been superceded by the Counter subsystem, I'd
>> also be all right with just removing the IIO Counter ABI entirely from
>> the codebase, or alternatively setting a future date for removal.
> 
> I agree that we should look to remove this ABI.  If we can establish no one
> is relying on it today then we can drop quickly.  If not it would be good
> to establish when we drop it.
> 
> Fabrice, Benjami any thoughts on the stm32-lptimer-cnt?

Hi Jonathan, William,

I apologize for the late reply, being busy on other topics. I think the
stm32 timer driver need some cleanup to remove this ABI:

- stm32-lptimer-counter indeed is similar to 104-quad-8 driver. It still
registers an IIO device with the "preset" attribute pointed out in the
doc warning. Yes, the counter interface covers the same.
So, I agree this ABI could be removed here. Still, I don't know if there
are users for the IIO counter ABI.
Dummy question... Is it needed to drop driver part and ABI, at the same
time ?

- stm32-timer-trigger driver which resides in iio, also registers preset
attr being pointed out above. I'm more concerned there: I think some
modes may depend on the preset attr, even for the trigger. Partial
removal was done by Benjamin earlier (after stm32-timer-cnt addition).
still I need to double check this.

At least dropping the stm32-lptimer-counter part, should avoid the
Warning here. So it may probably be ok in the short term?

Please advise,
Best Regards,
Fabrice

> 
> I'm going to hazard a guess that there aren't many 104-quad-8 users
> that you don't know about William, so if you think we can immediately drop
> the interface from that, lets do so, whether or not we can clean up
> the stm32 one at the same time.
> 
> Jonathan
> 
>>
>> William Breathitt Gray
>>
>>>>
>>>> Jonathan
>>>>   
>>>>>
>>>>> Thanks,
>>>>> Mauro    
>>>>   
>>>   
>>
> 
