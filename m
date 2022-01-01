Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350CD482874
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 21:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiAAUiI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 15:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiAAUiH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 15:38:07 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E4C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 12:38:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q3so21843761pfs.7
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VNPSFRhCkkxWPK3ApMyzLdKjQua+d6N8H9b1Iv7mYTg=;
        b=D2M3RPqb62DwxM6l7mi9Qv0dEymsGU9w7sJfCKq1wUyota4hckWO9A9SsLcI2GddGr
         102RpEgZpLunnjHlbEcPTyNY5/tEnHrxsw/ltqgauKuN105yxhWmWXx9FKw/gID6oLfZ
         /au0hONWnRYOWv39QAaQUkaE5CT7/nxkbBH9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNPSFRhCkkxWPK3ApMyzLdKjQua+d6N8H9b1Iv7mYTg=;
        b=aJhcxDej+EdO1hz6SEchjvW856bLv98UYm9qOsTEuUvemZqvnMn4Ii+N+ds3k1ltAW
         DzHMbH5XUsvcGpRZ7Ohu0WD9Z/n5u2qX6CTEXcpoWbHVsSvjzQZkszKFab8xDZbxxzxJ
         Ss3P28zUwrAC4g953UH9LCG9oqf87gfLHYdIUNAljlOD/l9rYO/PdUqYfZw0m8jGZHh2
         yMGcha1l2gPOreoY7dtObIPiCjmHnwd74D1JetCbK1/tJ2YGpLRTSa0WVlmdDXMk0xOT
         4Ftwquh2U+c5j0Vy25aCcXGDB9FJqg7A00gY4qL12U2zNTDqQTmXjDIhxiYFEIWOg7e2
         yPqg==
X-Gm-Message-State: AOAM530D/hhr9epNY2L7vPckQWz8TAZ14wUaY3GN4Th1cfgnpbEKMpd1
        MpJ8lV120u5TENYzPDL6N67Uvw==
X-Google-Smtp-Source: ABdhPJyj3Remeqf8lLe8UX7fLxoe9cAAVRl3dfOlJleuCknJyrmDUOyD9FB4A4C7rIhGGTU2LtDCVw==
X-Received: by 2002:a63:d446:: with SMTP id i6mr35893120pgj.479.1641069486716;
        Sat, 01 Jan 2022 12:38:06 -0800 (PST)
Received: from localhost ([2620:15c:202:201:df49:1d3f:ae08:999])
        by smtp.gmail.com with UTF8SMTPSA id f4sm30870471pfj.25.2022.01.01.12.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 12:38:06 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v6 2/3] dt-bindings: iio: Add sx9360 binding
Date:   Sat,  1 Jan 2022 12:37:59 -0800
Message-Id: <20220101203800.290387-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220101203800.290387-1-gwendal@chromium.org>
References: <20220101203800.290387-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding to configure Semtech sx9360 sensor.
It is a simpler version of sx9324.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No Changes since v5.
No Changes since v4.
No Changes since v3.
Changes since v2:
- Use const instead of single enum.
- Use proper syntax for maximum/minimum
- Fix spelling errors.

Changes since v1:
- Fix cut and paste error.
- Add . at end of sentence.

 .../iio/proximity/semtech,sx9360.yaml         | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
new file mode 100644
index 00000000000000..63e1a1fd00d4ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9360 capacitive proximity sensor
+
+maintainers:
+  - Gwendal Grignou <gwendal@chromium.org>
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9360 proximity sensor.
+
+properties:
+  compatible:
+    const: semtech,sx9360
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Generated by device to announce preceding read request has finished
+      and data is available or that a close/far proximity event has happened.
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
+  semtech,resolution:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
+    description:
+      Capacitance measurement resolution. For both phases, "reference" and
+      "measurement". Higher the number, higher the resolution.
+    default: 128
+
+  semtech,proxraw-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 1
+    description:
+      PROXRAW filter strength for both phases. A value of 0 represents off,
+      and other values represent 1-1/2^N.
+
+  semtech,avg-pos-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
+    default: 16
+    description: |
+      Average positive filter strength. A value of 0 represents off and
+      UINT_MAX (4294967295) represents infinite. Other values
+      represent 1-1/N.
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
+        compatible = "semtech,sx9360";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+        #io-channel-cells = <1>;
+        semtech,resolution = <256>;
+        semtech,proxraw-strength = <2>;
+        semtech,avg-pos-strength = <64>;
+      };
+    };
-- 
2.34.1.448.ga2b2bfdf31-goog

