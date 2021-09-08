Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA8403859
	for <lists+linux-iio@lfdr.de>; Wed,  8 Sep 2021 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbhIHK56 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 06:57:58 -0400
Received: from mx20.baidu.com ([111.202.115.85]:40088 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348979AbhIHK5y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Sep 2021 06:57:54 -0400
Received: from BJHW-Mail-Ex05.internal.baidu.com (unknown [10.127.64.15])
        by Forcepoint Email with ESMTPS id 1F312325696CBF91C806;
        Wed,  8 Sep 2021 18:56:45 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:56:44 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 18:56:44 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: dac: stm32-dac:  Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 18:56:38 +0800
Message-ID: <20210908105638.1525-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex05_2021-09-08 18:56:45:120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/iio/dac/stm32-dac-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 906436780347..9a6a68b11b2a 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -90,7 +90,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	const struct stm32_dac_cfg *cfg;
 	struct stm32_dac_priv *priv;
 	struct regmap *regmap;
-	struct resource *res;
 	void __iomem *mmio;
 	struct reset_control *rst;
 	int ret;
@@ -106,8 +105,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	cfg = (const struct stm32_dac_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmio = devm_ioremap_resource(dev, res);
+	mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mmio))
 		return PTR_ERR(mmio);
 
-- 
2.25.1

