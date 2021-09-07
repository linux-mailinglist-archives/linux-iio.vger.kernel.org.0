Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA88D402226
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 04:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhIGB6x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 21:58:53 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56948 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229835AbhIGB6v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Sep 2021 21:58:51 -0400
Received: from BC-Mail-Ex23.internal.baidu.com (unknown [172.31.51.17])
        by Forcepoint Email with ESMTPS id 2C1288AFED56B243199A;
        Tue,  7 Sep 2021 09:57:43 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex23.internal.baidu.com (172.31.51.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 7 Sep 2021 09:57:42 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 09:57:42 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] MAINTAINERS:  Add the driver info of the NXP IMX8QXP ADC
Date:   Tue, 7 Sep 2021 09:57:23 +0800
Message-ID: <20210907015724.1377-4-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907015724.1377-1-caihuoqing@baidu.com>
References: <20210907015724.1377-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex12.internal.baidu.com (172.31.51.52) To
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
index f800abca74b0..de98fcf75b01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13475,6 +13475,13 @@ S:	Maintained
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

