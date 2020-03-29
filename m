Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46112196D56
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgC2MbX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 08:31:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36556 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgC2MbU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 08:31:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so17567636wrs.3;
        Sun, 29 Mar 2020 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GKapBrOlmEHVYhUBBTH0BCVxUR3q5V6xELfo4+ssQ3g=;
        b=luWn4VxAKy4BMYnYdqLUrCkt63SrzaWh6EqMAKjUtK8xE0ru4i7ApfWkdUQbtDXBgT
         Ha4wm3V70sc1bAsUKo1+ujVuURtb03crrYALhV8kp9gDeXTuozFt8v+wwwRGaKr3PpPn
         nwgzRGBBkwBP+fI4WR+FwUooSFbi80mP1avkhxS7payAmbjflmfrbAYEAZFVynLiNS+3
         dloIumUUtPuoyUbl1FoICq/3/SW9WVlcu+PVP7B9bd4j6euBQsbcoBwVcJ7go2HnCBYU
         cc7mBag5R4ab297eF9LlDh0cdjOBWaqzYZy8BHbYDHI7FiK1OsXp9bnX44TAgU5JIge+
         G69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GKapBrOlmEHVYhUBBTH0BCVxUR3q5V6xELfo4+ssQ3g=;
        b=o48HfwRL+8S6cWOmO4+/c1m33htyu+WGGTJhu+/UawAMup+7gOLDhIvsWhUxxsX2yj
         PHHEndESeUPFpzPyNDnVmhM7Hr5wLP7uAjJQA9Ae1SQysEpqvTpobvU35NRMTVanIRKk
         sUm1whnWW+TRrJBcECKq1xTXdc/pUgcEKzY31oM7z3ROiM6X1evNwok6NY9wdgYt34fl
         V32CyZbUxmsPaQSQDTjjZzFAKtPovos1kEXA88L2ZN/I4gjc4JUgGEay9oulD1xus6qZ
         suF9zyq3iXPxTfeMDAoacCa/9Pvw/ZyylCmam+pjRJe0rRiR/t4btJoiEPbTrCujpV7v
         ETqg==
X-Gm-Message-State: ANhLgQ0CKAUuw4UoftthZm8fxSGogTDYxUarla0EkAIrD98IjOazsgAA
        QGbvrs4F+ad2QIpBd72YcF0=
X-Google-Smtp-Source: ADFU+vtNyysNuarRctEs+jLSSz+ipgSiE9hlpQH+rJ096CnE78UdigIo4l6JvLOfcwjAw6ZxxuO1AQ==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr9960745wrc.139.1585485078601;
        Sun, 29 Mar 2020 05:31:18 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6BD9.dip0.t-ipconnect.de. [91.63.107.217])
        by smtp.gmail.com with ESMTPSA id f9sm17259108wrc.71.2020.03.29.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 05:31:17 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 1/5] dt-bindings: mfd: add document bindings for mp2629
Date:   Sun, 29 Mar 2020 14:31:06 +0200
Message-Id: <20200329123110.26482-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329123110.26482-1-sravanhome@gmail.com>
References: <20200329123110.26482-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for mp2629 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
new file mode 100644
index 000000000000..3c3cd023256a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MP2629 Battery Charger PMIC from Monolithic Power System.
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+description: |
+  MP2629 is a PMIC providing battery charging and power supply for smartphones,
+  wireless camera and portable devices. Chip is contrlled over I2C.
+
+  The battery charge management device handles battery charger controller and
+  ADC IIO device for battery, system voltage
+
+properties:
+  compatible:
+    const: mps,mp2629
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger type.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@4b {
+            compatible = "mps,mp2629";
+            reg = <0x4b>;
+
+            interrupt-controller;
+            interrupt-parent = <&gpio2>;
+            #interrupt-cells = <2>;
+            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1

