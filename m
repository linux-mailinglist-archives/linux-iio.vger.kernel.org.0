Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB15033DE14
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 20:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCPTsi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 15:48:38 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:38136 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhCPTs3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Mar 2021 15:48:29 -0400
Received: by mail-il1-f178.google.com with SMTP id f10so13842395ilq.5;
        Tue, 16 Mar 2021 12:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RdNKGj3FobG6MH1X+dKs4+VSnyyid6fFPtQXmtZq7o4=;
        b=FwK6JVUO0CXmaLEmwBYx/Vfr7zKgCSvrWXulcsG9FtfTOSMjV9IDF0W0aEEjbHQCYH
         1XOLbkEh7LTLO+z8jzW9Fjd4q5JUJrquB0Iz9m90ydMR7wtPm0MKA/eKVKmOCWv8gKYw
         Egg5Mtai88a8jhxCbhkMa+9Bkeej2gTnBSw0gxKiX1uFwHmU31ZQcV/PpvEgsBYOm6FR
         misFArx9eS2lQ2V33U0rzSW0b4yA9+8qKE1p+dUpe7SmIb8HZmAO8lY6QUjduh70olvu
         OuuCmR/N6cZ8ZRThVzY/cKP6zgL+G0mnJtAc6bKjaz92JinKLFOu7/Ao7qxOQnu2QI0y
         Pnfg==
X-Gm-Message-State: AOAM533jK0xD7lqWMRxzKGlyrpdtZNlgKoWESiaDyTglDNFOAAMHNR4u
        VBI37/mISv3F5/9O/MWImqtkMguLQg==
X-Google-Smtp-Source: ABdhPJxr6112TJfnRPR0/Pblh7yamHgST8Dcm9ZPXpcv09y4FtrrYXucVBlNyp/mi8G3zDBhHJPhww==
X-Received: by 2002:a92:7d0d:: with SMTP id y13mr5263148ilc.269.1615924108645;
        Tue, 16 Mar 2021 12:48:28 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id a16sm9928962ild.82.2021.03.16.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:48:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: More cleanup of standard unit properties
Date:   Tue, 16 Mar 2021 13:48:24 -0600
Message-Id: <20210316194824.3526913-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Properties with standard unit suffixes already have a type and don't need
type references. Fix a few more cases which have gotten added.

Cc: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml | 1 -
 Documentation/devicetree/bindings/input/input.yaml              | 1 -
 Documentation/devicetree/bindings/power/supply/bq256xx.yaml     | 1 -
 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml   | 2 --
 .../devicetree/bindings/regulator/qcom-labibb-regulator.yaml    | 1 -
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml          | 1 -
 6 files changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
index 27972938b60d..c63b79c3351b 100644
--- a/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
@@ -48,7 +48,6 @@ properties:
   vdd-supply: true
 
   capella,aset-resistance-ohms:
-    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [50000, 100000, 300000, 600000]
     description: >
       Sensitivity calibration resistance. Note that calibration curves
diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index ab407f266bef..3fc37478c0c0 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -32,6 +32,5 @@ properties:
       Duration in seconds which the key should be kept pressed for device to
       power off automatically. Device with key pressed shutdown feature can
       specify this property.
-    $ref: /schemas/types.yaml#/definitions/uint32
 
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
index 18b54783e11a..92ec7ed25668 100644
--- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -39,7 +39,6 @@ properties:
     maxItems: 1
 
   ti,watchdog-timeout-ms:
-    $ref: /schemas/types.yaml#/definitions/uint32
     default: 0
     description: |
       Watchdog timer in ms. 0 (default) disables the watchdog
diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 1f88c9e013f4..6d7aa97a6475 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
@@ -29,12 +29,10 @@ properties:
     description: I2C address of the charger.
 
   lltc,rsnsb-micro-ohms:
-    $ref: /schemas/types.yaml#/definitions/uint32
     description: Battery sense resistor in microohm.
     minimum: 1000
 
   lltc,rsnsi-micro-ohms:
-    $ref: /schemas/types.yaml#/definitions/uint32
     description: Input current sense resistor in microohm.
     minimum: 1000
 
diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
index cf784bd1f5e5..1ddc1efd19e2 100644
--- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
@@ -23,7 +23,6 @@ properties:
 
     properties:
       qcom,soft-start-us:
-        $ref: /schemas/types.yaml#/definitions/uint32
         description: Regulator soft start time in microseconds.
         enum: [200, 400, 600, 800]
         default: 200
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 7cd364430573..95a728f4d333 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -78,7 +78,6 @@ patternProperties:
           also known as absolute calibration.
 
       qcom,hw-settle-time-us:
-        $ref: /schemas/types.yaml#/definitions/uint32
         description: Time between AMUX getting configured and the ADC starting conversion.
         enum: [15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000]
 
-- 
2.27.0

