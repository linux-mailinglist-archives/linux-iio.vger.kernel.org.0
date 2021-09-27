Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739A44190E9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhI0Ien (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 04:34:43 -0400
Received: from mx24.baidu.com ([111.206.215.185]:39926 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233564AbhI0Ieh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 04:34:37 -0400
Received: from BC-Mail-Ex32.internal.baidu.com (unknown [172.31.51.26])
        by Forcepoint Email with ESMTPS id 6D35EDC21C8CE232EB7E;
        Mon, 27 Sep 2021 16:32:58 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex32.internal.baidu.com (172.31.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:32:56 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 27 Sep 2021 16:32:56 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] iio: light: gp2ap002: Make use of the helper function dev_err_probe()
Date:   Mon, 27 Sep 2021 16:32:37 +0800
Message-ID: <20210927083238.949-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210927083238.949-1-caihuoqing@baidu.com>
References: <20210927083238.949-1-caihuoqing@baidu.com>
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
 drivers/iio/light/gp2ap002.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index f960be7d4001..724a3928ead1 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -521,15 +521,14 @@ static int gp2ap002_probe(struct i2c_client *client,
 	}
 
 	gp2ap002->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(gp2ap002->vdd)) {
-		dev_err(dev, "failed to get VDD regulator\n");
-		return PTR_ERR(gp2ap002->vdd);
-	}
+	if (IS_ERR(gp2ap002->vdd))
+		return dev_err_probe(dev, PTR_ERR(gp2ap002->vdd),
+				     "failed to get VDD regulator\n");
+
 	gp2ap002->vio = devm_regulator_get(dev, "vio");
-	if (IS_ERR(gp2ap002->vio)) {
-		dev_err(dev, "failed to get VIO regulator\n");
-		return PTR_ERR(gp2ap002->vio);
-	}
+	if (IS_ERR(gp2ap002->vio))
+		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
+				     "failed to get VIO regulator\n");
 
 	/* Operating voltage 2.4V .. 3.6V according to datasheet */
 	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);
-- 
2.25.1

