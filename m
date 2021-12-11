Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1E4710D8
	for <lists+linux-iio@lfdr.de>; Sat, 11 Dec 2021 03:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbhLKC0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 21:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244380AbhLKC0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 21:26:13 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE9C061714
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t5so34958969edd.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGu50E09mCw1U2A+S3O19n9x6nLpFWs+pIRJt2who2g=;
        b=FJhMOelpXH/gQkr1u/xvKKHT9KsquhHmDyWP+tjc1adW1YFCaZkavXR9QdYylwIw52
         H2R9nCMEeAE9yjspJ5c709PvGmqCkjeSjTe33VtSdPfDfo8sG0t7ImLhA44MZDv3nznO
         aSfghjxeL7RCjJpjJZsdjy77Hd36uu2nn2rC4r7bwV1OS5Cq0q5zQHCm+x+7Rb+Ya3RL
         drgZYdhsrPgLjeE9wUcXjh1x1ubJTZXpckLgux9X3WpcXunflwuRsIijrDpe9qdOEnQj
         s+XwQWCSGhbGOV20nm418dzEuUb2zJ5nK7f1x3GPnr8gCTblGd7Re1k8VtSGTEqCQutI
         zzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGu50E09mCw1U2A+S3O19n9x6nLpFWs+pIRJt2who2g=;
        b=kYiQ5o6eLjvJ/ayBAJ4OZNPe7TiuuYLi/9LRSlZ6RZXFOwaJ/8vJ85L2qgJRKUn39Q
         9i5gbHwzXH/RGMlnK/KhPEDz82ynRJe8lu2uT9wNThtDlJPyzS6RPBqxX8IPe3BuYlzV
         3mxrGQKuBldSL6uuAU1c/Khd1nYr+g4WR0KgWbE5N146QGD6UJ1lmFh7kxJWBXiBQkSh
         oF53CEL4/YO4/xFBeLDPWmV1uHDi5MA41jImFnli6xmDR7IuGWySWKS9w7J0dmxyg/5U
         LcImGzS7tQm5e/qvGxHAW/3IX4Lbd7ngnarg14zLWKRHmIesoIJmlV/7re3XFzi5ltLN
         188Q==
X-Gm-Message-State: AOAM532x1KMkfaJmhjmRbhGqmdrTf1II/9dz+Td7VtzPAlpWETuY/qjR
        9GxH2QHts3E8rPT2MSaIPAsf3A==
X-Google-Smtp-Source: ABdhPJylsm/JkdtpGjy9BZuZbGuSwA+7ItwXoqaYozk3OClVmNQrEogbcpSPKrL3NdH+T+lW+WBY6A==
X-Received: by 2002:a17:907:3e9a:: with SMTP id hs26mr28599389ejc.433.1639189355965;
        Fri, 10 Dec 2021 18:22:35 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:35 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Sat, 11 Dec 2021 02:22:19 +0000
Message-Id: <20211211022224.3488860-3-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211211022224.3488860-1-caleb@connolly.tech>
References: <20211211022224.3488860-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
PMI8998 and PMI8994

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
new file mode 100644
index 000000000000..11d47c46a48d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-rradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC Round Robin ADC
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+description: |
+  The Qualcomm SPMI Round Robin ADC (RRADC) provides interface to clients to read the
+  voltage, current and temperature for supported peripherals such as the battery thermistor
+  die temperature, charger temperature, USB and DC input voltage / current and battery ID
+  resistor.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-rradc
+      - qcom,pm660-rradc
+
+  reg:
+    description: rradc base address and length in the SPMI PMIC register map
+    maxItems: 1
+
+  qcom,batt-id-delay-ms:
+    description:
+      Sets the hardware settling time for the battery ID resistor.
+    enum: [0, 1, 4, 12, 20, 40, 60, 80]
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic_rradc: adc@4500 {
+          compatible = "qcom,pmi8998-rradc";
+          reg = <0x4500>;
+          #io-channel-cells  = <1>;
+      };
+    };
+...
-- 
2.34.1

