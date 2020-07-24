Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60F22C3F5
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGXLCQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLCO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 07:02:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F2DC0619D3;
        Fri, 24 Jul 2020 04:02:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a14so4920864pfi.2;
        Fri, 24 Jul 2020 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nA0wOT43rTAqi8O7/YsvVt72X7BqcnXDtD4IHwFFIXU=;
        b=HxqE5gqQNqfaNKzS1ilKxfQpGiTZ8NePzMT5W2YJWHmeSbN+BhSF/hw3DNFpJPL83X
         l1YDYyuknLcrdoQp20G++ik5vhBXS9cJbF0SuwNuj3AxQk4lQG1DPjr2630M876SY3hS
         wL7aCVloUpE7T/4vorm79/GwOWFIhtCDpSYk6RIO5leu2Nm2DHGzEiBqoh6kHE2/zsIl
         M8utH22QL83kDrL79Mwyjh3M8u8C6oMP1Vsmu1BI+dtAkGjUY2KM/qDeq6WY+igsAFhM
         JSmjTxhGx+aZ01x6RjqnbFtWOTtZG3OCOaoEdDTpxsoWNaI3i+auqKofcYYcKEDniHuh
         orhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nA0wOT43rTAqi8O7/YsvVt72X7BqcnXDtD4IHwFFIXU=;
        b=OpEJOnzBHz4kGOudCW16dzovSUhOVA6y3BM1W0lRI+MPoLVFgOsOIRANMc0LQEl+Us
         2m/gY1Bs78dkzpHV9mHkhAuUmoEA/7Iax6FgUJG5obv1be6q9xvwOE2k0qjd6xQgrCoW
         gIE6GKrlMqd+Ewl8ZKi6Whg/JU4RRsHx/LsqOZxfTnilyTqy77J+VzqwqaLbSULUdiEw
         h/BWaZdGb6MMZQ5f9hjekRVJUcXv6FUMw8rYwmFPREsR6NDMIpVhyq1YE4xNH8DaMw8s
         K8fF8PRnXHF2OYoKWoBnfODmUHjg0MlEnMD+v3gSeLaydXQe8LEUA4ny+8PWDHjtRbhe
         t/UA==
X-Gm-Message-State: AOAM532CmSJ3neCpit+RtGb6IAdO5JUZD4KCPdL9NE3qvvMasDH6Uzmn
        7QyNPCLIUdgRmC4ipiQUo+c=
X-Google-Smtp-Source: ABdhPJyeXHsUI+poEKhq9tZ3GXzcpp1IOnGnv8pclRIdA/uoa0dg5qx9zUj/0imG/m9OOEq+CunWJQ==
X-Received: by 2002:a62:7a07:: with SMTP id v7mr8182260pfc.76.1595588533917;
        Fri, 24 Jul 2020 04:02:13 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:195:617:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id t29sm6053212pfq.50.2020.07.24.04.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:02:13 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [v3 2/2] dt-bindings: iio: gyro: Add DT binding doc for ADXRS290
Date:   Fri, 24 Jul 2020 16:32:07 +0530
Message-Id: <20200724110207.24456-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for ADXRS290, a dual-axis MEMS gyroscope.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

No changes in v3.

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
index 71ae9b184179..bb2cd4ee140c 100644
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

