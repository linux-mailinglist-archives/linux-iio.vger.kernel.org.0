Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214047BBAF
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhLUITM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 03:19:12 -0500
Received: from inva020.nxp.com ([92.121.34.13]:45024 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234213AbhLUITM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Dec 2021 03:19:12 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D7BD91A1965;
        Tue, 21 Dec 2021 09:19:10 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A0DBE1A1145;
        Tue, 21 Dec 2021 09:19:10 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 14D39183AD6D;
        Tue, 21 Dec 2021 16:19:09 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, cai.huoqing@linux.dev, robh+dt@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, haibo.chen@nxp.com,
        shawnguo@kernel.org, festevam@gmail.com
Subject: [PATCH 2/2] dt-bindings:iio:adc: update the maintainer of vf610-adc
Date:   Tue, 21 Dec 2021 15:50:00 +0800
Message-Id: <1640073000-32629-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640073000-32629-1-git-send-email-haibo.chen@nxp.com>
References: <1640073000-32629-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Drop Fugang Duan as the vf610-adc maintainer, and add my self as
the maintainer.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---

Fugang Duan already leave NXP, his mail address is dropped. And He can't
keep maintain this driver.

---
 Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
index 1ca571056ea9..925f355cc21f 100644
--- a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ADC found on Freescale vf610 and similar SoCs
 
 maintainers:
-  - Fugang Duan <fugang.duan@nxp.com>
+  - Haibo Chen <haibo.chen@nxp.com>
 
 description:
   ADCs found on vf610/i.MX6slx and upward SoCs from Freescale.
-- 
2.25.1

