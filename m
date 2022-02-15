Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77AC4B7574
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbiBOQza (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 11:55:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbiBOQz3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 11:55:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6A119F3F
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so19427288wrg.11
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=meiTWsel7ZbC9L6PHG/OWYITdJiqi1rAGR7ERsKPwfaKJKXgXSK2zxPiKgIgrdR33h
         VwhbUwgNAbZVB9F1T8K1qVnpYDOCXCFTdUPO+ylLJrhejQokDV2lFL0lofKWsA0dhWVS
         e+3i9ZuZ2MMF4afrRXu8mAGs8g9jHvTjCXDG8j8GuoIatM+dZUNV/jT8q3hpq6CwEIGM
         lOc/fkX4ppRIaUQTFCTvJg8u9gZ86Y31Ev9SoSQ17pYWGZ6kAPOyeGLD+L4nSpHtG/rI
         du2TSMTylMKg5UcfmKfOoBceS7Kh+UgGdn4lUEzFUsP0tLBn3PbZiYOZOEkY0nvEFUQI
         0v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=DlYaiCWLes6uNb5dt/qweAqOZiPdDiWp+GBsX6uE2mG0Wn9FLZOO3cpYzTZvEZFQEp
         4/2zNoliL0ZE/WJpqq76OHifodxXedZQV5Dr6gi3DId65SYaxRX0GFtf5DolTfXIpL3a
         FK92TJEY18fomcHsUS2nEwIl/ieCSq9HikB96Kqy3pXa6dtEpxHsQRqewfsFX9T1ge1z
         NRrgwxgqhN6M2z1nrL7BlmSgypJ3o5UaIS//HK6zDqLsA5BhvS2pU46oRDDEFF3iUyei
         zAAyxJzO37NPq/aUoPmhD3IJo0lJkaik1pKTEWv2F+3zZXBCxr4qMXe+JREEB/znnY3x
         klRQ==
X-Gm-Message-State: AOAM531F00jgQX1Gyz90DwPAiCfOteDmh5Wf9k60ym2NcGzQ9AUM37bR
        e6jw8PxoxH1WSBxcY3GMK/AZ0A==
X-Google-Smtp-Source: ABdhPJwgLMF9CrvJtO+PUkLsT3YRgpq3NKokh3bHlDR5KlLuOxL26EByon4yDCZC/61gUBKU2O0OCw==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr4046453wri.478.1644944117406;
        Tue, 15 Feb 2022 08:55:17 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f14sm15373652wmq.3.2022.02.15.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:16 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/9] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Tue, 15 Feb 2022 16:54:51 +0000
Message-Id: <20220215165456.1205583-5-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215165456.1205583-1-caleb.connolly@linaro.org>
References: <20220215165456.1205583-1-caleb.connolly@linaro.org>
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

