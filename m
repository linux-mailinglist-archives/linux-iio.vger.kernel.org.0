Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6819CD3D
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbgDBXCG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Apr 2020 19:02:06 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34330 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBXCG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Apr 2020 19:02:06 -0400
Received: by mail-il1-f196.google.com with SMTP id t11so5427634ils.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Apr 2020 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8h9TNvv6CZ2PKXPL953qS4ZWG+3/jrimtqMPT6Mv1pU=;
        b=QomA5NjtFvJQErByC8wHcdpBoa4FleTSJNfY747f268VshMlihtHC6OviHbjhlZBM6
         yc3Nxmlb3GRhGQ5nmF22Xfy46volL/Us88RKVifpWoYcayJ1q5Hd4XZyOeh8E8knn4u9
         g2KKzgTI5UZAYJxVUTae7wN3FCUs8sT3zy3k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8h9TNvv6CZ2PKXPL953qS4ZWG+3/jrimtqMPT6Mv1pU=;
        b=m8YcaAW/EZq/CLf76jXcXqwC9xPqFyVD4vaXN9tSN/RPFWa3F5XSeka+H5zt/A4WD6
         Hsy5YukDosLelhkP+vzeqZUQ0TNji2TqLMtbyUi74tXJOj7jVy4LEuFfdFlhRVAhwTba
         kEiNic2gjtNAgHJcCiiAl/p5d7q6I7MGdZckoYl0V4PBR6AEg4YRhFf0WgC77R/mFlWf
         wcsl0drf/wKqni/GgaJ5754UoGBuLeyj4qa9B8YzrcAntOuEn527pD1sAlolVtPu0fDf
         8YmpRFt2uOObD1KS0Ly1gnnZSzewjbU/5YUftlTStoSMs4vYovQ1Rvd8iIqWCK+nVcQH
         8zNg==
X-Gm-Message-State: AGi0PubbRAOWOveFhAyt9rI8H/PF5wRD3Kw14xoAt5BdWZK2NSHzGJbe
        bVJpB/yRUwOA1TFsCVFt0ao6FQ==
X-Google-Smtp-Source: APiQypJfC8VUbwJAGR7sUSeGGe0EC41G2TO8QzvnR3qOZDxuY//+mCVxGZ3gqZhd37cWATOWh6pVDA==
X-Received: by 2002:a92:d490:: with SMTP id p16mr5940369ilg.300.1585868525477;
        Thu, 02 Apr 2020 16:02:05 -0700 (PDT)
Received: from derch.Home (75-166-136-192.hlrn.qwest.net. [75.166.136.192])
        by smtp.gmail.com with ESMTPSA id v24sm1808461iob.0.2020.04.02.16.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 16:02:04 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 1/2 v2] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Thu,  2 Apr 2020 17:01:29 -0600
Message-Id: <20200402165720.1.I6ed779cd21abf3e70f21c1562bbda81f590976ab@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds device tree bandings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2 changes:
 - Added power-supply
 - Changed to dual license

 .../iio/proximity/semtech,sx9310.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..b52ffdac678b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,56 @@
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
+  power-supply: true
+
+required:
+  - compatible
+  - reg
+  - power-supply
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
+        power-supply = <...>;
+      };
+    };
--
2.26.0.292.g33ef6b2f38-goog

