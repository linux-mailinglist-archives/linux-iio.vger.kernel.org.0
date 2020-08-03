Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD623B152
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgHCX6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgHCX6U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:20 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A122C061756
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id t4so32659697iln.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvWcLJLa3Y53Vay5RMNxPF61bNyr+HrQ2gp6EQOAsiA=;
        b=DlJfuhKgon2eBMn6wys5U+E13+Qrr+UPKm33xGWpyc3wpO2k+7/7Sx48mfCxuAe35q
         3Jk59WDzBr2hJceHVzgOw/EQl9n3q75y+w8wXpuOLV3i3/sDmDLpL0nFcRx8tUhIOxRy
         JgKYVj706F2GN0ZeAz4cvKO8/R/yURiVXxHS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvWcLJLa3Y53Vay5RMNxPF61bNyr+HrQ2gp6EQOAsiA=;
        b=P+16pEnLRc6Owxtdl2M6BViyDanZOldALGcOL+PBqAlTSoMdRa6hy0FAsbWvZ7bHEJ
         xhSbztXVP4WZh0GM0d7XNm1MtTvPD09b3RyXEja3/QMcZ8hojFxNoRX66ZPOAkPohU/z
         E1NdfzqCY1+cU+Ck1kYVHLdO11irj/Hpal70WNmidoVkiJ2oZ9DYG9+sb14p2ecpZV7y
         N4hEypgKkFnOgPypkP2jhubtGSYeTbPUnOO8eh1uBw3Rmv1Amuv9jtWvxLnjTJklnFba
         Q1l430ODI+KjO5d0ChrZp5e4biiShNHm2FP0rxbsbvy98UHNDjFABbLYh7dQRdgdiwJd
         ZRqw==
X-Gm-Message-State: AOAM532GdPVBIDUT+sv2mwdfx9ipwHtOodmKVs/G48zWg5boPBuAk7IA
        q7kUyC2/WXTguTvCEpcU9HvfrA==
X-Google-Smtp-Source: ABdhPJynJdzgOO3Mqe09VzRnogKDfLpOpKaW1TxTvVR6Wldca0tfZ2b5h89NUJboTDFs5nQDUtZraQ==
X-Received: by 2002:a92:6c0b:: with SMTP id h11mr1990621ilc.66.1596499099673;
        Mon, 03 Aug 2020 16:58:19 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:19 -0700 (PDT)
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
Subject: [PATCH v5 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Mon,  3 Aug 2020 17:58:01 -0600
Message-Id: <20200803175559.v5.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
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

Changes in v5: None
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

