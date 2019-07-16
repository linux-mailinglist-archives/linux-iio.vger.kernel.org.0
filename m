Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAF6B07B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 22:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfGPUd3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 16:33:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45891 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388778AbfGPUd3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2019 16:33:29 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so42119238ioc.12;
        Tue, 16 Jul 2019 13:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seqk9J0ooH5AhAm3aq6IH0gSWsrdcbTHmh1T2bCLVs0=;
        b=iO7xZLvdujsw4yCLGZgY5fwtmKWPf96vvy+UUw3uYI/ScB+MkzurjxUIxmPMWq18/V
         pxh2lWqLU+kUO+Wc9a3HHvOQVNWFlSDLie1bvawujnRwA3I5SvTcEvue/KqfDdDMRRBP
         zMJ/zpbCHqsBB98KvqoAbieaZwh+zWyZgSr2LllUyCqDw4LHTIDGjO1iUK2iVZDHUB7J
         /WvpIbNGWkKTKR5RWTFipvmpN0dCY6A/YaIG61iDVF4pXe8DlzQMQhh8lmnyjAHdXRDX
         3RyxW/dyJsmIuQhf1jEKVdfV9/LCYR20p1OuQfyQfHsvNeT0BAjz19f5TN9Wkagw+nBq
         KQzw==
X-Gm-Message-State: APjAAAXl8ljzVdEKhBQ1PPcONkggFOKIsiPv3U9AKA1bSrtGxF7Lx+W9
        tFG24YFunKw8sIgSj51B0RXr0m0=
X-Google-Smtp-Source: APXvYqyk2BtdP2A4xOeszThjIfHuGMgL0fUlwZQQzvqXZ2B4o/DIcZpgpjc6LXc9Hnl2+laUR/M1Jw==
X-Received: by 2002:a6b:dd18:: with SMTP id f24mr133937ioc.97.1563309207583;
        Tue, 16 Jul 2019 13:33:27 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id k2sm16605168iom.50.2019.07.16.13.33.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 13:33:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: ad7124: Fix dtc warnings in example
Date:   Tue, 16 Jul 2019 14:33:24 -0600
Message-Id: <20190716203324.12198-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716203324.12198-1-robh@kernel.org>
References: <20190716203324.12198-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the conversion to DT schema, the examples are now compiled with
dtc. The ad7124 binding example has the following warning:

Documentation/devicetree/bindings/iio/adc/adi,ad7124.example.dts:19.11-21: \
Warning (reg_format): /example-0/adc@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)

There's a default #size-cells and #address-cells values of 1 for
examples. For examples needing different values such as this one on a
SPI bus, they need to provide a SPI bus parent node.

Fixes: 26ae15e62d3c ("Convert AD7124 bindings documentation to YAML format.")

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/adi,ad7124.yaml          | 71 ++++++++++---------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index cf494a08b837..9692b7f719f5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -114,42 +114,47 @@ patternProperties:
 
 examples:
   - |
-    adc@0 {
-      compatible = "adi,ad7124-4";
-      reg = <0>;
-      spi-max-frequency = <5000000>;
-      interrupts = <25 2>;
-      interrupt-parent = <&gpio>;
-      refin1-supply = <&adc_vref>;
-      clocks = <&ad7124_mclk>;
-      clock-names = "mclk";
-
+    spi {
       #address-cells = <1>;
       #size-cells = <0>;
 
-      channel@0 {
+      adc@0 {
+        compatible = "adi,ad7124-4";
         reg = <0>;
-        diff-channels = <0 1>;
-        adi,reference-select = <0>;
-        adi,buffered-positive;
-      };
-
-      channel@1 {
-        reg = <1>;
-        bipolar;
-        diff-channels = <2 3>;
-        adi,reference-select = <0>;
-        adi,buffered-positive;
-        adi,buffered-negative;
-      };
-
-      channel@2 {
-        reg = <2>;
-        diff-channels = <4 5>;
-      };
-
-      channel@3 {
-        reg = <3>;
-        diff-channels = <6 7>;
+        spi-max-frequency = <5000000>;
+        interrupts = <25 2>;
+        interrupt-parent = <&gpio>;
+        refin1-supply = <&adc_vref>;
+        clocks = <&ad7124_mclk>;
+        clock-names = "mclk";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0>;
+          diff-channels = <0 1>;
+          adi,reference-select = <0>;
+          adi,buffered-positive;
+        };
+
+        channel@1 {
+          reg = <1>;
+          bipolar;
+          diff-channels = <2 3>;
+          adi,reference-select = <0>;
+          adi,buffered-positive;
+          adi,buffered-negative;
+        };
+
+        channel@2 {
+          reg = <2>;
+          diff-channels = <4 5>;
+        };
+
+        channel@3 {
+          reg = <3>;
+          diff-channels = <6 7>;
+        };
       };
     };
-- 
2.20.1

