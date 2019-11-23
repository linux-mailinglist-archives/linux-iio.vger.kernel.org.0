Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30F108113
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2019 00:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKWXgF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 18:36:05 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:42351 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKWXgC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2019 18:36:02 -0500
Received: by mail-qt1-f182.google.com with SMTP id t20so12545502qtn.9;
        Sat, 23 Nov 2019 15:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2od3CCfgH/wIJisYHutA7VGKvbA/ioFGgCw20B9AbCQ=;
        b=aVRPkvGbxERhDbAG8Ocv8JoY/lx7E3zCK+HMvmy0zK/T+ZOHuhS5Bjgd6h1wXmkVbP
         JYq7hmz23+kDhPYYJpZpLIXdCyBrb2E+kw5BJGyBxfgmTZRSIaJHFZ0CrDMxg50kmHsp
         6TnrKhZbTFV9i0J+Hp8Ln7IQhM4oDmtodv6LnY9VYg+7iJzcCr4l+gUhVscdOz48vwRP
         GLKHjawSPd5dJfwlw3tTIb49UWFWKYPvHqLoDznjCaFFAVZoMrRHfGNwtT2qZEcEV04m
         7fDjZOjf9+Ra8YcjpSXVxycuR7s4FrUNiZSCJBIAcVN7uxF3SXyF2hM/H3SoiiiUNYOy
         HvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2od3CCfgH/wIJisYHutA7VGKvbA/ioFGgCw20B9AbCQ=;
        b=bcXchlhavyhX6WlkTqjTRj4fhBZn1FnFmZy3ccUndq0Jat+EXc7m79Hp4S3HlcthIJ
         jkE8AYp0l5odjfObLKhn70D65jSzTV0m8SkeXKqLL2Ca10WxfT+Z5MO3XjXHq4RkWzNz
         ur3WLZM/n0w1gzIDE4xV16uJLhvqt9stjp5tayyTUdphdpe2yVyZOLFGytTM8llRYI8w
         /kG+9FMbqbCw7QovEJfjL7S2eXzK3GAQ8L1LyiuMdEbsx/inwQKGoxkV1UFxRhzcNx9F
         yYsyGYZTMNoqYdhHf8nLznVFXcKoQABMNQ9Ub6Abr0sXhKngsYPLu/pduDFJ4/x5Kuqn
         x6rg==
X-Gm-Message-State: APjAAAUV6V/3z/ru1AmtJAltTx1zbscscMwioLpvSmEHo34WR2RLLu33
        b1QcOQJr6dYl5Obqkht1fRM=
X-Google-Smtp-Source: APXvYqwiW5oPSsRKtf1m5y8Vp4pPXQoOpP371XN7h1l7Y0p0ha1FctguEtstT6uIp6HcajHDmWmkVg==
X-Received: by 2002:ac8:424e:: with SMTP id r14mr4386591qtm.193.1574552161525;
        Sat, 23 Nov 2019 15:36:01 -0800 (PST)
Received: from localhost.localdomain ([177.76.215.166])
        by smtp.gmail.com with ESMTPSA id f22sm1357518qtc.43.2019.11.23.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 15:36:01 -0800 (PST)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alexandru.ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v5 2/2] dt-bindings: iio: accel: add binding documentation for ADIS16240
Date:   Sat, 23 Nov 2019 20:35:10 -0300
Message-Id: <20191123233510.4890-2-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123233510.4890-1-rodrigorsdc@gmail.com>
References: <20191123233510.4890-1-rodrigorsdc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add device tree binding documentation for ADIS16240.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
V5:
  - None 

 .../bindings/iio/accel/adi,adis16240.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
new file mode 100644
index 000000000000..8e902f7c49e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADIS16240 Programmable Impact Sensor and Recorder driver
+
+maintainers:
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
+  SPI interface.
+    https://www.analog.com/en/products/adis16240.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16240
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "adi,adis16240";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.24.0

