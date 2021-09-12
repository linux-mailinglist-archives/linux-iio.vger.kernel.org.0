Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAA407C1E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Sep 2021 09:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhILHPI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Sep 2021 03:15:08 -0400
Received: from mx21.baidu.com ([220.181.3.85]:51088 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229783AbhILHPH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Sep 2021 03:15:07 -0400
Received: from BC-Mail-Ex29.internal.baidu.com (unknown [172.31.51.23])
        by Forcepoint Email with ESMTPS id BA1FF5F56688E55BC8B1;
        Sun, 12 Sep 2021 15:13:51 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex29.internal.baidu.com (172.31.51.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 12 Sep 2021 15:13:50 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.12) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 12 Sep 2021 15:13:50 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <aardelean@deviqon.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH v4 3/3] MAINTAINERS: Add the driver info of the NXP IMX8QXP ADC
Date:   Sun, 12 Sep 2021 15:13:34 +0800
Message-ID: <20210912071334.1745-4-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
In-Reply-To: <20210912071334.1745-1-caihuoqing@baidu.com>
References: <20210912071334.1745-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.12]
X-ClientProxiedBy: BC-Mail-Ex29.internal.baidu.com (172.31.51.23) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC has a new ADC IP. After adding
the driver support for it, I add the driver info of the
NXP IMX8QXP ADC to MAINTAINERS file.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a61cb2d0cd4..2115db14f5d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13476,6 +13476,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
 F:	drivers/gpu/drm/imx/dcss/
 
+NXP i.MX 8QXP ADC DRIVER
+M:	Cai Huoqing <caihuoqing@baidu.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
+F:	drivers/iio/adc/imx8qxp-adc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.25.1

