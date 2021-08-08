Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24FD3E37E1
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhHHB5y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 21:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhHHB5y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 21:57:54 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD466C0613CF;
        Sat,  7 Aug 2021 18:57:34 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id em4so7219276qvb.0;
        Sat, 07 Aug 2021 18:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=615kMpMCOocH22xvYuBl/egorml5TWflMxM6T2l3ME4=;
        b=RZpZDh5Nf9S1QhoBOJRE8JjpsRm34WH+ogmJ+Ec9B+JOVOmXpaGCu1340y7cvwxq3j
         PnzjiIiivp45gBNCXI41aIWGGEfy/3FBQgM4uwc6EIPLbcx+bkBt4f4mYk0zP8giEbYP
         9TmrNFvhfi61h6tT5YwBAMU5IxOv+eyh399hLa63qWY6FWwmItvffpHOvghR4E0ecBvF
         7TiRLzBlc8vapDoZIk4uhZ54TReoLhQBxWjbHCSFfIH/Ek/qEDfd24En0H2XAf3/drQi
         qtz2RsCWb7lQ5yTl9z+/jNvwT9QmimqxjneZRT4yWqWa11aTZsbDpVSg+YBF3kr8a4of
         cw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=615kMpMCOocH22xvYuBl/egorml5TWflMxM6T2l3ME4=;
        b=aBgbz1O0p3mN8thGLd6+3P/YjgAWdLqrRWeIDTBoixQEAbFqavyyNX3xu4pSyQOQwJ
         lb4K/UyIMiMo+MREWYWtvrvGkD2gCE+ziamUIKXVYK7fGuDH5ybnl/+7e/g6pIU8oqeX
         Nxay9OBF0IqjM9xIE1qHFQCDCXs7HOpT4hvwwDbboFPoDz9t/ipKo0BQNNEtFhKGeTmW
         KrDYESMRmmWURLIThqtFzMsI2v6VY0IP+E+1OL1LlSxw0JHflmQy9GZ0mw/XLP9T2Sjn
         dLmBl+Utjdaf1Jaiz5NQrDvVCtAym8F+EDyAb5We9WluvUJUFJsMvpWVQvqkIywGSbXf
         AtKg==
X-Gm-Message-State: AOAM533ktrOiD8ZiN3f4Wpx5eZpila/kzLgGOJ13wzEqq6E5oRuwlHDb
        m1j7AHTc5tu6aWjjfirfTVo=
X-Google-Smtp-Source: ABdhPJw9r9YoePEnovkVjBP6vSKTAZ8PqeNQVXkNc3+dfJQgL7PKXzZtslkEVdAEVDd9DEL/JmYOoQ==
X-Received: by 2002:a05:6214:1933:: with SMTP id es19mr170063qvb.42.1628387854101;
        Sat, 07 Aug 2021 18:57:34 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id k24sm1569612qki.11.2021.08.07.18.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 18:57:33 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 4/5] dt-bindings: iio: adc: ad7949: add per channel reference
Date:   Sat,  7 Aug 2021 21:56:58 -0400
Message-Id: <20210808015659.2955443-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210808015659.2955443-1-liambeguin@gmail.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add bindings documentation describing per channel reference voltage
selection.
This adds the adi,internal-ref-microvolt property, and child nodes for
each channel. This is required to properly configure the ADC sample
request based on which reference source should be used for the
calculation.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/adi,ad7949.yaml          | 69 +++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
index 9b56bd4d5510..893f72b8081e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
@@ -26,19 +26,63 @@ properties:
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
+
+patternProperties:
+  '^channel@([0-7])$':
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number.
+          Up to 4 channels, numbered from 0 to 3 for adi,ad7682.
+          Up to 8 channels, numbered from 0 to 7 for adi,ad7689 and adi,ad7949.
+        items:
+          minimum: 0
+          maximum: 7
+
+      adi,internal-ref-microvolt:
+        description: |
+          Internal reference voltage selection in microvolts.
+
+          If no internal reference is specified, the channel will default to the
+          external reference defined by vrefin-supply (or vref-supply).
+          vrefin-supply will take precedence over vref-supply if both are defined.
+
+          If no supplies are defined, the reference selection will default to
+          4096mV internal reference.
+
+        enum: [2500000, 4096000]
+        default: 4096000
+
+    required:
+      - reg
+
+    additionalProperties: false
 
 additionalProperties: false
 
@@ -49,9 +93,26 @@ examples:
         #size-cells = <0>;
 
         adc@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
             compatible = "adi,ad7949";
             reg = <0>;
-            vref-supply = <&vdd_supply>;
+            vrefin-supply = <&vdd_supply>;
+
+            channel@0 {
+                adi,internal-ref-microvolt = <4096000>;
+                reg = <0>;
+            };
+
+            channel@1 {
+                adi,internal-ref-microvolt = <2500000>;
+                reg = <1>;
+            };
+
+            channel@2 {
+                reg = <2>;
+            };
         };
     };
 ...
-- 
2.32.0.452.g940fe202adcb

