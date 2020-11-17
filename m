Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD5A2B6701
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgKQOIB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 09:08:01 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:39699 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbgKQOH7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 09:07:59 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4E2B120000C;
        Tue, 17 Nov 2020 14:07:54 +0000 (UTC)
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
Subject: [PATCH v2 03/11] dt-bindings:iio:adc:remove atmel,adc-res and atmel,adc-res-names
Date:   Tue, 17 Nov 2020 15:06:48 +0100
Message-Id: <20201117140656.1235055-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
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

