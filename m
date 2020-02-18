Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8DD162539
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 12:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgBRLGy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 06:06:54 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44890 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBRLGy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 06:06:54 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so8912085qvg.11;
        Tue, 18 Feb 2020 03:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6VAAN5zOHBh8mqoV9dm6Z9ziAu/DTVFg/ZBaDqy0cHM=;
        b=TR0KbHtHTvyc2elBVynqmLM5o5pO0hCYabxVGN86Khzk27mc/EninuxgYZ1EDo3Ps3
         2ySKSdG2eDi5sdv6oJuSelSFkkZ6F5zcx1k7sLrKW3iHQ8f+IxVtr78iUPSjdFUfz0LX
         /j9v3JRThB9qSuwWDyfOUuy5SBV/WjzYC8YTkL4ZNo59fdvkifZb81Jca0m8XdVuF7Pb
         0YAtQ8AQMlxJxUH3FMsbl2nmItn2BCrBlaCX6FeOMsFtKYkExZOWOJ9tpcCGXc/cL6GI
         dp2oHtLhY6SVCRpZuBrV3QaQ/V0eE5AlYUFkoe/jJKx8B3XsWDjwd5869ztK57VIgUrM
         nGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6VAAN5zOHBh8mqoV9dm6Z9ziAu/DTVFg/ZBaDqy0cHM=;
        b=HJBJBdxcz1vFIlijjGZwQSD8EMrN6qu0PAvfl32cykEddKwEKcnpcgG87Nbolxm/aI
         aU4N9+B6nJSpVULvnlMx5WabvEK0uUNmM94AzJEd/1MteN1FLm3hn2cUlX2uFwyvPaPd
         rRULu4TIaNGLw3EwvCAMM4JDF4MnlOf5PSCjpvJkxMmqK1rwUNb81zGsL9jzZRul8rI6
         Xy4szFSw+ACMK2IOL5NsMUD6V0Pg+Ihigk8gckm/TaJXsOJONFajpJF4vYjUjksj7xl7
         PdH85m+dQnx5MzmLDs9Zr43iejc0c2f/cSh88heJ1gB1/blIqIjdxQmln2P/Y6ZkuI0h
         6mzA==
X-Gm-Message-State: APjAAAUn6l5vO6JZIlV4qZkTBBCGhcVDqWbtkNz1J4oeXUJM8Vss+OrY
        x2cJO6faRguIAxe0aRPvBmc=
X-Google-Smtp-Source: APXvYqwl7QUj+Jgd0kzYsARb+vBb1sXqmvGzo8Dfej2qIrwtXC3ET9hLn/Hj6rJJCxJKOl/f86ZcLA==
X-Received: by 2002:a05:6214:3aa:: with SMTP id m10mr16313354qvy.125.1582024013342;
        Tue, 18 Feb 2020 03:06:53 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id u4sm1701591qkh.59.2020.02.18.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 03:06:52 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
X-Google-Original-From: Daniel Junho <djunho@padtec.com.br>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        michael.hennerich@analog.com, patrick.vasseur@c-s.fr,
        alexandru.Ardelean@analog.com
Subject: [PATCH v2] dt-bindings: iio: adc: ad7923: Add binding documentation for AD7928
Date:   Tue, 18 Feb 2020 08:06:47 -0300
Message-Id: <20200218110647.24758-1-djunho@padtec.com.br>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Daniel Junho <djunho@gmail.com>

This patch add device tree binding documentation for AD7923 adc in YAML
format.

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
Changes in v2:
- Fix the license header to "GPL-2.0-only OR BSD-2-Clause";
- Change the Michael Hennerich email.

 .../bindings/iio/adc/adi,ad7923.yaml          | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
new file mode 100644
index 000000000000..e293df9442cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7923.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7923 and similars with 4 and 8 Channel ADCs.
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>"
+  - Patrick Vasseur <patrick.vasseur@c-s.fr>"
+
+description: |
+  Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
+   AD7918, AD7928 8 Channels ADCs.
+
+  Specifications about the part can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7904_7914_7924.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7908_7918_7928.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7904
+      - adi,ad7914
+      - adi,ad7923
+      - adi,ad7924
+      - adi,ad7908
+      - adi,ad7918
+      - adi,ad7928
+
+  reg:
+    maxItems: 1
+
+  refin-supply:
+    description: |
+      The regulator supply for ADC reference voltage.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad7928: adc@0 {
+        compatible = "adi,ad7928";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+        refin-supply = <&adc_vref>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+      };
+    };
-- 
2.25.0

