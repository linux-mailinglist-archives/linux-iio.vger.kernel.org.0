Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B268C186F4B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgCPPvF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 11:51:05 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36733 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbgCPPvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 11:51:05 -0400
Received: by mail-wr1-f47.google.com with SMTP id s5so21919019wrg.3;
        Mon, 16 Mar 2020 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNZofgTlgtRg/4yW84auDEy6du4PpWb+UTGhqf35H2A=;
        b=l5fv644M5KTPiLp2EhOTSeqyhaqVXnP801VGzM0E6TXHMdHQqDjZmnK8YkyrMXh3v3
         vy+LofasGSCAlpqnMGi3sFRWgcP1VD+VCwGUFYoHyuFCwCscqEAbI9GDTC3keV1Z+B6c
         EeBtUDb5LPxg9mjc/sLSwJmsjcgAFT4BB1hN7+qRY6OQPjokAaqwSxxSpWPgLFumHa5q
         akQYX5/qPexVn732Qu2VHTRQMzpY9n9Fr0x+SLVPQYK91XDIfoSVONiNxm/phaNtmny2
         pW4Y5EQcE48po92TBKZz3RNxpVKvRBae7Uc//OULQn1iFGXyDIl5D1FpPbjqb9+/tGCp
         YK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNZofgTlgtRg/4yW84auDEy6du4PpWb+UTGhqf35H2A=;
        b=W1c2v0Fu22iqK9sdCVEuNcIsO1HVj+kNKy/3ZExKfgMVR/skXr4Im0DxUcdf+AEAA5
         jIfqWYcryvNQ8GNeiJFOzmF7P+UdEyMKaOxOHXzSdbyy65jALOLjooDBpGfMGu6I99TA
         VsdV7kFzWoucjCgJIB3O4tFJH5GPuGuKGNdvcLM1OF4rmCAEJPdXh6VVUoSvQv+suDOY
         ayN+vuixFgrnGzgyBsQ5yo6E+Nv3BS3cyYs3gaUt5hW1mA0Mc4Mvum0q6QosA81EmnR1
         lnPH4oJ4OP/H/tQw2NW5NfAzkxTrBuEp7YOCQlvEUQ/G/yownPgSQ6olVtXScCRHVfXn
         Yuqw==
X-Gm-Message-State: ANhLgQ2fKyKVSa64eJNByoqxpsrWKCpx2d1smpHBCamDdt+2hIQIFzed
        2Ldsz+vzSwIt8f91bxi+4InmeGrD
X-Google-Smtp-Source: ADFU+vtqe2sZDhyQzlmlhdoMo0f3Rl0a3Posy6jaxBOCQ5mVgKDRrRQkqAHvJ5okCjZF1J6f3lY7ZQ==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr35927365wrm.305.1584373862235;
        Mon, 16 Mar 2020 08:51:02 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id n14sm153558wmi.19.2020.03.16.08.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:51:01 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v10 6/8] dt-bindings: iio: adc: add bindings doc for AXI ADC driver
Date:   Mon, 16 Mar 2020 17:50:33 +0200
Message-Id: <20200316155035.25500-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316155035.25500-1-alexandru.ardelean@analog.com>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
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

