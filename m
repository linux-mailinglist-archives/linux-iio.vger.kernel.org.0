Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7C78A607
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjH1GqB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 02:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjH1GqB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 02:46:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4110D
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 23:45:58 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZ1FB5bKJzhZFT;
        Mon, 28 Aug 2023 14:42:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 28 Aug
 2023 14:45:55 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <yangyingliang@huawei.com>,
        <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 0/3] iio: adc: at91_adc: Cleanup with the helpers
Date:   Mon, 28 Aug 2023 14:45:43 +0800
Message-ID: <20230828064546.2383857-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
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

changes in v3:
- Take the last remove free_irq() and add it to be the first devm managed.
- Not going any longer than 80 chars than is necessary.

Changes in v2:
- Also use devm_request_irq() and dev_err_probe() to clean up the at91_adc.
- Split the at91_adc patch out to be a new patch set.

Jinjie Ruan (3):
  iio: adc: at91_adc: Use devm_request_irq() helper function
  iio: adc: at91_adc: Use devm_clk_get_enabled() helper function
  iio: adc: at91_adc: Simplify with dev_err_probe()

 drivers/iio/adc/at91_adc.c | 108 +++++++++++++------------------------
 1 file changed, 37 insertions(+), 71 deletions(-)

-- 
2.34.1

