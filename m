Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F533B543B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhF0Qc7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhF0Qc6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:32:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C663619EE;
        Sun, 27 Jun 2021 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811434;
        bh=hBOyjKv+0wVWVYHNsRiFNDZRxA1uNPRZ6ksWzHUapDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFITp9rcZywJFDDSlHRCUT09TQelQxNKYPqnLVsCBzHYlgFJRwdpybTH0/t3a9muB
         99Ue1Tzw/V8tStO23WL6JS/12p1PTPf4gbQUpFseMNGRIfe0zYPOapWQo8aIvsYLEB
         l+4RoG1hqOwQLKLl0okfQCYJFiEAre8Bv6KU5ShtUMLzC9HT8f/J77rKZwcGNM5+mM
         zklwzyiUJH0vWdhXVVPFBPFbFMghIeVgCrn+pD+HLY8F6bNu69JNHMdGW7M4li5o7H
         KZLtXDpieMdP4qmpMDQb0pBE4fYLyFmt9B1fnuFMnHw1bDfp0RutdbaJotSTsD/u4G
         MzRBIuPOI2buA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/15] dt-bindings: iio: dac: adi,ad5421: Add missing binding document.
Date:   Sun, 27 Jun 2021 17:32:30 +0100
Message-Id: <20210627163244.1090296-2-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is documented what is currently the case.  There are a number
of things that could be added, but I don't feel the binding elements
are obvious enough to document without a driver implementation to
verify they are good choices.

These include
* Range
* Regulators, both input and potentially output (if the loop being
  driven is ever described).

I've listed Lars and myself as maintainers of the binding, but if
anyone else wants to be added they would be most welcome!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/dac/adi,ad5421.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
new file mode 100644
index 000000000000..188f656617e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5421.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5421 DAC
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  AD5421 is designed for us in loop-powered, 4 mA to 20 mA smart transmitter
+  applications. It provides a 16-bit DAC, current amplifier, voltage regulator
+  to drive the loop and a voltage reference.
+
+properties:
+  compatible:
+    const: adi,ad5421
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Fault signal.
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5421";
+            reg = <0>;
+            spi-max-frequency = <30000000>;
+            interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.32.0

