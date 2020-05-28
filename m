Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E750E1E64F6
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403929AbgE1O6C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403787AbgE1O6B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 10:58:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E6EC08C5C6;
        Thu, 28 May 2020 07:58:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w1so3344095qkw.5;
        Thu, 28 May 2020 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gzI5VT3HoLRyAyzvufJuU0rnVQlP8Cfplvh+aTwNJOI=;
        b=KEvXp2ETmxGb5UfS97Z7dC86BLXH8Ke8H2UHphVLV36mliF1c493OnRDRHcaC3mPRt
         BgFIq0i00r31XTm2i92stxp0f97+Bvuo1egxIvIYKUhDKEKQSDSz5Zhi5lH06pkutnN4
         SUvJRIJRgMxMBG1kilAEhkj5MIT0k2VJceHU92x+D7aCJpHg9hQLnJxAigjsZ848z/E7
         Tt/2kA4JfUPpfu6RyM+p5MQYLC/xH8R4ul1wf/hJJAZKNpnBThoWZObOmqmZcBY353dp
         IRs8Mf7plbctXT32WZFqCM9f+HgV1SeDNSpOBngcv1YUvhFXr4muwiazli7bIyMPOPys
         f7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gzI5VT3HoLRyAyzvufJuU0rnVQlP8Cfplvh+aTwNJOI=;
        b=tvpWgwXvwRd6fbVMJfOvollXEwjPifZog9gKfEiwmPd4jTlhsY7nPBPXnCZsrGD2Py
         8gI3mHz4bl0Ch3GZILP8g7zGzYBX89Eu8Z3FZz+QqQfKI/P/S6KdYnvX9fPyQ+FQWtAE
         GZlOmFW1DICps+OsWKVwP2JPROy9EItWeDQufteJ/KVXKPuJ0a2ZPafyz0yxVUSl2eX5
         QpZTOOb0w+/xr+UxTcUfxo7M8S/dXdHIhspiefmeGnIY+zLxZmE+TMJkr1jBFDMCtqx3
         Mgir1vBAxULnHe0a7n6EBp2G2E7wfRKazbiyfTzsXXkWZ/4iMhtQuORmrkSHXeI+z9ML
         2plw==
X-Gm-Message-State: AOAM532rErXRx7xin4VNNCfbBNEXFz6S4dal+8kFDOFN23JxDv+VKrRs
        f6uKwPp8OOG61nlYRgXpWfDUTGRXhXk=
X-Google-Smtp-Source: ABdhPJzUaDMzlKbRDkRY5VshnmUm0YPFb9V/m5sbZPcSMyqNGIlrVoK/gPx5NP9LGcwp+tVnN556Dw==
X-Received: by 2002:a37:a74a:: with SMTP id q71mr3273396qke.446.1590677879288;
        Thu, 28 May 2020 07:57:59 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id s74sm5116876qka.54.2020.05.28.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:57:47 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: iio: magnetometer: ak8975: reword gpios, add interrupts, fix style
Date:   Thu, 28 May 2020 16:56:04 +0200
Message-Id: <20200528145631.11608-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528145631.11608-1-jonathan.albrieux@gmail.com>
References: <20200528145631.11608-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reword gpios documentation, add interrupt documentation and fix styles.
Update example to use interrupts instead of gpios.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/magnetometer/ak8975.txt      | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
index aa67ceb0d4e0..0576b9df0bf2 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
@@ -2,21 +2,28 @@
 
 Required properties:
 
-  - compatible : should be "asahi-kasei,ak8975"
-  - reg : the I2C address of the magnetometer
+  - compatible : should be "asahi-kasei,ak8975".
+  - reg : the I2C address of the magnetometer.
 
 Optional properties:
 
-  - gpios : should be device tree identifier of the magnetometer DRDY pin
-  - vdd-supply: an optional regulator that needs to be on to provide VDD
-  - mount-matrix: an optional 3x3 mounting rotation matrix
+  - gpios : AK8975 has a "Data ready" pin (DRDY) which informs that data
+      is ready to be read and is possible to listen on it. If used,
+      this should be active high. Prefer interrupt over this.
+
+  - interrupts : interrupt for DRDY pin. Triggered on rising edge.
+
+  - vdd-supply: an optional regulator that needs to be on to provide VDD.
+
+  - mount-matrix: an optional 3x3 mounting rotation matrix.
 
 Example:
 
 ak8975@c {
         compatible = "asahi-kasei,ak8975";
         reg = <0x0c>;
-        gpios = <&gpj0 7 0>;
+        interrupt-parent = <&gpio6>;
+        interrupts = <15 IRQ_TYPE_EDGE_RISING>;
         vdd-supply = <&ldo_3v3_gnss>;
         mount-matrix = "-0.984807753012208",  /* x0 */
                        "0",                   /* y0 */
-- 
2.17.1

