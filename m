Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2E5F824B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Oct 2022 04:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJHCGj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Oct 2022 22:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJHCGi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Oct 2022 22:06:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D041144D9
        for <linux-iio@vger.kernel.org>; Fri,  7 Oct 2022 19:06:37 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MkpMf21mszlXd1;
        Sat,  8 Oct 2022 10:02:06 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 10:06:35 +0800
Subject: Re: [PATCH] iio: adc: ltc2496: Fix possible null-ptr-deref in
 ltc2496_probe()
To:     Jonathan Cameron <jic23@kernel.org>,
        Wei Yongjun <weiyongjun@huaweicloud.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        <linux-iio@vger.kernel.org>
References: <20220928040949.581092-1-weiyongjun@huaweicloud.com>
 <20221002142719.2c4c0d71@jic23-huawei>
From:   Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <d8ffed32-6841-2a84-ee12-3f2656ca3a35@huawei.com>
Date:   Sat, 8 Oct 2022 10:06:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20221002142719.2c4c0d71@jic23-huawei>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 2022/10/2 21:27, Jonathan Cameron wrote:
> On Wed, 28 Sep 2022 04:09:48 +0000
> Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
> 
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> KASAN report null-ptr-deref as follows:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>> CPU: 0 PID: 282 Comm: python3 Tainted: G N 6.0.0-rc7-next-20220927+ #153
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>> RIP: 0010:ltc2497core_probe+0x77/0x440 [ltc2497_core]
>> Call Trace:
>>  <TASK>
>>  ltc2496_probe+0xf4/0x150
>>  spi_probe+0x158/0x1f0 drivers/spi/spi.c:421
>>  call_driver_probe drivers/base/dd.c:560 [inline]
>>  really_probe+0x207/0x750 drivers/base/dd.c:639
>>  __driver_probe_device+0x229/0x2a0 drivers/base/dd.c:778
>>  device_driver_attach+0xb8/0x1e0 drivers/base/dd.c:1105
>>
>> This happend when probe ltc2496 device with spi device id but without
>> dts, device_get_match_data() return null chip_info. Fix it by adding
>> null check for chip_info in ltc2496_probe().
> 
> What tree are you based on?  When I look at this file I'm not seeing a
> spi_device_id table so how is it matching?
> 

When no spi_device_id tables exists, the driver name in ltc2496_driver
can be used as the spi_device_id for matching.


> Also I'd prefer a more comprehensive fix that ensured the same data is
> available via the spi_device_id table and uses that if
> device_get_match_data() == NULL.
> 

Got it, will fix in next version.


Regards,
Wei Yongjun

