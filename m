Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F72B397A
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKOV0i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 16:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgKOV0h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 16:26:37 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A095C0613D2
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 13:26:37 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id r9so22345391lfn.11
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNRQyWFC1luLFZtivM+492qWfKb/Alm/CyFKDv0IwIk=;
        b=qptWnQmU4BdfqZIMN1EBPAGW03FyLftg+ifITV0ESGN4n7AhriRM1w1TVgtPR0lR05
         afpqmLFLJ8G14NcBgWEm5oe7vTPpMyB3UVMZOlet2IFOPOtdsak5Kn7gOlvSgPw1UNyo
         dUhjlc4R80cfYiZYP1RgLWHQHmRgtwdrh+hqIEBESkC9BEv4jxVbPKtukwDXJo6SOCEH
         UUTULfWZPglNqugPlDN7Cq5ctClZsQylncu+FwMHCTSIgam27SgxSD3TETzNFko3x2o/
         b9D3R/NMrnJnzpwc5juP5wNv0lZXRWw2BHdpfRdOB8UvU0RIaT4H06H3uiUOWEnb/9LT
         0hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNRQyWFC1luLFZtivM+492qWfKb/Alm/CyFKDv0IwIk=;
        b=H70Yj4eB/bFc5KR17I/OVjJW3ett68TmxPqTqKBLIBEGdxTfnrh9gZLeW9+j3zo8NJ
         jbaRJ38CJobneEXOKrhHkTLEdkaN6JI3BC9vVoVSpjGee/8BVxVb/mWdwdpfb2Hpyx0o
         BqmcRhCQnyPDnlzbNuFj17QIle4tVvyDH5MqrVsxht0o7FavJ39UCHIjIfN53dzKvRpM
         pjLXrCK9i82q+su79qn/Vz7IjH9mXH3KD2gUKsk26Ocnn7rhBgY2frbiKWrGqgZpI/6b
         dC8MO6+FpSYbjvf4qb4TqMHJ3leGFAzJLv9vcQlvYqK23gyzKYoETrkq9KiLwrak5ND7
         aF4Q==
X-Gm-Message-State: AOAM533Y57rbChrCvfQkJIrBfUhnhnS0m2V+ywZorkO3vOwjkuf8rNty
        EsPlVb/pfVIZSQmBs9JXW00Tjw==
X-Google-Smtp-Source: ABdhPJxY8kd4liFU4EScdfDKyBLDV2sRnpoZjaBf0jexPmSErEm+e5arQidaIcDvvL94LcnItvQgXA==
X-Received: by 2002:ac2:490f:: with SMTP id n15mr4654541lfi.158.1605475595659;
        Sun, 15 Nov 2020 13:26:35 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id p204sm2482178lfa.168.2020.11.15.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:26:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org
Subject: [PATCH] iio: accel: yamaha-yas: Add DT bindings
Date:   Sun, 15 Nov 2020 22:26:33 +0100
Message-Id: <20201115212633.626241-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds device tree bindings for the Yamaha YAS5xx
magnetometers/compass sensors.

Cc: devicetree@vger.kernel.org
Cc: phone-devel@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I am still working on the actual driver for the magnetometer
but why not send out the DT bindings for review, the
hardware variants are easy to describe.
---
 .../bindings/iio/magnetometer/yamaha,yas.yaml | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml
new file mode 100644
index 000000000000..6fc4cfe4a417
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/yamaha,yas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Yamaha YAS5xx magnetometer sensors
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  The Yamaha YAS5xx magnetometers is a line of 3-axis magnetometers
+  first introduced by Yamaha in 2006 with the YAS529. Over the years
+  this magnetometer has been minatyrized and appeared in a number of
+  different variants.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - yamaha,yas529
+          - yamaha,yas530
+          - yamaha,yas532
+          - yamaha,yas533
+          - yamaha,yas535
+          - yamaha,yas536
+          - yamaha,yas537
+          - yamaha,yas539
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: The YAS5xx sensors has a RSTN pin used to reset
+      the logic inside the sensor. This GPIO line should connect
+      to that pin and be marked as GPIO_ACTIVE_LOW.
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt for INT pin for variants that support
+      interrupt generation. This polarity, whether the interrupt
+      is active on the rising or the falling edge, is configurable
+      in the hardware.
+
+  vdd-supply:
+    description: An optional regulator providing core power supply
+      on the VDD pin, typically 1.8 V or 3.0 V.
+
+  iovdd-supply:
+    description: An optional regulator providing I/O power supply
+      for the I2C interface on the IOVDD pin, typically 1.8 V.
+      This is not present on all variants of the component, some
+      have only the VDD voltage.
+
+  mount-matrix:
+    description: An optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@2e {
+          compatible = "yamaha,yas530";
+          reg = <0x2e>;
+          vdd-supply = <&ldo1_reg>;
+          iovdd-supply = <&ldo2_reg>;
+          reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.26.2

