Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25FF58A682
	for <lists+linux-iio@lfdr.de>; Fri,  5 Aug 2022 09:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiHEHHk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Aug 2022 03:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbiHEHHX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 03:07:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE674E0E;
        Fri,  5 Aug 2022 00:07:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bf13so1929568pgb.11;
        Fri, 05 Aug 2022 00:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qeopJMMMGQSOM0makhnpPexR2tcMVpSaueKhDF363vc=;
        b=InwB0H0z7UJWx1xHOJC64Z4Kq8Ocdh/v3W/VRRB/TbDkixafeNdBDdpKacr0pCIRU8
         j4R8m7lRV3mPaxFZvRp4z6mHXosKZIId+CyYyovhhD8wru0+AHnjANRuCx0X+96EBaaA
         sC/5pYw/OXnSDy7QuT3LC9G8ssdB8FbOwyMfllMcrovy7a09nEMEsZ4GtEUVxxift4uV
         xy3vxpy0nENJ4hSrGJ9LjvNM3tzwFrs9Wx3e1a1/YAVkjW76LpBluDW2IENsUjsvznfG
         n6y9msCnKBmAEYOlHbHJ6UGeQ1wlHztbnb5Res5lVaqFovHmmStPtcqurTo04HNSsSU/
         nuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qeopJMMMGQSOM0makhnpPexR2tcMVpSaueKhDF363vc=;
        b=QsB86xj5I2XXIgYy6pWV5Xh5ektXhwrcKcSEckIOsIEMkmJTARgKCYIt0CYBNZ1a3o
         M1UfruRuqm9qkzyptkNlVWM4g8ziYkqrH3YeC9uPtVPLL+lAeMitI8mZ9QuPgzin+GbL
         MbUDbYk05aRdCkhlpGjqIcaebWPgMwwhI8GDD5L1JFqdzGz9pPjcMwn2PTKUukmRmuO3
         pnP/di1/EQ4yuE+L4e+S8qtm22qQPiVRWjpCKIzbUXzB72CMP8TIZ/cHDyzTb9OsI9Uv
         ARyGEJi13KVTnGNBibWPMzswsESGpq2G2fhxcBuCOGlrHsRLP0RON2gpFn3TjPNY2hJf
         DNqQ==
X-Gm-Message-State: ACgBeo2i00OG6kM5MvT7HLdGeMYBefWmGWZo6651iEeFlBckTcxCbJGF
        IIAtL7W2nQSxtrxtGihQasw=
X-Google-Smtp-Source: AA6agR4RCWr+OmHvsf5Vj3yHmct3WXBf4k9PSgUYPPdCQTG6FMOvaIn3j7K62RblsN/IOB1K4L4/Kw==
X-Received: by 2002:a05:6a00:cc1:b0:52d:a29d:fb1 with SMTP id b1-20020a056a000cc100b0052da29d0fb1mr5663372pfv.56.1659683222769;
        Fri, 05 Aug 2022 00:07:02 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-229-62.emome-ip.hinet.net. [42.72.229.62])
        by smtp.gmail.com with ESMTPSA id i5-20020a056a00224500b00525343b5047sm2191616pfu.76.2022.08.05.00.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:07:02 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 05/13] dt-bindings: backlight: Add MediaTek MT6370 backlight
Date:   Fri,  5 Aug 2022 15:06:02 +0800
Message-Id: <20220805070610.3516-6-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805070610.3516-1-peterwu.pub@gmail.com>
References: <20220805070610.3516-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add MT6370 backlight binding documentation.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v7
- Add the second compatible string for 'mt6372'
- Add 'mediatek,bled-exponential-mode-enable' property for enable the
  exponential mode of backlight brightness
- Add validation for the maximum value of 'default-brightness' and
  'max-brightness'
---
 .../leds/backlight/mediatek,mt6370-backlight.yaml  | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
new file mode 100644
index 0000000..5533b65
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6370 Backlight
+
+maintainers:
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  The MT6370 Backlight WLED driver supports up to a 29V output voltage for
+  4 channels of 8 series WLEDs. Each channel supports up to 30mA of current
+  capability with 2048 current steps (11 bits, only for MT6370/MT6371) or
+  16384 current steps (14 bits, only for MT6372) in exponential or linear
+  mapping curves.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-backlight
+      - mediatek,mt6372-backlight
+
+  default-brightness:
+    minimum: 0
+
+  max-brightness:
+    minimum: 0
+
+  enable-gpios:
+    description: External backlight 'enable' pin
+    maxItems: 1
+
+  mediatek,bled-pwm-enable:
+    description: |
+      Enable external PWM input for backlight dimming
+    type: boolean
+
+  mediatek,bled-pwm-hys-enable:
+    description: |
+      Enable the backlight input-hysteresis for PWM mode
+    type: boolean
+
+  mediatek,bled-pwm-hys-input-th-steps:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [1, 4, 16, 64]
+    description: |
+      The selection of the upper and lower bounds threshold of backlight
+      PWM resolution. If we choose selection 64, the variation of PWM
+      resolution needs more than 64 steps.
+
+  mediatek,bled-ovp-shutdown:
+    description: |
+      Enable the backlight shutdown when OVP level triggered
+    type: boolean
+
+  mediatek,bled-ovp-microvolt:
+    enum: [17000000, 21000000, 25000000, 29000000]
+    description: |
+      Backlight OVP level selection.
+
+  mediatek,bled-ocp-shutdown:
+    description: |
+      Enable the backlight shutdown when OCP level triggerred.
+    type: boolean
+
+  mediatek,bled-ocp-microamp:
+    enum: [900000, 1200000, 1500000, 1800000]
+    description: |
+      Backlight OC level selection.
+
+  mediatek,bled-exponential-mode-enable:
+    description: |
+      Enable the exponential mode of backlight brightness. If this property
+      is not enabled, the default is to use linear mode.
+    type: boolean
+
+  mediatek,bled-channel-use:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      Backlight LED channel to be used.
+      Each bit mapping to:
+        - 0: CH4
+        - 1: CH3
+        - 2: CH2
+        - 3: CH1
+    minimum: 1
+    maximum: 15
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: mediatek,mt6372-backlight
+
+then:
+  properties:
+    default-brightness:
+      maximum: 16384
+
+    max-brightness:
+      maximum: 16384
+
+else:
+  properties:
+    default-brightness:
+      maximum: 2048
+
+    max-brightness:
+      maximum: 2048
+
+required:
+  - compatible
+  - mediatek,bled-channel-use
+
+additionalProperties: false
-- 
2.7.4

