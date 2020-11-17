Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1A2B671E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgKQOIt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 09:08:49 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:9527 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgKQOIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 09:08:05 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 807F1240015;
        Tue, 17 Nov 2020 14:08:01 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 06/11] dt-bindings:iio:adc:remove triggers
Date:   Tue, 17 Nov 2020 15:06:51 +0100
Message-Id: <20201117140656.1235055-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The trigger child nodes are not necessary anymore as they are defined
directly by the driver, depending on the compatible string.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 46 -------------------
 1 file changed, 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
index 9b0ff59e75de..e6a1f915b542 100644
--- a/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
@@ -97,29 +97,6 @@ required:
   - atmel,adc-startup-time
   - atmel,adc-vref
 
-patternProperties:
-  "^(trigger)[0-9]$":
-    type: object
-    description: Child node to describe a trigger exposed to the user.
-    properties:
-      trigger-name:
-        $ref: /schemas/types.yaml#/definitions/string
-        description: Identifying name.
-
-      trigger-value:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Value to put in the Trigger register to activate this trigger
-
-      trigger-external:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description: This trigger is provided from an external pin.
-
-    additionalProperties: false
-    required:
-      - trigger-name
-      - trigger-value
-
 examples:
   - |
     #include <dt-bindings/dma/at91.h>
@@ -139,29 +116,6 @@ examples:
             atmel,adc-use-external-triggers;
             atmel,adc-vref = <3300>;
             atmel,adc-use-res = "lowres";
-
-            trigger0 {
-                trigger-name = "external-rising";
-                trigger-value = <0x1>;
-                trigger-external;
-            };
-
-            trigger1 {
-                trigger-name = "external-falling";
-                trigger-value = <0x2>;
-                trigger-external;
-            };
-
-            trigger2 {
-                trigger-name = "external-any";
-                trigger-value = <0x3>;
-                trigger-external;
-            };
-
-            trigger3 {
-                trigger-name = "continuous";
-                trigger-value = <0x6>;
-            };
         };
     };
 ...
-- 
2.28.0

