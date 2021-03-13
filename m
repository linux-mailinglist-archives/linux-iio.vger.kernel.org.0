Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E833A073
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 20:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhCMT1a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 14:27:30 -0500
Received: from www381.your-server.de ([78.46.137.84]:60772 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhCMT1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Mar 2021 14:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=2Y/++9sYlBOYM4KS9PfUZArW4uGIS1XD0WcoRAPtU8M=; b=cP7KzTH6Bhq//tq87yGTEQrr7m
        vBJpC+sAng0xyXptldg/stwyvL/9PMjJf2z2X+qUo3/RhXmoKuc5L4JXg6Nd03YAd5hkXRm8G8jM2
        07IDZoW4EoQZYN/3sT+1Xu96xnDj0dckgJozFVLMipgyaFo2Sh7RCmooOYz5IFnr33UPTbo5Xd3EC
        WrYgg6xNy+6Jve4SL7PCHU2HGNDxVCMV5esCfoknrarPuAZg3ZFaCD/EKa3Grw3EKQ72vNMjwKjJR
        LNbHrSTC4OM0gzGTbS3tn/i3Cy75aHtDWqMUmFrbhiU/sB2A8juENAcMLebTjyg83yE1NaUKDqHoB
        bSnxo1iQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lL9ur-000Gq3-As; Sat, 13 Mar 2021 20:27:13 +0100
Received: from [2001:a61:2aea:a901:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lL9ur-000MEQ-6U; Sat, 13 Mar 2021 20:27:13 +0100
Subject: Re: GSoC IIO project: Mugil
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Mugil Raj <dmugil2000@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Utkarsh Verma <utkarshverma294@gmail.com>
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
 <CA+U=DsqAcmQq2qPMfxVcuwLWJefus_qyM1wG+ioGyG8bej88pw@mail.gmail.com>
 <20210313152834.GA99671@mugil-Nitro-AN515-52>
 <CA+U=DspeDi0uX3JYBt1Q0pCHhQ6bszg8siUPQ9HE4CJi7rpG_A@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <53ae83be-2568-bdf4-6f5e-1875ba408c73@metafoo.de>
Date:   Sat, 13 Mar 2021 20:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DspeDi0uX3JYBt1Q0pCHhQ6bszg8siUPQ9HE4CJi7rpG_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26107/Sat Mar 13 13:02:04 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/13/21 7:43 PM, Alexandru Ardelean wrote:
> On Sat, Mar 13, 2021 at 5:28 PM Mugilraj <dmugil2000@gmail.com> wrote:
>> On Thu, Mar 11, 2021 at 10:58:53AM +0200, Alexandru Ardelean wrote:
>>> On Thu, Mar 11, 2021 at 9:03 AM Mugil Raj <dmugil2000@gmail.com> wrote:
>>>> Hi,
>>>> This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
>>>> GSoC'21 for the project IIO driver. So, I need help from you guys with
>>>> the application process and finding the device to develop a driver.
>>>> I've done few exercises on patch submissions and completed a Linux
>>>> Foundations course, "A beginners guide to Linux kernel development
>>>> (LFD103)". I found this "https://kernelnewbies.org/IIO_tasks" task for
>>>> beginners, and now I'm doing that also If anyone suggests some fixes
>>>> to develop, that would be helpful for me.
>>>>
>>>
>>> hey,
>>>
>>> i posted some ideas here:
>>> https://lore.kernel.org/linux-iio/CA+U=Dsp98caW89g9FbsV-+KQ-NjyOqd+KSkO+aaFp4qBb-hpMg@mail.gmail.com/T/#md6c49f2e457d66d922d3d22f1f6fdb54971e6b8a
>>>
>>> [a quick copy + paste from that email]
>>>
>>> One thing I've always wanted to do, is to convert the entire IIO
>>> subsystem to devm_ variants.
>>> Essentially getting rid of the iio_device_unregister() function in
>>> favor of using devm_iio_device_unregister() and similar.
>>>
>>> There's about ~217 uses of this function.
>>> The more complicated one is in the 'drivers/platform/x86/toshiba_acpi.c'
>>> I think reworking the Toshiba ACPI driver would also be interesting,
>>> but it is some work.
>>>
>>> Now, converting everything to devm_ variants can be considered a bit
>>> of an obsession [by some people].
>>> But I sometimes find potential memory leaks by doing this conversion.
>>> And chances are that we may never be able to fully convert the IIO API
>>> to be devm_ variant-only.
>>> But it is an interesting process [for me], just the cleanup itself.
>> I've gone through docs and I hade a dout on devm_iio_device_register().
>> If we use this function it  will automatically unregistered on driver
>> detach. Then what is the use of devm_iio_device_unregister().
> [...]
>> It may be a silly question sorry:).
> not a silly question;
> this is all kernel API stuff, which isn't obvious in the beginning

Mugil,

There are two drivers that would be good candidates to get started with this, send your first patch and familiarize yourself with the process.

  * drivers/iio/dac/max517.c
  * drivers/iio/gyro/adis16080.c

Basically if iio_device_unregister() is the last function that gets called in the remove() function of the driver it is usually safe to convert the iio_device_register() in the probe function to a devm_iio_device_register().

- Lars

