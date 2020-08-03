Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597023B12E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgHCXnH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgHCXmB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:42:01 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0CC06174A
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:42:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l1so40352721ioh.5
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySLfczwfPCSsE/wIMdBijYsg19z6IEGg8VtkjJac6SY=;
        b=DcZwLeIUcR1SxjgrjtGSRF0f2IaIwkE2cwYwmc4Wow/SeAyV4MiPpWcMB8TJ4eauEY
         vECMqzmfNeED0nATqni3SI8pI3puiGdsNq1GVvTO0Bj7MHYIgfiCJ8ddluTfnIG1OdBq
         1T+YRqoNReDpWeeUGSo52zs2v/cybiX1wnn14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySLfczwfPCSsE/wIMdBijYsg19z6IEGg8VtkjJac6SY=;
        b=N4+xo1vmkduDu7cVyDtbJjSzPPAB4ee8FHRyBV/mjYWBpohkXcajD2v46REQY7NNWo
         /jzsWw0LdK/2Qw2D+Kua+HNUAb47A53gvxMl8ROH2e9QCfwQ09wms3ialZgs1QQ5DBTE
         hDUwbJXIFeiKgZHfYrcQq0ILKgFXcUtbGBBd6QLgbQz5R0x/A+0f75UowHKMUH2anvKv
         wRNIQlWRwFMfqgTT/IOSvz691Xq3Me6TNPxmOLW1NA105IdAKjDOZIrbRtsh5jQmE44S
         sf0BZX3CdYqNlQ8vjbf4ZvIm/PhJmnEBErMMnWrlMSBK56miteTNKxkyWU817b7+bWOW
         ezVg==
X-Gm-Message-State: AOAM531LgjHlT2m1kDjbp5TSnXI/1EpQphDoZb+a+lzV85zbg8X5ed7b
        kEIKa8Y9MP4qZLcI47oNs4ZHCw==
X-Google-Smtp-Source: ABdhPJzDGIe+hSIe7APq0Lc1WUsIPi4TvIWjSHUGZz5lkp3h7XL6rCOs1v64EAKNtBkCZCDJwqsRvA==
X-Received: by 2002:a05:6638:2689:: with SMTP id o9mr2591145jat.37.1596498120365;
        Mon, 03 Aug 2020 16:42:00 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:00 -0700 (PDT)
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
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v4 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Mon,  3 Aug 2020 17:41:40 -0600
Message-Id: <20200803131544.v4.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds device tree bindings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
[swboyd@chromium.org: Add both regulators and make them optional]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4: None
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

