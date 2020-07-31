Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E712234973
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbgGaQtA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbgGaQs7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:48:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52FEC061574
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:48:58 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id t15so23358962iob.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GsrH317o9ZXCzgzy3uVli3vBl/8VqU/V+NLgYgRn16Y=;
        b=QE1/qz/YlrUfA1R7HhCBY9mGH1JfX7uFKfSueFy09R1h0SAlO/7Ex7dmLiMeD1+U1G
         8UTq/wnJwQ8moxqOLjOY9JlfLOUx3lU/TyxNp312R8ddsUq4n4kySIOngY7Z1N8n6O3y
         wgdJt5FzMtUAWYKzT35a+ImqlNM5SwiVsHK+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsrH317o9ZXCzgzy3uVli3vBl/8VqU/V+NLgYgRn16Y=;
        b=J/ic2SpS0HIgIKTBFiWkHAqDAp+B536tYHj9c5Ih2yftHAJdSAByb51yRKUyjUC6VX
         dhdXuuu5bpLc6kzAFg2EKvY6/x3QMK9Amm9NjExs6qOnaLvF3D1ST10crl/dDR3TRXTD
         pU91K+bWA6s0wyDklkS8wRDtXTZoX1OCtV2Y09XuMhTYMvVEE3uPRSqZSBQdncSxXk6G
         Q4epuodjvywIpVOW20uu7CyYFwCY6Rddmg718PvUAWFhKxXybVDHsJ6yF23gOmWci3qi
         BBERSamA9mZQBDYgIvZk3hGY9lvBxsI1UKQVAFGPB3qwUT+8fQ4qRbudC61eyvznzDOC
         Hf4w==
X-Gm-Message-State: AOAM530LOgaM7RHCX40EgJkU0Lo3CfMpTGSBt6rikt9IOaTeMSWsFJYw
        yHfDxBrhres+rs7GAouAryAgJA==
X-Google-Smtp-Source: ABdhPJwCOKctFj27OG+BseqGcoNN+41qJ80MB7hgJ79QNm6A4cruPdZcGfMZd4MUPL5TpNJrdcEqOA==
X-Received: by 2002:a6b:bb43:: with SMTP id l64mr4404849iof.191.1596214138272;
        Fri, 31 Jul 2020 09:48:58 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:48:57 -0700 (PDT)
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
Subject: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Fri, 31 Jul 2020 10:48:38 -0600
Message-Id: <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
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

Changes in v3: None
Changes in v2:
 - Added #io-channel-cells as a required property

 .../iio/proximity/semtech,sx9310.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..5739074d3592fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,65 @@
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
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
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
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.28.0.163.g6104cc2f0b6-goog

