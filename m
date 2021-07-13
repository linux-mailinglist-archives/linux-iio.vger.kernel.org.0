Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37043C6970
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 06:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGMEho (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhGMEh3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 00:37:29 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEDC0613E9;
        Mon, 12 Jul 2021 21:34:39 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 201so6267340qkj.13;
        Mon, 12 Jul 2021 21:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTZUe6lePqaiw1G9wbgvwq76zWCGlANz5kNfBk1PKF0=;
        b=Gk7Qg/56zPhOJqukqbmHlbVy1wDYjhJ0V3GXqS5Rb9RHRLzjccSJcXN+IodpmHi9JJ
         mYWzFpFLxpKzAVbEBjuRZQ7ubtRInDIy1sdnZS+5oIQN4Y03MGezTauNJXlivMM8hVqN
         Dou2+TjChLTehIhCAJdcWBRa/h6Kpu8TGDn6YkqY943AtJLSpYw32c4325lDa/x5digB
         x+NBIQ2XfQlkuJihehOmeqhuPFqTC1zsn4jLhqfL85DcVWJy1WuQAtf/g4n8zwLYGOrR
         YqO6lH5hTLde0g0dtdBTOL68f5knSVQGdPaRUVTwf0G5rnFtLlyrdA9J8WaHRrBa6YFX
         fzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTZUe6lePqaiw1G9wbgvwq76zWCGlANz5kNfBk1PKF0=;
        b=kfo520vrH18y68oVr4XhvaQJerT2pLUcY0B5op4J4R4A5nHCbWmPmwyr4BQw+tJfLp
         qaBQh+/+Wpim9lhEs8a1RQ3ROxSJOI5mYNAYIxUYcY38yojIAsphv0TPfBjxTVwLURwF
         f4aHgQoT5wvlfzGvx/1QOX2a0NHLOT2KnCIW/WTxIKbJxFBOqunlRgbrS31LjM4z7Teu
         RKfFxTmVKEi3/I2oZIxDCFcoo3NXLunHZQ0uVt0vL1AEeBO+HS4LfMvT5+fwSqZoQN1L
         STep1J4u+OTRkDPI5SJFiPd9csn+IL6Z4ilHcx6i9jCDaIFs4nWW54Y5CJl+pGQY/AU+
         qIvg==
X-Gm-Message-State: AOAM530sDNzFDFpbl362aDbdWfx2FoU4e+MWxoZWY1prRsrqyI9FtIGF
        0PgL7cCczjGBIopj0gK5GXU=
X-Google-Smtp-Source: ABdhPJyndypbts2s9Fsz4072+2DMx01IxlztrEy3T3IB1xS+NrGxRiHPhddvSI060Ux7gr4mjf6bpQ==
X-Received: by 2002:a05:620a:685:: with SMTP id f5mr426477qkh.148.1626150878899;
        Mon, 12 Jul 2021 21:34:38 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x16sm7311455qkn.130.2021.07.12.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 21:34:38 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 4/4] dt-bindings: iio: adc: ad7949: add per channel reference
Date:   Tue, 13 Jul 2021 00:34:25 -0400
Message-Id: <20210713043425.3321230-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210713043425.3321230-1-liambeguin@gmail.com>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add bindings documentation describing per channel reference voltage
selection.
This adds the adi,internal-ref-mv property, and child nodes for each
channel. This is required to properly configure the ADC sample request
based on which reference source should be used for the calculation.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../bindings/iio/adc/adi,ad7949.yaml          | 71 +++++++++++++++++--
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
index 9b56bd4d5510..18abba3b0b4d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
@@ -26,19 +26,65 @@ properties:
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
+      adi,internal-ref-mv:
+        description: |
+          Internal reference voltage selection in millivolts.
+
+          If no internal reference is specified, the channel will default to the
+          external reference defined by vrefin-supply (or vref-supply).
+          vrefin-supply will take precedence over vref-supply if both are defined.
+
+          If no supplies are defined, the reference selection will default to
+          4096mV internal reference.
+
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [2500, 4096]
+        default: 4096
+
+    required:
+      - reg
+
+    additionalProperties: false
 
 additionalProperties: false
 
@@ -49,9 +95,26 @@ examples:
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
+                adi,internal-ref-mv = <4096>;
+                reg = <0>;
+            };
+
+            channel@1 {
+                adi,internal-ref-mv = <2500>;
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

