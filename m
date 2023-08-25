Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32660788545
	for <lists+linux-iio@lfdr.de>; Fri, 25 Aug 2023 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjHYK6W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHYK6L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 06:58:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F01BC9
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 03:58:08 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXH1H0TQ4zVk5T;
        Fri, 25 Aug 2023 18:55:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 18:58:05 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Michael.Hennerich@analog.com>, <heiko@sntech.de>,
        <yangyingliang@huawei.com>, <robh@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/4] iio: Use devm_clk_get_enabled() helper function
Date:   Fri, 25 Aug 2023 18:57:42 +0800
Message-ID: <20230825105746.2999548-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks") provides a new helper function to prepare and
enable a clock which keeps prepared (or enabled) during the whole
lifetime of the driver.

Jinjie Ruan (4):
  iio: adc: at91_adc: Use devm_clk_get_enabled() helper function
  iio: adc: mt6577_auxadc: Use devm_clk_get_enabled() helper function
  iio: adc: spear_adc: Use devm_clk_get_enabled() helper function
  iio: frequency: adf4350: Use devm_clk_get_enabled() helper function

 drivers/iio/adc/at91_adc.c      | 38 +++++++++------------------------
 drivers/iio/adc/mt6577_auxadc.c | 17 +++------------
 drivers/iio/adc/spear_adc.c     | 30 ++++++--------------------
 drivers/iio/frequency/adf4350.c | 20 +++++------------
 4 files changed, 25 insertions(+), 80 deletions(-)

-- 
2.34.1

