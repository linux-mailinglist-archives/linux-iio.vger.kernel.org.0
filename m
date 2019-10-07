Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA449CE384
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfJGN1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 09:27:12 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56275 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfJGN1J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 09:27:09 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 328931C001B;
        Mon,  7 Oct 2019 13:27:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 7/8] dt-bindings: Add 1027/1029/1031 SPI ADCs as trivial devices
Date:   Mon,  7 Oct 2019 15:26:56 +0200
Message-Id: <20191007132657.4190-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007132657.4190-1-miquel.raynal@bootlin.com>
References: <20191007132657.4190-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the same time, remove the dedicated bindings file which is now
useless.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/iio/adc/max1027-adc.txt          | 22 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  6 +++++
 2 files changed, 6 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1027-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
deleted file mode 100644
index 7b23d68f655c..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Maxim 1027/1029/1031 Analog to Digital Converter (ADC)
-
-Required properties:
-  - compatible: Should be "maxim,max1027" or "maxim,max1029" or "maxim,max1031"
-  - reg: SPI chip select number for the device
-
-Optional properties:
-  - interrupts: IRQ line for the ADC
-  see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Recommended properties:
-- spi-max-frequency: Definition as per
-                     Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-adc@0 {
-	compatible = "maxim,max1027";
-	reg = <0>;
-	interrupt-parent = <&gpio5>;
-	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
-	spi-max-frequency = <1000000>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 870ac52d2225..e0095ecb472f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -114,6 +114,12 @@ properties:
           - isil,isl68137
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
+            # 10-bit 8 channels 300ks/s SPI ADC with temperature sensor
+          - maxim,max1027
+            # 10-bit 12 channels 300ks/s SPI ADC with temperature sensor
+          - maxim,max1029
+            # 10-bit 16 channels 300ks/s SPI ADC with temperature sensor
+          - maxim,max1031
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
-- 
2.20.1

