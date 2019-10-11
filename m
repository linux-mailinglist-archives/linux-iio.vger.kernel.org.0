Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5FD47EE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfJKStK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 14:49:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43191 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbfJKStK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 14:49:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so6584933pfo.10
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBpxkrL7tKtRXDCw9jTxzLjYHb3eYmsJbnS949ORXyY=;
        b=wR7b4t8wiKB1zRfIkb8Ljj8NDXM8pfWH1+h6ohkMaqOTccYaQbclt3YjdbDEixiooF
         IDrKFliJUFwWCgTS8nsd5hVivMEZZ2FXCWbfK6EZU0LW/dZdye3VbqMlsjvefV7AWN9M
         Yit4F6mdtbNSxanYWJMLq8DnMRSV7xLA4XFQ2McB0jIL+db/X1Qwb+UT7KdzJtvez9wp
         XJzHJnI8f7+F1n8s2VXVCP/mI3/GPj8xGTCriPly2jTdxtIyhpELEv31o71IIKYovCj2
         Xqn+zRTbs9/TeMzrMY61Fzq4yWXMJPKLPNB+SibztJMogoCwuz3B1DsXnJwgROY0nq/9
         3Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBpxkrL7tKtRXDCw9jTxzLjYHb3eYmsJbnS949ORXyY=;
        b=tfAe3JcjVGYabaqLLUkHQlhA/6okKOfIJVh+yCmH2lr9sLcJV/TzuwFj2BLSeNPVrp
         thEFDXe0mP4686R7Gc2xW5B4FfPi+RShRfmIBIboY35sFGjnjadLIsjnAQYsvSoS0niA
         B7pN/TPiRbwZhv3zgLEtlj8e5CbrlvByQn4sn47mnijUDYoVf5kYaQb75um8loCYZUcn
         fnNhc3bPSDuCA2fSTPydN3gdHeerY0uFu9o1XFhEp4PI1Y0DP9ScVeleSb1yqBfir9Ci
         /sCuSUEN3L9TNcXPlbJAB4O8mHgFDdrc5zW7jSLF9T+G7sSP/nmkX7T+vPvaDa8xjcKi
         x6HQ==
X-Gm-Message-State: APjAAAXRLBr+ydje9UKckZL1z1livbyzS1pYD26ZjP8EUJbngw8pAZ1I
        cq6w7Z0dfS6VxlSJvco2PTXZ
X-Google-Smtp-Source: APXvYqxXIGdsoCVaSN/Uh4svgs7Yp0VbyU4voFE9v2eBu03uRl7ePFdrB717TH3GAR3dAYW/1TO97Q==
X-Received: by 2002:a65:4188:: with SMTP id a8mr17912797pgq.81.1570819749573;
        Fri, 11 Oct 2019 11:49:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6407:a090:18a3:ff6e:e66c:65b0])
        by smtp.gmail.com with ESMTPSA id 68sm10031497pgb.39.2019.10.11.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 11:49:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Date:   Sat, 12 Oct 2019 00:18:51 +0530
Message-Id: <20191011184852.12202-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011184852.12202-1-manivannan.sadhasivam@linaro.org>
References: <20191011184852.12202-1-manivannan.sadhasivam@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for Analog Devices ADUX1020 Photometric
sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

