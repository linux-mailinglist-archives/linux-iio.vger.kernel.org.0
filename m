Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1B3DD548
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhHBMJm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 08:09:42 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:25708 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhHBMJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 08:09:42 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea6107e06c852-e82ce; Mon, 02 Aug 2021 20:09:19 +0800 (CST)
X-RM-TRANSID: 2eea6107e06c852-e82ce
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36107e06b2e6-80095;
        Mon, 02 Aug 2021 20:09:19 +0800 (CST)
X-RM-TRANSID: 2ee36107e06b2e6-80095
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH v2] iio: adc: fsl-imx25-gcq: fix the right check and simplify code
Date:   Mon,  2 Aug 2021 20:09:29 +0800
Message-Id: <20210802120929.33760-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For the function of platform_get_irq(), the example in platform.c is
 *	int irq = platform_get_irq(pdev, 0);
 *	if (irq < 0)
 *		return irq;
the return value of zero is unnecessary to check, so make the right
check and simplify code.

Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
 - change the code to the original place and make it simple.
 - change the commit message.
---
 drivers/iio/adc/fsl-imx25-gcq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 8cb51cf7a..2cdf45aa8 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -336,14 +336,11 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 		goto err_vref_disable;
 	}
 
-	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq <= 0) {
-		ret = priv->irq;
-		if (!ret)
-			ret = -ENXIO;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto err_clk_unprepare;
-	}
 
+	priv->irq = ret;
 	ret = request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
 	if (ret) {
 		dev_err(dev, "Failed requesting IRQ\n");
-- 
2.20.1.windows.1



