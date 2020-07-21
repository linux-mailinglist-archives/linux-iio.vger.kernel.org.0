Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF322881B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgGUSTo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUSTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:19:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE5C061794;
        Tue, 21 Jul 2020 11:19:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d7so1842390plq.13;
        Tue, 21 Jul 2020 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wr3/k+1ex6fptAAVFMs6oDFrFt7DqcfgHz1IZTNoliM=;
        b=gBBl1cIQ2RaGy6mgApwpDBftoKfmP/is4EdoquHSFl7/kBk9I+aupEmuq/QMNerRj/
         rVYgORnZWckQUFGzNobePsGUuMkfsdXZNpVEDAdaZqmMpMW0E8Kk1zoQSqqtZP/P9Usj
         nxpByUvfLQftyEslbPq2N7ZFDnQJloM5CMa5yxxjgvhLux8LnSAit6HYPxBHjV8NBTFU
         SxAitVjZN0bMSBUPnTPyGCuwrTvDECweKvqKvFGoDmbiv3rhy8oNwWIaZkpgsI+YP1LV
         bQ85fWyp6hyaJyTs5l0nQ6B5sipgLH/qHkeZXEwtLqfM49DrenGacjozgpvnMCNlBIH6
         iaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wr3/k+1ex6fptAAVFMs6oDFrFt7DqcfgHz1IZTNoliM=;
        b=TOxUz7oqWA3h73/keLLN4J69gQjShG+iSKU+pFM46p1k/yIL/f9IU8vFRo1tYtTtOY
         p+YbultjSI39KSWdy2eYtOpHr/LhNL6Eb6nBBpWzQeKE6SMC9yuF8v6aHCwejTS5VRq9
         TV0IzPWwbIAW1dQOn/T8jcGKZDibp5pY+11OejEhQwxZvMAGsYVkqPomK5zUCXHwgG2X
         x3W1c9gMqvEp9Zn/7ZLPBx1hV6p/Ey3bizks/sxvts8vaTR07Yi/sdHkpZ6lwi+YG/Dj
         wAnDGTB00G0MxW6AhFzd0w5WuysFnTzCnnNHzL7UjR7rWmaHdieTYq+0vbB/KWiGHsbG
         x6rA==
X-Gm-Message-State: AOAM5332pZwyTOJHspabL6X/0dq8JLw8lrVjcVtYZcmVmw0YxlLlP4M/
        fGkhoy0BaM3J1rS9KulnOoMEsRTi3oQ=
X-Google-Smtp-Source: ABdhPJw9ba4fbeXIwYrqUneCu5yvlWJc9CNkBFnQGg5lLtiNaY4tWxFusGuxYmwInBZh74p/3Yg8xw==
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11mr8794167plo.49.1595355583486;
        Tue, 21 Jul 2020 11:19:43 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:593:314e:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id c134sm21054948pfc.115.2020.07.21.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:19:42 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: gyro: Add DT binding doc for ADXRS290
Date:   Tue, 21 Jul 2020 23:49:37 +0530
Message-Id: <20200721181937.27101-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for ADXRS290, a dual-axis MEMS gyroscope.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v2:
  - use 'const' instead of 'enum' while setting the compatible string
    since only a single item is expected
  - add 'additionalProperties: false'
---
 .../bindings/iio/gyroscope/adi,adxrs290.yaml  | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
new file mode 100644
index 000000000000..61adb2c2454b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/gyroscope/adi,adxrs290.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope
+
+maintainers:
+  - Nishant Malpani <nish.malpani25@gmail.com>
+
+description: |
+  Bindings for the Analog Devices ADXRS290 dual-axis MEMS gyroscope device.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
+
+properties:
+  compatible:
+    const: adi,adxrs290
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-cpol
+  - spi-cpha
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gyro@0 {
+                   compatible = "adi,adxrs290";
+                   reg = <0>;
+                   spi-max-frequency = <5000000>;
+                   spi-cpol;
+                   spi-cpha;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index dd02cfc410e8..0bb8ac90fba1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1103,6 +1103,7 @@ M:	Nishant Malpani <nish.malpani25@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/gyro/adxrs290.c
+F:	Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
 
 ANALOG DEVICES INC ASOC CODEC DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
-- 
2.20.1

