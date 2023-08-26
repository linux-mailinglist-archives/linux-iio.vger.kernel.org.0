Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD321789371
	for <lists+linux-iio@lfdr.de>; Sat, 26 Aug 2023 04:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjHZCaG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Aug 2023 22:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjHZC3g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 22:29:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE86F128
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 19:29:34 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXgg40Vj9zJrnb;
        Sat, 26 Aug 2023 10:26:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 10:29:31 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <yangyingliang@huawei.com>,
        <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH -next v2 0/3] iio: adc: at91_adc: Cleanup with the helpers
Date:   Sat, 26 Aug 2023 10:29:19 +0800
Message-ID: <20230826022922.3457054-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks") provides a new helper function to prepare and
enable a clock which keeps prepared (or enabled) during the whole
lifetime of the driver.

Use devm_request_irq() to request the interrupt, so we can
avoid having to manually clean this up.

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless
error is printed.

Changes in v2:
- Also use devm_request_irq() and dev_err_probe() to clean up the at91_adc.
- Split the at91_adc patch out to be a new patch set.

Jinjie Ruan (3):
  iio: adc: at91_adc: Use devm_clk_get_enabled() helper function
  iio: adc: at91_adc: Use devm_request_irq() helper function
  iio: adc: at91_adc: Simplify with dev_err_probe()

 drivers/iio/adc/at91_adc.c | 105 ++++++++++++-------------------------
 1 file changed, 34 insertions(+), 71 deletions(-)

-- 
2.34.1

