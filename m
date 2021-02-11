Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1E3183B5
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 03:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBKCrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 21:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBKCrb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 21:47:31 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08833C06178B
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 18:46:07 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id j12so2722042pfj.12
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 18:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twuddSAEbF2FSdE2d9dO84GR4RHu82vdTNMWvHeTMIU=;
        b=JUrK65fm4XZSacciVCll9OWFvnD3WDueX41Kby5HfMyEHfLp+UUXgOEkl/IXyLSy2u
         TsQKTdnQgJN6T358ewT5f8hTsmiqa5ERcXPEw8bDbycFRu1MR2zIMNDH8rlrYvo/bMd4
         iac9FYrjceae8WZci0bvxuaMqsOo2CNotynSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twuddSAEbF2FSdE2d9dO84GR4RHu82vdTNMWvHeTMIU=;
        b=UuXTqb1yY5juCKEz/9BS83qugQxKHN+SH1/sqthaB4p1sT6O0SwBguWh4oQvAXcla4
         QJVtOB5ITwdv+cH5mT5Dm+pdCIuKwx52BKehYjmBE7EyiP/r54DOAWyd0YEUKpgwN9E2
         xgkkORuDVGwJfBezoHdAYU9QjYzslPACsX8DDBwI9ldXQI91y/LJlL8xZ+rvuUu/KnAF
         DLy3NRnWK5kbQbBi0YvNEUyv25Y5uvQ2KSMCaiK/w94uKa2ywx5mAgwWk7AV2dqj0EMl
         R/gT/0lANICImjoYGMIGFq+R4JKhYxzq3UTIGxoV+LOvo/HxdwM09cXihLJ0r4KMvUFX
         J7Rw==
X-Gm-Message-State: AOAM530Gv2YlnD5AyAlhfineQIiY6nzZohJoqQPHIYibmYG/F3BndTJ1
        c3cZHN5zh4w+cNfEa1Fm3qX6bzgy58RS9Q==
X-Google-Smtp-Source: ABdhPJz1acX46pn80JHWWhZiFQgpQ4IbQ8LeBmcYLJkr0EwQNml0btKPbK3PMxrHiHe05HkuHujC1g==
X-Received: by 2002:a63:515:: with SMTP id 21mr5884155pgf.231.1613011566603;
        Wed, 10 Feb 2021 18:46:06 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5533:1106:2710:3ce])
        by smtp.gmail.com with ESMTPSA id o185sm2615920pfb.196.2021.02.10.18.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:46:06 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Date:   Wed, 10 Feb 2021 18:46:00 -0800
Message-Id: <20210211024601.1963379-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210211024601.1963379-1-swboyd@chromium.org>
References: <20210211024601.1963379-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some cros ECs support a front proximity MKBP event via
'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
a node that is a child of the main cros_ec device node. Devices that
have this ability will describe this in firmware.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: <devicetree@vger.kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../google,cros-ec-mkbp-proximity.yaml        | 37 +++++++++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |  7 ++++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
new file mode 100644
index 000000000000..099b4be927d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC MKBP Proximity Sensor
+
+maintainers:
+  - Stephen Boyd <swboyd@chromium.org>
+  - Benson Leung <bleung@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  Google's ChromeOS EC sometimes has the ability to detect user proximity.
+  This is implemented on the EC as near/far logic and exposed to the OS
+  via an MKBP switch bit.
+
+properties:
+  compatible:
+    const: google,cros-ec-mkbp-proximity
+
+  label:
+    description: Name for proximity sensor
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    proximity {
+      compatible = "google,cros-ec-mkbp-proximity";
+      label = "proximity-wifi-lte";
+    };
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 76bf16ee27ec..4dfa70a013ae 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -94,6 +94,9 @@ properties:
   keyboard-controller:
     $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
 
+  proximity:
+    $ref: "/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#"
+
   codecs:
     type: object
     additionalProperties: false
@@ -180,6 +183,10 @@ examples:
             interrupts = <99 0>;
             interrupt-parent = <&gpio7>;
             spi-max-frequency = <5000000>;
+
+            proximity {
+                    compatible = "google,cros-ec-mkbp-proximity";
+            };
         };
     };
 
-- 
https://chromeos.dev

