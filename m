Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0335F3ECB6B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhHOVfN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhHOVfK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 17:35:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04295C0612AF;
        Sun, 15 Aug 2021 14:33:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e14so17139514qkg.3;
        Sun, 15 Aug 2021 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0aH1SD7OXnEr9T1hwKbROMxfg2WX5L/OYnwQ2B4t0M=;
        b=mhxCbxP2/8ivK3NagsAl2lanl7es0MROKSGCXez3o3t8qdK0lWyd9sbYY008OlQkdR
         CTvsqLgIR87Gd05yUtzAp8se3dycC9rdtOwzB7EoE9jpy18XXXbeItGdKW3535ipfi1Y
         CQeHeoHqgV0ldqQiDg47umx+qqV/WH3NI6lEq2mI1t9gBC3qkqfPEngYOyvbMZ2+WFWI
         GMC9v8vt3aX2b60uF+NtUd++8MoxNOD5eNLRuLiIi+DifaPzp2jVlhtfDg91WXRHnBG5
         xUwx8ZNEq5Un6gWTQDoTNbvMqgZqu2Mg1VfN4OeksR5DwTWEX1Jt9v4lysTbn3s7rcz3
         sO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0aH1SD7OXnEr9T1hwKbROMxfg2WX5L/OYnwQ2B4t0M=;
        b=Yaq4kEjCkl/pKKs6My2aJXjYPRcwHZxdrzRNe8jvVyjjFqnRvTSyD/RH5z29X7f+N9
         TYQ2WpC8gIEDv5q9vKjVqgIHJFv2FBRVyU0cVnsyErAkDBnrVyfAz+hvsUB2gBYC52ug
         F/HvjfLGyRJW0ZuwOMXCXFIjYACY35adGEjh1nOlXFxVSvmtZeuK9vjuW/9ssmFqdz5C
         5NJwzR6JeNPB+eHmDo8M//u4HUW6vcP6cmuBgvShFPr2pux+7b3AH4BhL3MabOgPGsZe
         c/+vh22xpgap0glEWrWoErzZvh2iwu85qQfj4hHRQnI/aQOQY9HYdthWC+bB3dQiaA1f
         oTeA==
X-Gm-Message-State: AOAM530Pgs87qwnahztnr49foJJPu8FtwvdxuXEG3q+kiKxYzkBQKPdc
        gjEIInqcITVJRT4VI4AmRuk=
X-Google-Smtp-Source: ABdhPJxTikpBxtv1w/quz377VuK9ztaVj/tvDsW1A3sf5g/iJAEy3f36VAMjs3kIEe8hUWLJTMcA4A==
X-Received: by 2002:a05:620a:702:: with SMTP id 2mr6231519qkc.7.1629063236223;
        Sun, 15 Aug 2021 14:33:56 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u19sm3870988qtx.48.2021.08.15.14.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 14:33:55 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 4/5] dt-bindings: iio: adc: ad7949: update voltage reference bindings
Date:   Sun, 15 Aug 2021 17:33:08 -0400
Message-Id: <20210815213309.2847711-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210815213309.2847711-1-liambeguin@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Update bindings to describe support for buffered and unbuffered external
voltage references selection, and add adi,internal-ref-microvolt for
internal voltage reference selection.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../bindings/iio/adc/adi,ad7949.yaml          | 51 +++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
index 9b56bd4d5510..0b10ed5f74ae 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
@@ -26,19 +26,43 @@ properties:
   reg:
     maxItems: 1
 
+  vrefin-supply:
+    description:
+      Buffered ADC reference voltage supply.
+
   vref-supply:
     description:
-      ADC reference voltage supply
+      Unbuffered ADC reference voltage supply.
+
+  adi,internal-ref-microvolt:
+    description: |
+      Internal reference voltage selection in microvolts.
+
+      If no internal reference is specified, the channel will default to the
+      external reference defined by vrefin-supply (or vref-supply).
+      vrefin-supply will take precedence over vref-supply if both are defined.
+
+      If no supplies are defined, the reference selection will default to
+      4096mV internal reference.
+
+    enum: [2500000, 4096000]
+    default: 4096000
+
 
   spi-max-frequency: true
 
-  "#io-channel-cells":
+  '#io-channel-cells':
     const: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
 required:
   - compatible
   - reg
-  - vref-supply
 
 additionalProperties: false
 
@@ -49,9 +73,30 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
             compatible = "adi,ad7949";
             reg = <0>;
             vref-supply = <&vdd_supply>;
         };
+
+        adc@1 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compatible = "adi,ad7949";
+            reg = <1>;
+            vrefin-supply = <&vdd_supply>;
+        };
+
+        adc@2 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compatible = "adi,ad7949";
+            reg = <2>;
+            adi,internal-ref-microvolt = <4096000>;
+        };
     };
 ...
-- 
2.32.0.452.g940fe202adcb

