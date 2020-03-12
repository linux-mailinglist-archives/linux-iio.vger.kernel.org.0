Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A958D182B49
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 09:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCLIfa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 04:35:30 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52921 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCLIfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 04:35:30 -0400
Received: by mail-wm1-f51.google.com with SMTP id 11so5074373wmo.2;
        Thu, 12 Mar 2020 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNZofgTlgtRg/4yW84auDEy6du4PpWb+UTGhqf35H2A=;
        b=va4iXLyY9zmvpLLro4/ZRFGPHnFqZu0tQDZr3sKiOXm4bV14kUUxmWxkdNBTUuvdSU
         UzIMFBBJOOYXNyxjzQ+pUCzG9oasQGljhhDxfdw2yyejtU++HHtvmAZZqkUvT6Uk/3zz
         GGn7LJqcGp9YaZvdOc34gTRmqjNNlJMEJpDeM3E4xYKUuQ8G1yyLipH5ugbDKg+TgHbD
         QkfKhxfyZe0ZhVyQsf5OVBJnKFugZZwhwOSkxU03DvdEHeO1Qrzv55NGHHlrflVZGrHH
         hCUK/j3hTagujT7MeBrNKhoVl8acN8cT/okyso9wQFE4hj1t58gfWEaKQW21VUAWq/CT
         tQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNZofgTlgtRg/4yW84auDEy6du4PpWb+UTGhqf35H2A=;
        b=ofyOYMjEpVPLFl0af1QD/Nr7j3f6GroU3LHvUalE6fpSVKZLYvzzDfj6O+VCs/iRhs
         tE/Qsd1B20uEH80SasjiDf/YdxXr0TwMFUD+wS1S1gHc45qKLJ966pytNkBe7wrb1qWg
         heMXDTYCsUIgtzTqE5BGHj87y90ynhDSVqDZ+PTVxSxzHmpSWcQAl5J/IHJWUXllmWkb
         o4BlflaE0pyj3sSyMDyh6AD345ucpXefZMm2hf78F4YFOo22cv9AcMBtaSM6oO3dzbch
         JvvJhIzGYv+gDhw6AEEWapl3qWi1MVL4jAgYLst7VD5pL7c9E0diO3P9a+ffNhVRAO5/
         AJyg==
X-Gm-Message-State: ANhLgQ2SDFio2WzB6Xx9pyaID6EkB8Lpzsq9RB/CdPReDWawB/fluxEV
        dN2ifaOvxigbDn2Q94Nm0dTbAR5hpWE=
X-Google-Smtp-Source: ADFU+vuUq/H+asVTTIOAM65v/YbN2x2oHe6N4+2Pbu6oRlz7M0Oyx54lPxBn6JkDX/pVBeOfl75jrA==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr3668464wmk.18.1584002127350;
        Thu, 12 Mar 2020 01:35:27 -0700 (PDT)
Received: from localhost.localdomain ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id 9sm11543334wmo.38.2020.03.12.01.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:35:26 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v9 6/8] dt-bindings: iio: adc: add bindings doc for AXI ADC driver
Date:   Thu, 12 Mar 2020 10:35:09 +0200
Message-Id: <20200312083511.28832-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312083511.28832-1-alexandru.ardelean@analog.com>
References: <20200312083511.28832-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds the bindings documentation for the AXI ADC driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/adc/adi,axi-adc.yaml         | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
new file mode 100644
index 000000000000..6bd80e241f40
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,axi-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI ADC IP core
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  Analog Devices Generic AXI ADC IP core for interfacing an ADC device
+  with a high speed serial (JESD204B/C) or source synchronous parallel
+  interface (LVDS/CMOS).
+  Usually, some other interface type (i.e SPI) is used as a control
+  interface for the actual ADC, while this IP core will interface
+  to the data-lines of the ADC and handle the streaming of data into
+  memory via DMA.
+
+  https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+
+properties:
+  compatible:
+    enum:
+      - adi,axi-adc-10.0.a
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    maxItems: 1
+    items:
+      - const: rx
+
+  adi,adc-dev:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A reference to a the actual ADC to which this FPGA ADC interfaces to.
+
+required:
+  - compatible
+  - dmas
+  - reg
+  - adi,adc-dev
+
+additionalProperties: false
+
+examples:
+  - |
+    axi-adc@44a00000 {
+          compatible = "adi,axi-adc-10.0.a";
+          reg = <0x44a00000 0x10000>;
+          dmas = <&rx_dma 0>;
+          dma-names = "rx";
+
+          adi,adc-dev = <&spi_adc>;
+    };
+...
-- 
2.20.1

