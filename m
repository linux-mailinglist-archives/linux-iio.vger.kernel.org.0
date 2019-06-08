Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32543399F9
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 03:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfFHBCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jun 2019 21:02:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36210 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfFHBCw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jun 2019 21:02:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so2006488pgb.3;
        Fri, 07 Jun 2019 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YgvRM0fa8wItnmd/7e3mHREuafKBIW7aDiObwQNf1zI=;
        b=mB7+gv4HF9j+P7mQTHXqtorleukYleS3WanGBKgSAydJIIL+xk+mUK1J9XcOVVhTB9
         8KGeMfXKt4FKbDa2tKIh/onCsCRZfgOfjzfX+vWed004sI347VTMiKO7NsICAckwi2Yl
         EH2RaBYI4Zm8chxMetvg+HlAh9yyO7EDQSB3QZOfECg84AU/PVGJxjjcVOc3d7CWTz8u
         rSKciVIaaSBx1cnagQ+2HKvJAngg+16e+lBygU+y2tRcUc3Ntg3FO1LTpwjuUSbEOrCP
         dECtUZxQqLlOl5StA7UqS1Xr03msNSMWT9bfuqKp0wzc6zKUNV/ae774eEPby7oy0/RN
         PVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YgvRM0fa8wItnmd/7e3mHREuafKBIW7aDiObwQNf1zI=;
        b=liZjpjPnoLeWpvVNQMKR1nQL0PlOmIvrmWh5Q70/sitoDjirVMPTbx2/H2AtuziCA8
         LngXk5OD+dZiUBDDPqphijnE2iL6NWh4IdmkRcZMpHWWkkQTKyGNQvkCpz8IU5uoTaYh
         mI+i/WBn1weo2ybzIWYx1sK+5CPVDfHG/YaixBe6CeRN0F0cS5qJrG1WPLF9k7XjZ6We
         54I5y6bVDhwr7MvsObIFd/DwufNjtekkoGMXMVBeyIT2tJlRuP+yQqoQFdi9uTSPb6B+
         zfFyLzJwhchVQjgGITDHmRlIM5fdJnklD1WzdqT0r+5zALbSxk+MfGm+jt/sEk4ic0Ph
         M/Ow==
X-Gm-Message-State: APjAAAVlr+Us4Xj9V0pq+1srfjdMo77BHiWbOpcS0s54QHPBYuXCj9cz
        2RPEd/kigGgOTreVm5rg2v+HkLjP
X-Google-Smtp-Source: APXvYqzX74zqceXQykHaNAit68dyghLJ5CBj4exNfV2VYZtCpkuxHoqHR5e2ls87m36J3U9R+jFM1A==
X-Received: by 2002:a63:fb05:: with SMTP id o5mr5591847pgh.203.1559955771254;
        Fri, 07 Jun 2019 18:02:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1sm2884222pgv.15.2019.06.07.18.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 18:02:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: Add ads1000/ads1100 voltage ADCs driver
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Jean Delvare <jdelvare@suse.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20190514225810.12591-1-fancer.lancer@gmail.com>
 <20190514225810.12591-3-fancer.lancer@gmail.com>
 <20190530125510.GA26072@roeck-us.net> <20190603121117.0000512c@huawei.com>
 <20190605205556.GA397@roeck-us.net>
 <20190607230144.fnkzljhnnqks5oqx@mobilestation>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <02ff9666-d666-c539-aeb3-9e67fc358b17@roeck-us.net>
