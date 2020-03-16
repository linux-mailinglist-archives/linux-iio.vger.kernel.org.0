Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F58186F40
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgCPPvP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 11:51:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732072AbgCPPvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 11:51:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id y2so6383801wrn.11;
        Mon, 16 Mar 2020 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pi3izNgFJ8/Wn3g5uvUevM173nM22Xr7mDvSE98uAq0=;
        b=cJ48qA7kE7JybTdpcAoE5sbhxDypIhKl5l9q5MIIdwZKsWfNyHJ5L1qUrYRGPev5C9
         DkcNqHIvbeWOGDUceNXMPvzGqKDzs1qfVkhYXR6XI+VQfLTqnadj5CwooPEk9QQpsohq
         NE8Vik+Px9eSNpRKF56Q2QbpfKv8mx4Qt5PZ4ELhBYMbCYaZ3tb77xVGc5GWalYqLa09
         e/4BJDsl24eOPtmMP+cQjs/FFKi+T5VUk+fbvOElzcWfFmBk/Tny0bqG5NxRAJoafv6o
         6lq0ZPTSLKxWttOZ4/dEuFnD9/J3+jZmsDDnZiGdzMB9xFpwMKGx4DXKOqXYcHOnUh7x
         CG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pi3izNgFJ8/Wn3g5uvUevM173nM22Xr7mDvSE98uAq0=;
        b=bwjEmPlPPL90JYdSVJyOZS8eHFUG8kupZdYfbEniEaTVATsjV3zqwt7/NmwaLEaqY/
         XYovI/VZzo0Sv6p7bQzwJu8NFlKuI5P8hvWmvmm70XEPyQ6VTOQ8Td8uMRQSHTgXo1Sk
         +mt5vKtuqsuM415SnM30PIKD+GTP3quO5OK7L8huPqECRiZBEIuw5PsFrcdQWNvTSowN
         Rgb2cbUZKfvAnqjpamNLV4KbXHcx4tnIpnWyS7Qc2uJxgIahfn1/shK5VApyWl4cmDAd
         GnnOELNPgGI1IeDQi8b/dzEUJHL9uROOby9GhWqfJpFC37rk9J40CUYc/yIhUT9PtOW5
         LgYg==
X-Gm-Message-State: ANhLgQ3vDjYG9X6yvlfDNsy/oRXz11SzNF9aJWuXMS1SFi8C+hWuz913
        m5lKujcYsV2sAgVm2fXX5oQQL47O
X-Google-Smtp-Source: ADFU+vuRh4hYRRqz4FcdU201pTY3UL3+RG8kdekrT+sL3Qqb5ePPt24DY48+sk7sG4oPy8prX+tYTg==
X-Received: by 2002:adf:f504:: with SMTP id q4mr44851wro.28.1584373865545;
        Mon, 16 Mar 2020 08:51:05 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id n14sm153558wmi.19.2020.03.16.08.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:51:05 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v10 8/8] dt-bindings: iio: adc: add bindings doc for AD9467 ADC
Date:   Mon, 16 Mar 2020 17:50:35 +0200
Message-Id: <20200316155035.25500-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316155035.25500-1-alexandru.ardelean@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds the binding doc for the AD9467 ADC.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/adc/adi,ad9467.yaml          | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
new file mode 100644
index 000000000000..c4f57fa6aad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad9467.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9467 High-Speed ADC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital
+  converter (ADC).
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9467
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: adc-clk
+
+  powerdown-gpios:
+    description:
+      Pin that controls the powerdown mode of the device.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Reset pin for the device.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+          compatible = "adi,ad9467";
+          reg = <0>;
+          clocks = <&adc_clk>;
+          clock-names = "adc-clk";
+        };
+    };
+...
-- 
2.20.1

