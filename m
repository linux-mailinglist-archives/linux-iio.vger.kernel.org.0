Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416C43D9F17
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 10:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhG2IDA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 04:03:00 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58844 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234683AbhG2ICy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 04:02:54 -0400
X-UUID: 6a40c968f07941fba8a03fcde679b9ae-20210729
X-UUID: 6a40c968f07941fba8a03fcde679b9ae-20210729
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1639818568; Thu, 29 Jul 2021 16:02:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Jul 2021 16:02:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Jul 2021 16:02:08 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1] iio: mtk-auxadc: add mutex_destroy
Date:   Thu, 29 Jul 2021 16:01:35 +0800
Message-ID: <20210729080135.17436-2-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210729080135.17436-1-hui.liu@mediatek.com>
References: <20210729080135.17436-1-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add mutex_destroy when probe fail and remove device.

Signed-off-by: Hui Liu <hui.liu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 79c1dd68b909..d57243037ad6 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -289,6 +289,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register iio device\n");
+		mutex_destroy(&adc_dev->lock);
 		goto err_power_off;
 	}
 
@@ -313,6 +314,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 			      0, MT6577_AUXADC_PDN_EN);
 
 	clk_disable_unprepare(adc_dev->adc_clk);
+	mutex_destroy(&adc_dev->lock);
 
 	return 0;
 }
-- 
2.18.0

