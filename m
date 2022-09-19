Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12BE5BCF98
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiISOuq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISOul (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 10:50:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CCE11A15
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:50:39 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWSCm4sWVzMn2r;
        Mon, 19 Sep 2022 22:45:56 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 22:50:36 +0800
Subject: Re: [PATCH] iio: adc: ad7124: Silent no spi_device_id warnings
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Wei Yongjun <weiyongjun@huaweicloud.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>
References: <20220919145945.823327-1-weiyongjun@huaweicloud.com>
 <d4fa7502-d5a5-9849-8daf-efc25a22ae81@metafoo.de>
From:   Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <d7afc35d-e764-609c-003c-5ff664649eb4@huawei.com>
Date:   Mon, 19 Sep 2022 22:50:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <d4fa7502-d5a5-9849-8daf-efc25a22ae81@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2022/9/19 22:46, Lars-Peter Clausen wrote:
> On 9/19/22 16:59, Wei Yongjun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> Add spi_device_id entries to silent following SPI warnings:
>>
>> SPI driver ad7124 has no spi_device_id for adi,ad7124-4
>> SPI driver ad7124 has no spi_device_id for adi,ad7124-8
> What generates those warnings?
> 

Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
compatible") added a test to check that every SPI driver has a
spi_device_id for each DT compatiable string defined by the driver
and warns if the spi_device_id is missing.

Regards,
Wei Yongjun
