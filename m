Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1682EC6A1
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfKAQYF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 12:24:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42870 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKAQYE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 12:24:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so13563015qts.9;
        Fri, 01 Nov 2019 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+X7BAjwpoxCzuO7LUDb5mczFy+30nvHy05MmfNzCz4=;
        b=ewa4wdqP71lzjCXdvCoOcqAu5J/9ahceSSSyd1Nlp94EWrRTg/7VsNE9mPZ9sh6qTI
         ixYUIQX5KXocB1/nbWGu02ADzqbRTk330bwkDPdU+jvJuaqWf7gLGv99qy1L7SxnZrnu
         wVlZiyaUmyNXON6doOJs4BuEGOTNoLqGGZ4hbWmGdlqgcnMX4lM/JWb+lU1w6slPwk6o
         ocGZ2IqJHgAF223E+APNvYeWPTk2dkYvDzxfqbEFsJpG9RzIRuT+8GE7veX91E+1/58q
         hta8qBzHEoKf299VCu6ZfGDMgIW69SnHoLO1I6rN8TkmhXKFQ1lQlxGvqh5KrEN40CN4
         2WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+X7BAjwpoxCzuO7LUDb5mczFy+30nvHy05MmfNzCz4=;
        b=T7/llN1spPYljU5PE9TPW6NXjsWp25rQjM0Hkq+m3i76e4b5vObIXjwCBVR8hqp1au
         G9mAq1JgqgqCNcYY6Cj0vXN2iAFemM0iuN5XhI17rh3d9VudeTWqgCLxoM0RmunbkH1F
         i6nSwGKaVmSB8wReqLxJRmHXhcH54kwObR6C6cleDNrrSZaPGeiYuA5lHCL/GjNOBkJf
         PZxUeaTbuRypG+uqM6UvM+jQCKk8GaiwvQB19TN8dolqtuHEFYQaJNsaurYe0/tWEIb/
         Lpemuj3Qvjn7vcBlJey5eX9Q0d5fHnSUGSi8WpCbKly95cF9Io98o9GRLvS9UtJ2aCBQ
         mp/Q==
X-Gm-Message-State: APjAAAVAk0cmVU4eoRYHa43WXKWdCQxWyVKCL82sOGUALNDUKpl0cshD
        s+erFoHUucdtVXJGmGpiEj8=
X-Google-Smtp-Source: APXvYqzpjKnKKXlPIFw+nGn3re6fAmcPQAh40jIsC1I43pyorcE3/jNZZbKnW96PBTVIq3Ph9cmwGA==
X-Received: by 2002:ac8:183:: with SMTP id x3mr68817qtf.279.1572625443125;
        Fri, 01 Nov 2019 09:24:03 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id k199sm3998365qke.0.2019.11.01.09.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 09:24:02 -0700 (PDT)
Date:   Fri, 1 Nov 2019 13:23:59 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
Message-ID: <9a748c5150561dcf3e1f59b2900ae281b662c5b9.1572614297.git.marcelo.schmitt1@gmail.com>
References: <cover.1572614297.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572614297.git.marcelo.schmitt1@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a devicetree schema for AD7292 monitor and control system.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Changelog V2 -> V3:
- changed spi-cpha property
- added spi-cpha to the list of required properties
- renamed example device node
- added ';' to the final curly braces correctly closing dt-schema

 .../bindings/iio/adc/adi,ad7292.yaml          | 103 ++++++++++++++++++
 MAINTAINERS                                   |   7 ++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
new file mode 100644
index 000000000000..1014eb50a263
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0
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
+        maxItems: 1
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

