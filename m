Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75FA394ED5
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhE3BBX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhE3BBS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:18 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E13C061342;
        Sat, 29 May 2021 17:59:38 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a15so5592695qta.0;
        Sat, 29 May 2021 17:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eM/AgXZ1tPcK96JeOBgvMwuUfYGi+k7+FBTbEFk9D58=;
        b=lore6e0w8lcgK/ddDTsUw/KlFvUGRtmIVDQUbxzSnSzwPcBHMzOEGMZ8E5Qx+YqHZu
         4BNGIbQkFCAZ/Gvq+j7q8KYsxhtGa2MlqVMudmZfgDyaSkHG1e65+4e10SUgt899xwut
         YUof2vQ0PwJrmcN5lLs1RlXQ6V0i/3XMf4jMLEbjHRpL6gALnKtiALBKhjx6aqXWW6nw
         NdfbxbYQp8xUyJZG2qYYiBNUUolNAPh09RR6dlNrNOLahrE4XGV1Ya/DNvlRTybXAWR7
         hmFmdRGRZ2b/jJVRo3VIqPpBAQAQBAnnVOR45EC33KejtM+X2z0JrduBUxc8giLLjPlZ
         2fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eM/AgXZ1tPcK96JeOBgvMwuUfYGi+k7+FBTbEFk9D58=;
        b=XLAZ448bu4MkZagBM9kwsa6D3jOUGYgvM4OaGTHblRXOF5nW3Yiq8lNmC2zD0vbWED
         dZ1RbTm3UkZcsD/ABv4yYfKxu7gs1W8nKw+sNY09DXpVOFT7mCfmi5sWv0IAFwjNhWhw
         4W5J+cucbbPNKjeS9m2HUnTM37YKpeALNuwyr5UJzHgGUsFsa6wuAnIcR/lYv7l0hczd
         /B9phhr0oyOTGsbQJ6qAfeFecbXUmsOhdWgpyinYrI3dAOCSpdfEohnemea1aUjGt4gt
         7UAzI/oXgF6Zt2i4lJMGTzPm17qLyE+hLRwxPrscCvsER54wHu6NFs/TrHWO/Zr28HwS
         vC+g==
X-Gm-Message-State: AOAM530AoghnLF/JegLKWJ3hLIJOh+jrgDV7asQREzkIXDGLgAI28Ziv
        LtkJ3uwLlnW7m39DGjBLR0s=
X-Google-Smtp-Source: ABdhPJzH5XlOvgyiyEsIZqThTCzzZPHjjp8y/2r2CJk1MmLYPxCBXh6PKen/90roKrOR9vU2KpS+Eg==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr9643408qtx.145.1622336377945;
        Sat, 29 May 2021 17:59:37 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:37 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 8/9] dt-bindings: iio: afe: add binding for temperature-sense-current
Date:   Sat, 29 May 2021 20:59:16 -0400
Message-Id: <20210530005917.20953-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly. This
binding describe one cases, the measurement of a temperature through
a current sense amplifier (such as an AD590) and a sense resistor.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../iio/afe/temperature-sense-current.yaml    | 61 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
new file mode 100644
index 000000000000..1bac74486102
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/temperature-sense-current.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sense Current
+
+maintainers:
+  - Liam Beguin <lvb@xiphos.com>
+
+description: |
+  When an io-channel measures the output voltage for a temperature current
+  sense amplifier such as the AD950, the interesting measurement is almost
+  always the corresponding temperature, not the voltage output.
+  This binding describes such a circuit.
+
+properties:
+  compatible:
+    const: temperature-sense-current
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  '#io-channel-cells':
+    const: 1
+
+  sense-resistor-ohms:
+    description: The sense resistance.
+
+  alpha-micro-amps-per-degree:
+    description: |
+      Linear output current gain of the temperature IC.
+
+  use-kelvin-scale:
+    type: boolean
+    description: |
+      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.
+
+additionalProperties: false
+required:
+  - compatible
+  - io-channels
+  - sense-resistor-ohms
+  - alpha-micro-amps-per-degree
+
+examples:
+  - |
+    ad590: iio-rescale0 {
+        compatible = "temperature-sense-current";
+        #io-channel-cells = <1>;
+        io-channels = <&temp_adc 2>;
+
+        sense-resistor-ohms = <8060>;
+        use-kelvin-scale;
+        alpha-micro-amps-per-degree = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a7279af85adb..0eb7fcd94b66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
+F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
 F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
-- 
2.30.1.489.g328c10930387

