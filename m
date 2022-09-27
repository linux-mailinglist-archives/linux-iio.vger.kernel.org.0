Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF55EBCE6
	for <lists+linux-iio@lfdr.de>; Tue, 27 Sep 2022 10:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiI0INw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiI0INe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 04:13:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F3B7D7B5;
        Tue, 27 Sep 2022 01:09:05 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McBwc6fytzHtfR;
        Tue, 27 Sep 2022 16:04:16 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:09:03 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:09:02 +0800
Subject: Re: [PATCH -next] Documentation: devres: add missing IIO helpers
To:     <linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <Jonathan.Cameron@huawei.com>, <corbet@lwn.net>,
        <yangyingliang@huawei.com>
References: <20220927074043.942836-1-yangyingliang@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <850dabb9-e62b-2273-9371-1ae1b7535e50@huawei.com>
Date:   Tue, 27 Sep 2022 16:09:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220927074043.942836-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Cc: Jonathan Corbet <corbet@lwn.net>

On 2022/9/27 15:40, Yang Yingliang wrote:
> Add missing device-managed helpers of iio to devres.rst.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   Documentation/driver-api/driver-model/devres.rst | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 2895f9ea00c4..5154844bc222 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -286,12 +286,16 @@ IIO
>     devm_iio_device_register()
>     devm_iio_dmaengine_buffer_setup()
>     devm_iio_kfifo_buffer_setup()
> +  devm_iio_kfifo_buffer_setup_ext()
>     devm_iio_map_array_register()
>     devm_iio_triggered_buffer_setup()
> +  devm_iio_triggered_buffer_setup_ext()
>     devm_iio_trigger_alloc()
>     devm_iio_trigger_register()
>     devm_iio_channel_get()
>     devm_iio_channel_get_all()
> +  devm_iio_hw_consumer_alloc()
> +  devm_fwnode_iio_channel_get_by_name()
>   
>   INPUT
>     devm_input_allocate_device()
