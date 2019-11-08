Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1EF4D99
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 14:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfKHN4Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 08:56:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33263 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfKHN4Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 08:56:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id 71so5346610qkl.0;
        Fri, 08 Nov 2019 05:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gCAeybLe0NU7m7647n7l4SIquRQF/E2OQ7kqEsPTDCo=;
        b=UdIr02TwSKfPv7e3SZdwnZqpS81eX5D5cFK3hR/Uq4UgO7WQksLY2taK7FB4KajQnm
         agMhDj6xHm7g9ihSTvl7hj8GAx7aMCbearL3y0rbavW92GfCo5/biU+tm45l6U1yV3WQ
         OqmIVF4ItMrdieimGqS/efCPtV9OqKPgjVZ373HNwAR2aPVE1AATihNJo+pzdy0X2ANB
         z4F7B9w8bFI4xeTRc6f8BfJYkwHiKyFuDFFHPzT/k+7nyjYSjP6cFdHiSjJsjiOtG4Te
         UJlLDJX0NFWWy5lbD0VgGZ1u2ZoSkvhpzQwRPIsnz0Z+Cd3dGSoMLBrxpAnf8XJykUIk
         eqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gCAeybLe0NU7m7647n7l4SIquRQF/E2OQ7kqEsPTDCo=;
        b=dq5ob1wphPCB2GWghWJoinQbQ6v65vTmJFqaa2JFBsGzkV6ClCyqzylTXy5BeJh34j
         6bS2+OeqZq2xpDFUPrae6xlANPhlHBoJCif34FNtBSEdguEgjzIjFxH6+5Dm3SCTZA2O
         RijbFv9JJ4ibKpe9ZEYcCImnxBXKf3uLzPK7lR5wJK3VW3Nfn/UYkzs8BQX9oVGJdd0T
         M2jhWiSbk9ekbHLpki+6ORQmI8vgx5TFggp3m+KAOuVZXWb+vrw1atjtvDlwnjlfuvUX
         /oC8wihLxdPS0C2tw89EoPA4k7FIX+8eKNW0uIEd96rodGIFxknsXITjXve9QtNrzdqm
         oEyg==
X-Gm-Message-State: APjAAAWJHyqwCfgZAj1rjl5PjA961lBMaMFJj5sJoJ6YaqnvSNJwrHnJ
        H1Y0LixNPLtPKLuXAhJM520=
X-Google-Smtp-Source: APXvYqwz6uCw0d2ZWvQV7FHEvdst3SlTAX5suY795WniLDYHJ5j5ICzRMoa1G88Pnd4MDGI5CkWjzA==
X-Received: by 2002:a37:8b03:: with SMTP id n3mr6571831qkd.493.1573221375073;
        Fri, 08 Nov 2019 05:56:15 -0800 (PST)
Received: from smtp.gmail.com ([2804:d43:422:3955:b4df:7a81:96e1:236e])
        by smtp.gmail.com with ESMTPSA id o17sm509058qkg.4.2019.11.08.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:56:14 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:56:09 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
Message-ID: <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
References: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a devicetree schema for AD7292 monitor and control system.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Changelog V3 -> V4:
- updated SPDX identifier to GPL-2.0-only
- changed maxitems constraint on channel property

 .../bindings/iio/adc/adi,ad7292.yaml          | 104 ++++++++++++++++++
 MAINTAINERS                                   |   7 ++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
new file mode 100644
index 000000000000..b68be3aaf587
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7292 10-Bit Monitor and Control System
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
+
+description: |
+  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
+  Temperature Sensor, and GPIOs
+
+  Specifications about the part can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7292
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: |
+      The regulator supply for ADC and DAC reference voltage.
+
+  spi-cpha: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+
+patternProperties:
+  "^channel@[0-7]$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+      See Documentation/devicetree/bindings/iio/adc/adc.txt.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 8 channels numbered from 0 to 7.
+        items:
+          maximum: 7
+
+      diff-channels:
+        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+        maxItems: 1
+
+    required:
+      - reg
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad7292: adc@0 {
+        compatible = "adi,ad7292";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+        vref-supply = <&adc_vref>;
+        spi-cpha;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0>;
+          diff-channels = <0 1>;
+        };
+        channel@2 {
+          reg = <2>;
+        };
+        channel@3 {
+          reg = <3>;
+        };
+        channel@4 {
+          reg = <4>;
+        };
+        channel@5 {
+          reg = <5>;
+        };
+        channel@6 {
+          reg = <6>;
+        };
+        channel@7 {
+          reg = <7>;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 32bf5f8116d0..5d00e871c4c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -813,6 +813,13 @@ S:	Supported
 F:	drivers/iio/adc/ad7124.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 
+ANALOG DEVICES INC AD7292 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+
 ANALOG DEVICES INC AD7606 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.23.0

