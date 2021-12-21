Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7369447BBAC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhLUITL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 03:19:11 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60136 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhLUITL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Dec 2021 03:19:11 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0A072019C2;
        Tue, 21 Dec 2021 09:19:09 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 866A72012FB;
        Tue, 21 Dec 2021 09:19:09 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 17AE7183ACDD;
        Tue, 21 Dec 2021 16:19:08 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, cai.huoqing@linux.dev, robh+dt@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, haibo.chen@nxp.com,
        shawnguo@kernel.org, festevam@gmail.com
Subject: [PATCH 1/2] MAINTAINERS: add imx7d/imx6sx/imx6ul/imx8qxp and vf610 adc maintainer
Date:   Tue, 21 Dec 2021 15:49:59 +0800
Message-Id: <1640073000-32629-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add myself as imx7d/imx6sx/imx6ul/imx8qxp and vf610 adc maintainer.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

---

First, thanks Cai Huoqing upstream the i.MX 8QXP ADC driver, really appreciate!

For some unknown issue, I miss all imx8qxp adc related mail threads,
now I actively maintain all i.MX ADC downstream drivers, so add myself
here as maintainer, and make sure I can be cc/to when there is any new patch.

---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c87a3f5e302a..210bded08641 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13792,11 +13792,23 @@ F:	drivers/gpu/drm/imx/dcss/
 
 NXP i.MX 8QXP ADC DRIVER
 M:	Cai Huoqing <cai.huoqing@linux.dev>
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-imx@nxp.com
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 F:	drivers/iio/adc/imx8qxp-adc.c
 
+NXP i.MX 7D/6SX/6UL AND VF610 ADC DRIVER
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-imx@nxp.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
+F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
+F:	drivers/iio/adc/imx7d_adc.c
+F:	drivers/iio/adc/vf610_adc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.25.1

