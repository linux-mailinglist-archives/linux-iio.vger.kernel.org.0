Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EA54B8AB7
	for <lists+linux-iio@lfdr.de>; Wed, 16 Feb 2022 14:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiBPNuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Feb 2022 08:50:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiBPNuC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 08:50:02 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53052A0D5A
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:47 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so4692857ejb.13
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=Scf6O2stTGdtVaPze+UWVzHErvnfXw/hwTZOH6LGyDS1BQjxEIFg8/ei7EMf9jrPYl
         ikSxGC46OVLYopRVFO0q21u40ExXX2VYtLohELUnFZtkYgPUhEQHYAKsfgjs4gp55cKN
         SYx1Ikw0wF/CpXtrRtQp0SmkzPhpTK9JTfHiZb26R3rVxXnAfgLJSHB98ZMsntxnmCu/
         3yPwHMQojHTt8q2CtTH6Gv82DZxRhIlNsGdcY9cZQP2ozDA7XP71dUttpzfRUSof1BpF
         tSO1s5+5Tkw6az/Ke48jwciQUe51Ul4zOZ/7Lg5cTwF0z6bGR11ZIj/gcLj6IR/vdry4
         9pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=AahjmoRUq3Ud8VryyMtv7v874+HkOylSJA1rC1UOcbOoaa7maFysesCQ1YnO35pvcR
         iBKCHdNiMlkskrYP0J6TRuc7t61FdPkM78TYttzd60qt/f2R66pL68L9/Z6A9LhULkUe
         H9amwFq9glf2sw7sKDDIfrqNBNR1bkFngKXnh0r3SbOgV6peeVuOzUvmsqy/Gup83JnO
         wUKTCYteq2FIGGzHmDu6UcWYchxdslJUnrnijQ9BdUiY7zQoy+K3898oxT4Qz72adGU0
         AuiVj39ajUXQrBhKvefp8gr2OuFaynOeJZm0uV3O/OAlAjd8LLgqIP6GpaZbZKcDTe1L
         rXxA==
X-Gm-Message-State: AOAM530y2GxT/eZsJ112ke+xXp342nslRqhqeQ5nnSKqjsmgCsgHwyye
        +E//YmCBJDSwB+M8kXBIYQyNuw==
X-Google-Smtp-Source: ABdhPJzQ6T0pXsCDlnLFumHk0k39T+GTyVy+bzJJkcuBUBmg+FmYeGa20YIXBxtb65uO9HnJLZ4j6g==
X-Received: by 2002:a17:906:c12:b0:6cd:795c:9803 with SMTP id s18-20020a1709060c1200b006cd795c9803mr2451608ejf.593.1645019386229;
        Wed, 16 Feb 2022 05:49:46 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id o20sm1711996edc.84.2022.02.16.05.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:49:45 -0800 (PST)
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
Subject: [PATCH v7 4/9] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Wed, 16 Feb 2022 13:49:15 +0000
Message-Id: <20220216134920.239989-5-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216134920.239989-1-caleb.connolly@linaro.org>
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
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

