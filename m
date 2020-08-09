Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0023FDCD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgHILUC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHILUC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:02 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95F920716;
        Sun,  9 Aug 2020 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972001;
        bh=YzI06x2VtwyLUH1SPEtarEcOok5X9Xg6xMPI3fOMg1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3PDVTw+IyIiacQJjOgMAktxiJNuniHdmMrvqgAF6tawyP5D3Ddsgafi9A4WbavO+
         McbWrEFHk+ZymTTMrFVGFEROaFt8lOAr2kD6+/ePh/VYEG6+DkBbOHogQ1zFAYq4Ag
         Fu6jo95lf1PKIjOSwVEz6AWmKaJNDal9TFhKkrr8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 02/13] dt-bindings: trivial-devices: Add mcp342x ADCs and drop separate binding doc.
Date:   Sun,  9 Aug 2020 12:17:42 +0100
Message-Id: <20200809111753.156236-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809111753.156236-1-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These i2c devices have simple bindings, well described by trivial-device.yaml
so rather than convert the binding doc to yaml, let us just add them to
trivial devices and drop the old binding document.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 .../devicetree/bindings/iio/adc/mcp3422.txt   | 19 -------------------
 .../devicetree/bindings/trivial-devices.yaml  | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
deleted file mode 100644
index 82bcce07255d..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Microchip mcp3421/2/3/4/6/7/8 chip family (ADC)
-
-Required properties:
- - compatible: Should be
-	"microchip,mcp3421" or
-	"microchip,mcp3422" or
-	"microchip,mcp3423" or
-	"microchip,mcp3424" or
-	"microchip,mcp3425" or
-	"microchip,mcp3426" or
-	"microchip,mcp3427" or
-	"microchip,mcp3428"
- - reg: I2C address for the device
-
-Example:
-adc@0 {
-	compatible = "microchip,mcp3424";
-	reg = <0x68>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 4165352a590a..837592ec62aa 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -130,6 +130,22 @@ properties:
           - mcube,mc3230
             # MEMSIC 2-axis 8-bit digital accelerometer
           - memsic,mxc6225
+            # Microchip differential I2C ADC, 1 Channel, 18 bit
+          - microchip,mcp3421
+            # Microchip differential I2C ADC, 2 Channel, 18 bit
+          - microchip,mcp3422
+            # Microchip differential I2C ADC, 2 Channel, 18 bit
+          - microchip,mcp3423
+            # Microchip differential I2C ADC, 4 Channel, 18 bit
+          - microchip,mcp3424
+            # Microchip differential I2C ADC, 1 Channel, 16 bit
+          - microchip,mcp3425
+            # Microchip differential I2C ADC, 2 Channel, 16 bit
+          - microchip,mcp3426
+            # Microchip differential I2C ADC, 2 Channel, 16 bit
+          - microchip,mcp3427
+            # Microchip differential I2C ADC, 4 Channel, 16 bit
+          - microchip,mcp3428
             # Microchip 7-bit Single I2C Digital POT (5k)
           - microchip,mcp4017-502
             # Microchip 7-bit Single I2C Digital POT (10k)
-- 
2.28.0

