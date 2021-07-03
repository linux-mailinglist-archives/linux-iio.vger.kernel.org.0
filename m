Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4C3BA7D5
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhGCIpQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhGCIpQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 04:45:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0EEC061762;
        Sat,  3 Jul 2021 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xLwbIydJ/1+GsatuQCc4utjxtl8RBJMHU2IpjZQ0Cis=; b=CHAl8F+nQos1V0SL7OXB2F4aEJ
        BAIJ205KxTwOYyuaLFK9sN3r8YZ5kx/LW6xKSu/0s/oI9tcLWO1iLeJyzM/9RWdPWfE9p79VShTtY
        +y9Z9N/LW3V4GrVU5xRjS6YaHvgdKHkTRLxJa4jRDkl1RI6yW3QHwmZde04kf7PfnY9s=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbEU-0006Nh-At; Sat, 03 Jul 2021 10:42:38 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbET-0008HB-QE; Sat, 03 Jul 2021 10:42:37 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        lars@metafoo.de, sre@kernel.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        leonard.crestez@nxp.com, letux-kernel@openphoenux.org
Subject: [PATCH 1/4] dt-bindings: mfd: ricoh,rn5t618: ADC related nodes and properties
Date:   Sat,  3 Jul 2021 10:42:21 +0200
Message-Id: <20210703084224.31623-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210703084224.31623-1-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add ADC related nodes and properties. This will allow to wire
up ADC channels to consumers, especially to measure input voltages
by the power subdevice.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/mfd/ricoh,rn5t618.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
index 032a7fb0b4a7..185f87a14a54 100644
--- a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
+++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
@@ -73,6 +73,48 @@ properties:
     description: |
       See Documentation/devicetree/bindings/power/power-controller.txt
 
+  adc:
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - ricoh,rn5t618-adc
+          - ricoh,rc5t619-adc
+
+      "#io-channel-cells":
+        const: 1
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - "#io-channel-cells"
+
+  power:
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - ricoh,rn5t618-power
+          - ricoh,rc5t619-power
+
+      io-channels:
+        items:
+          - description: ADP Voltage Channel
+          - description: USB Voltage Channel
+
+      io-channel-names:
+        items:
+          - const: vadp
+          - const: vusb
+
+    additionalProperties: false
+
+    required:
+      - compatible
+
   regulators:
     type: object
 
@@ -96,6 +138,17 @@ examples:
         interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
         system-power-controller;
 
+        rn5t618_adc: adc {
+          compatible = "ricoh,rn5t618-adc";
+          #io-channel-cells = <1>;
+        };
+
+        power {
+          compatible = "ricoh,rn5t618-power";
+          io-channels = <&rn5t618_adc 2>, <&rn5t618_adc 3>;
+          io-channel-names = "vadp", "vusb";
+        };
+
         regulators {
           DCDC1 {
             regulator-min-microvolt = <1050000>;
-- 
2.30.2

