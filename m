Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102EFDED92
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfJUNbb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 09:31:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37194 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfJUNbb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 09:31:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so8447419pfo.4;
        Mon, 21 Oct 2019 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tvfcF9sNk5GoSAibZTw0PFIKkXsPwPf4R4XRzM0V1GU=;
        b=CJngm68J5BwmBgJ5GHAYBbFcbgEg0f/O5awSVDnnm/ztGPorzN6Hl65wtrSvRa3GhB
         qs+AUtRSc+V8nMw7kcE/524TmR+ClIjJwm9hLg5ZnhCo1j6xLy4LI35Iu7gACJv0nHpf
         +w/z3sqDYXUF3tv3n1Kf0foIWTSkTxJi3F7ivFl/eyxpGpMTP1GgdfcVjFMGgO7OVPh5
         GGVgVii0dDOg0pUL5GgdR5PF4Ybx9An046biHIIHAY0hMXn1fdS9JQ2r4qYf/LNC9tj4
         w//GoPg0GTV4mLOAJR4GJbBgyNWlRQ6zrttmxb/SwbU1Pu7gnfSpVrRoYpRdjr12sOlc
         OCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tvfcF9sNk5GoSAibZTw0PFIKkXsPwPf4R4XRzM0V1GU=;
        b=OTTm0HEcvvlAJwtOs750mVk74TKJURuG5VCbDrnBUcLCEoLkSOGGL1QlrIXfJqWDT+
         YD5zXvVih20/6Sx5nACOcXkvOxVz56NCp03VYFzITJR1LzujkXP2qCA5+VR8eh7LU8wv
         Rp58FqGbu+SaptiLpYMC1psQfhO2TvH47uzbxOwwea7uCBgWOpFZbstdSCCo2tR+TBtC
         6nIBU3Vx+cZ7F2erM1xObDXC0qN1I2D9GNh6yNj7/9w1InAA6ceQtuXnc1kASrfq5TIk
         uNBkv6D4cSgrcBMVajkrVC+D2F7oy8NSGzuJ49fg/AKasEJTLmjCMqjJoFc7goSvXoPG
         WoIA==
X-Gm-Message-State: APjAAAXT105rQjZ2UlzmPBasuUKPdJlqxI8jve94bB1UWunAdoIqkVYo
        BDa5eoq97DvNKZC009xIlPc=
X-Google-Smtp-Source: APXvYqxa6Lkz6ZrDpFQMeNSdzqPnbGRSFuZe1+Q2OyjPdmnBwe+J4jFynJnoLVafO9w2tzAo8gx4Kg==
X-Received: by 2002:a65:64da:: with SMTP id t26mr25517401pgv.180.1571664690283;
        Mon, 21 Oct 2019 06:31:30 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.0])
        by smtp.gmail.com with ESMTPSA id t13sm16861068pfh.12.2019.10.21.06.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 06:31:29 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
Date:   Mon, 21 Oct 2019 19:01:17 +0530
Message-Id: <1571664677-6984-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20191005151404.5fc7386f@archlinux>
References: <20191005151404.5fc7386f@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds device tree bindings for veml6030 ambient
light sensor.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v3:
* None

Changes in v2:
* Corrected grammatical mistake from 'is' to 'are' in description of bindings

 .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
new file mode 100644
index 0000000..969b314
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VEML6030 Ambient Light Sensor (ALS)
+
+maintainers:
+  - Rishi Gupta <gupt21@gmail.com>
+
+description: |
+  Bindings for the ambient light sensor veml6030 from Vishay
+  Semiconductors over an i2c interface.
+
+  Irrespective of whether interrupt is used or not, application
+  can get the ALS and White channel reading from IIO raw interface.
+
+  If the interrupts are used, application will receive an IIO event
+  whenever configured threshold is crossed.
+
+  Specifications about the sensor can be found at:
+    https://www.vishay.com/docs/84366/veml6030.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,veml6030
+
+  reg:
+    description:
+      I2C address of the device. If the ADDR pin on veml6030
+      is pulled up, this address is 0x48. If the ADDR pin is
+      pulled down, this address is 0x10.
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt mapping for IRQ. Configure with IRQ_TYPE_LEVEL_LOW.
+      Refer to interrupt-controller/interrupts.txt for generic
+      interrupt client node bindings.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@10 {
+                compatible = "vishay,veml6030";
+                reg = <0x10>;
+                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
-- 
2.7.4

