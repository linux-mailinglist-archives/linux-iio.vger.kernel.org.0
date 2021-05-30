Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D4394ED0
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhE3BBU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhE3BBR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB25C06138D;
        Sat, 29 May 2021 17:59:37 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v4so5560803qtp.1;
        Sat, 29 May 2021 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6V6t8hE+Gu6eo3I8d/U+TwOs3wXsrPEKOAhCz4/hV8=;
        b=JnFhXtun9geW3UTMOIhO07Y+aB29Pxalh5B77e91YMF+qhJvxARUtnPlFg5zHNs2Zd
         4hLI/U1Kf64+wHEVBAsq9/7XXFQNq3G5g48WIYyUKP5rNGN4lnafSJ7+NXXeelHKKm6c
         dddKLi4hDuK4nygbrHTCOeKaebdew0skDRkUStT7Ou/OEyYwikFGi6kyjFjENjOzYIIB
         0eDHlL0Bs7IyFLLcUEDd7jsyXsQJL4q3vIGgUmeBLc27ndkCVQuUkUB+uIMyRK/yltkX
         kmrZLSs1I+NolSoWAvyJ2k8L077tpIHqUujKTOYwO/QFK+xQFXHGUyaqB5SdFUp4K4eJ
         TCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6V6t8hE+Gu6eo3I8d/U+TwOs3wXsrPEKOAhCz4/hV8=;
        b=FpS8ZT9hIPHiASPEgrhLqXIqTlE/D2h7vxK1VqOGOTagZg6IMzgnQeqHGLryRrgZIH
         yJGgF2VeXpyIXaXgD3YN6vmDvaqTN7SCn4HOinj1mjo6L2T7AzIQViFmL/F/EUGRryMA
         vZB4frbwfC3saWIDo+hfDW8EBH6Eg6L28PsuCQSpsuOmNKAMFNtmfcZ+9N6zGtTGF/+f
         SNT34+1xaR/pr5TttmCiM+h5xV1o1SpfF5JN7diEnl33YH2TZ5B70DoWB9KBLdkVkAZD
         adYH91aXn43ds4BrNeVkv1EymY6i7r0YTHbGjqT9oqUoQsMaxoSrrMTQML9iHIoYxnAR
         YTfg==
X-Gm-Message-State: AOAM532vYO8VtB5lTfcoEs/ccWMQrHiOhxVb7HaI0oNMGJxfaeY8ZAko
        O3ZP/WWcLab8azfGT38tWtI=
X-Google-Smtp-Source: ABdhPJxQSVPTH6TgQf6TNMH+y/b51NwnbwkI/uxSzfZmNzh/EbrdFEDqImKr5McPa19xCJAf+dVn5A==
X-Received: by 2002:a05:622a:44:: with SMTP id y4mr9512991qtw.258.1622336376951;
        Sat, 29 May 2021 17:59:36 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:36 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 7/9] dt-bindings: iio: afe: add binding for temperature-sense-rtd
Date:   Sat, 29 May 2021 20:59:15 -0400
Message-Id: <20210530005917.20953-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly. This
binding describe one cases, the measurement of a temperature through
the voltage across an RTD resistor such as a PT1000.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../iio/afe/temperature-sense-rtd.yaml        | 65 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
new file mode 100644
index 000000000000..4798eda6e533
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/temperature-sense-rtd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sense RTD
+
+maintainers:
+  - Liam Beguin <lvb@xiphos.com>
+
+description: |
+  When an io-channel measures the output voltage across an RTD such as a
+  PT1000, the interesting measurement is almost always the corresponding
+  temperature, not the voltage output. This binding describes such a circuit.
+
+properties:
+  compatible:
+    const: temperature-sense-rtd
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  '#io-channel-cells':
+    const: 1
+
+  excitation-current-microamp:
+    description: The current fed through the RTD sensor.
+
+  alpha-micro-ohms-per-ohm-celsius:
+    description: |
+      Linear approximation of the resistance versus temperature relationship
+      between 0 and 100 degrees Celsius.
+
+      Pure platinum has an alpha of 3925. Industry standards such as IEC60751
+      and ASTM E-1137 specify an alpha of 3850.
+
+  r-naught-ohms:
+    description: |
+      Resistance of the sensor at 0 degrees Celsius.
+      Common values are 100 for PT100 and 1000 for PT1000.
+
+additionalProperties: false
+required:
+  - compatible
+  - io-channels
+  - excitation-current-microamp
+  - alpha-micro-ohms-per-ohm-celsius
+  - r-naught-ohms
+
+examples:
+  - |
+    pt1000_1: iio-rescale0 {
+        compatible = "temperature-sense-rtd";
+        #io-channel-cells = <1>;
+        io-channels = <&temp_adc1 0>;
+
+        excitation-current-microamp = <1000>;
+        alpha-micro-ohms-per-ohm-celsius = <3908>;
+        r-naught-ohms = <1000>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d3ab0ccc34ab..a7279af85adb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
+F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
 
-- 
2.30.1.489.g328c10930387

