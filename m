Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C09738A82
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jun 2023 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFUQJ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jun 2023 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjFUQJX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2023 12:09:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A75910A
        for <linux-iio@vger.kernel.org>; Wed, 21 Jun 2023 09:09:23 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1qC0OJ-0007At-3g; Wed, 21 Jun 2023 18:09:07 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alazar@startmail.com, daniel.baluta@nxp.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max value and meaning
Date:   Wed, 21 Jun 2023 18:08:57 +0200
Message-Id: <20230621160857.3400747-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
allowed for all devices but only for the ADS1115 devices a value of 7
does make a difference.

While on it fix the description of the datarate for ADS1115 devices as
well.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml   | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index 2127d639a7683..e004659099c19 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -78,9 +78,9 @@ patternProperties:
       ti,datarate:
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
-        maximum: 6
+        maximum: 7
         description: |
-          Data acquisition rate in samples per second
+          Data acquisition rate in samples per second for ADS1015, TLA2024
           0: 128
           1: 250
           2: 490
@@ -88,6 +88,17 @@ patternProperties:
           4: 1600 (default)
           5: 2400
           6: 3300
+          7: 3300
+
+          Data acquisition rate in samples per second for ADS1115
+          0: 8
+          1: 16
+          2: 32
+          3: 64
+          4: 128 (default)
+          5: 250
+          6: 475
+          7: 860
 
     required:
       - reg
-- 
2.39.2

