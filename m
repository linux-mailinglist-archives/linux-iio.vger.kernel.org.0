Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810463B5456
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhF0Qdc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhF0Qda (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08F9E61A2D;
        Sun, 27 Jun 2021 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811466;
        bh=528RYEkDvcb3g+na6HYClWgZj4+rl50+j9vJXJwl+qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7iiCDkQtad/Oxcko5cJudvr5ysnrHimatwbUuPZqbi3Ed3MUT7Of7WfON/OsQWzU
         /Z6+AafrHLseOUy0AsRC3Y9SZR/hFZOfg1IJvYVRG4bUFGJxyiWn/LOe9pnh/Dx9v/
         hx1cHd49/BDijcrm409oWerfph9swzaO56S8XaPJ9otvdJTnrw0fdM+TJrhxGh/5KC
         H7ssqrCRlVohAW+TQQq7dRSbaWXLN5xk5ditq/z0Rjh+Kn7MidmfVtZQQMhNQ3cTw1
         ctrYHZodV+gZEBEAOLtlLy0bwwKmyhSUgOYZWP7Kb8hSuHGj+sQUiiwsHlyTK/sOMW
         M9G9+1bRNHF3w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
Subject: [PATCH 14/15] dt-bindings: iio: dac: adi,ad8801: Add missing binding document.
Date:   Sun, 27 Jun 2021 17:32:43 +0100
Message-Id: <20210627163244.1090296-15-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This device was missing a binding document. Simple binding with the
ad8803 requiring two both low and high references whilst the 8801
only has a high reference.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
---
 .../bindings/iio/dac/adi,ad8801.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
new file mode 100644
index 000000000000..6a3990a8d0ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad8801.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD8801 and AD8803 DACs
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+
+  compatible:
+    enum:
+      - adi,ad8801
+      - adi,ad8803
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vrefh-supply: true
+  vrefl-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vrefh-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad8803
+    then:
+      required:
+        - vrefl-supply
+    else:
+      properties:
+        vrefl-supply: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad8803";
+            reg = <0>;
+            vrefl-supply = <&dac_vrefl>;
+            vrefh-supply = <&dac_vrefh>;
+        };
+    };
+...
-- 
2.32.0

