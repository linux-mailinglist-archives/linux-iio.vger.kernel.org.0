Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4F196251
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 01:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgC1AMI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 20:12:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgC1AMI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 20:12:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so13913326wrd.0;
        Fri, 27 Mar 2020 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GKapBrOlmEHVYhUBBTH0BCVxUR3q5V6xELfo4+ssQ3g=;
        b=AMoBlXtS5fw2fDSHQJMxR9aMEo7eqSCEZeV03SmudGz0GdgSAQGTvIm4Pq+cwSL/z6
         XjkPhe15wsn0oXx1WRKY1PG+EYJvrKeSxkW3glN5BaG4YzSFvDGbrXg3spnmdgiyeNN7
         1w2ImGee78kpF31v26UanAwQMSiyLlpNrJnl0zDKjLWTopmonf/pjYZcLQrPMy3KcSsW
         qkwyHOiTns+3zoVZw+tnZqC6rjQq+vry8eJkIlhZ2is8ixSloKzE1W7Nw1tyYXSnZKBG
         31j8hKc1lsQET6CNSFUG2vlakQNxVhFE8aLq8iTiAhU5Xw5j55Xj26eH3m2yUwVfsgng
         eGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GKapBrOlmEHVYhUBBTH0BCVxUR3q5V6xELfo4+ssQ3g=;
        b=JYVXdLgdYfyKaaZ2cSkigG2K7XWCmKWJjAfBK3xdFz98rA4YIPF3RFuRSBGhmxNpvf
         wYGQ22earROuNJMpj3qmLKqt5E6W3Z9Uq5Rm3vg4qhyyhHPXDTaiB1S0kICZEJWy78wX
         XLreDD8Y+9/0EoMU/KcOZCNO4zP/kaOsaeCvXc10GBKcGAZak7diFlyb/foVexrv2Dkp
         g6dhdij+0yB/MVpkqhIwPVWrbPGixgD8UHMzwEpYUSWMmUruFsGOvXvBeDrcTdAYZiXL
         7A/YPXUy3PF/V3K85IBOa7topNJ5fFWzty6u3u6wTA4QzWq39XIyZOQyMtLeVQ6g+svy
         n28g==
X-Gm-Message-State: ANhLgQ0leBhhaViz1E5uZrMBRbRyXQJXKiT5Z/64ukkZQkhYkaDIzCYy
        D0dhOf+r8s1kyUVmhaS8JIQ=
X-Google-Smtp-Source: ADFU+vuTwTn5FVvR7OQTGnDdGCcHc8D0OlhQwgAW0koy9bdPnu0aGtMNrPaMIcSr9wousCaReryslQ==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr2020212wro.309.1585354325335;
        Fri, 27 Mar 2020 17:12:05 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7536.dip0.t-ipconnect.de. [91.63.117.54])
        by smtp.gmail.com with ESMTPSA id 61sm11237956wrn.82.2020.03.27.17.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:12:04 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 1/5] dt-bindings: mfd: add document bindings for mp2629
Date:   Sat, 28 Mar 2020 01:11:50 +0100
Message-Id: <20200328001154.17313-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328001154.17313-1-sravanhome@gmail.com>
References: <20200328001154.17313-1-sravanhome@gmail.com>
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

