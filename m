Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1D4CE21B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 03:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiCECNz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Mar 2022 21:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiCECNy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2022 21:13:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDAC1C665E
        for <linux-iio@vger.kernel.org>; Fri,  4 Mar 2022 18:13:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b5so15107613wrr.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2022 18:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=NZ1BlzI4zfSoKVCD/bcoVJWdLwO+Ld1Gbst8/YayG375V+ItoVLuo/iC8tQIiBbhwa
         vnR5voO3C/PfQkW8pmP9H/trVk4y1nHKzUfwNk/MTemoaJ81xiN+VTE7YBlHH16mHJIx
         GHO16aA7IMF2wF3GVM5ePtGto2R1mN1EQfEFp62mMNU/sqHpgYFT0ijU8nZj0oCcFdiu
         E0ab9wOM4h0DeBmYGIW0KViBwdiwnc7p4UhqTSHdo/Ur07wCNf4tQe+22eVauEjYVR+v
         x1ayS07vhfmrGHztbfIQE/xnqwUS98QuWPMDrE269E4HnrvyUaw3OUwahEd+GcpM4o7K
         vlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=n+Sn0++7CvVy6TJFJESz7NhDydalJqjQxZEpaigmWir3/jVSqvAYK7Jh8pNs3XmSCO
         yBk5NGgMZWh5PrS77BwMVeChQTb3C+xZekusF7ch4UmHfBErKZBgmRJsP1RUxgKaSfoT
         ITY4+X+HZm02W/htdt+IKxnuOpIVGpmyG8hNJie4Ba2TUp92EVoNpyJWCuQcvOMTqDzk
         gga7plDO8PE7gIsT//aa6mnCv2z0yO+Q2i9YeqjB3eDj7oMzl/qFg564CwhIg2uJtZ4+
         ekPekQAQ9ez/vxanK/aYDBPL8h7aXboAwKvsxGwGPSUkPbV7n6i24VBz1+wdR65xYq7a
         lIZQ==
X-Gm-Message-State: AOAM530h8ZdsI9xCq7Isi/fudit2D/MfRpFFKr+6ItZUbde2k5i9DmRz
        8BqG1e4EvQ1TxrSohHg2DZEFAw==
X-Google-Smtp-Source: ABdhPJwoucFAZ5IFWHo9oSMES8xCO1aAOGkWH5CXbW+PVyqhenjH572K8dMvZ+YZt0tp/iKaWzzJxQ==
X-Received: by 2002:a5d:47c5:0:b0:1ef:f2e8:11fc with SMTP id o5-20020a5d47c5000000b001eff2e811fcmr924295wrc.109.1646446383718;
        Fri, 04 Mar 2022 18:13:03 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k10-20020adfe3ca000000b001f0329ba94csm7932589wrm.18.2022.03.04.18.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:13:03 -0800 (PST)
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
Subject: [PATCH v10 4/9] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Sat,  5 Mar 2022 02:12:42 +0000
Message-Id: <20220305021247.1020122-5-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305021247.1020122-1-caleb.connolly@linaro.org>
References: <20220305021247.1020122-1-caleb.connolly@linaro.org>
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

