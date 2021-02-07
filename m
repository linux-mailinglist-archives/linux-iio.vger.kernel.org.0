Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC4312595
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBGPub (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBGPu0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8A2A64E64;
        Sun,  7 Feb 2021 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712955;
        bh=BNvWERF7kZIB0Y4RCSxZOcMeDmUk3d5+ItEOYMBWmnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/7FzrvrgHwobvr6KC+eQtFYdns4a4VNMsE67SK304yOWKPOmLwnZTBFPLdV86Wbk
         GlDXQQn4n4Ul9+Hdj4QBfBuF1Yz+9ufUIMU/4wtX4/9agW6DdmUgnzg422CvyIbq6Q
         9RDiE9SnyHEeHMdhc7Tt4b0VmvhfQylLpu65SjuqSoNAjeUTY0mNXycRnq6t4gwjdu
         oJQQERc5h3WfpR8WXrv4lVQMBgXYJPSTC6/8MOA8Tp3kkNLFHhlWIx4uPWObCouJns
         bBVLGgpp8dPXPSFLzYmZ5rSoZS9Qa0T9ZD6MxkiJCALRTMhijWv5X+DLslwSzqZUqp
         XlWL9ssYUR3xw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Date:   Sun,  7 Feb 2021 15:46:20 +0000
Message-Id: <20210207154623.433442-22-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Binding covering the ad7150, ad7151 and ad7156 capacitance to digital
convertors.  The only difference between these is how many channels they
have (1 or 2)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Robh+dt@kernel.org
Cc: devicetree@vger.kernel.org
---
 .../bindings/iio/cdc/adi,ad7150.yaml          | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
new file mode 100644
index 000000000000..2155d3f5666c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/cdc/adi,ad7150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog device AD7150 and similar capacitance to digital convertors.
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7150
+      - adi,ad7151
+      - adi,ad7156
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7150
+              - adi,ad7156
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7151
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cdc@48 {
+            compatible = "adi,ad7150";
+            reg = <0x48>;
+            interrupts = <25 2>, <26 2>;
+            interrupt-parent = <&gpio>;
+        };
+    };
+...
-- 
2.30.0

