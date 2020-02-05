Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8E152409
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 01:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBEAV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 19:21:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45808 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgBEAV2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 19:21:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so124002qkl.12;
        Tue, 04 Feb 2020 16:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wj6LT20dLajifXtV99Zcoip6WQEuOXXdWvQjZR632DQ=;
        b=cWIK/VhIEfvG6R7vLQUjiD2USWqk74e7Y8UP8G29xerXGSihB/jO4Jdic3n/iuC+Cc
         i9qiETRp7a7wDh9zqTYFNQXIVI30ANvjbpAh4zGXfCXOxwrITuJ8nE88eBt27l3rfGCc
         I4CW9lVK9212KAc2INscHM2lFTtbrwv4MslXEwQ4DP+c56mPYLMTwyvtzhm+htnm8z1c
         fKO8c1IPtUKOUL15GzDv8NJKxMQJyXqXyiLeUo0oAN4TrX+y1ZvnzUbtBgtXvJvpIS7G
         ldAswVGtddXIuwYpe2Tyg6c8ic8z+1NuyfDlfXfBJVAGNuY1jFOTlTey9aE0233Lm53k
         zNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wj6LT20dLajifXtV99Zcoip6WQEuOXXdWvQjZR632DQ=;
        b=tpjXQhLml7y2s+2t91gWN3EFsn7RweAUnX5ST2HI3XkUgPEDPArNVCiK7dJbM4lSI3
         LVBbfolXigp84MyECA4D4nN+uUFehbayfXOOYh/6bQfjOOox+QUD+i8mNiRTCu0a0TJB
         7LwZcZkVGZ4q5zpQxMnNBo8qHxixVWZRJoaG+xZiwBVbp5fk8oaFrsP1kiZ11WHrW7ry
         adynQF/qTfYPWO2iMJjRV/Af8hz2gyUzCnfEAv/FcvLw2nVoUlREaDfy4Lh8FAfsr18Z
         h4YmL9e3A4fu8vNWx0LxHLc03lBg5ZKtYn81mq/k4lz1DM4rw6XUIfdOt63tXVELHMES
         0IyQ==
X-Gm-Message-State: APjAAAUoqKdWdmc8a8sZUASz2XrX/31Od+RLjdNXIJX5nckz2qTssDll
        uBNrCVcxQYlkjK7sFOpVax4=
X-Google-Smtp-Source: APXvYqzH9Sr3l/kGruhLbmvfKoKFWin30NBwVhgSosWEkPbFkoAMTLswz872Ls26QcHZQ5E9RL1HZw==
X-Received: by 2002:ae9:f714:: with SMTP id s20mr30691996qkg.236.1580862086239;
        Tue, 04 Feb 2020 16:21:26 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id z8sm12850825qth.16.2020.02.04.16.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:21:25 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
X-Google-Original-From: Daniel Junho <djunho@padtec.com.br>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        hennerich@blackfin.uclinux.org, patrick.vasseur@c-s.fr
Subject: [PATCH] dt-bindings: iio: adc: ad7923: Add dt-bindings for AD7928
Date:   Tue,  4 Feb 2020 21:21:21 -0300
Message-Id: <20200205002121.30941-1-djunho@padtec.com.br>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Daniel Junho <djunho@gmail.com>

Add device tree bindings documentation for AD7923 adc in YAML format.

Tested with:
make ARCH=arm dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
make ARCH=arm dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml

Signed-off-by: Daniel Junho <djunho@gmail.com>
---

Hi,

I got maintainers from the driver authors list. Let me know if this is
fine.

Thanks.

 .../bindings/iio/adc/adi,ad7923.yaml          | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
new file mode 100644
index 000000000000..8097441c97be
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7923.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7923 and similars with 4 and 8 Channel ADCs.
+
+maintainers:
+  - Michael Hennerich <hennerich@blackfin.uclinux.org>"
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

