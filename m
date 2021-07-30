Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC73DB4FD
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhG3IW0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 04:22:26 -0400
Received: from lotus.prowebdns.com ([81.19.181.157]:47341 "EHLO
        lotus.prowebdns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhG3IWZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 04:22:25 -0400
X-Greylist: delayed 1128 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 04:22:25 EDT
Received: from [::1] (port=52386 helo=lotus.prowebdns.com)
        by lotus.prowebdns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <patrick@patricknet.net>)
        id 1m9NUR-00055M-HG; Fri, 30 Jul 2021 09:03:28 +0100
Received: from [82.31.129.141] ([82.31.129.141]) by www.patricknet.net
 (Horde Framework) with HTTPS; Fri, 30 Jul 2021 09:03:28 +0100
Date:   Fri, 30 Jul 2021 09:03:28 +0100
Message-ID: <20210730090328.Horde.UFBzdgjVdntkW8Y7kU-s71p@www.patricknet.net>
From:   patrick@patricknet.net
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: IRQ related query
References: <2B7BAE11-FF1D-4A3C-9E00-E3ACD280D66E@patricknet.net>
 <CA+U=DsroXD3v85COsvXqB5xkVYTzayuEb-gWWF=-45+MhJyUfA@mail.gmail.com>
In-Reply-To: <CA+U=DsroXD3v85COsvXqB5xkVYTzayuEb-gWWF=-45+MhJyUfA@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - lotus.prowebdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - patricknet.net
X-Get-Message-Sender-Via: lotus.prowebdns.com: authenticated_id: patrick@patricknet.net
X-Authenticated-Sender: lotus.prowebdns.com: patrick@patricknet.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Alex,

Thank you so very much for your help, I browsed most of that  
litterature already and the kernel side of it is very much covered,  
understood and assimilated.

However my question is basically: How can I be alerted, for example  
through a callback function, when an interruption occurs in the kernel  
space and my daemon lives in userspace.

IRQ Occuring -------> Upper half of the interrupt(put the timestamp in  
the buffer) ---------> Lower half of the interrupt handler (read data  
and adds the timestamp in the buffer) -----------> ???? userspace  
daemon (async callback of some description) that will write a log on  
the HD.

I have everything up to the daemon part written and working, I seem to  
understand that through libiio you can assign a trigger to a  
particular channel or attribute but that is where I get stuck.

Litterature on the libiio (most notably its wiki) has a chapter on  
triggers that is 4 lines long ... not very helpful to say the least.

iioinfo lists the devices present in the LSM6DSLTR (18 devices  
including two triggers) and I have been unable to assign the triggers  
to any device that they are not assigned to already (No such file or  
directory) which I gather refer to the absence of the trigger  
directory in the sysfs for that  particular device.

I also gather that the sysfs directory is, of course, slave to the  
kernel device tree and that the creation of that part of the device  
tree is made as the driver is loaded.

So there must be a way to alter that part of the sysfs filesystem by  
asking the kernel driver to provision a device in the context to  
implement the trigger directory so we can assign a trigger to it

second part will be to slave that trigger to an actual IRQ (42 in my  
case - as listed in /proc/interrupts) and be alerted in the  userspace  
daemon when a thresold has been reached in terms of either  
acceleration or vibration ...

Well, this is the nuts and bolts of what I am trying to achieve. the  
last part will be to write a few registers on the chip to configure  
how and when IRQ will occur for any given integrated devices.

Sorry to be such a pain but I thnk my problem lies in the passage of  
information from kernel space (very well documented) to the userspace  
(could not find reasonable documention and/or C code examples on how  
to achieve this)

Thnks again

/Patrick









Quoting Alexandru Ardelean <ardeleanalex@gmail.com>:

> On Thu, Jul 29, 2021 at 3:54 PM Patrick Regnouf  
> <patrick@patricknet.net> wrote:
>>
>> Hello,
>>
>
> [I did not hit Reply All on my first email]
>
> Hey,
>
> For libiio in particular, it's on Github:
> https://github.com/analogdevicesinc/libiio
>
> I think you could raise some questions as issues there.
>
> And there's also a wiki that can be browsed:
> https://wiki.analog.com/resources/tools-software/linux-software/libiio
> https://wiki.analog.com/resources/tools-software/linux-software/libiio_internals
>
> Now, regarding IIO events support in libiio, I am not sure [at point  
> in time] whether support is implemented.
>
> But an example of getting events from IIO can be found here:
> https://github.com/torvalds/linux/blob/master/tools/iio/iio_event_monitor.c
>
> The https://github.com/torvalds/linux/blob/master/tools/iio/  folder
> in the kernel should offer some basic bits about accessing IIO
> devices, and getting events [which can be driver IRQ events, or kernel
> IIO polling]
>
> I was going to answer on the previous question that you raised, but I forgot.
> Apologies. It's been a busy week.
>
> Alex
>
>> Please someone tell me whether this is the right mailing list to  
>> ask questions related to actually using libiio or actually please  
>> point me in the right direction
>>
>> To summarise I am looking for C source code that would capture an  
>> IRQ emitted by an iio accelerometer (LSM6DSLTR) all of that using  
>> libiio
>>
>> I have successfully implemented a program that can read the x, y  
>> and z axis but that means polling constantly. Not an option…  the  
>> iio_device_set_trigger however returns “no such file or directory “
>>
>> Thanks
>>
>> /Patrick



