Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272BC18962F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 08:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCRHTw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 03:19:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38608 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 03:19:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so13420119pfn.5;
        Wed, 18 Mar 2020 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ntc/lC+0lJ6yYNxW0plx8U2OvYjUOf42pIvCB4jmx7A=;
        b=orQAqFg4WmrI4PrZKdYeg3WvkW2Mg/qBOdGVmytn6TwK13yLp3azzmm/RhijcDv63w
         EMZDVnjh5Vf1S/qsYIuIGxYZNvFpkAwBGlnrJ6gIr/iuX2ECbOR/ocYctyKtjszsa7qb
         zjcPoajZQEoRLVmvRCXHSj9IRVMr5HuZffYYr2DyMPQK9hwz55RyG+yYFdsZ45Jsf0lw
         tmS96WEzAH8OSL/hPPQ9TLLPe9Eth7MBZzAja+mGUbPB5gtvIveFbNVm5Jm6LtZzggpz
         yDqxOLqaeU5UMXup0zw+2xkOaZ5yRKpzH6S1vWCiQFJx9pK7hqU5XAWSZL+DggxF/fhj
         27Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ntc/lC+0lJ6yYNxW0plx8U2OvYjUOf42pIvCB4jmx7A=;
        b=P8TNNmhbTbSQr3PCIIdR68DwB744vrCzYdx7EDzPP7AiXiu5GFTdHcPay4oYVJFeyi
         8KAzRWkbIt8BSLc196yrl2lt+tv4cvbpSFnCvjBfrrQoxsk5DqrrXMRyFlo13zKx9xk3
         olXKn0LcRRYp7IZahoSIws30GV3gEePBGL0f1dqRa/gkfs4L52dmLlyqJ5KnPoVMNkTt
         sVHw3k1DME1t67wtkQLu1Mo9xJZdOHNvC4h95iTAeoogGfFJRHqleLiRwVNGp9B628/K
         3E9otBauGxz2Z6xMD7xO5V6dGLAf2x4FCEsRn+X0uu0B9D9ocZhvWKd3q7lGeN7AukSX
         d8TQ==
X-Gm-Message-State: ANhLgQ0sZQkMtj5kdbsFmAq8XwCAKhkaPDaNvtKj77bJiWVoOhIngxXS
        A5UPVoxBYBfDoiL50rHVq3Ix+UmO
X-Google-Smtp-Source: ADFU+vvv7naQJrSr7Arvd2x0lASQjE60hLdv54iT681tXBkew6P05e66s0GirF8GoabRbZV7ApY4hg==
X-Received: by 2002:aa7:963d:: with SMTP id r29mr2801692pfg.87.1584515990993;
        Wed, 18 Mar 2020 00:19:50 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6086:470e:bc8d:c185:c429:a95b])
        by smtp.gmail.com with ESMTPSA id e187sm5202529pfe.143.2020.03.18.00.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 00:19:50 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, nish.malpani25@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: iio: tsl2563: convert bindings to YAML
Date:   Wed, 18 Mar 2020 12:49:40 +0530
Message-Id: <20200318071940.12220-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the TSL2563 device tree bindings to the new YAML format.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v4:
  - Change $id property to reflect corrected relative path.

Changes in v3:
  - Include the complete diff (changes from v1).

Changes in v2:
  - Rename the dt-bindings to include manufacturer's name.
  - Synchronize the bindings with the driver.
---
 .../bindings/iio/light/amstaos,tsl2563.yaml   | 49 +++++++++++++++++++
 .../devicetree/bindings/iio/light/tsl2563.txt | 19 -------
 2 files changed, 49 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt

diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
new file mode 100644
index 000000000000..efd2eba5f23c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/amstaos,tsl2563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS TAOS TSL2563 ambient light sensor
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Ambient light sensor with an i2c interface.
+
+properties:
+  compatible:
+    enum:
+      - amstaos,tsl2560
+      - amstaos,tsl2561
+      - amstaos,tsl2562
+      - amstaos,tsl2563
+
+  reg:
+    maxItems: 1
+
+  amstaos,cover-comp-gain:
+    description: Multiplier for gain compensation
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 16]
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      light-sensor@29 {
+        compatible = "amstaos,tsl2563";
+        reg = <0x29>;
+        amstaos,cover-comp-gain = <16>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.txt b/Documentation/devicetree/bindings/iio/light/tsl2563.txt
deleted file mode 100644
index f91e809e736e..000000000000
--- a/Documentation/devicetree/bindings/iio/light/tsl2563.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* AMS TAOS TSL2563 ambient light sensor
-
-Required properties:
-
-  - compatible : should be "amstaos,tsl2563"
-  - reg : the I2C address of the sensor
-
-Optional properties:
-
-  - amstaos,cover-comp-gain : integer used as multiplier for gain
-                              compensation (default = 1)
-
-Example:
-
-tsl2563@29 {
-	compatible = "amstaos,tsl2563";
-	reg = <0x29>;
-	amstaos,cover-comp-gain = <16>;
-};
-- 
2.20.1

