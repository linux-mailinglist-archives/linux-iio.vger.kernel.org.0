Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED93CA06F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhGOOUt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbhGOOUs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 10:20:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00473C06175F;
        Thu, 15 Jul 2021 07:17:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so6168837wms.1;
        Thu, 15 Jul 2021 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WlcQjV1pVGOdbbJgTKcaNM0AAWDKgA3E4feJJrmCLBs=;
        b=JSHy2P38ya/DHrqRszHIyHx6r4x5mXZOeteeXd631reo6Y05ZYpWxhGAE284a6HkEM
         R5XejMxtLKqvpifIMWJvLQj1tc6u2qGnb8z5YRA0DGCFWZkN7loSKHZDNlrUIRfClmko
         Sm689jCIy8cLcMqShcpiS70Tltmtsd42p+IMrhXvw7uKqT9FaW/p19Ls/1l6x3USO+X3
         qJ9yKlszmesIxVb1QkDYNWQqRyI3/lAz0n7Jah7oWw3dD1xmpNkRJilQxCTKXfzwzqsO
         KBPA1yE/697sjqb+hzQM1tmSLCybn3g8c1/0hOR8RDAnb0S2Voap038l3YM2Bzgxvvrx
         MGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WlcQjV1pVGOdbbJgTKcaNM0AAWDKgA3E4feJJrmCLBs=;
        b=r1ch1FGIez8KIa0+5CAOWv1g1RPoPDCR0VrPiBZkI++sdRRP2DLGHNAo2wTFxBQswM
         IUKGbaxg8wZYfirfy2o3/si9zAF3xuwVJxENQLaril11xyhWqwTOyw/YvD+Euy8kQoEm
         E+Dn1v17pGeQEV3Z5fJe7AbUa8UxqMB8YaOYQtm3h+EJLlG70fF60gMoyZYJqUxMBu5A
         yq/BIcnY9U2Orim14YlB9n2GxcrkPCvBFi6LzRe0w0JuggBksNZsV70G1IWmr8ddGJ+4
         UcYvtwwgIkepTy/Quek21q6K2J6zSWykFVDiltcuOVnhXeiEZTEWi+Cmpyh0zT3s1OD8
         y42Q==
X-Gm-Message-State: AOAM530sMcM3UfrOLI68mg9Xwc0oOBTmvl5Dn1fMwFmD//dukKqp9Poa
        R3EpnJv+5Du8RweR67T4nCW8c8Ih4SRDmAiNs0k=
X-Google-Smtp-Source: ABdhPJwLU6f+GNqlVZ74sviIzwZHetRsfXAWmohgY9YwygGiXaXxK+QaqXsdPuHfUlud1LH9YSZi6Q==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr4794896wml.59.1626358672602;
        Thu, 15 Jul 2021 07:17:52 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id u16sm7989094wrw.36.2021.07.15.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:17:52 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     robh+dt@kernel.org, matt.ranostay@konsulko.com,
        andriy.shevchenko@linux.intel.com, vlad.dogaru@intel.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH 3/4] dt-bindings: iio: imu: add bosch BNO055 serdev driver bindings
Date:   Thu, 15 Jul 2021 16:17:41 +0200
Message-Id: <20210715141742.15072-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715141742.15072-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce new documentation file for the BNO055 serdev driver that will
be included in next patches of this same series

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Cc: Andrea Merello <andrea.merello@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
 .../bindings/iio/imu/bosch,bno055-serial.yaml | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
new file mode 100644
index 000000000000..743c784ebc94
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bno055-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Serial-attached Bosch BNO055
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
+  internal MCU for sensor fusion
+  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
+
+properties:
+  compatible:
+    enum:
+     - bosch,bno055-serial
+
+  reset-gpios:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+ - |
+   #include <dt-bindings/gpio/gpio.h>
+   bno055 {
+      compatible = "bosch,bno055-serial";
+      reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+      clocks = <&imu_clk>;
+   };
-- 
2.17.1

