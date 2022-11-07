Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF71F61E83D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 02:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKGBZe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 20:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKGBZd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 20:25:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21F45FD8;
        Sun,  6 Nov 2022 17:25:31 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5D7M6x6HzmVj4;
        Mon,  7 Nov 2022 09:25:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 09:25:29 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 09:25:29 +0800
Subject: Re: [PATCH RESEND] Documentation: devres: add missing IIO helpers
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <Jonathan.Cameron@huawei.com>, <corbet@lwn.net>,
        <yangyingliang@huawei.com>
References: <20221103023402.1024437-1-yangyingliang@huawei.com>
 <20221105150812.66d81f40@jic23-huawei>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <7e984b00-8845-8938-1495-334c8d4db878@huawei.com>
Date:   Mon, 7 Nov 2022 09:25:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221105150812.66d81f40@jic23-huawei>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2022/11/5 23:08, Jonathan Cameron wrote:
> On Thu, 3 Nov 2022 10:34:02 +0800
> Yang Yingliang <yangyingliang@huawei.com> wrote:
>
>> Add some missing device-managed helpers of iio to devres.rst.
>>
>> devm_iio_kfifo_buffer_setup_ext() is introduced by commit 0a21526bc1d4 ("iio:
>> kfifo: add devm_iio_triggered_buffer_setup_ext variant").
>>
>> devm_iio_triggered_buffer_setup_ext() is introduced by commit 5164c7889857 ("iio:
>> triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants").
>>
>> devm_iio_hw_consumer_alloc() is introduced by b688c18d3006 ("IIO: hw_consumer:
>> add devm_iio_hw_consumer_alloc").
>>
>> devm_fwnode_iio_channel_get_by_name() is introduced by commit 1e64b9c5f9a0 ("iio:
>> inkern: move to fwnode properties").
>>
>> Fixes: 0a21526bc1d4 ("iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant")
>> Fixes: 5164c7889857 ("iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants")
>> Fixes: b688c18d3006 ("IIO: hw_consumer: add devm_iio_hw_consumer_alloc")
>> Fixes: 1e64b9c5f9a0 ("iio: inkern: move to fwnode properties")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> You didn't pick up my
>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> or mention that my assumption is that this will go via the docs tree.
I changed the commit message, it's not same as the earlier patch, so I 
didn't add your ACK tag.
It's nice that you acked this patch.

Thanks,
Yang
>
> Thanks,
>
> Jonathan
>
>> ---
>> The previous patch link:
>> https://patchwork.kernel.org/project/linux-iio/patch/20220927074043.942836-1-yangyingliang@huawei.com/
>> ---
>>   Documentation/driver-api/driver-model/devres.rst | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
>> index e0cb7df0f782..4249eb4239e0 100644
>> --- a/Documentation/driver-api/driver-model/devres.rst
>> +++ b/Documentation/driver-api/driver-model/devres.rst
>> @@ -287,12 +287,16 @@ IIO
>>     devm_iio_device_register()
>>     devm_iio_dmaengine_buffer_setup()
>>     devm_iio_kfifo_buffer_setup()
>> +  devm_iio_kfifo_buffer_setup_ext()
>>     devm_iio_map_array_register()
>>     devm_iio_triggered_buffer_setup()
>> +  devm_iio_triggered_buffer_setup_ext()
>>     devm_iio_trigger_alloc()
>>     devm_iio_trigger_register()
>>     devm_iio_channel_get()
>>     devm_iio_channel_get_all()
>> +  devm_iio_hw_consumer_alloc()
>> +  devm_fwnode_iio_channel_get_by_name()
>>   
>>   INPUT
>>     devm_input_allocate_device()
> .
