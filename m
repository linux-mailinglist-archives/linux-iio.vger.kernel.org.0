Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD553FC40A
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbhHaIAy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 04:00:54 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:46076 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbhHaIAx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 04:00:53 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 8F03B44A024F;
        Tue, 31 Aug 2021 09:49:53 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH 1/3] dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
Date:   Tue, 31 Aug 2021 09:48:26 +0200
Message-Id: <20210831074832.16310-2-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831074832.16310-1-roan@protonic.nl>
References: <20210831074832.16310-1-roan@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the SCD4x carbon dioxide sensor from Sensirion.

Signed-off-by: Roan van Dijk <roan@protonic.nl>
---
 .../iio/chemical/sensirion,scd4x.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
new file mode 100644
index 000000000000..119356933b86
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sensirion,scd4x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SCD4X carbon dioxide sensor
+
+maintainers:
+  - Roan van Dijk <roan@protonic.nl>
+
+description: |
+  Air quality sensor capable of measuring co2 concentration, temperature
+  and relative humidity.
+
+properties:
+  compatible:
+    enum:
+      - sensirion,scd4x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      co2-sensor@62 {
+        compatible = "sensirion,scd4x";
+        reg = <0x62>;
+      };
+    };
-- 
2.30.2

