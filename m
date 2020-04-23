Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9C1B53D5
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 06:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgDWEwn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 00:52:43 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:38474 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgDWEwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2020 00:52:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 0AA90200987E;
        Thu, 23 Apr 2020 12:52:41 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VZx7VtcbFw3r; Thu, 23 Apr 2020 12:52:40 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id DC490200986C;
        Thu, 23 Apr 2020 12:52:40 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.45])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 8F604C01A1D;
        Thu, 23 Apr 2020 12:52:40 +0800 (HKT)
Subject: Re: inquiry: where to place iio/ bandpass filter driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org
References: <55472b69-c587-ca04-d3b9-c8615e6a652d@gtsys.com.hk>
 <20200417102350.00003a28@Huawei.com>
 <a67b5e24-94df-cc84-73ae-004c0a27a26a@gtsys.com.hk>
 <20200422182540.0000410f@huawei.com>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <0af907a2-c85e-ab40-2fed-ba391fad0fed@gtsys.com.hk>
Date:   Thu, 23 Apr 2020 12:52:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422182540.0000410f@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 23/4/2020 1:25 am, Jonathan Cameron wrote:
> On Tue, 21 Apr 2020 08:37:13 +0800
> Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
>> Jonathan,
>>
>> On 17/4/2020 5:23 pm, Jonathan Cameron wrote:
>>> On Thu, 16 Apr 2020 11:48:31 +0800
>>> Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>>>   
>>>> Hi,
>>>>
>>>> I'm working on implementation for ltc6602 dual match bandpass
>>>> filter spi driver.
>>>> The driver tree has a iio/frequency which has PLLs at time beeing
>>>> and I wondering to drop my driver there or have a new directory
>>>> freqfilter or bpf ?
>>>>
>>>> This isn't urgent, but would be nice to know.
>>>>   
>>> Perhaps iio/afe?  It's a type of analog front end (or might be used
>>> as such). Is the intent to wrap these up as a consumer of an ADC?
>>> So they ultimately provide a unified device presentation to
>>> userspace of the ADC + filters. Or are we looking at simply
>>> controlling a filter which doesn't connect to an ADC or DAC visible
>>> to us?
>>>
>>> I'm not against a new directory for filters though.  Don't be
>>> specific on the type unless we need to be :)
>>>
>>> Jonathan
>> I place the driver into afe, makes totally sense to me, but have to
>> create a directory
>> linux/iio/afe which is not existing while I write this.
> curious.  It was introduced in 4.18.
>
> What tree are you working on top of?
linux-next , tag 20200408, 20200420

the include/linux/iio/afe not here.


>
>> will be then:
>> drivers/iio/afe/ltc6602.c
>> include/linux/iio/afe/ltc6602.h
> possibly on the header, but most IIO drivers don't have their own
> header. For kernel code it is preferred to put as much as possible
> directly in the c file.  The exceptions are drivers needing multiple
> files or where the header is used in conjunction with a DT binding.
>
>> add entry to drivers/iio/afe/Kconfig + Makefile.
>>
>> If i have the driver ready and checked I send my patches
> Great.
>
> Jonathan
>> Cheers
>> Chris
>>
>>>> Regards
>>>> Chris
>>>   

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html

