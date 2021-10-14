Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5A42DA9E
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhJNNlJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 09:41:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28943 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJNNlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 09:41:04 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HVVk86Y6JzbjLn;
        Thu, 14 Oct 2021 21:34:24 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 21:38:53 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 21:38:53 +0800
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Fix possible memory leak in probe
 and remove
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <jic23@kernel.org>, <hdegoede@redhat.com>,
        <ddvlad@gmail.com>
References: <20211014035338.3750416-1-yangyingliang@huawei.com>
 <YWhEwqdHbPTAfvto@smile.fi.intel.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <d4b9addc-1896-7e78-8a57-9ef0a8ab8f38@huawei.com>
Date:   Thu, 14 Oct 2021 21:38:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YWhEwqdHbPTAfvto@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2021/10/14 22:54, Andy Shevchenko wrote:
> On Thu, Oct 14, 2021 at 11:53:38AM +0800, Yang Yingliang wrote:
>> When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
>> memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
>> memory leak as follows:
> It seems it's not first time I'm telling you to shrink the noise in the commit
> message.  Can you please LEARN this once and forever?
Thanks for you advice, I searched the whole kernel source tree commit 
message to
learn how to make the memory leak report, I found most of them using the 
whole
backtrace, so I make the report like they did in this patch. I will 
shrink the noise in v2.
How about shrink it like this:

unreferenced object 0xffff888009551400 (size 512):
   comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
   hex dump (first 32 bytes):
     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
     00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
   backtrace:
     [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
     [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
     [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 
[industrialio_triggered_buffer]
     [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]

Thanks,
Yang
>
>> unreferenced object 0xffff888009551400 (size 512):
>>    comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
>>    hex dump (first 32 bytes):
>>      02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>      00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
>>    backtrace:
>>      [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
>>      [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
>>      [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 [industrialio_triggered_buffer]
>>      [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]
>>      [<0000000020115b9a>] i2c_device_probe+0xa31/0xbe0
>>      [<00000000d9f581a6>] really_probe+0x299/0xc30
>>      [<00000000c6c16cde>] __driver_probe_device+0x357/0x500
>>      [<00000000909852a1>] driver_probe_device+0x4e/0x140
>>      [<000000008419ba53>] __device_attach_driver+0x257/0x340
>>      [<00000000533bb466>] bus_for_each_drv+0x166/0x1e0
>>      [<000000005bf45d75>] __device_attach+0x272/0x420
>>      [<0000000075220311>] bus_probe_device+0x1eb/0x2a0
>>      [<0000000015587e85>] device_add+0xbf0/0x1f90
>>      [<0000000086901b9e>] i2c_new_client_device+0x622/0xb20
>>      [<000000000865ca18>] new_device_store+0x1fa/0x420
>>      [<0000000059a3d183>] dev_attr_store+0x58/0x80
