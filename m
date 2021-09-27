Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5154190E3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhI0Ie0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 04:34:26 -0400
Received: from mx22.baidu.com ([220.181.50.185]:39682 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233417AbhI0Ie0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 04:34:26 -0400
Received: from BC-Mail-EX04.internal.baidu.com (unknown [172.31.51.44])
        by Forcepoint Email with ESMTPS id B85041FB9F94DBD29FD4;
        Mon, 27 Sep 2021 16:32:47 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX04.internal.baidu.com (172.31.51.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:32:47 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 27 Sep 2021 16:32:47 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] iio: light: cm3605: Make use of the helper function dev_err_probe()
Date:   Mon, 27 Sep 2021 16:32:35 +0800
Message-ID: <20210927083238.949-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
Using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/iio/light/cm3605.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 4c83953672be..0b90564213e8 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -211,10 +211,10 @@ static int cm3605_probe(struct platform_device *pdev)
 	}
 
 	cm3605->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(cm3605->vdd)) {
-		dev_err(dev, "failed to get VDD regulator\n");
-		return PTR_ERR(cm3605->vdd);
-	}
+	if (IS_ERR(cm3605->vdd))
+		return dev_err_probe(dev, PTR_ERR(cm3605->vdd),
+				     "failed to get VDD regulator\n");
+
 	ret = regulator_enable(cm3605->vdd);
 	if (ret) {
 		dev_err(dev, "failed to enable VDD regulator\n");
@@ -223,8 +223,7 @@ static int cm3605_probe(struct platform_device *pdev)
 
 	cm3605->aset = devm_gpiod_get(dev, "aset", GPIOD_OUT_HIGH);
 	if (IS_ERR(cm3605->aset)) {
-		dev_err(dev, "no ASET GPIO\n");
-		ret = PTR_ERR(cm3605->aset);
+		ret = dev_err_probe(dev, PTR_ERR(cm3605->aset), "no ASET GPIO\n");
 		goto out_disable_vdd;
 	}
 
-- 
2.25.1

