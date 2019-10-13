Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818D4D5675
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfJMONw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 10:13:52 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:34276 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfJMONw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 10:13:52 -0400
Received: by mail-qt1-f178.google.com with SMTP id 3so21485097qta.1;
        Sun, 13 Oct 2019 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LfdlAAMgQUQxeFcddb3RmfQ4HHSumyOT5O7MeMSz7Xw=;
        b=uDAmp2+QMcnO6pjdQo5G7D/ywYCksgRXhZs/Ceoy2+9TlFVemiNZwqExsAoYbfO4VG
         7SpeIyJPRrF6iffxj3IQVPyoxMr2GlmNYo6QV/BE9amhzUUBr1Ais5CP8RfrU0wp5vOd
         +ucj07RXuliPqGSwADAwnu46geMfD//j5Qoc6ZtD8CXbm78CVMu1Neqg8GAyKooT7Xrc
         C//TTDPBJGydmC7u2DPtqMQpo7do+GiiWcmrnMrHrLs/wD8TWxdgUDATLiWfr8XdaVZi
         HQ9HidnZ4BapeslX3uRpblwzJyIfitNjAPR6K+Ae8/C100tiVEMEQqjpD747R1Zbe/nG
         cjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LfdlAAMgQUQxeFcddb3RmfQ4HHSumyOT5O7MeMSz7Xw=;
        b=QFgXwj0j6nGk0oNmQspobmzMON9lLZJ6ZFKmeVVeoMWLHt2DVQYv16VdYNpc2wuEwi
         p9PFTUMGyLdlypkSdMNb712zBYlHP72IDB5g1clurTXQkLfv6elVxvClyQBHrh0P5Rb5
         CupHilvKL4KaD9j6bsTnSgEYFy8Rh+tlIfd8YrZz0xNQK2NryJt6iljQHAQv8JjIg7dM
         rIL5KaKvCFQLzrM5/7Sd/r94REKcgaV+PMoNhxeCkdVkfdSMtXskkTeXQ1oAmsoJpxNu
         A3B/SQORjmolUkQUA/pt5HNycoPFCoTW3I4qtRUCDZZm4PhpE7lZEBKvEQJNa2vNuvvH
         LcjA==
X-Gm-Message-State: APjAAAVIUBcv33dWq5MjMP7pkMh5vnwFR4RCWCOpODL6vqpb0XK6ZRPc
        b+RGzyK9q+AB56OkJXWYQ/I=
X-Google-Smtp-Source: APXvYqxvyACioIrCNHx5jP4FTIhVCL7rT4kbeS8yHQJ/TikU6NpZ+5SFBAcAlw2zWzu6LGyaPfWCjA==
X-Received: by 2002:a0c:f8cd:: with SMTP id h13mr26501795qvo.53.1570976031439;
        Sun, 13 Oct 2019 07:13:51 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p36sm9806214qtc.0.2019.10.13.07.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 07:13:51 -0700 (PDT)
Date:   Sun, 13 Oct 2019 11:13:47 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        stefan.popa@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
Message-ID: <20191013141345.uctcutryo7pmdkem@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a device tree binding doc for AD7292 monitor and control system.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../bindings/iio/adc/adi,ad7292.yaml          | 71 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
new file mode 100644
index 000000000000..16be9ea4194d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7292 10-Bit Monitor and Control System
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
+
+description: |
+  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
+  Temperature Sensor, and GPIOs
+
+  Specifications about the part can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7292
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: |
+      The regulator supply for ADC and DAC reference voltage.
+    maxItems: 1
+
+  spi-cpha:
+    description: |
+      See Documentation/devicetree/bindings/spi/spi-controller.yaml
+    maxItems: 1
+
+  diff-channels:
+    description: |
+      Empty property to tell whether VIN0 and VIN1 shall work as differential
+      inputs.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad7292: ad7292@0 {
+        compatible = "adi,ad7292";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi-max-frequency = <25000000>;
+        vref-supply = <&adc_vref>;
+        spi-cpha;
+        diff-channels;
+      };
+    }
diff --git a/MAINTAINERS b/MAINTAINERS
index e78317a5f4f1..5941cfc0d6f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -819,6 +819,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7292.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 
 ANALOG DEVICES INC AD7606 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.23.0

