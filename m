Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD92C760D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgK1W3P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 17:29:15 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35815 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbgK1W3N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 17:29:13 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E1DF2C0003;
        Sat, 28 Nov 2020 22:28:30 +0000 (UTC)
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
Subject: [PATCH v3 03/10] dt-bindings:iio:adc:remove atmel,adc-res and atmel,adc-res-names
Date:   Sat, 28 Nov 2020 23:28:11 +0100
Message-Id: <20201128222818.1910764-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
References: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove atmel,adc-res and atmel,adc-res-names as they are not necessary and
are handled by the driver. Also add sama5d3 to the list of possible chips.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/iio/adc/at91_adc.txt        | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
index f65b04fb7962..da393ac5c05f 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
@@ -2,7 +2,7 @@
 
 Required properties:
   - compatible: Should be "atmel,<chip>-adc"
-    <chip> can be "at91sam9260", "at91sam9g45" or "at91sam9x5"
+    <chip> can be "at91sam9260", "at91sam9g45", "at91sam9x5" or "sama5d3"
   - reg: Should contain ADC registers location and length
   - interrupts: Should contain the IRQ line for the ADC
   - clock-names: tuple listing input clock names.
@@ -13,17 +13,12 @@ Required properties:
   - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
     defined in the datasheet
   - atmel,adc-vref: Reference voltage in millivolts for the conversions
-  - atmel,adc-res: List of resolutions in bits supported by the ADC. List size
-		   must be two at least.
-  - atmel,adc-res-names: Contains one identifier string for each resolution
-			 in atmel,adc-res property. "lowres" and "highres"
-			 identifiers are required.
 
 Optional properties:
   - atmel,adc-use-external-triggers: Boolean to enable the external triggers
-  - atmel,adc-use-res: String corresponding to an identifier from
-		       atmel,adc-res-names property. If not specified, the highest
-		       resolution will be used.
+  - atmel,adc-use-res: String selecting the resolution, can be "lowres" or
+		       "highres". If not specified, the highest resolution will
+		       be used.
   - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
   - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
   - atmel,adc-ts-wires: Number of touchscreen wires. Should be 4 or 5. If this
-- 
2.28.0

