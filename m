Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32F22DF9D
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 16:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGZOKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 10:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZOKd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jul 2020 10:10:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE79C0619D2;
        Sun, 26 Jul 2020 07:10:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f7so1883816pln.13;
        Sun, 26 Jul 2020 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrYoViD1Na8p/cme/0P1ewz9+ldHUHX3U6cruBs/b7w=;
        b=rwLpKE/5d8jiOco9iFTlU3Kol0FhAPrKr/EmdSyeybLew44LlqhWw6tgZyzkVoa1gj
         MpVaDk7QcGKkjp3euq9IbPzC5RgLi2Jd5FZwc6pIdKTeUhHHkC2/few0syTQxzjrx8se
         Tz+OMHnXXYzAr5B+sa5eY8xaN0+1tThQ4mJg6M29c0iuHqsbrPCT1KU7YIipslqYDGAq
         NZfrBAI+/kFyFxyqVBAv6rd06p2QpSgdqX1ML8680nbay2dcmZMbBXq3Su8Ht1XImvZQ
         6VfRnpopfXk1iP8XFUWaAxGfVoXMskR00DD6yVr5PFW7Hnp30pavKVTXtsGOExvdx4h0
         rUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrYoViD1Na8p/cme/0P1ewz9+ldHUHX3U6cruBs/b7w=;
        b=Xcry54P7OlUYtdf7Qjt+V3aGFRbzQuWpc7TMH4sd5Qo9cCxYgCJnlIySmyoWYTIPTP
         jx3rLadKCQU5tx9xAFanlvCpv1GT6ThwFlljCMINfq2+oM7YlOp7iJMfkZc45OPg7Sqf
         Vsf6TVT8v+1iBZlgWux0BLzaG2ILfpYGoQVRbQ4LCHWZ6jb8IBUqqlRfHgsbiZDP0SPo
         W2bdG674pK0/83qKG7Rrd0TVC0Pwr8dTGEOWMmAfRXxVJWhe7AKQuyxVAGQu63qlw4k0
         M6hTjfYpgkRGie9WIJ6qzWXYT0aADd+Z9SrjU75oaPSFvcI6UrsCuPz71GxPOyWPKAE1
         k6lg==
X-Gm-Message-State: AOAM533sid0eX/z1DWoDS4DEK8pOlsnuTtJZNmmi0TJnb/MLZP428+IE
        6Lz3/i3/K6kRS4HFsP3e1sU=
X-Google-Smtp-Source: ABdhPJzcsX2Jrk1eDQZ4+OMXJCv/qsPL+y/GTkaLnq+c1EKblPedhvB0zp3HeKmyAecGEypQRyfEkw==
X-Received: by 2002:a17:90a:c693:: with SMTP id n19mr2771821pjt.53.1595772633082;
        Sun, 26 Jul 2020 07:10:33 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6d98:886d:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id d14sm11901928pjc.20.2020.07.26.07.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:10:32 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [v4 2/2] dt-bindings: iio: gyro: Add DT binding doc for ADXRS290
Date:   Sun, 26 Jul 2020 19:40:26 +0530
Message-Id: <20200726141026.2888-1-nish.malpani25@gmail.com>
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

No changes in v4.

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

