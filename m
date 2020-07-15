Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFACB2208BB
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgGOJ2h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbgGOJ2g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 05:28:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4C4C061755;
        Wed, 15 Jul 2020 02:28:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so2795147pgk.4;
        Wed, 15 Jul 2020 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJvTVWXy3m6W0qHqqi1ZBUoRZaoYbJ8TfIq2rvc7zc0=;
        b=sHuPXXrR0FXlRt0O0gM1esBKXFMWqSTDJyw4IeTGgOTCe+yeYmq5cKabsfYpOagmHt
         YnyidHuzjuGVGMy9zKzsSVKJvGWYlGPXQd6wBt8l24TMEgwessmGJv/fK1aoSxn3y7pg
         HcvGxFnQC1YKf1rXIfZb9VnvCNh+sdObDz/piUsWK7UzyYZajY/cYqC2ZmeMi7bqk9M1
         TZ5akwzWXVyRgrks0aEAtPWU9V31u1j6utjwZsT6AnDeIKI1BTd/Cu+lLYzqgjR6zJFE
         qKrNFZU364IDmHSFyCFPozcdC5qLqVzibY8FDfU46BGUCWadWQlx6y8kf+cI6uFxJhYG
         XCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJvTVWXy3m6W0qHqqi1ZBUoRZaoYbJ8TfIq2rvc7zc0=;
        b=n8QfTXIKBGKHpQkNQLd9q31v1TOCJyOFfaL/SGwoGGYWl9lZZo4MZUefjohYNGZbWV
         aW0EHJMuEEDHm01YLWLe8hkp91IhbDVZZqiRhouCUm9V+bRqmX3MHtKO0NKOBmJYdlTf
         5Qa9cbjW7HTdTY9qvtJh9fIaJ+Yh1mNWzlxL5qJmDueNrhW6dulH2wUgvs7ipHDQIGu6
         OxyKmbmtFPeAwG7aKKukn2N0jdrtBX+y1yjXdw/s79joW1k/tx2UI0nVTvzfv0j4o1cz
         rHhL/sQrGThteq3QqSVI/8lUkO7E3F3rZ2ta1ijq7wO8GqPTNF+HawITBC6dqCTlX0ls
         0h3A==
X-Gm-Message-State: AOAM5335q8wq7rJnxA0MJq6Cja9fWyN91NHB0fFLE9zywp/jCQz+2UV3
        LUzTIPIe6SmDvIYw+yhcfDM=
X-Google-Smtp-Source: ABdhPJxOI/TWSkRH4YpTDwc9zURvXajeabWuPS+KR7SoEsT4GhQpTWxvdwrcmGOBgBXTeWfl2oNGkw==
X-Received: by 2002:a63:ab4f:: with SMTP id k15mr7396434pgp.247.1594805316396;
        Wed, 15 Jul 2020 02:28:36 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6188:2bbe:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id 17sm1549391pfv.16.2020.07.15.02.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:28:35 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH 2/2] dt-bindings: iio: gyro: Add DT binding doc for ADXRS290
Date:   Wed, 15 Jul 2020 14:58:21 +0530
Message-Id: <20200715092821.14625-1-nish.malpani25@gmail.com>
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
 .../bindings/iio/gyroscope/adi,adxrs290.yaml  | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
new file mode 100644
index 000000000000..a997d945fdb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
@@ -0,0 +1,52 @@
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
+    enum:
+      - adi,adxrs290
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

