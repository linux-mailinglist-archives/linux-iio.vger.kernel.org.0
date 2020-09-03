Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9666825CD55
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgICWSc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 18:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgICWSb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 18:18:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DEC061245
        for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2020 15:18:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 5so3235100pgl.4
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2020 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Roix3RhAEEOO2V01BUd1l2dtuHebq2+iPymfTqDrfKA=;
        b=malaHd5r4alh1HJyeDyqDu7Mey/38FwBExzCtlODrP1yv0Kp55lsKlc4p00m1kU1wz
         06MepI8ARBeA1bjq9yyLsh5N4fIP0/VCGvrCTx/erzWdPrF7UOKJOKJ6LzRstg0tmZjj
         85RirG/8z6BAsuLa7c24lw9eWx66QUol7PTr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Roix3RhAEEOO2V01BUd1l2dtuHebq2+iPymfTqDrfKA=;
        b=Kcgnk8TXhogR5brmO3VaFNrIW2EuWb0lAurgBs6OLuAQJjiXX9E+Y4tqepnm6nIZLa
         cBc3XlYWxx9sXotgAjhxgfxLS9vC6GYX1zfvBs0stVYc1b3j64tB0LeTHjgtUCnDO0u/
         Jxq93A6KhM6tZIMzRytI6vXtyDvGuFos8DRD9xT+ss8lp1P1mFYRjfGq7WVNh/Tqvbfb
         FEJX3zRTKjSX4nlEWG8V+9cGxnFLnMQumWuWoA+pDwRkucHFrZetxOVMMwUwJoiZDBZa
         E/gomKDyjR7QUXVCdygEYhB7/UvQG2xddt8A9p4bliQ8e3TKVxY8vrP8tnC9R8t04XCO
         PATw==
X-Gm-Message-State: AOAM533FvSF3f48mRvsozNyORegyTLURdZA8tBHU7l8TcbydTSH1L4Iw
        TZqdDtSdgg55gyWH+hnfgnyPkw==
X-Google-Smtp-Source: ABdhPJyNpfEDlgl8BoZHuF2puXp9YWnttTtYfUOHnZq7eEOWT2W+CMSH3iaOHUCZ9AjszaCRgypIcg==
X-Received: by 2002:a65:614a:: with SMTP id o10mr4697995pgv.411.1599171509795;
        Thu, 03 Sep 2020 15:18:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p188sm4205391pfb.17.2020.09.03.15.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:18:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT properties
Date:   Thu,  3 Sep 2020 15:18:28 -0700
Message-Id: <20200903221828.3657250-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to set various bits in the hardware registers for this device to
operate properly depending on how it is installed. Add a handful of DT
properties to configure these things.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I haven't written any code to handle these properties yet. I'd rather do
that once the binding patch is reviewed. Patch based on iio.git testing
branch.

 .../iio/proximity/semtech,sx9310.yaml         | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
index 5739074d3592..e74b81483c14 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -40,6 +40,169 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  semtech,cs0-ground:
+    description: Indicates the CS0 sensor is connected to ground.
+    type: boolean
+
+  semtech,combined-sensors:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 1, 2, 3]
+    default: 0
+    description:
+      Which sensors are combined. 0 for CS3, 1 for CS0+CS1, 2 for CS1+CS2,
+      and 3 for all sensors.
+
+  semtech,cs0-gain-factor:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [1, 2, 4, 8]
+    default: 1
+    description:
+      Gain factor for CS0 (and combined if any) sensor.
+
+  semtech,cs1-gain-factor:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [1, 2, 4, 8]
+    default: 1
+    description:
+      Gain factor for CS1 sensor.
+
+  semtech,cs2-gain-factor:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [1, 2, 4, 8]
+    default: 1
+    description:
+      Gain factor for CS2 sensor.
+
+  semtech,resolution:
+    description:
+      Capacitance measure resolution.
+    enum:
+      - coarsest
+      - very-coarse
+      - coarse
+      - medium-coarse
+      - medium
+      - fine
+      - very-fine
+      - finest
+
+  semtech,startup-sensor:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 1, 2, 3]
+    default: 0
+    description:
+      Sensor used for start-up proximity detection. The combined
+      sensor is represented by 3.
+
+  semtech,proxraw-strength:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 2, 4, 8]
+    default: 2
+    description:
+      PROXRAW filter strength. A value of 0 represents off, and other values
+      represent 1-1/N.
+
+  semtech,compensate-common:
+    description: Any sensor triggers compensation of all channels.
+    type: boolean
+
+  semtech,avg-pos-strength:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
+    default: 16
+    description:
+      Average positive filter strength. A value of 0 represents off and
+      UINT_MAX (4294967295) represents infinite. Other values
+      represent 1-1/N.
+
+  semtech,cs0-prox-threshold:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
+               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
+               160, 192, 224, 256, 320, 384, 512, 640,
+               768, 1024, 1536]
+    default: 12
+    description:
+      Proximity detection threshold for CS0 (and combined if any) sensor.
+
+  semtech,cs1-prox-threshold:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
+               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
+               160, 192, 224, 256, 320, 384, 512, 640,
+               768, 1024, 1536]
+    default: 12
+    description:
+      Proximity detection threshold for CS1 sensor.
+
+  semtech,cs2-prox-threshold:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
+               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
+               160, 192, 224, 256, 320, 384, 512, 640,
+               768, 1024, 1536]
+    default: 12
+    description:
+      Proximity detection threshold for CS2 sensor.
+
+  semtech,cs0-body-threshold:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
+    default: 1800
+    description:
+      Body detection threshold for CS0 (and combined if any) sensor.
+
+  semtech,cs1-body-threshold:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
+    default: 12
+    description:
+      Body detection threshold for CS1 sensor.
+
+  semtech,cs2-body-threshold:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
+    default: 12
+    description:
+      Body detection threshold for CS2 sensor.
+
+  semtech,hysteresis:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 6, 12, 25]
+    default: 0
+    description:
+      The percentage of hysteresis +/- applied to proximity/body samples.
+
+  semtech,close-debounce-samples:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 2, 4, 8]
+    default: 0
+    description:
+      The number of close samples debounced for proximity/body thresholds.
+
+  semtech,far-debounce-samples:
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint32
+      - enum: [0, 2, 4, 8]
+    default: 0
+    description:
+      The number of far samples debounced for proximity/body thresholds.
+
 required:
   - compatible
   - reg
@@ -61,5 +224,24 @@ examples:
         vdd-supply = <&pp3300_a>;
         svdd-supply = <&pp1800_prox>;
         #io-channel-cells = <1>;
+        semtech,cs0-ground;
+        semtech,combined-sensors = <0>;
+        semtech,cs0-gain-factor = <8>;
+        semtech,cs1-gain-factor = <8>;
+        semtech,cs2-gain-factor = <8>;
+        semtech,resolution = "fine";
+        semtech,startup-sensor = <1>;
+        semtech,proxraw-strength = <2>;
+        semtech,compensate-common;
+        semtech,avg-pos-strength = <64>;
+        semtech,cs0-prox-threshold = <96>;
+        semtech,cs1-prox-threshold = <112>;
+        semtech,cs2-prox-threshold = <96>;
+        semtech,cs0-body-threshold = <300>;
+        semtech,cs1-body-threshold = <300>;
+        semtech,cs2-body-threshold = <300>;
+        semtech,hysteresis = <0>;
+        semtech,close-debounce-samples = <2>;
+        semtech,far-debounce-samples = <2>;
       };
     };

base-commit: 1bebdcb928eba880f3a119bacb8149216206958a
-- 
Sent by a computer, using git, on the internet

