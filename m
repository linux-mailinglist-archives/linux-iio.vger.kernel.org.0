Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3578933D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 04:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjHZCDH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 22:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjHZCCy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 22:02:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A652129
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 19:02:51 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RXg6374ZKz1L9Fn;
        Sat, 26 Aug 2023 10:01:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 10:02:48 +0800
Message-ID: <2b9c3a6d-8d1d-7815-c4ea-59ff77654e3c@huawei.com>
Date:   Sat, 26 Aug 2023 10:02:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 1/4] iio: adc: at91_adc: Use devm_clk_get_enabled()
 helper function
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Michael.Hennerich@analog.com>, <heiko@sntech.de>,
        <yangyingliang@huawei.com>, <robh@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20230825105746.2999548-1-ruanjinjie@huawei.com>
 <20230825105746.2999548-2-ruanjinjie@huawei.com>
 <20230825135015.481d0aff@jic23-huawei>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230825135015.481d0aff@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2023/8/25 20:50, Jonathan Cameron wrote:
> te patch moving to
> devm_request_irq() as then the exit paths will become much simpler and you
> can also move to return dev_err_probe() save a few pointless lines of code
> and give the benefit of debug info for deferred return codes.

Right！I'll cleanup these together in v2.

