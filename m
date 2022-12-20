Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C365235E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiLTPCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 10:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiLTPCh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 10:02:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BBFB6E
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 07:02:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7e8P-000176-Sd; Tue, 20 Dec 2022 16:02:25 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7e8O-000arN-QG; Tue, 20 Dec 2022 16:02:24 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7e8O-007br3-3r; Tue, 20 Dec 2022 16:02:24 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/4] dt-bindings: iio: ti,tmp117: add binding for the TMP116
Date:   Tue, 20 Dec 2022 16:02:20 +0100
Message-Id: <20221220150222.1813729-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221220150222.1813729-1-m.felsch@pengutronix.de>
References: <20221220150222.1813729-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The TMP116 is the predecessor of the TMP117.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../bindings/iio/temperature/ti,tmp117.yaml       | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 8d1ec4d39b28..d56fbf11edaf 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -7,8 +7,9 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
 
 description: |
-    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
-    I2C interface.
+    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
+    supports I2C interface.
+      https://www.ti.com/lit/gpn/tmp116
       https://www.ti.com/lit/gpn/tmp117
 
 maintainers:
@@ -16,8 +17,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - ti,tmp117
+    oneOf:
+      - items:
+          - enum:
+              - ti,tmp117
+      - items:
+          - enum:
+              - ti,tmp116
+          - const: ti,tmp117
 
   reg:
     maxItems: 1
-- 
2.30.2

