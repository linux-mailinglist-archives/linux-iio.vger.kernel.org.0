Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939473035A5
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 06:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbhAZFt0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbhAZCFz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 21:05:55 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1EC061221
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 18:01:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s15so8826415plr.9
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 18:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wm686hw4j5jBSqd7g6ladOMIGoWP5gBh2lB4YQM5T54=;
        b=LTws3vDgcnnJwh5i3qvu2kkI6RqoXRxND4JDktxQgM3yKiZwheDz/EISwEaEyXjHOO
         pTAAv3jZW66k1+tHiC+BvlfIQHUaVp1mMe1Ag4ElqDk47Yc3ZzKA3QihhRJAx3j6CgZd
         vHI42ETF7GrSMq4ljzQOCkSPzYSenTxNcj1IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wm686hw4j5jBSqd7g6ladOMIGoWP5gBh2lB4YQM5T54=;
        b=oq7U4raa2ETcXkl9OHkFm4bdmq/R4z/8h5lyl9VFedJIrbJCvmrVkTT+iCyDHlde0Q
         Vb1o7UYpyaH2ooR0CfQHTauChhcyyPGLQxVw1rv1L29d4en209D3rXvdC7HNQJVK9/fM
         RBlGOW2wGQ+Fwk2nvauebSQIBdZC3DvgnFj6OjH5tOaXCpk8XuvRAUkAQ2uiSL9VJB//
         w535C2K+jBWB4haR+uHpKcUF88rfEdz7+LeRlu4saRb9zl70EYj451Kp/Tk6T/omcDCL
         LYW6NorRIhF/BYAqm0gIMR/DivWAa2ZFqPzEH+GkF08R7itdwa/MH96Ap4/GhA7jlppF
         N+bw==
X-Gm-Message-State: AOAM5332NhDR7TesiVM4OUnNmjW1YFFWKcGTySC/AHUcXCZ6YZj+2NC3
        egl3UEg/UlD99MRtRwzCAvKHPQ==
X-Google-Smtp-Source: ABdhPJywNUMbEQHIkLbDUwVCpu2O5SfY8LRfgGxByPbyXBlYnbqvlcNqMMo9n/A3xciukAOe2vuWyw==
X-Received: by 2002:a17:90a:2f44:: with SMTP id s62mr3315525pjd.182.1611626484024;
        Mon, 25 Jan 2021 18:01:24 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id n2sm16975028pfu.42.2021.01.25.18.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 18:01:23 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Date:   Mon, 25 Jan 2021 18:01:16 -0800
Message-Id: <20210126020117.2753615-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210126020117.2753615-1-swboyd@chromium.org>
References: <20210126020117.2753615-1-swboyd@chromium.org>
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
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Added additionalProperties
 * Included proximity in cros-ec yaml

 .../google,cros-ec-mkbp-proximity.yaml        | 38 +++++++++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |  3 ++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
new file mode 100644
index 000000000000..c3141c2be286
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
@@ -0,0 +1,38 @@
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
+unevaluatedProperties: false
+additionalProperties: false
+
+examples:
+  - |
+    proximity {
+        compatible = "google,cros-ec-mkbp-proximity";
+        label = "proximity-wifi-lte";
+    };
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 76bf16ee27ec..479a9f15de32 100644
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
-- 
https://chromeos.dev

