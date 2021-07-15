Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667783C9BF6
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 11:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhGOJiZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 05:38:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53654 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231655AbhGOJiY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 05:38:24 -0400
X-UUID: ca5835588ac04b1aa19441c5c14331f9-20210715
X-UUID: ca5835588ac04b1aa19441c5c14331f9-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 490753211; Thu, 15 Jul 2021 17:35:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:35:27 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:35:26 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] iio: mtk-auxadc: add mutex_destroy
Date:   Thu, 15 Jul 2021 17:35:23 +0800
Message-ID: <20210715093523.29844-2-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210715093523.29844-1-hui.liu@mediatek.com>
References: <20210715093523.29844-1-hui.liu@mediatek.com>
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

