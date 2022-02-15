Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753A14B7727
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbiBORKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 12:10:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiBORKY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 12:10:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799111ADC7
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p9so12722342wra.12
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=q5K1OyvaYsOINgGfvSiQqSu6VbFtQjFkcNKc6vQ0TPyc6ylGrB7Z7szgzSS8aEBhOa
         k7+7r4zLNOaMBB8Ydscn9JDuTrQKFnmnVhVkD2+67vBodr2VySr8x1WGy2dQBGeh/lww
         znPHdyoP2oGTI6WSPWgtzdJSrUTo6KO7nOKoqNUl1Ew7jOxQKP8R8yQrCJzzjdUxmlot
         TH6e8uUBJ4/Yei2/GUzC4ICKHfW/j/g0EwXGQOWwLC0NVAfVIwFrFXUAp3flOhURZRTV
         Nju3uIVHkptaEZC0lxNRbip6Xwf6odDwETUOXGsbt5q8ulDpE/0KhGXM7ELE6fFxDl7Y
         nILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXhDDcjJdPDbZfpGFJmQRsA5lMP0BnPrEwgZzVXptZc=;
        b=t0BWLC2YJjwo/T6qUle5V4IiBzCB/Hv7KlsuCkr2DP/rPIz1ovgn0MyamNk59ariCq
         Mg4krg5VGQv0VhzLw8G2obO8xQafUnRkhKBtIyqAkQPkdw8kM7swQXmHR3MnSponySpQ
         94xOF4Tr85vluaTF5GO8780EDIut/do7YU1V9ktao+0ZGKYRpx/Jz4URFUztTdJhAPSM
         +4x5Icatax+vO4Kbuqo0FzkpMQ/qcl7LT0DC3vpJP7J/9igxUN83GNWtNZ1TEdF2kxlr
         0OKMSPVDEHgBkQmZolDVluIwPQb9HXpfa0tRP38Ob6bigi4GtlF3PitA/8KcjvFnK9v7
         DQpA==
X-Gm-Message-State: AOAM531Cd7Pz00pfbO5+rDgfZCR72gZqCIEFFAIMXyM6SX/JdlNJ6aFB
        zFfsHBGE1BX329oQo8Ju6VwLew==
X-Google-Smtp-Source: ABdhPJyV1Ikotpbp26m5NUUhQNx7DE9+PzwwpTxzHqmHkddhVMh0Ip1K8aekFgLxFWb5YzVHtkx1bQ==
X-Received: by 2002:adf:ea0d:: with SMTP id q13mr3939589wrm.191.1644945009289;
        Tue, 15 Feb 2022 09:10:09 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5sm15558474wmk.38.2022.02.15.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:08 -0800 (PST)
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
Subject: [PATCH v6 4/9] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Tue, 15 Feb 2022 17:09:46 +0000
Message-Id: <20220215170951.1233375-5-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215170951.1233375-1-caleb.connolly@linaro.org>
References: <20220215170951.1233375-1-caleb.connolly@linaro.org>
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

