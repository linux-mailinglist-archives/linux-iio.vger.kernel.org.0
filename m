Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E5407C10
	for <lists+linux-iio@lfdr.de>; Sun, 12 Sep 2021 08:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhILGmq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Sep 2021 02:42:46 -0400
Received: from mx20.baidu.com ([111.202.115.85]:48466 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229535AbhILGmp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Sep 2021 02:42:45 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id 4FA382798FCFEE9D74E4;
        Sun, 12 Sep 2021 14:41:17 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 12 Sep 2021 14:41:16 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.11) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 12 Sep 2021 14:41:16 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v2] iio: adc: ad799x: Add a single error handling block at the end of the function.
Date:   Sun, 12 Sep 2021 14:41:01 +0800
Message-ID: <20210912064101.539-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.11]
X-ClientProxiedBy: BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A single error handling block at the end of the function could
be brought in to make code a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2:
Change the error path-error_disable_reg from "st->vref" to "st->reg".

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
+	regulator_disable(st->reg);
+
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);
-- 
2.25.1

