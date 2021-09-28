Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2098F41A502
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhI1B7K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 21:59:10 -0400
Received: from mx24.baidu.com ([111.206.215.185]:36228 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238453AbhI1B7J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 21:59:09 -0400
Received: from BC-Mail-Ex32.internal.baidu.com (unknown [172.31.51.26])
        by Forcepoint Email with ESMTPS id DF474B54FA64E38ABC96;
        Tue, 28 Sep 2021 09:41:04 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex32.internal.baidu.com (172.31.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 28 Sep 2021 09:41:04 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:41:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] iio: st_sensors: Make use of the helper function dev_err_probe()
Date:   Tue, 28 Sep 2021 09:40:53 +0800
Message-ID: <20210928014055.1431-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
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
v1->v2: Remove the separate line of PTR_ERR().

 .../iio/common/st_sensors/st_sensors_core.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index a5a140de9a23..732d0f8f99f6 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -228,10 +228,10 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 
 	/* Regulators not mandatory, but if requested we should enable them. */
 	pdata->vdd = devm_regulator_get(parent, "vdd");
-	if (IS_ERR(pdata->vdd)) {
-		dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
-		return PTR_ERR(pdata->vdd);
-	}
+	if (IS_ERR(pdata->vdd))
+		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd),
+				     "unable to get Vdd supply\n");
+
 	err = regulator_enable(pdata->vdd);
 	if (err != 0) {
 		dev_warn(&indio_dev->dev,
@@ -243,10 +245,10 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 		return err;
 
 	pdata->vdd_io = devm_regulator_get(parent, "vddio");
-	if (IS_ERR(pdata->vdd_io)) {
-		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
-		return PTR_ERR(pdata->vdd_io);
-	}
+	if (IS_ERR(pdata->vdd_io))
+		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd_io),
+				     "unable to get Vdd_IO supply\n");
+
 	err = regulator_enable(pdata->vdd_io);
 	if (err != 0) {
 		dev_warn(&indio_dev->dev,
-- 
2.25.1

