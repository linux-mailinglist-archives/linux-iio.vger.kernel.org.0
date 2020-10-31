Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18E12A1A16
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgJaSw3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgJaSw2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7794620739;
        Sat, 31 Oct 2020 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170347;
        bh=A2pwFngauHoS66hH5BWqmxkQXqVJk7bmvyKpRg8LrxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5q/KaW+DYjAB9BOs2dTXK+mmC97z/1A14893uL5HnBrT1Bu5B2xC/kbVXBBZXU4z
         QCLr21ZUmTrFaHOryx0Vb65AMkFRrtG5lPIjwb1FUxRY9ps6Ux5x6sM0zXBYPUmiz/
         4MSJ8GGxfpAWG4HkBW77cTN7d+U2VFrlkNesgKNE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Robert Yang <decatf@gmail.com>
Subject: [PATCH 41/46] dt-bindings:iio:accel:kionix,kxcjk1013: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:49 +0000
Message-Id: <20201031184854.745828-42-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding hence a straight forward conversion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Robert Yang <decatf@gmail.com>
---
 .../bindings/iio/accel/kionix,kxcjk1013.txt   | 24 ----------
 .../bindings/iio/accel/kionix,kxcjk1013.yaml  | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
deleted file mode 100644
index ce950e162d5d..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Kionix KXCJK-1013 Accelerometer device tree bindings
-
-Required properties:
-
-- compatible: Must be one of:
-    "kionix,kxcjk1013"
-    "kionix,kxcj91008"
-    "kionix,kxtj21009"
-    "kionix,kxtf9"
- - reg: i2c slave address
-
-Optional properties:
-
-  - mount-matrix: an optional 3x3 mounting rotation matrix
-
-Example:
-
-kxtf9@f {
-	compatible = "kionix,kxtf9";
-	reg = <0x0F>;
-	mount-matrix =	"0", "1", "0",
-			"1", "0", "0",
-			"0", "0", "1";
-};
diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
new file mode 100644
index 000000000000..5667d09dfe6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/kionix,kxcjk1013.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kionix KXCJK-1013 Accelerometer
+
+maintainers:
+  - Robert Yang <decatf@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - kionix,kxcjk1013
+      - kionix,kxcj91008
+      - kionix,kxtj21009
+      - kionix,kxtf9
+
+  reg:
+    maxItems: 1
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
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
+        accel@f {
+            compatible = "kionix,kxtf9";
+            reg = <0x0F>;
+            mount-matrix = "0", "1", "0",
+                           "1", "0", "0",
+                           "0", "0", "1";
+        };
+    };
+...
-- 
2.28.0