Date:   Fri, 7 Jun 2019 18:02:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607230144.fnkzljhnnqks5oqx@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/7/19 4:01 PM, Serge Semin wrote:
> Hello folks
> 
> On Wed, Jun 05, 2019 at 01:55:56PM -0700, Guenter Roeck wrote:
>> On Mon, Jun 03, 2019 at 12:11:17PM +0100, Jonathan Cameron wrote:
>>> On Thu, 30 May 2019 05:55:10 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> Hi,
>>>>
>>>> On Wed, May 15, 2019 at 01:58:09AM +0300, Serge Semin wrote:
>>>>> These are simple Texas Instruments ADC working over i2c-interface with
>>>>> just one differential input and with configurable 12-16 bits resolution.
>>>>> Sample rate is fixed to 128 for ads1000 and can vary from 8 to 128 for
>>>>> ads1100. Vdd value reference value must be supplied so to properly
>>>>> translate the sampled code to the real voltage. All of these configs are
>>>>> implemented in the device drivers for hwmon subsystem. The next dts
>>>>> properties should be specified to comply the device platform setup:
>>>>>   - vdd-supply - voltage regulator connected to the Vdd pin of the device
>>>>>   - ti,gain - programmable gain amplifier
>>>>>   - ti,datarate - converter data rate
>>>>>   - ti,voltage-divider - possible resistors-base external divider
>>>>> See bindings documentation file for details.
>>>>>
>>>>> Even though these devices seem more like ads1015 series, they
>>>>> in fact pretty much different. First of all ads1000/ads1100 got less
>>>>> capabilities: just one port, no configurations of digital comparator, no
>>>>> input multi-channel multiplexer, smaller PGA and data-rate ranges.
>>>>> In addition they haven't got internal voltage reference, but instead
>>>>> are created to use Vdd pin voltage. Finally the output code value is
>>>>> provided in different format. As a result it was much easier for
>>>>> development and for future support to create a separate driver.
>>>>>    
>>>>
>>>> This chicp doesn't have any real hardware monitoring characteristics
>>>> (no limit registers). It seems to be better suited to be implemented
>>>> as iio driver. If it is used as hardware monitor, the iio-hwmon bridge
>>>> should work just fine.
>>>>
>>>> Jonathan, what do you think ?
>>> Sorry for slow response, was on vacation.
>>>
>>> Agreed, this looks like a standard multipurpose ADC so probably more suited
>>> to IIO. Whether you bother with a buffered /chardev interface or not given it
>>> is a fairly slow device is a separate question (can always be added later
>>> when someone wants it).
>>>
>>> Note the voltage-divider in the DT properties is something that should
>>> have a generic representation. In IIO we have drivers/iio/afe/iio-rescale.c
>>> for that, in this case using the voltage divider binding.
>>>
>>> gain and datarate are both characteristics that should be controlled from
>>> userspace rather than via a binding.
>>>
>>
>> In summary: Serge, please re-implement the driver as iio adc driver.
>>
> 
> Thanks for the comments. I see your point, but since you are asking of a pretty
> much serious code redevelopment, I want to make sure it is fully justified.
> 
> I made my decision of creating the hwmon driver following the next logic.
> Before I started this driver development, I searched the kernel for either a
> ready-to-use code or for a similar device driver to add the ads1000 ADC support.
> I found the ads1015 driver, which is created for TI ADC1015 ADCs. These devices
> are similar to the ads1000 series, but are more complex. Due to the complexity
> I decided to create a separate driver for ads1000s, and of course since the similar
> device driver lived in hwmon, I chose it to be home of my new driver.
> 
> But now you are asking me to move it to IIO, while the driver of more complex
> ads1015 device exists in the hwmon subsystem of the kernel. Moreover the ads1000

A driver for ADS1015 also exists in drivers/iio/adc/ti-ads1015.c, meaning there
are already two drivers for that chip. Accepting the driver for ads1000 into
hwmon would ultimately mean that we would end up with another duplicate driver,
as soon as someone needs iio support for this chip. From hwmon perspective,
that driver would have zero additional functionality.

Users would then have to choose between the hwmon ads1000 driver and the iio
ads1000 driver plus iio->hwmon bridge. The kernel maintainers would have to
maintain two drivers instead of one, for no good reason. We would therefore
at that time remove hwmon driver from the kernel because it doesn't make sense
to keep two drivers for the same chip if both drivers provide exactly the same
functionality. This just doesn't make sense.

On top of that, the ads1000 has zero characteristics of a typical hardware
monitoring chip. It doesn't have any limit or alarm status registers.

> device is utilized on our board to monitor system itself (voltage on the input
> DC-DC). Could you please tell me why the driver should really be in IIO instead
> of hwmon and how do you select which subsystem one or another driver is supposed
> to live in?
> 
If a chip has typical hardware monitoring characteristics such as slow but accurate
conversion rates and limit/alarm registers, we are happy to accept it into the
hardware monitoring subsystem. If the chip has no such characteristics,
it should be implemented as iio driver.

Actually, we should remove the ads1015 driver from the hwmon subsystem.
I'll start a separate thread to discuss that.

Thanks,
Guenter
