Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7F402367
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 08:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhIGGZU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Sep 2021 02:25:20 -0400
Received: from mx21.baidu.com ([220.181.3.85]:54486 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231828AbhIGGZU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Sep 2021 02:25:20 -0400
Received: from BC-Mail-Ex16.internal.baidu.com (unknown [172.31.51.56])
        by Forcepoint Email with ESMTPS id 241E27BF1FE1EDA7FFB7;
        Tue,  7 Sep 2021 14:24:13 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex16.internal.baidu.com (172.31.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 14:24:12 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 14:24:12 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad799x: Add a single error handling block at the end of the function.
Date:   Tue, 7 Sep 2021 14:24:06 +0800
Message-ID: <20210907062407.1930-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex30.internal.baidu.com (172.31.51.24) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A single error handling block at the end of the function could
be brought in to make code a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/iio/adc/ad799x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 18bf8386d50a..d3dbc4c1e375 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -891,20 +891,23 @@ static int __maybe_unused ad799x_resume(struct device *dev)
 	}
 	ret = regulator_enable(st->vref);
 	if (ret) {
-		regulator_disable(st->reg);
 		dev_err(dev, "Unable to enable vref regulator\n");
-		return ret;
+		goto error_disable_reg;
 	}
 
 	/* resync config */
 	ret = ad799x_update_config(st, st->config);
-	if (ret) {
-		regulator_disable(st->vref);
-		regulator_disable(st->reg);
-		return ret;
-	}
+	if (ret)
+		goto error_disable_vref;
 
 	return 0;
+
+error_disable_vref:
+	regulator_disable(st->vref);
+error_disable_reg:
+	regulator_disable(st->vref);
+
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);
-- 
2.25.1

