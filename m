Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E393B5459
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhF0Qdf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231350AbhF0Qde (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8921F619AD;
        Sun, 27 Jun 2021 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811469;
        bh=58MyanpF+CguHFikUqTuPVvkHhFLPL6cRoRjkZwfOd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BtFTTEW5llOifaWFZNm4NgmVEXqpcXf2lfSNKsqdKhAxdZCdLXqO7vvawkGRUREiM
         QMJvnI+/PsYBuMa/bCpA+rZmFTIsTvU8tphI/sPGrTlP1IYXvRFUynsig09JBTSky3
         A1kGkjquMWKptFvN+CrPcFgzroZ6NDXuxA/kY8+d2gKJuMZi94njRKnHYzkV6owvyA
         3tc8bM35cPviBMuEAXtPn1MsgIS7ZbxwW9LLxkIQSh3baDQrl6MgKjFgWX7bIlzZIh
         FB03htJ4/vtmZd9K7jCh7Gcbr+XZD3SaaO6M3T/m+wQdWc92Cqftzvj61L7VFO/cBe
         Qiq7G4PXRjcRg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Welling <mwelling@ieee.org>
Subject: [PATCH 15/15] dt-bindings: iio: dac: microchip,mcp4922: Add missing binding document
Date:   Sun, 27 Jun 2021 17:32:44 +0100
Message-Id: <20210627163244.1090296-16-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding for this family of microchip DACs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Welling <mwelling@ieee.org>
---
 .../bindings/iio/dac/microchip,mcp4922.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
new file mode 100644
index 000000000000..12a14b3f36cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4922.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP4902, MCP4912 and MPC4922 dual output SPI DACs
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+  - Michael Welling <mwelling@ieee.org>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4902
+      - microchip,mcp4912
+      - microchip,mcp4922
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vref-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "microchip,mcp4912";
+            reg = <0>;
+            vref-supply = <&dac_vref>;
+        };
+    };
+...
-- 
2.32.0

