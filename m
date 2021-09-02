Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253643FF5F9
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347663AbhIBVxC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:02 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43689 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347600AbhIBVw7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:52:59 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DFC8F240006;
        Thu,  2 Sep 2021 21:51:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 05/46] dt-bindings: touchscreen: ti,am3359-tsc: Remove deprecated text file
Date:   Thu,  2 Sep 2021 23:51:03 +0200
Message-Id: <20210902215144.507243-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that the three hardware peaces described in this file have been
translated in yaml in 3 dedicated files (MFD, touchscreen controller and
ADC) it is time to remove this text file.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/touchscreen/ti-tsc-adc.txt | 91 -------------------
 1 file changed, 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
deleted file mode 100644
index aad5e34965eb..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-* TI - TSC ADC (Touschscreen and analog digital converter)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Required properties:
-- mfd
-	compatible: Should be
-		"ti,am3359-tscadc" for AM335x/AM437x SoCs
-		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
-- child "tsc"
-	compatible: Should be "ti,am3359-tsc".
-	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
-		  support on the platform.
-	ti,x-plate-resistance: X plate resistance
-	ti,coordinate-readouts: The sequencer supports a total of 16
-				programmable steps each step is used to
-				read a single coordinate. A single
-                                readout is enough but multiple reads can
-				increase the quality.
-				A value of 5 means, 5 reads for X, 5 for
-				Y and 2 for Z (always). This utilises 12
-				of the 16 software steps available. The
-				remaining 4 can be used by the ADC.
-	ti,wire-config: Different boards could have a different order for
-			connecting wires on touchscreen. We need to provide an
-			8 bit number where in the 1st four bits represent the
-			analog lines and the next 4 bits represent positive/
-			negative terminal on that input line. Notations to
-			represent the input lines and terminals resoectively
-			is as follows:
-			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
-			XP  = 0, XN = 1, YP = 2, YN = 3.
-- child "adc"
-	compatible: Should be
-		    "ti,am3359-adc" for AM335x/AM437x SoCs
-		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
-	ti,adc-channels: List of analog inputs available for ADC.
-			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
-
-Optional properties:
-- child "tsc"
-	ti,charge-delay: Length of touch screen charge delay step in terms of
-			 ADC clock cycles. Charge delay value should be large
-			 in order to avoid false pen-up events. This value
-			 effects the overall sampling speed, hence need to be
-			 kept as low as possible, while avoiding false pen-up
-			 event. Start from a lower value, say 0x400, and
-			 increase value until false pen-up events are avoided.
-			 The pen-up detection happens immediately after the
-			 charge step, so this does in fact function as a
-			 hardware knob for adjusting the amount of "settling
-			 time".
-
-- child "adc"
-	ti,chan-step-opendelay: List of open delays for each channel of
-				ADC in the order of ti,adc-channels. The
-				value corresponds to the number of ADC
-				clock cycles to wait after applying the
-				step configuration registers and before
-				sending the start of ADC conversion.
-				Maximum value is 0x3FFFF.
-       ti,chan-step-sampledelay: List of sample delays for each channel
-				  of ADC in the order of ti,adc-channels.
-				  The value corresponds to the number of
-				  ADC clock cycles to sample (to hold
-				  start of conversion high).
-				  Maximum value is 0xFF.
-       ti,chan-step-avg: Number of averages to be performed for each
-			  channel of ADC. If average is 16 then input
-			  is sampled 16 times and averaged to get more
-			  accurate value. This increases the time taken
-			  by ADC to generate a sample. Valid range is 0
-			  average to 16 averages. Maximum value is 16.
-
-Example:
-	tscadc: tscadc@44e0d000 {
-		compatible = "ti,am3359-tscadc";
-		tsc {
-			ti,wires = <4>;
-			ti,x-plate-resistance = <200>;
-			ti,coordiante-readouts = <5>;
-			ti,wire-config = <0x00 0x11 0x22 0x33>;
-			ti,charge-delay = <0x400>;
-		};
-
-		adc {
-			ti,adc-channels = <4 5 6 7>;
-			ti,chan-step-opendelay = <0x098 0x3ffff 0x098 0x0>;
-			ti,chan-step-sampledelay = <0xff 0x0 0xf 0x0>;
-			ti,chan-step-avg = <16 2 4 8>;
-		};
-	}
-- 
2.27.0

