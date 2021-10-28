Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9943DEA8
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhJ1KVk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1KV0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3343C061767;
        Thu, 28 Oct 2021 03:18:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 5so22084472edw.7;
        Thu, 28 Oct 2021 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9BUjl4okxY8aA7pzaomcnAeXCAIZPbq0hI8y6lGNmQ=;
        b=PZopLnown1hyTxRpfjvh4LRSLKC7VTjLpbJjoAI3RMYcotcLbPxPnye91j6HE4+6Gj
         EtMC/BsrOLr8U8OGhw1X5VkmZ9yXbsyIamPjwOyh1O2RkT6mgk/tqx7beKOYXI1pxKtv
         y2TEV1tdmeFKkTRKWPMZU1wtaBaCDpz9XKfd2GjiC59uh5VNtbTYDD+i9ocdGQQHjt7j
         rfeguU7dxYshK24EBvkuV7uONE4qxusE1hj97G9JLLhacwy40EP1sC3wdt/bd7umq8jC
         OHHjPxQKv5WgfwelgLfLiF9AwTmKXgPmWTC2DBdB1tz1TBghiUMxF81Xt6s9hUOMxUsb
         voXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9BUjl4okxY8aA7pzaomcnAeXCAIZPbq0hI8y6lGNmQ=;
        b=RjvMTqRwDwSV84BVkg6GUL+iCFJIGpkq7zJ3iCFZOlhtlOewnGORAnnpHN2WknKrXB
         BqSqdQTSyyyRobh0lMhJ930zlisSmOGgdSD1CBYeL6wNFnfX5lR8Oa+tHeFppYQsITGA
         66Cm5LccAqaDdOz642XVc3fsPPU3ix55wI8DW5MD2/K64KccWKIv0lfnROds7A4WNBdt
         by/tHhhYquIAHfciDqOXlKZk1aYM83oWwwmoH46zyze+Bl5XZlBHtaifEpmbm5qb7slO
         4YRIY1wkRbpCePuABVyuObRdvDBQjcEGpPuRJrhhXdRYQzFGglk/eMnVgisBN8O9eUqc
         7q+g==
X-Gm-Message-State: AOAM533OdJ2PhTCEcw4CWoDvXNfwp+zDb77pMultHe/rRApgAPYIl9zW
        P2NfGNwwoM29Fv+DBY8hISE=
X-Google-Smtp-Source: ABdhPJyedGf5W8+dk2RsvAACI85c2zcwub/MVdOKonhTQldDUOp1NRQhsXYh/qufwzTQHgixlWUO9g==
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr4292948ejy.170.1635416336759;
        Thu, 28 Oct 2021 03:18:56 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:56 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 08/10] dt-bindings: iio: imu: add documentation for Bosch BNO055 bindings
Date:   Thu, 28 Oct 2021 12:18:38 +0200
Message-Id: <20211028101840.24632-9-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce new documentation file for the Bosch BNO055 IMU

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 .../bindings/iio/imu/bosch,bno055.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
new file mode 100644
index 000000000000..0c0141162d63
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bno055-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BNO055
+
+maintainers:
+  - Andrea Merello <andrea.merello@iit.it>
+
+description: |
+  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
+  internal MCU for sensor fusion
+  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
+
+properties:
+  compatible:
+    enum:
+     - bosch,bno055
+
+  reg:
+    maxItems: 1
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
+   serial {
+     imu {
+       compatible = "bosch,bno055";
+       reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+       clocks = <&imu_clk>;
+     };
+   };
+
+ - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+
+     imu@28 {
+       compatible = "bosch,bno055";
+       reg = <0x28>
+       reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+       clocks = <&imu_clk>;
+     };
+   };
-- 
2.17.1

