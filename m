Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96C3DB6DD
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhG3KJJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 30 Jul 2021 06:09:09 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:34477 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbhG3KJJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 06:09:09 -0400
Received: by mail-wr1-f51.google.com with SMTP id r2so10641518wrl.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Jul 2021 03:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TVgKJoPTYFqItcNwkDnte1OCHR5goR7p7DtNKnzDlUo=;
        b=s69wULAh03b7fW3g5+PkkGNvK21Lftka+KspwUyG+kw9rjAw7ojvNYM9RfqZHiaahC
         pjo0l1o8pSqIZPE3Z6iwsFtUrZmIgSfL02QRUMKlZ1bipTyTiEyKmOdmtpGat4SjeXxG
         BU/YbvjJes6aKj8NjkWCobFJe6zRvZrwL/TcUcXYzK1h8vUAUQfVD9OxrxwH/ws0U/jP
         vjWEhhTNUG1mB01Pcsy6+DJveBjwzmSx3GWHd4LTx7X29CS01Y813Vwp1qBhCPYJEp8v
         QUAwS7V+p3sJZgjgf2EwlWGetTZetKmzA6zRcIFMQWzkHhK75VwgrhdN9OX11FMn3M4z
         BfrQ==
X-Gm-Message-State: AOAM5309Ussq7Z2q+JLOLMjLd4kjSpoR5soE18HRKAZRgD2FZ2UZqrNg
        rRd2n25crW+cXUl9fEoK6Ns=
X-Google-Smtp-Source: ABdhPJws3xXmK9L4FQEzf4HaZCpjNxzxDZ0lC39ZSdERm2UkQMeCO6M+h6QWUWKO1qQAFS07d19ZRA==
X-Received: by 2002:a05:6000:18a9:: with SMTP id b9mr2145953wri.418.1627639743774;
        Fri, 30 Jul 2021 03:09:03 -0700 (PDT)
Received: from localhost.localdomain (cpc142184-mcam2-2-0-cust140.18-3.cable.virginm.net. [82.31.129.141])
        by smtp.gmail.com with ESMTPSA id 19sm1392801wmj.2.2021.07.30.03.09.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jul 2021 03:09:03 -0700 (PDT)
Received: from smtpclient.apple ([10.0.0.191])
        by localhost.localdomain (8.14.3/8.14.3/Debian-9.4) with ESMTP id 16U9mReS032713;
        Fri, 30 Jul 2021 10:48:28 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Patrick Regnouf <patrick@patricknet.net>
Mime-Version: 1.0 (1.0)
Subject: Re: IRQ related query
Date:   Fri, 30 Jul 2021 11:08:54 +0100
Message-Id: <57344167-348E-4DB9-9FBF-354265200913@patricknet.net>
References: <CA+U=DsoVoTAodAYPKbpshHx3B3u5Cdeg0UJCumVOKO4YQLXCJg@mail.gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
In-Reply-To: <CA+U=DsoVoTAodAYPKbpshHx3B3u5Cdeg0UJCumVOKO4YQLXCJg@mail.gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: iPhone Mail (18F72)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Alex, 

Thank you so much for clarifying this. It surely explains why I couldn’t find any documentation on how to do that!!!

Seems like, taking this in account,  we are going to go the i2c route…

Thanks again



/Patrick

