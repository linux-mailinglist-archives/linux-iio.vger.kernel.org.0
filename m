Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63F03D83FE
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 01:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhG0X32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 19:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhG0X31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 19:29:27 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D3C061757;
        Tue, 27 Jul 2021 16:29:26 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t66so545047qkb.0;
        Tue, 27 Jul 2021 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RbNDDyjg8LeqN8Ur+WvNroKgulCjlo8nSzXgbnXYI8=;
        b=vaRhEYQ39gDSfch3qn2iuLemkQaknmC+8zgyx/ubcS0n6ABBL1MNuf5dat8e1/gBSl
         iRF9S0Qzq3puyKCzW+D9nIxSGc4ZbykIgk9NaiwtAca5Dctm842CnBqK0WFhQ7KEuvje
         f9gc3/i2cirNMuOJyHB5VQxk9v/KNjB0ZIc70Y2NX9jf1Vw9bjKmw5eRHFPIB0F2Hbg7
         Rq85B6rHf998IiK42ijaY02zdeNiO/BFcdSoS4zMaW/XMueoJP1mYrGKGwTGGOJAr38l
         Jo9k3LJl+jAz28lHReUjXyo4Bhebcsyn9iDkBoP6czy0AhKXnb00c7M2E1C1cAPOErhP
         nS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RbNDDyjg8LeqN8Ur+WvNroKgulCjlo8nSzXgbnXYI8=;
        b=PkZ6ozXk26ss3Zz9YwXq+QHqfet6+X/rRJEI1fyGwfLQ/1pM/ge+yEi5TRhVP/ZrDP
         nFUCrXxdbcx2/SQtcUpcX3WE91BQftVXo/oFckErDTToZp5rARSanSsoX4IiyPoUsIwZ
         VL1nD/GOwyxQmqn0/iWaCwTHzVOsH9JbUHtk8ejOV3WeD7KMnWCEepi/qOqJcneGIwF9
         mrl5uxVH+sBZXM12+fX5LhsCjwiD7LF+ANfIipWwBd3R9ar971ErAbXkxxw2Ze9GwjH/
         nsT73sBwfrHITFbNsDgYUtZLLUOPOo7mV62UHseIH0a3Bs1tiTjTh/ebru6XRrVwWCwZ
         bQ/Q==
X-Gm-Message-State: AOAM531IXlXmP0DEhxYNvEVEiuxMhhswQ8IUanpMny8g/nPTSRxwJ+Tq
        Uv35tVeUAh8h2d+av/HBiHE=
X-Google-Smtp-Source: ABdhPJziiBME7bS4VSI257P/dcqtPtRil5PVxBI3EhYJoqfl8wyL+BwRllE5xhS2JrCn65tWsoi6Cg==
X-Received: by 2002:a37:847:: with SMTP id 68mr25024897qki.112.1627428565270;
        Tue, 27 Jul 2021 16:29:25 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p188sm2380514qka.114.2021.07.27.16.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:29:24 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 4/5] dt-bindings: iio: adc: ad7949: add per channel reference
Date:   Tue, 27 Jul 2021 19:29:05 -0400
Message-Id: <20210727232906.980769-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210727232906.980769-1-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
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
2.30.1.489.g328c10930387

