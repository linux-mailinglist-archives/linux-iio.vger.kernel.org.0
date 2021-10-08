Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA64266C8
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 11:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhJHJ3I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 05:29:08 -0400
Received: from mx22.baidu.com ([220.181.50.185]:35260 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238471AbhJHJ3H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 05:29:07 -0400
Received: from BJHW-Mail-Ex08.internal.baidu.com (unknown [10.127.64.18])
        by Forcepoint Email with ESMTPS id 608CF5E843CA90EF356F;
        Fri,  8 Oct 2021 17:27:11 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:27:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:27:10 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] iio: light: gp2ap002: Make use of the helper function dev_err_probe()
Date:   Fri, 8 Oct 2021 17:26:54 +0800
Message-ID: <20211008092656.421-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008092656.421-1-caihuoqing@baidu.com>
References: <20211008092656.421-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2021-10-08 17:27:11:417
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
v2: Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
v2->v3:
	*Handle the lack of availability of an IIO channel
	 by converting an -ENODEV to an -EPROBE_DEFER.

 drivers/iio/light/gp2ap002.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index f960be7d4001..c6d1d88d3775 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -503,12 +503,9 @@ static int gp2ap002_probe(struct i2c_client *client,
 	if (!gp2ap002->is_gp2ap002s00f) {
 		gp2ap002->alsout = devm_iio_channel_get(dev, "alsout");
 		if (IS_ERR(gp2ap002->alsout)) {
-			if (PTR_ERR(gp2ap002->alsout) == -ENODEV) {
-				dev_err(dev, "no ADC, deferring...\n");
-				return -EPROBE_DEFER;
-			}
-			dev_err(dev, "failed to get ALSOUT ADC channel\n");
-			return PTR_ERR(gp2ap002->alsout);
+			ret = PTR_ERR(gp2ap002->alsout);
+			ret = (ret == -ENODEV) ? -EPROBE_DEFER : ret;
+			return dev_err_probe(dev, ret, "failed to get ALSOUT ADC channel\n");
 		}
 		ret = iio_get_channel_type(gp2ap002->alsout, &ch_type);
 		if (ret < 0)
@@ -521,15 +518,14 @@ static int gp2ap002_probe(struct i2c_client *client,
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

