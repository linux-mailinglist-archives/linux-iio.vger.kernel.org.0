Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9E1E1DE9
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgEZJHM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZJHL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:07:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E2C03E97E;
        Tue, 26 May 2020 02:07:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h21so22985441ejq.5;
        Tue, 26 May 2020 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UoSXv7d+tfcbmDpE4494j4outc83bbmJfjPfvWfKgp8=;
        b=E1Zn4BonDAZfXqeAVoIjieZScLB7xEcTXC1txRzXUH4cyZuLA90KwdC3EGMqnnoZ6G
         Vz66XzILh53/4yZY/rakDIuLG7uD1RRlR04D7G8RyKZzVjzS+W8EI0Wc3X7cdzsumNUE
         Dzz6EGyrlOHlNtQsJxHgEVspJVj9iZK+wmtBqxCgfWfdsAygkJ/en15AQnPDPVKPFB57
         9GwUtAQixdqFK8BqJeiBCzYaPC7ElJ9gj2NBOEOypsWmQp1lI92n8UGl2PweDeDq3fy2
         houOrcj/9t9hbcJyGHNeiOhn6JogBApRhxPm7A127Uzhxm55Xd+5K4MRI2aY2M5yn+Rc
         jl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UoSXv7d+tfcbmDpE4494j4outc83bbmJfjPfvWfKgp8=;
        b=Axrr/A44fDgQ71uR6ojYsmFaxyqShDnGOxk/YFRsBVoKmBrSLtFxFBOgvtlyW9F7wJ
         KRT/YWOhGmIdvgM0BB9H7cceKHhs1d7CRBLWF+kOGvvn9JjBA38aKlgrzc7TfZ60HC1u
         9LxScmlgvXW5dV7FklWumK/lFEbB5kzPWjXvf8vLrkJTeHy9K/UXbqxTHA3dQM/iO3s0
         KVYDsBILNCB7kZUjPUFZNbavFjeF4ttcq9ih9BR3eAC2L7tiSpT9nldDVfvwfzw7Ps8Z
         QIFJlfiIMslF9qN1vBdTv7VeCdblixHL+cEptHGj8MT2WTlhx89KzK8QbpFEXzScs7Cg
         QKng==
X-Gm-Message-State: AOAM530R4T7K+DJ/NrvFGdnwampg2AIhI3H050Nr+xf/Wjphrl5aecyR
        7LNj95n1HXl54mG60rxX7svEKAAVp3g=
X-Google-Smtp-Source: ABdhPJwpvX+VTKRQ21Tskdgdffg+/i7CV0+SqALml+Alne2V/whW+p7h/YP7ZJIKMZawfplBQexcEA==
X-Received: by 2002:a17:906:3944:: with SMTP id g4mr237901eje.55.1590484028537;
        Tue, 26 May 2020 02:07:08 -0700 (PDT)
Received: from localhost.localdomain (p5b3f6e09.dip0.t-ipconnect.de. [91.63.110.9])
        by smtp.gmail.com with ESMTPSA id c7sm17870535edj.54.2020.05.26.02.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:07:07 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        sravanhome@gmail.com
Subject: [PATCH v12 1/6] dt-bindings: mfd: add document bindings for mp2629
Date:   Tue, 26 May 2020 11:06:41 +0200
Message-Id: <20200526090646.25827-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526090646.25827-1-sravanhome@gmail.com>
References: <20200526090646.25827-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for mp2629 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/mps,mp2629.yaml   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
new file mode 100644
index 000000000000..f91acc42d652
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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
+  wireless camera and portable devices. Chip is controlled over I2C.
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
+additionalProperties: false
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

