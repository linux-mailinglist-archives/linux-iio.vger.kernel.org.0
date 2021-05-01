Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD04E370732
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 14:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhEAMd0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 08:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhEAMdZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 08:33:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B4C06174A;
        Sat,  1 May 2021 05:32:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id o21so514898qtp.7;
        Sat, 01 May 2021 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h5m2DTNHNLXWhh9S7FYl1vIhEyv66QJBu88/urj17ag=;
        b=jH0zM08ZNJuiKXKb9FZ53kmA8gS8CfJHQixQZxVpZXgjyNyBZ222OG7ApFh9IVv6f3
         At6T7IWsa0ZZ5q46SG6QoHh6uaXzLcUlcrUOpYfblMFDdZcofKps8P7yBvXD7Mthx8ni
         /WyOpfbWURTgxjOyCwiDVDEc4j3qdPP6O2SoeB3cM186mXxjRAWHGUsIFQ2n+s6cGArK
         OI4QiafPUe9Bjy6IGjJmG8B5aTeF3OPfZch+de74NK/+wuk4TxtrWrPxfw5ysmXkQBmV
         oBcmBB7CGlSRIK1VS//WXO16iKlnfj+K+RUtr9LwanpXdVoQ/LU+jLz+YSXyKDsX3BFK
         0pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5m2DTNHNLXWhh9S7FYl1vIhEyv66QJBu88/urj17ag=;
        b=dYFklDLeIbWfW+rMOmqrsCLbdg1HnH7rpcDBGLyotbAdavUyqUATOOY6i8ge4X3seK
         GtWyvnBD0YkXJAY7lFhHjwm4bYoiDPm4X7NW9rPGiS/Bu644HT5fX8KHBjdZUOfTIMYH
         j+pMRTqu+vdvCpXpeLMx1Pnf6TT14DpJdr/uC7BYVPMYexIef2wIiKsbxGXOAld5uz5K
         syBaIvKbBhhJxGLYpDVCEHHH7y5/O0XSe6foPsYXccVnakiO8scP7kep5mttAxo2gMqE
         AVlChEdE86co+HDI4Leachaha788n25tvUNQkplB0QOTiEfGYuapzJ7XjDiHedUGzEq/
         HGEQ==
X-Gm-Message-State: AOAM532wTm3vOeUJe433JnO9dNxiEal+MLR2CVYYIqNMfnu0gYMXUnVB
        mtEXcQ8Ejzp0CeHj7mHHqSXPZI3yA+QwQssO
X-Google-Smtp-Source: ABdhPJxCCM53wefrHv5mgx7CgvblhDV8G4zFxgNm+fXc64Ol4pyPPnxxbN7xBNlcs8u+4RlhAVAdSg==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr7330715qti.91.1619872355283;
        Sat, 01 May 2021 05:32:35 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1001])
        by smtp.gmail.com with ESMTPSA id 66sm2839139qkh.54.2021.05.01.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 05:32:34 -0700 (PDT)
Date:   Sat, 1 May 2021 09:32:31 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: staging: iio: cdc: ad7746: add binding
 documentation for AD7746
Message-ID: <2c2f4d486a94e0740e112bfac0d9306bdb7ea69c.1619841953.git.lucas.p.stankus@gmail.com>
References: <cover.1619841953.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619841953.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding documentation for AD7746 cdc in YAML format.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 .../bindings/iio/cdc/adi,ad7746.yaml          | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml

diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
new file mode 100644
index 000000000000..a02036ef9e8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
@@ -0,0 +1,77 @@
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
+    description: |
+      Inverts the excitation output in the EXCA pin.
+      Normally only one of the EXCX pins would be inverted, check the following
+      application notes for more details
+      https://www.analog.com/media/en/technical-documentation/application-notes/AN-1585.pdf
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

