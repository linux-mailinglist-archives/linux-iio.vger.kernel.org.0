Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC35BD17A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiISPyn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiISPyl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:54:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A184026F2
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:54:39 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWTgp4RZrzpSyn;
        Mon, 19 Sep 2022 23:51:50 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:54:37 +0800
Subject: Re: [PATCH] iio: adc: ti-ads131e08: Silent no spi_device_id warnings
To:     Jonathan Cameron <jic23@kernel.org>,
        Wei Yongjun <weiyongjun@huaweicloud.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        <linux-iio@vger.kernel.org>
References: <20220919150011.823383-1-weiyongjun@huaweicloud.com>
 <20220919165030.541bb3ea@jic23-huawei>
From:   Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <72460466-3ff6-da90-e89c-30427d7b3b0d@huawei.com>
Date:   Mon, 19 Sep 2022 23:54:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20220919165030.541bb3ea@jic23-huawei>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2022/9/19 23:50, Jonathan Cameron wrote:
> On Mon, 19 Sep 2022 15:00:11 +0000
> Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
> 
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> Add spi_device_id entries to silent following SPI warnings:
>>
>> SPI driver ads131e08 has no spi_device_id for ti,ads131e04
>> SPI driver ads131e08 has no spi_device_id for ti,ads131e06
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/iio/adc/ti-ads131e08.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
>> index 5235a93f28bc..9a6bc1be2877 100644
>> --- a/drivers/iio/adc/ti-ads131e08.c
>> +++ b/drivers/iio/adc/ti-ads131e08.c
>> @@ -926,12 +926,21 @@ static const struct of_device_id ads131e08_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, ads131e08_of_match);
>>  
>> +static const struct spi_device_id ads131e08_ids[] = {
>> +	{ "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },
> 
> If we are going to provide this, please also modify the getting of the
> const struct ads131e08_info to use spi_get_device_id(spi)->driver_data
> if device_get_match_data() returned NULL.
> 
>  I don't think we have any magic in the SPI core to make that association
> (maybe I missed a change there).
> 
> This is needed in case we are probing via a route that doesn't provide
> firmware info via the interfaces in linux/property.h
> and hence uses the spi_device_id table to get this info.


Will fix it in next version.

Thanks.
Wei Yongjun


> 
> 
>> +	{ "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
>> +	{ "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(spi, ads131e08_ids);
>> +
>>  static struct spi_driver ads131e08_driver = {
>>  	.driver = {
>>  		.name = "ads131e08",
>>  		.of_match_table = ads131e08_of_match,
>>  	},
>>  	.probe = ads131e08_probe,
>> +	.id_table = ads131e08_ids,
>>  };
>>  module_spi_driver(ads131e08_driver);
>>  
> 
