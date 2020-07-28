Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BB4230D32
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgG1PNO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbgG1PNN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:13:13 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC0DC0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:13 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y18so8041111ilp.10
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHxD6udjM+BmNfhqgaIfVpk0lOiGcwdA5o4lB9ADOmg=;
        b=Nxhgyc2o90wGCC4mr9sfow37Cv8CwXysAIFqU5XftS8rVLH/R0j6zi4OUP+0feVtHc
         2aQrmr4IZpXxZXEk5WU8glZ3RpNmTVQgrtkZ7t2nHytXPgPRxQ5Jn7oNJRmf4U5+GCw0
         rbQ+jK6iC+QaaegD5ga8biXsQl1XuUdSjDycA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHxD6udjM+BmNfhqgaIfVpk0lOiGcwdA5o4lB9ADOmg=;
        b=PtIgBwtmsKGjMl0GfCichhDDi8JsYuMQpADKM4WwsUDfImN0qsGpxuBAkVRF9NNin4
         rZoD9k2VIM0TG7hSiZdSz4TywvWbktedOEP6zpTR5Fdh1vuhcmh6xNmxzyxDy8Hc8g4c
         cIDKTmqYyjxxEgkAPpPLCq1oUts21DvNAblofDj2GEoVdztQsy3bS0q6PyH5+CpwtuFJ
         IbMQYVDtyXvKGC4Uo87c4srRjnk6e/9KL5vffhog8AmIBLiKdcG5CCWYUoyCIaOIIz2D
         qKt8iVFdArAVCIOVV25UZHH9tTtn1ZX/5MKVDrV4qXeJZZkKpH8QTDnc6TXLTK7G5CB0
         bxxQ==
X-Gm-Message-State: AOAM532yWuRcQmD+QsOfaWBrRVjAXLsGPSLZJSfyuKIP8fZHW6L2IvoC
        roaUaKWze0Q8jXZEg8o+m5LA2Q==
X-Google-Smtp-Source: ABdhPJyY0Au2KBM6mUQMhG/TED004pcY9xvoRI9jRFk1FoUdWituv1aslVKg5ArjQJN0Jf9d+hx9og==
X-Received: by 2002:a92:de42:: with SMTP id e2mr28066004ilr.189.1595949193089;
        Tue, 28 Jul 2020 08:13:13 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:12 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Tue, 28 Jul 2020 09:12:44 -0600
Message-Id: <20200728091057.1.I3bf8ece8c303bd9ecfc1573464cdacc47d73784b@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds device tree bandings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
[swboyd@chromium.org: Add both regulators and make them optional]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

 .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..ba734ee868c77f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9310 capacitive proximity sensor
+
+maintainers:
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9310/SX9311 capacitive proximity/button solution.
+
+  Specifications about the devices can be found at:
+  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
+
+properties:
+  compatible:
+    enum:
+      - semtech,sx9310
+      - semtech,sx9311
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The sole interrupt generated by the device used to announce the
+      preceding reading request has finished and that data is
+      available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+  svdd-supply:
+    description: Host interface power supply
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@28 {
+        compatible = "semtech,sx9310";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+      };
+    };
-- 
2.28.0.rc0.142.g3c755180ce-goog

