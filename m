Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387A298DD9
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfHVIgQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 04:36:16 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:42598 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbfHVIgQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2019 04:36:16 -0400
Received: (qmail 29380 invoked by uid 5089); 22 Aug 2019 08:36:14 -0000
Received: by simscan 1.2.0 ppid: 29213, pid: 29214, t: 0.0835s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 22 Aug 2019 08:36:12 -0000
Subject: Re: iio: Is storing output values to non volatile registers something
 we should do automatically or leave to userspace action. [was Re: [PATCH]
 iio: potentiometer: max5432: update the non-volatile position]
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Kaiser <martin@kaiser.cx>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190809160617.21035-1-martin@kaiser.cx>
 <20190811101137.5bd495e9@archlinux>
 <20190812103751.gumfzgazlytq5zqm@viti.kaiser.cx>
 <42d99cc8-e59b-6c0b-d1e3-5690b8d1fe53@electromag.com.au>
 <20190818203256.202318d3@archlinux>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <18c1f34d-8db0-face-b026-a4676324220a@electromag.com.au>
Date:   Thu, 22 Aug 2019 16:36:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818203256.202318d3@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19/08/2019 03:32, Jonathan Cameron wrote:
> On Mon, 12 Aug 2019 19:08:12 +0800
> Phil Reid <preid@electromag.com.au> wrote:
> 
>> G'day Martin / Jonathan,
>>
>> On 12/08/2019 18:37, Martin Kaiser wrote:
>>> Hi Jonathan,
>>>
>>> Thus wrote Jonathan Cameron (jic23@kernel.org):
>>>    
>>>> The patch is fine, but I'm wondering about whether we need some element
>>>> of policy control on this restore to current value.
>>>    
>>>> A few things to take into account.
>>>    
>>>> * Some devices don't have a non volatile store.  So userspace will be
>>>>     responsible for doing the restore on reboot.
>>>> * This may be one of several related devices, and it may make no sense
>>>>     to restore this one if the others aren't going to be in the same
>>>>     state as before the reboot.
>>>> * Some devices only have non volatile registers for this sort of value
>>>>     (or save to non volatile on removal of power). Hence any policy to
>>>>     not store the value can't apply to this class of device.
>>>
>>> I see your point. You'd like a consistent bahaviour across all
>>> potentiometer drivers. Or at least a way for user space to figure out
>>> whether a chip uses non-volatile storage or not.
>>> This property doesn't quite fit into the channel info that are defined
>>> in the arrays in drivers/iio/industrialio-core.c. Is there any other way
>>> to set such a property?
>>>    
>>>> My initial thought is that these probably don't matter that much and
>>>> we should apply this, but I would like to seek input from others!
>>>    
>>>> I thought there were some other drivers doing similar store to no
>>>> volatile but I can't find one.
>>>
>>> drivers/iio/potentiometer/max5481.c and max5487.c do something similar.
>>>
>>> They use a command to transfer the setting from volatile to non-volatile
>>> register in the spi remove function. I guess that the intention is to
>>> save the current setting when the system is rebooted. However, my
>>> understanding is that the remove function is called only when a module
>>> is unloaded or when user space does explicitly unbind the device from
>>> the bus via sysfs. That's why I tried using the shutdown function
>>> instead.
>>>
>>> Still, this approach has some disadvantages. For many systems, there's a
>>> soft reboot (shutdown -r) where the driver's shutdown function is called
>>> and a "hard reboot" where the power from the CPU and the potentiometer
>>> chip is removed and reapplied. In this case, the current value would not
>>> be transfered to the non-volatile register.
>>>
>>> At least for the max5432 family, there's no way to read the current
>>> setting. The only option for user space to have a well-defined setting
>>> is to set the wiper position explicitly at startup.
>>>
>>> I guess the only sensible way to use a non-volatile register would be a
>>> write operation where user space gets a response about successful
>>> completion.
>>>
>>> We could have two channels to write to the volatile or to non-volatile
>>> register. Or we stick to one channel and update both volatile and
>>> non-volatile registers when user space changes the value. This assumes
>>> that the setting does not change frequently, which is prabably not true
>>> for all applications...
> 
> I'm not keen on multiple channels as that is a fairly non obvious interface.
> Definitely want to avoid writing all the time.
> 
>>>
>>> Whatever we come up with, we should at least make the max* chips behave
>>> the same way.
>>>    
>> The AD5272/AD5274 Digital Rheostat has a 50-times limit for programming the NV register.
>> So you want to be real sure that you want to set it.
> 
> Ouch, I new some were limited to a few thousand cycles, but 50 is rather nasty!
> 
>>
>> I'd rather my system default to a known "safe" value for next boot than
>> set to whatever the last write was. So some kind of policy on setting this would
>> be nice. I personally think it's something that userspace should initiate via an explicit
>> command.
> Agreed. I think we should look at an explicit write.
> 
> Perhaps an extra attribute on the channels?  Hence a shared_by_all version
> could be used when there is only one write command.

Yes, now the only question is what should it be called.

> 
>>
>> Writing the NV for the AD5272 is something I planned to add at some stage.
>> But so far the default factory values have worked ok.
>> It'd be nice for cross device consistency for any interface for this.
>>
> Agreed. This is an area that crept up on me, so we haven't enforced any
> consistency on it yet.  However, we definitely should!
> 
> Thanks,
> 
> Jonathan
> 
> 
> 


-- 
Regards
Phil Reid

