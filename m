Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23F4266C4
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhJHJ27 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 05:28:59 -0400
Received: from mx22.baidu.com ([220.181.50.185]:34950 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238210AbhJHJ26 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 05:28:58 -0400
Received: from BJHW-Mail-Ex03.internal.baidu.com (unknown [10.127.64.13])
        by Forcepoint Email with ESMTPS id 3785ADB641E8B382955F;
        Fri,  8 Oct 2021 17:26:57 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:26:57 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:26:56 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] iio: light: cm3605: Make use of the helper function dev_err_probe()
Date:   Fri, 8 Oct 2021 17:26:52 +0800
Message-ID: <20211008092656.421-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
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
v2->v3:
	*Handle platform_get_irq() that returns -EPROBE_DEFER.
	*Handle the lack of availability of an IIO channel
	 by converting an -ENODEV to an -EPROBE_DEFER.

 drivers/iio/light/cm3605.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 4c83953672be..3e7fb16ab1f6 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -159,6 +159,7 @@ static int cm3605_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	enum iio_chan_type ch_type;
 	u32 rset;
+	int irq;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*cm3605));
@@ -195,12 +196,9 @@ static int cm3605_probe(struct platform_device *pdev)
 
 	cm3605->aout = devm_iio_channel_get(dev, "aout");
 	if (IS_ERR(cm3605->aout)) {
-		if (PTR_ERR(cm3605->aout) == -ENODEV) {
-			dev_err(dev, "no ADC, deferring...\n");
-			return -EPROBE_DEFER;
-		}
-		dev_err(dev, "failed to get AOUT ADC channel\n");
-		return PTR_ERR(cm3605->aout);
+		ret = PTR_ERR(cm3605->aout);
+		ret = (ret == -ENODEV) ? -EPROBE_DEFER : ret;
+		return dev_err_probe(dev, ret, "failed to get AOUT ADC channel\n");
 	}
 	ret = iio_get_channel_type(cm3605->aout, &ch_type);
 	if (ret < 0)
@@ -211,10 +209,10 @@ static int cm3605_probe(struct platform_device *pdev)
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
@@ -223,13 +221,16 @@ static int cm3605_probe(struct platform_device *pdev)
 
 	cm3605->aset = devm_gpiod_get(dev, "aset", GPIOD_OUT_HIGH);
 	if (IS_ERR(cm3605->aset)) {
-		dev_err(dev, "no ASET GPIO\n");
-		ret = PTR_ERR(cm3605->aset);
+		ret = dev_err_probe(dev, PTR_ERR(cm3605->aset), "no ASET GPIO\n");
 		goto out_disable_vdd;
 	}
 
-	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
-			cm3605_prox_irq, NULL, 0, "cm3605", indio_dev);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "failed to get irq\n");
+
+	ret = devm_request_threaded_irq(dev, irq, cm3605_prox_irq,
+					NULL, 0, "cm3605", indio_dev);
 	if (ret) {
 		dev_err(dev, "unable to request IRQ\n");
 		goto out_disable_aset;
-- 
2.25.1

