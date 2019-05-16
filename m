Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4B20107
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfEPILj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 04:11:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37807 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbfEPIL0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 May 2019 04:11:26 -0400
X-UUID: f450220cab504dc2be8cd2eba0479dbf-20190516
X-UUID: f450220cab504dc2be8cd2eba0479dbf-20190516
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2012717291; Thu, 16 May 2019 16:11:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 16 May 2019 16:11:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 16 May 2019 16:11:13 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>, Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH 4/4] iio: auxadc: mediatek: change to subsys_initcall
Date:   Thu, 16 May 2019 16:10:47 +0800
Message-ID: <1557994247-16739-5-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

  Move auxadc platform_driver_register() from module_init
to subsys_initcall because auxadc user drivers
are all moudle drivers, need to gurantee
auxadc driver ready before module_init.

Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 58d7cb2..cb8e3dd 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -350,7 +350,19 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 	.probe	= mt6577_auxadc_probe,
 	.remove	= mt6577_auxadc_remove,
 };
-module_platform_driver(mt6577_auxadc_driver);
+
+static int __init mt6577_auxadc_init(void)
+{
+	return platform_driver_register(&mt6577_auxadc_driver);
+}
+
+static void __exit mt6577_auxadc_exit(void)
+{
+	platform_driver_unregister(&mt6577_auxadc_driver);
+}
+
+subsys_initcall(mt6577_auxadc_init);
+module_exit(mt6577_auxadc_exit);
 
 MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
 MODULE_DESCRIPTION("MTK AUXADC Device Driver");
-- 
1.9.1

