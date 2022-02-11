Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3911C4B2F45
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 22:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352934AbiBKVUY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Feb 2022 16:20:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349534AbiBKVUX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2022 16:20:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E5C5B
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso4007674wmj.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=E7AMSUvwtUB2Ul1EJMd0nBqLS8YlEKGzgAhZ2r+5hsVmb38DHWw113iqnrGSgremJA
         PljpHRQdKRZRDUWNbqPq8R663G+7jupXGPLJz7SY4W1/vqMVGSOK+k3jyVD5MUaIJHic
         Pd6acQk46RmUBRN6pcXoVzQGVmGSdYEGJpg3siCoNTxiUZeAa2cctzQNT8tylI0Imfjl
         9gHr+cHUmyNWhjOBA8ujO5PoZLtN3/TVHeyurIsJvB7Ku9fK74kPvOkNpmGR+AAg+JE7
         2iMT0RsZSxwD0B9cA3F62Hbb2IDQORQ05z4GfrHClnJZc/4KxQr0y0dLjxVwupHqfVmH
         QYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=C1654xBNam3GabnEvpGXL+XFIaP0dyr/6kE1wllO6LlAObvR7cjv6Oz2G9p/6/KOg/
         QXX9uY6frSfWLKPjx2TF0lzumDVF1WyOx7xjP3GeqBBCJzFfMcoXIhs258IF+aw+XeiP
         R1Aoe8YjLaps9TJ7b8fspllPsInWC/8PXCRAw5F4E+ECk11XE331t/LnsF1JcNpOxvQH
         VKoK9eJ7glL/8sLXTCAD0PCk8HW5kcDrsyNgTbjgoKUAGU6x2X+kpI59lM6M4P1D6T7s
         AMwoNm6YqaEW4JZ5QqCJYWfF7iuSpc84wxz72uVNAR4o74zz9Bhrtu/fbqo4J1xyUvbL
         J4jg==
X-Gm-Message-State: AOAM533qvEm4pxeawTYkfC4IIN5UeqzrGIa15wVYkS0JBe1ffZ6vSPds
        OeNiyy7OArkua6EWA+YeaB+WJw==
X-Google-Smtp-Source: ABdhPJxFtczxqzZSasyWl6Efyuq/Lsq4Dj9LUh4RHYrT5mfp4m6j2c/6HjXjX17HJP6Nrx8qMZaMiQ==
X-Received: by 2002:a05:600c:1d92:: with SMTP id p18mr1779690wms.93.1644614419749;
        Fri, 11 Feb 2022 13:20:19 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id x5sm14276017wrv.63.2022.02.11.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:20:19 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/8] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Fri, 11 Feb 2022 21:19:54 +0000
Message-Id: <20220211211959.502514-4-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211211959.502514-1-caleb.connolly@linaro.org>
References: <20220211211959.502514-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
PMI8998 and PMI8994

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.35.1

