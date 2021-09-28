Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598BC41A4DF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 03:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhI1Bmt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 21:42:49 -0400
Received: from mx24.baidu.com ([111.206.215.185]:49524 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238437AbhI1Bms (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 21:42:48 -0400
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id 78A349228FC2B4B57F4C;
        Tue, 28 Sep 2021 09:41:08 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 28 Sep 2021 09:41:07 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:41:07 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: st_lsm9ds0: Make use of the helper function dev_err_probe()
Date:   Tue, 28 Sep 2021 09:40:54 +0800
Message-ID: <20210928014055.1431-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928014055.1431-1-caihuoqing@baidu.com>
References: <20210928014055.1431-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex24.internal.baidu.com (172.31.51.18) To
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
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index b3a43a3b04ff..9fb06b7cde3c 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -24,10 +24,10 @@ static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds
 
 	/* Regulators not mandatory, but if requested we should enable them. */
 	lsm9ds0->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(lsm9ds0->vdd)) {
-		dev_err(dev, "unable to get Vdd supply\n");
-		return PTR_ERR(lsm9ds0->vdd);
-	}
+	if (IS_ERR(lsm9ds0->vdd))
+		return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd),
+				     "unable to get Vdd supply\n");
+
 	ret = regulator_enable(lsm9ds0->vdd);
 	if (ret) {
 		dev_warn(dev, "Failed to enable specified Vdd supply\n");
@@ -36,9 +36,9 @@ static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds
 
 	lsm9ds0->vdd_io = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(lsm9ds0->vdd_io)) {
-		dev_err(dev, "unable to get Vdd_IO supply\n");
 		regulator_disable(lsm9ds0->vdd);
-		return PTR_ERR(lsm9ds0->vdd_io);
+		return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd_io),
+				     "unable to get Vdd_IO supply\n");
 	}
 	ret = regulator_enable(lsm9ds0->vdd_io);
 	if (ret) {
-- 
2.25.1