> On 30 Jul 2021, at 09:30, Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> 
> ﻿On Fri, Jul 30, 2021 at 11:03 AM <patrick@patricknet.net> wrote:
>> 
>> Alex,
>> 
>> Thank you so very much for your help, I browsed most of that
>> litterature already and the kernel side of it is very much covered,
>> understood and assimilated.
>> 
>> However my question is basically: How can I be alerted, for example
>> through a callback function, when an interruption occurs in the kernel
>> space and my daemon lives in userspace.
>> 
>> IRQ Occuring -------> Upper half of the interrupt(put the timestamp in
>> the buffer) ---------> Lower half of the interrupt handler (read data
>> and adds the timestamp in the buffer) -----------> ???? userspace
>> daemon (async callback of some description) that will write a log on
>> the HD.
>> 
>> I have everything up to the daemon part written and working, I seem to
>> understand that through libiio you can assign a trigger to a
>> particular channel or attribute but that is where I get stuck.
>> 
>> Litterature on the libiio (most notably its wiki) has a chapter on
>> triggers that is 4 lines long ... not very helpful to say the least.
>> 
>> iioinfo lists the devices present in the LSM6DSLTR (18 devices
>> including two triggers) and I have been unable to assign the triggers
>> to any device that they are not assigned to already (No such file or
>> directory) which I gather refer to the absence of the trigger
>> directory in the sysfs for that  particular device.
>> 
>> I also gather that the sysfs directory is, of course, slave to the
>> kernel device tree and that the creation of that part of the device
>> tree is made as the driver is loaded.
>> 
>> So there must be a way to alter that part of the sysfs filesystem by
>> asking the kernel driver to provision a device in the context to
>> implement the trigger directory so we can assign a trigger to it
>> 
>> second part will be to slave that trigger to an actual IRQ (42 in my
>> case - as listed in /proc/interrupts) and be alerted in the  userspace
>> daemon when a thresold has been reached in terms of either
>> acceleration or vibration ...
>> 
>> Well, this is the nuts and bolts of what I am trying to achieve. the
>> last part will be to write a few registers on the chip to configure
>> how and when IRQ will occur for any given integrated devices.
>> 
>> Sorry to be such a pain but I thnk my problem lies in the passage of
>> information from kernel space (very well documented) to the userspace
>> (could not find reasonable documention and/or C code examples on how
>> to achieve this)
>> 
>> Thnks again
>> 
>> /Patrick
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> Quoting Alexandru Ardelean <ardeleanalex@gmail.com>:
>> 
>>> On Thu, Jul 29, 2021 at 3:54 PM Patrick Regnouf
>>> <patrick@patricknet.net> wrote:
>>>> 
>>>> Hello,
>>>> 
>>> 
>>> [I did not hit Reply All on my first email]
>>> 
>>> Hey,
>>> 
>>> For libiio in particular, it's on Github:
>>> https://github.com/analogdevicesinc/libiio
>>> 
>>> I think you could raise some questions as issues there.
>>> 
>>> And there's also a wiki that can be browsed:
>>> https://wiki.analog.com/resources/tools-software/linux-software/libiio
>>> https://wiki.analog.com/resources/tools-software/linux-software/libiio_internals
>>> 
>>> Now, regarding IIO events support in libiio, I am not sure [at point
>>> in time] whether support is implemented.
>>> 
>>> But an example of getting events from IIO can be found here:
>>> https://github.com/torvalds/linux/blob/master/tools/iio/iio_event_monitor.c
>>> 
>>> The https://github.com/torvalds/linux/blob/master/tools/iio/  folder
>>> in the kernel should offer some basic bits about accessing IIO
>>> devices, and getting events [which can be driver IRQ events, or kernel
>>> IIO polling]
>>> 
>>> I was going to answer on the previous question that you raised, but I forgot.
>>> Apologies. It's been a busy week.
> 
> Wait, I'm confusing/mixing triggers and events [in my head].
> Apologies. I'm still processing the coffee I ingested 1-2h ago.
> 
> libiio supports triggers. But not events.
> 
> However, the driver for LSM6DSLTR (i.e. the one here
> drivers/iio/imu/st_lsm6dsx) doesn't register any IIO triggers.
> So, there's nothing for libiio [or any userspace tool] to hook into
> for triggers.
> 
> There's an IRQ handler and IRQ thread-handler, but nothing to link
> these to IIO framework triggers.
> This needs to be implemented in the driver.
> An example of how IIO kernel triggers should be implemented in the
> driver is in drivers/iio/accel/adxl372.c and drivers/iio/imu/adis***
> drivers.
> 
>>> 
>>> Alex
>>> 
>>>> Please someone tell me whether this is the right mailing list to
>>>> ask questions related to actually using libiio or actually please
>>>> point me in the right direction
>>>> 
>>>> To summarise I am looking for C source code that would capture an
>>>> IRQ emitted by an iio accelerometer (LSM6DSLTR) all of that using
>>>> libiio
>>>> 
>>>> I have successfully implemented a program that can read the x, y
>>>> and z axis but that means polling constantly. Not an option…  the
>>>> iio_device_set_trigger however returns “no such file or directory “
>>>> 
>>>> Thanks
>>>> 
>>>> /Patrick
>> 
>> 
>> 

