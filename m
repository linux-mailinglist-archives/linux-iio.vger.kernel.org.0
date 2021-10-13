Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA43E42B25F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhJMBta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 21:49:30 -0400
Received: from mx24.baidu.com ([111.206.215.185]:33562 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234119AbhJMBta (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Oct 2021 21:49:30 -0400
Received: from BC-Mail-EX04.internal.baidu.com (unknown [172.31.51.44])
        by Forcepoint Email with ESMTPS id 7B05BA3DD4FE3D051073;
        Wed, 13 Oct 2021 09:47:21 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX04.internal.baidu.com (172.31.51.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 13 Oct 2021 09:47:21 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 13 Oct 2021 09:47:20 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <rdunlap@infradead.org>, <jic23@kernel.org>, <lars@metafoo.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>
CC:     <linux-imx@nxp.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH] iio: imx8qxp-adc: Fix the error - defined but not used for runtime pm API
Date:   Wed, 13 Oct 2021 09:46:58 +0800
Message-ID: <20211013014658.2798-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the prefix '__maybe_unused' to imx8qxp_adc_runtime_suspend/resume()
to avoid the compiler complain without setting CONFIG_SUSPEND,
CONFIG_HIBERNATION and CONFIG_PM.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/iio/adc/imx8qxp-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index 5030e0d8318d..011bef4b5dda 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -416,7 +416,7 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx8qxp_adc_runtime_suspend(struct device *dev)
+static int __maybe_unused imx8qxp_adc_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
@@ -430,7 +430,7 @@ static int imx8qxp_adc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx8qxp_adc_runtime_resume(struct device *dev)
+static int __maybe_unused imx8qxp_adc_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
-- 
2.25.1

