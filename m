Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0E356670
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347064AbhDGIVY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 04:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240507AbhDGIVR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9215E613E3;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=NPMfGgHKVQk69CaP3CWjyeJKVdj6F+brEur4iKI4NSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddaNIzq2i0IDLiuh7aVaFMqdcNmKbRkg1tKkkVnsi4MljgODt/+I3mLP1Wi9iE7B9
         WUD9g8Hh+jGtHAlfLdL8LO9uieyJ65X1iZ82UMM4h2rdIfPpMmYHIy6dOJ+oYLtxFu
         zpAS/QzJtK9kzSOyBQ1Stjr2KazYdX8TKyt39tU1KidiYwy5vS8elOTA/atbdDhlYG
         R2ll/+aa8Z+FqQ3zBkj1dG3XgR2IuZXt4U69TBYjVRxrxu8dX/k/DLxRrF7suT+kS4
         I6YQZ5oX20uu1etMgMnkLnNn3XgptE+YOwEaA+ujq29+JzNTFozkc0bj8NhneBuMJO
         R8/sARQlCXl4Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2K-FK; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 07/19] dt-bindings: fix references for iio-bindings.txt
Date:   Wed,  7 Apr 2021 10:20:46 +0200
Message-Id: <c4e3cfcc666552084df5155c4f3957134b72ef7a.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio-bindings.txt was converted into two files and merged
at the dt-schema git tree at:

	https://github.com/devicetree-org/dt-schema

Yet, some documents still refer to the old file. Fix their
references, in order to point to the right URL.

Fixes: dba91f82d580 ("dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt   | 2 +-
 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml   | 5 +++--
 Documentation/devicetree/bindings/input/adc-joystick.yaml    | 4 +++-
 .../bindings/input/touchscreen/resistive-adc-touch.txt       | 5 ++++-
 Documentation/devicetree/bindings/mfd/ab8500.txt             | 4 +++-
 .../devicetree/bindings/power/supply/da9150-charger.txt      | 2 +-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
index 37f18d684f6a..4c5c3712970e 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
+++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
@@ -32,7 +32,7 @@ Optional node properties:
 - "#thermal-sensor-cells" Used to expose itself to thermal fw.
 
 Read more about iio bindings at
-	Documentation/devicetree/bindings/iio/iio-bindings.txt
+	https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/
 
 Example:
 	ncp15wb473@0 {
diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
index 9f414dbdae86..433a3fb55a2e 100644
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
@@ -14,8 +14,9 @@ description: >
   Industrial I/O subsystem bindings for ADC controller found in
   Ingenic JZ47xx SoCs.
 
-  ADC clients must use the format described in iio-bindings.txt, giving
-  a phandle and IIO specifier pair ("io-channels") to the ADC controller.
+  ADC clients must use the format described in
+  https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml,
+  giving a phandle and IIO specifier pair ("io-channels") to the ADC controller.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 054406bbd22b..721878d5b7af 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -24,7 +24,9 @@ properties:
     description: >
       List of phandle and IIO specifier pairs.
       Each pair defines one ADC channel to which a joystick axis is connected.
-      See Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
+      See
+      https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
+      for details.
 
   '#address-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
index fee0da12474e..af5223bb5bdd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
@@ -5,7 +5,10 @@ Required properties:
  - compatible: must be "resistive-adc-touch"
 The device must be connected to an ADC device that provides channels for
 position measurement and optional pressure.
-Refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details
+Refer to
+https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
+for details
+
  - iio-channels: must have at least two channels connected to an ADC device.
 These should correspond to the channels exposed by the ADC device and should
 have the right index as the ADC device registers them. These channels
diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index d2a6e835c257..937b3e5505e0 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -72,7 +72,9 @@ Required child device properties:
                                                pwm|regulator|rtc|sysctrl|usb]";
 
   A few child devices require ADC channels from the GPADC node. Those follow the
-  standard bindings from iio/iio-bindings.txt and iio/adc/adc.txt
+  standard bindings from
+  https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
+  and Documentation/devicetree/bindings/iio/adc/adc.yaml
 
   abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
 			   temperatures.
diff --git a/Documentation/devicetree/bindings/power/supply/da9150-charger.txt b/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
index f3906663c454..033a9b6e1dd5 100644
--- a/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
@@ -7,7 +7,7 @@ Optional properties:
 - io-channels: List of phandle and IIO specifier pairs
 - io-channel-names: List of channel names used by charger
       ["CHAN_IBUS", "CHAN_VBUS", "CHAN_TJUNC", "CHAN_VBAT"]
-  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
+  (See https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml for further info)
 
 
 Example:
-- 
2.30.2

