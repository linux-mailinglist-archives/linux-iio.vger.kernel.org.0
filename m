Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6674146BC
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhIVKlq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 06:41:46 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:32854 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbhIVKlM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 06:41:12 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 343C244A024F;
        Wed, 22 Sep 2021 12:39:36 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
Date:   Wed, 22 Sep 2021 12:39:22 +0200
Message-Id: <20210922103925.2742362-2-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922103925.2742362-1-roan@protonic.nl>
References: <20210922103925.2742362-1-roan@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the SCD4x carbon dioxide sensor from Sensirion.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Roan van Dijk <roan@protonic.nl>
---
 .../iio/chemical/sensirion,scd4x.yaml         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
new file mode 100644
index 000000000000..798f48d05279
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
@@ -0,0 +1,46 @@
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
+      - sensirion,scd40
+      - sensirion,scd41
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
+        compatible = "sensirion,scd41";
+        reg = <0x62>;
+      };
+    };
-- 
2.30.2

