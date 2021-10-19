Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57343333A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhJSKMJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 06:12:09 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:26194 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhJSKMJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 06:12:09 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 06:12:07 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea616e972d9bc-faf41; Tue, 19 Oct 2021 18:00:15 +0800 (CST)
X-RM-TRANSID: 2eea616e972d9bc-faf41
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3616e97244be-dc5f9;
        Tue, 19 Oct 2021 18:00:15 +0800 (CST)
X-RM-TRANSID: 2ee3616e97244be-dc5f9
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 1/3] iio: adc: rockchip_saradc: Use of_device_get_match_data to simplify code
Date:   Tue, 19 Oct 2021 18:00:11 +0800
Message-Id: <20211019100013.27312-2-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20211019100013.27312-1-tangbin@cmss.chinamobile.com>
References: <20211019100013.27312-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Retrieve OF match data, it's better and cleaner to use
'of_device_get_match_data' over 'of_match_device'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/iio/adc/rockchip_saradc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index f3eb8d2e5..e221e7aaa 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -304,7 +304,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct iio_dev *indio_dev = NULL;
 	struct resource	*mem;
-	const struct of_device_id *match;
 	int ret;
 	int irq;
 
@@ -318,14 +317,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	}
 	info = iio_priv(indio_dev);
 
-	match = of_match_device(rockchip_saradc_match, &pdev->dev);
-	if (!match) {
+	info->data = of_device_get_match_data(&pdev->dev);
+	if (!info->data) {
 		dev_err(&pdev->dev, "failed to match device\n");
 		return -ENODEV;
 	}
 
-	info->data = match->data;
-
 	/* Sanity check for possible later IP variants with more channels */
 	if (info->data->num_channels > SARADC_MAX_CHANNELS) {
 		dev_err(&pdev->dev, "max channels exceeded");
-- 
2.20.1.windows.1



