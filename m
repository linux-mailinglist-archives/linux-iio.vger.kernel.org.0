Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B036918D38A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 17:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCTQFl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 12:05:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51590 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCTQFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 12:05:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so7100051wme.1;
        Fri, 20 Mar 2020 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwCmGDqsEh9XOKRvHr9se8XJIEtfRxaXZTs5ZhiqEL0=;
        b=nfq5IR3I5y/CtEhmWS4dAo4T71K0TWyauykhZfx604NbduITMZ29zsKGtucCFIlUy1
         Q8bFx8vUanJPEFejhDya8vC5Z5VS30ELCRDBEBhgv0MRh+1c0q/RF7MgCCydrM0INFMI
         yFMuhBmtNXpPpTS6PkmWzYJ/og4Aw1JnkduW0XONr+buoN5T9bmJpkW4rxbzdpjWIpCm
         hs4TTCTz83aoDF6S37IVNOHNL8sBYU2MBW8Inox2UOs7V7k8nqhwMpNDN/8rbKhoY3QA
         7+KXYlw/BJJxMCm943TvaoN35DwReqhAWDaRAD4HF4YrxSVd+rPx88CJVmhxGxKcPJid
         MoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwCmGDqsEh9XOKRvHr9se8XJIEtfRxaXZTs5ZhiqEL0=;
        b=Lg0gvL5LwUMvmd7PIXQ6ZUulWFl2TGGeAzCYJlkXAoljUTgRugEhoqE48ZZZ5Yb8jk
         wHbx+6QIZrrmwahfi9WZX3Cvj/hvv4RWAY7uz0Ps59rOR0GmwA+Gubtj8t+UGuC6Mnv4
         BG9BEfisOg7dloGVxA1BnrKz+q2CqgCBUK858+kEQr6Z2GQCQejfB8YlXZ8bzxmuCAxz
         X8br7X7My0eoKvIH+sVTvInJN4XUVI6ZBqLg2ETfScaNdDc8UcMQ7WZdhnwAU35TL/Ob
         b+dheY8Gp5aG4ZWao9GkQBap5YLkk0Poryks22dvS8wPyqQS8QVk9o2uyUqLVfh8fdbM
         YPFQ==
X-Gm-Message-State: ANhLgQ0e4XKkudUsn8yKOGQXMaxAp5j5P2uxFDuoNv/DUUodt81jdu5p
        o01VN1RJbbH4utG1sSgA4kChcZOK
X-Google-Smtp-Source: ADFU+vuN/to9EqmHpQqvUDQkiydTx44sr67zS0wADgQ5jKmk8fFfOdAb/meCqrmz1yRsb+YuQb5ahA==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr10505879wma.182.1584720335366;
        Fri, 20 Mar 2020 09:05:35 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id k3sm8348895wro.59.2020.03.20.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:05:34 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: dac: AD5570R fix bindings errors
Date:   Fri, 20 Mar 2020 18:05:31 +0200
Message-Id: <20200320160531.23732-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320160531.23732-1-alexandru.tachici@analog.com>
References: <20200320160531.23732-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replaced num property with reg property, fixed errors
reported by dt-binding-check.

Fixes: ea52c21268e6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../bindings/iio/dac/adi,ad5770r.yaml         | 77 ++++++++++---------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index d9c25cf4b92f..d1755dbc1a41 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -2,7 +2,7 @@
 # Copyright 2020 Analog Devices Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/bindings/iio/dac/adi,ad5770r.yaml#
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5770r.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analog Devices AD5770R DAC device driver
@@ -49,83 +49,84 @@ properties:
       asserted during driver probe.
     maxItems: 1
 
-  channel0:
+  channel@0:
     description: Represents an external channel which are
       connected to the DAC. Channel 0 can act both as a current
       source and sink.
     type: object
 
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          const: 0
 
       adi,range-microamp:
           description: Output range of the channel.
           oneOf:
-            - $ref: /schemas/types.yaml#/definitions/int32-array
             - items:
-                - enum: [0 300000]
-                - enum: [-60000 0]
-                - enum: [-60000 300000]
+                - const: 0
+                - const: 300000
+            - items:
+                - const: -60000
+                - const: 0
+            - items:
+                - const: -60000
+                - const: 300000
 
-  channel1:
+  channel@1:
     description: Represents an external channel which are
       connected to the DAC.
     type: object
 
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          const: 1
 
       adi,range-microamp:
           description: Output range of the channel.
           oneOf:
-            - $ref: /schemas/types.yaml#/definitions/uint32-array
             - items:
-                - enum: [0 140000]
-                - enum: [0 250000]
+                - const: 0
+                - const: 140000
+            - items:
+                - const: 0
+                - const: 250000
 
-  channel2:
+  channel@2:
     description: Represents an external channel which are
       connected to the DAC.
     type: object
 
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          const: 2
 
       adi,range-microamp:
           description: Output range of the channel.
           oneOf:
-            - $ref: /schemas/types.yaml#/definitions/uint32-array
             - items:
-                - enum: [0 140000]
-                - enum: [0 250000]
+                - const: 0
+                - const: 55000
+            - items:
+                - const: 0
+                - const: 150000
 
 patternProperties:
   "^channel@([3-5])$":
     type: object
     description: Represents the external channels which are connected to the DAC.
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          minimum: 3
-          maximum: 5
 
       adi,range-microamp:
           description: Output range of the channel.
           oneOf:
-            - $ref: /schemas/types.yaml#/definitions/uint32-array
             - items:
-                - enum: [0 45000]
-                - enum: [0 100000]
+                - const: 0
+                - const: 45000
+            - items:
+                - const: 0
+                - const: 100000
 
 required:
 - reg
@@ -150,34 +151,36 @@ examples:
                         vref-supply = <&vref>;
                         adi,external-resistor;
                         reset-gpios = <&gpio 22 0>;
+                        #address-cells = <1>;
+                        #size-cells = <0>;
 
                         channel@0 {
-                                num = <0>;
-                                adi,range-microamp = <(-60000) 300000>;
+                                reg = <0>;
+                                adi,range-microamp = <0 300000>;
                         };
 
                         channel@1 {
-                                num = <1>;
+                                reg = <1>;
                                 adi,range-microamp = <0 140000>;
                         };
 
                         channel@2 {
-                                num = <2>;
+                                reg = <2>;
                                 adi,range-microamp = <0 55000>;
                         };
 
                         channel@3 {
-                                num = <3>;
+                                reg = <3>;
                                 adi,range-microamp = <0 45000>;
                         };
 
                         channel@4 {
-                                num = <4>;
+                                reg = <4>;
                                 adi,range-microamp = <0 45000>;
                         };
 
                         channel@5 {
-                                num = <5>;
+                                reg = <5>;
                                 adi,range-microamp = <0 45000>;
                         };
                 };
-- 
2.20.1

