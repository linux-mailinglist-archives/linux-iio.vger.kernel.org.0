Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94D33CFA22
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGTM2N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 08:28:13 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:59136 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhGTM2M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 08:28:12 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2021 08:28:11 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee360f6c88da67-3df30; Tue, 20 Jul 2021 20:58:56 +0800 (CST)
X-RM-TRANSID: 2ee360f6c88da67-3df30
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.134])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee960f6c88d6d7-9b48d;
        Tue, 20 Jul 2021 20:58:56 +0800 (CST)
X-RM-TRANSID: 2ee960f6c88d6d7-9b48d
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] iio: adc: fsl-imx25-gcq: Use the defined variable to clean code
Date:   Tue, 20 Jul 2021 20:59:45 +0800
Message-Id: <20210720125945.11548-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the defined variable "dev" to make the code cleaner.

Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index d28976f21..01fe5b137 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -192,11 +192,11 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 	 */
 	priv->vref[MX25_ADC_REFP_INT] = NULL;
 	priv->vref[MX25_ADC_REFP_EXT] =
-		devm_regulator_get_optional(&pdev->dev, "vref-ext");
+		devm_regulator_get_optional(dev, "vref-ext");
 	priv->vref[MX25_ADC_REFP_XP] =
-		devm_regulator_get_optional(&pdev->dev, "vref-xp");
+		devm_regulator_get_optional(dev, "vref-xp");
 	priv->vref[MX25_ADC_REFP_YP] =
-		devm_regulator_get_optional(&pdev->dev, "vref-yp");
+		devm_regulator_get_optional(dev, "vref-yp");
 
 	for_each_child_of_node(np, child) {
 		u32 reg;
@@ -298,7 +298,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
-- 
2.20.1.windows.1



