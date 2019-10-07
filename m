Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABCACE7E4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfJGPjl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 11:39:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37869 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfJGPjk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 11:39:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so7040481plq.4
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2019 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NKz+jzuPRkeE8OyfVXN3xWzVOBpfNSKgJ1fmTtHwhbk=;
        b=GlECiIs6yqHMnmv6owgHQSiNAw8TmUs/ep7tSo5/YMXwUyBynPgentNR0AXiGM9wUS
         qPHCGRQfpXEOHvqYEe5BxlakCUYnxQvRbhK+UxZkKXuBtTBAEbR1vR/96ih4igNEHPef
         eXxCjUuiZEFUisDXIzZQVvpQQ5Vj4dO6ESiQLAWsQZRZjLWO9LvV44EeLSj8XF08GH6x
         moIkoc/krUGlmK3qoJhwpSK4Hyza4WCSIrvCLiYpPw5bQLzobYGLx/4RkiLHFpfWLue+
         uBEsWdZjUYA6rDBRmB2zgTq19Eq2J7VXguUZkjcysrcy0OJA6qdKW0b0tHJAtuZHXNfw
         mRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NKz+jzuPRkeE8OyfVXN3xWzVOBpfNSKgJ1fmTtHwhbk=;
        b=Uw7QH1K7kFQEEoUnjyUBxGACxyfCNkMa0l5o8NEJnvHRadh+AcU42tabImsksFaKcs
         FlhmC2VL5FQKJZn7gmpNTzk+fWUWlC2ryvZRzU6mV8zcnniEckfEOa2PJiBvtQZsXDZp
         EwQ6fUWo6ssTR8DhtOMbdmMzQzxhvXSPYGEyzuVNYIb0kdXqTBOnoVNmgcbwcuPeUIJM
         qK9jtrlMzqR4KB1TYOU1i+tH0Hz5HG/kD1O5P0CLUOXGThoPefYyiyjyQG6diwPKQ34B
         ikPZGVfjzxvAQ3vy5rBEkdFftMg7J9ddyJPQVqsfVEMX9U0MoB/GUWDFSlHzjrpjNBkK
         9bUg==
X-Gm-Message-State: APjAAAXCBuFIhaxA59VzJkMxfqpDdy862GcnlfGWZzze8BD0M8hNb2Am
        h+ZLUX1IZou4mI4XcqYjDElh
X-Google-Smtp-Source: APXvYqwC2qTSZx1RcZnaOnSFwjtv4y1EeHa607q2ZdXiJy4DHtSGsRaMlhHdD9TuSR/e6KfaZw2U2w==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr29510816plb.160.1570462778750;
        Mon, 07 Oct 2019 08:39:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7088:cb7f:1889:38a3:2d:5880])
        by smtp.gmail.com with ESMTPSA id d69sm15945077pfd.175.2019.10.07.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:39:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Date:   Mon,  7 Oct 2019 21:09:16 +0530
Message-Id: <20191007153917.13611-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007153917.13611-1-manivannan.sadhasivam@linaro.org>
References: <20191007153917.13611-1-manivannan.sadhasivam@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for Analog Devices ADUX1020 Photometric
sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/iio/light/adux1020.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/adux1020.yaml b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
new file mode 100644
index 000000000000..69bd5c06319d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/adux1020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADUX1020 Photometric sensor
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+  Photometric sensor over an i2c interface.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADUX1020.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adux1020
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adux1020@64 {
+                compatible = "adi,adux1020";
+                reg = <0x64>;
+                interrupt-parent = <&msmgpio>;
+                interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.17.1

