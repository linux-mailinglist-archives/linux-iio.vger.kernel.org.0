Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216146A4CDC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Feb 2023 22:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjB0VMs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Feb 2023 16:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB0VMr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2023 16:12:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E3921A1D
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2023 13:12:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWknQ-00050F-Vq; Mon, 27 Feb 2023 22:12:33 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWknQ-000hzb-8g; Mon, 27 Feb 2023 22:12:32 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWknP-000jX6-BB; Mon, 27 Feb 2023 22:12:31 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v5 3/5] dt-bindings: iio: ti,tmp117: add binding for the TMP116
Date:   Mon, 27 Feb 2023 22:12:28 +0100
Message-Id: <20230227211230.165073-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230227211230.165073-1-m.felsch@pengutronix.de>
References: <20230227211230.165073-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The TMP116 is the predecessor of the TMP117.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v5:
- no changes
v4:
- sort alphabetical (Krzysztof)
- added Krzysztof's ab
v3:
- don't use tmp117 as fallback, therefore I didn't add Krzysztof
  ab
v2:
- drop items from single enum

 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 8d1ec4d39b28c..75f13cbcd72be 100644
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
@@ -17,6 +18,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - ti,tmp116
       - ti,tmp117
 
   reg:
-- 
2.30.2

