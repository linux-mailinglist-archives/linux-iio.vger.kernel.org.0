Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8929F2A19C6
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgJaSvc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSvc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CF42072C;
        Sat, 31 Oct 2020 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170291;
        bh=L/wwVjEw4yK3HrrDGnVbqNPnHVt+3J4zsBLbrQeLoAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2T4fdgxKWVVEeH2UN1eUM9k6+gBC3+VXRUiuufb3sPEKEHo+mQMiQkFX4jl7cysTl
         k+EWLnlaI98RNCbnXqHDhBoLT+QZKh5x8Mq69RaboVGxKxtoGNUUM0O+ETG2CZlelZ
         nahgLs6rU6GwU18JSfv8wPoBOFxCxpTtfe1DsiSA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 03/46] dt-bindings:iio:potentiometer:microchip,mcp4131 txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:11 +0000
Message-Id: <20201031184854.745828-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This binding is very simple, but I think the very large number of
compatible values make it unsuitable for moving to trivial-devices.yaml.
Main change in the conversion was reordering the compatible list to
numerical order.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Slawomir Stepien <sst@poczta.fm>
---
 .../bindings/iio/potentiometer/mcp4131.txt    |  84 ---------------
 .../iio/potentiometer/microchip,mcp4131.yaml  | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 84 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt
deleted file mode 100644
index 3ccba16f7035..000000000000
--- a/Documentation/devicetree/bindings/iio/potentiometer/mcp4131.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-* Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer
-  driver
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in
-
-        Documentation/devicetree/bindings/spi/spi-bus.txt
-
-must be specified.
-
-Required properties:
-	- compatible:  	Must be one of the following, depending on the
-			model:
-			"microchip,mcp4131-502"
-			"microchip,mcp4131-103"
-			"microchip,mcp4131-503"
-			"microchip,mcp4131-104"
-			"microchip,mcp4132-502"
-			"microchip,mcp4132-103"
-			"microchip,mcp4132-503"
-			"microchip,mcp4132-104"
-			"microchip,mcp4141-502"
-			"microchip,mcp4141-103"
-			"microchip,mcp4141-503"
-			"microchip,mcp4141-104"
-			"microchip,mcp4142-502"
-			"microchip,mcp4142-103"
-			"microchip,mcp4142-503"
-			"microchip,mcp4142-104"
-			"microchip,mcp4151-502"
-			"microchip,mcp4151-103"
-			"microchip,mcp4151-503"
-			"microchip,mcp4151-104"
-			"microchip,mcp4152-502"
-			"microchip,mcp4152-103"
-			"microchip,mcp4152-503"
-			"microchip,mcp4152-104"
-			"microchip,mcp4161-502"
-			"microchip,mcp4161-103"
-			"microchip,mcp4161-503"
-			"microchip,mcp4161-104"
-			"microchip,mcp4162-502"
-			"microchip,mcp4162-103"
-			"microchip,mcp4162-503"
-			"microchip,mcp4162-104"
-			"microchip,mcp4231-502"
-			"microchip,mcp4231-103"
-			"microchip,mcp4231-503"
-			"microchip,mcp4231-104"
-			"microchip,mcp4232-502"
-			"microchip,mcp4232-103"
-			"microchip,mcp4232-503"
-			"microchip,mcp4232-104"
-			"microchip,mcp4241-502"
-			"microchip,mcp4241-103"
-			"microchip,mcp4241-503"
-			"microchip,mcp4241-104"
-			"microchip,mcp4242-502"
-			"microchip,mcp4242-103"
-			"microchip,mcp4242-503"
-			"microchip,mcp4242-104"
-			"microchip,mcp4251-502"
-			"microchip,mcp4251-103"
-			"microchip,mcp4251-503"
-			"microchip,mcp4251-104"
-			"microchip,mcp4252-502"
-			"microchip,mcp4252-103"
-			"microchip,mcp4252-503"
-			"microchip,mcp4252-104"
-			"microchip,mcp4261-502"
-			"microchip,mcp4261-103"
-			"microchip,mcp4261-503"
-			"microchip,mcp4261-104"
-			"microchip,mcp4262-502"
-			"microchip,mcp4262-103"
-			"microchip,mcp4262-503"
-			"microchip,mcp4262-104"
-
-Example:
-mcp4131: mcp4131@0 {
-	compatible = "mcp4131-502";
-	reg = <0>;
-	spi-max-frequency = <500000>;
-};
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
new file mode 100644
index 000000000000..834d17ae3730
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/microchip,mcp4131.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer
+maintainers:
+  - Slawomir Stepien <sst@poczta.fm>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4131-103
+      - microchip,mcp4131-104
+      - microchip,mcp4131-502
+      - microchip,mcp4131-503
+      - microchip,mcp4132-103
+      - microchip,mcp4132-104
+      - microchip,mcp4132-502
+      - microchip,mcp4132-503
+      - microchip,mcp4141-103
+      - microchip,mcp4141-104
+      - microchip,mcp4141-502
+      - microchip,mcp4141-503
+      - microchip,mcp4142-103
+      - microchip,mcp4142-104
+      - microchip,mcp4142-502
+      - microchip,mcp4142-503
+      - microchip,mcp4151-103
+      - microchip,mcp4151-104
+      - microchip,mcp4151-502
+      - microchip,mcp4151-503
+      - microchip,mcp4152-103
+      - microchip,mcp4152-104
+      - microchip,mcp4152-502
+      - microchip,mcp4152-503
+      - microchip,mcp4161-103
+      - microchip,mcp4161-104
+      - microchip,mcp4161-502
+      - microchip,mcp4161-503
+      - microchip,mcp4162-103
+      - microchip,mcp4162-104
+      - microchip,mcp4162-502
+      - microchip,mcp4162-503
+      - microchip,mcp4231-103
+      - microchip,mcp4231-104
+      - microchip,mcp4231-502
+      - microchip,mcp4231-503
+      - microchip,mcp4232-103
+      - microchip,mcp4232-104
+      - microchip,mcp4232-502
+      - microchip,mcp4232-503
+      - microchip,mcp4241-103
+      - microchip,mcp4241-104
+      - microchip,mcp4241-502
+      - microchip,mcp4241-503
+      - microchip,mcp4242-103
+      - microchip,mcp4242-104
+      - microchip,mcp4242-502
+      - microchip,mcp4242-503
+      - microchip,mcp4251-103
+      - microchip,mcp4251-104
+      - microchip,mcp4251-502
+      - microchip,mcp4251-503
+      - microchip,mcp4252-103
+      - microchip,mcp4252-104
+      - microchip,mcp4252-502
+      - microchip,mcp4252-503
+      - microchip,mcp4261-103
+      - microchip,mcp4261-104
+      - microchip,mcp4261-502
+      - microchip,mcp4261-503
+      - microchip,mcp4262-103
+      - microchip,mcp4262-104
+      - microchip,mcp4262-502
+      - microchip,mcp4262-503
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        potentiometer@0 {
+            compatible = "mcp4131-502";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+        };
+    };
+...
-- 
2.28.0

