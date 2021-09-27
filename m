Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9C419104
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhI0In1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 04:43:27 -0400
Received: from mx24.baidu.com ([111.206.215.185]:50188 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233337AbhI0InZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 04:43:25 -0400
Received: from BC-Mail-Ex17.internal.baidu.com (unknown [172.31.51.11])
        by Forcepoint Email with ESMTPS id 2C40482073217AA26C03;
        Mon, 27 Sep 2021 16:41:46 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex17.internal.baidu.com (172.31.51.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:41:46 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 27 Sep 2021 16:41:45 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: st_sensors: Make use of the helper function dev_err_probe()
Date:   Mon, 27 Sep 2021 16:41:35 +0800
Message-ID: <20210927084137.1081-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX08.internal.baidu.com (172.31.51.48) To
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
 .../iio/common/st_sensors/st_sensors_core.c    | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index a5a140de9a23..732d0f8f99f6 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -228,10 +228,11 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 
 	/* Regulators not mandatory, but if requested we should enable them. */
 	pdata->vdd = devm_regulator_get(parent, "vdd");
-	if (IS_ERR(pdata->vdd)) {
-		dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
-		return PTR_ERR(pdata->vdd);
-	}
+	if (IS_ERR(pdata->vdd))
+		return dev_err_probe(&indio_dev->dev,
+				     PTR_ERR(pdata->vdd),
+				     "unable to get Vdd supply\n");
+
 	err = regulator_enable(pdata->vdd);
 	if (err != 0) {
 		dev_warn(&indio_dev->dev,
@@ -244,10 +245,11 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 		return err;
 
 	pdata->vdd_io = devm_regulator_get(parent, "vddio");
-	if (IS_ERR(pdata->vdd_io)) {
-		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
-		return PTR_ERR(pdata->vdd_io);
-	}
+	if (IS_ERR(pdata->vdd_io))
+		return dev_err_probe(&indio_dev->dev,
+				     PTR_ERR(pdata->vdd_io),
+				     "unable to get Vdd_IO supply\n");
+
 	err = regulator_enable(pdata->vdd_io);
 	if (err != 0) {
 		dev_warn(&indio_dev->dev,
-- 
2.25.1

