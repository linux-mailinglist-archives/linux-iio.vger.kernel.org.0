Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C49363847
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhDRWu0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDRWuZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 18:50:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AAFC06174A;
        Sun, 18 Apr 2021 15:49:56 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id er3so7567839qvb.6;
        Sun, 18 Apr 2021 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mkWQYP2tGzlG7VW0VXji+4s6uOm8qB8eLk1wC3hc8NE=;
        b=n6L+IVRzZwoOD/u/etS3e7RW+7UFOV9SsT5UAxyOlNVdUrd3W39L6zTrIgK5vRThUT
         MW2KxuMTSgwlVekgym0FyLR7uyynpaHP9LDkCetx6oYa1Q0hCftOfYri3VK3V4VnYs/h
         yYD33HnrQ4rmnF7q5wyZE6jz8kuZ1GjhRT8sTynSjhlnYW/FLEpGlAJoZFMIvH6xFP+K
         3RvEaja067fgjUShRTisjmglnzEA4uLGfkF4b5fUf7Z6+GTHtk6ViocGXxynfwMX7pog
         rqSeIR5I9aXIguYMstjrssUfHwj1Zob0owOjXNTuswrUkSwOf0uNH+bCtFyxKV+Yrzfx
         yXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mkWQYP2tGzlG7VW0VXji+4s6uOm8qB8eLk1wC3hc8NE=;
        b=m5n5406grUxA+6p6lAolFY6mje/xSP40MIh8e/EluUvCCf/1dx9BrS0Ncm8R03vZsh
         oo6KuhsE8+6NFPmc3FhaDzuJbCo8Mtqq2C3SXFM0Dz8L4pD2EABNf2fBdChe7X+H/rQm
         APHqQCKAysAfce5vS89yWsaDvmbLC7bul/UVbp2XSCMA10Qj6oRa/z0o9NQf24JDSgke
         MT/9JTgrZtml+W5yrZynPzrGd068crGWIRIEBxPcn+X5EJpEfs+1XGuoiNBtng39yFu5
         yA+ESyKWi9rztfmBuHRfr3oc/7lYha5nnll/xeP77Q8ZFiUTasefBi0DBsbROvIeCNFQ
         GYdw==
X-Gm-Message-State: AOAM5306ToQ3vjwxRhh4yVKCHEIUZIniAfq2bWyjYB8UgEew50Tp8jiS
        5y9LhaK7NjCMbGlloH6YIBAqxyVIpzTJdBsl
X-Google-Smtp-Source: ABdhPJz/43wwZq2AVnaKseGvzyK3m7Ljh2nMRkBjdBwshuNUT9BI1KU/XZarclwYW/XmFcW7HbFAJw==
X-Received: by 2002:a0c:be92:: with SMTP id n18mr18993119qvi.31.1618786195941;
        Sun, 18 Apr 2021 15:49:55 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1003])
        by smtp.gmail.com with ESMTPSA id f22sm1225081qkm.134.2021.04.18.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 15:49:55 -0700 (PDT)
Date:   Sun, 18 Apr 2021 19:49:51 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: staging: iio: cdc: ad7746: add binding
 documentation for AD7746
Message-ID: <54a9eaeaa42d47037b2a07bd933e6dfade745d02.1618785336.git.lucas.p.stankus@gmail.com>
References: <cover.1618785336.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618785336.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding documentation for AD7746 cdc in YAML format.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---

A minor note about the adi,excitation-vdd-permille property. Jonathan
suggested the name to be adi,excitation-vdd-milicent, but I was unsure of
the milicent naming. With a quick search I found out that the common way to
call a thousandth is 'per mille'[1], but I didn't find any use of it in the
kernel documentation. Any thoughts about it?

[1] https://en.wikipedia.org/wiki/Per_mille

 .../bindings/iio/cdc/adi,ad7746.yaml          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml

diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
new file mode 100644
index 000000000000..a2a7eee674ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/cdc/adi,ad7746.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
+
+  Specifications about the part can be found at:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7745
+      - adi,ad7746
+      - adi,ad7747
+
+  reg:
+    maxItems: 1
+
+  adi,excitation-vdd-permille:
+    description: |
+      Set VDD per mille to be used as the excitation voltage.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [125, 250, 375, 500]
+
+  adi,exca-output-en:
+    description: Enables the EXCA pin as the excitation output.
+    type: boolean
+
+  adi,exca-output-invert:
+    description: Inverts the excitation output in the EXCA pin.
+    type: boolean
+
+  adi,excb-output-en:
+    description: Enables the EXCB pin as the excitation output.
+    type: boolean
+
+  adi,excb-output-invert:
+    description: Inverts the excitation output in the EXCB pin.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad7746: cdc@48 {
+        compatible = "adi,ad7746";
+        reg = <0x48>;
+        adi,excitation-vdd-permille = <125>;
+
+        adi,exca-output-en;
+        adi,exca-output-invert;
+        adi,excb-output-en;
+        adi,excb-output-invert;
+      };
+    };
+...
-- 
2.31.1

