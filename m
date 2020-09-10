Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE326462E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgIJMjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 08:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbgIJMcz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 08:32:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174EC061756;
        Thu, 10 Sep 2020 05:32:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c196so4684704pfc.0;
        Thu, 10 Sep 2020 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mEwZSmSPM9tJPXbfj/hisKYRPYb4G1wKBGhUAXFVXQE=;
        b=QQyE+kittH/tfmJ8ZNi17jn05QZQZcXwMXVymiKtSy+2DeXb1jiT3escHBvEh6nBkR
         N88tlDY4zkfS37XNjX8SIuiq73jsc6YnrdrzA0t1dU2T2teWmUc2+DzpOA/8ZAtN5wNs
         +7b3EL7XVaNrhEX3l6z54aV0/P3PLQGCwEtcf3mdgUZJZ+1IH5g7aOTRY+80M6ykaEjE
         W9wHsMdf7Ii9vErVU1ctuZ7zBc33XwdDB9NDd93mll4W9W2Ayhlf03qiMEIiA3ilo89s
         z1wfC/PhdoTHEdGcuufJztn+lVo39fiNHxrCIK+IiuXNLL5FdM1D/saoqSFHIG8oh2Un
         /K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mEwZSmSPM9tJPXbfj/hisKYRPYb4G1wKBGhUAXFVXQE=;
        b=E+cNJO1uin1vPr8ATnylU5fSGCTi9rVpWsAvV5c0GJ60IPMUrS6aVVBBkUNDKDj2MS
         7v7x+F9NSAX6kbGgIoqIoeYPEmfiMF3vTIc5g5NSQllqvLejuveHW9IzXXEd2OIXlE+k
         bzEvsR/Vxc7jkQwEGdl09MlSTdaGKAdZ294SYDTfT+TjveFqRHHj08A0qSLEDwDem0N0
         h/rcC7dErP3QG6Ndw/rRgv2WDqYrq++hw82fNashmL6Qd0pNhyPCmT/piJ5LJC7bhAOM
         7xMtOYW4HOQIgGS78FKOZZPPy3KnAE/91iYREm1ABQAbM5UijXcCiBy+eo+wntq8VgmJ
         BrwQ==
X-Gm-Message-State: AOAM530nJ5DLYMz4hjhfXh6JpBCCa274icD41BIx29RzvP0kAHy46iRo
        RRKLYgb/HikTOjzfRdXgVIBHSc1uFfQ=
X-Google-Smtp-Source: ABdhPJx4LbkZbNn0hXoKo43LaWN99HPlceHJPG4X2zeKOzevSUZD1WXT6hmjCiUOacSfeY9fy+eduQ==
X-Received: by 2002:a63:4d5b:: with SMTP id n27mr4212074pgl.360.1599741162699;
        Thu, 10 Sep 2020 05:32:42 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id c1sm5799309pfc.93.2020.09.10.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:32:41 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: iio: gyro: adxrs290: Add interrupts support
Date:   Thu, 10 Sep 2020 18:02:36 +0530
Message-Id: <20200910123236.17141-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Include 'interrupts' property and provide a suitable example for using
a GPIO interrupt line.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v3:
  - remove gpio.h header since unused

Changes in v2:

  - remove 'interrupts' property from the required properties list
  - rewrite commit message
---
 .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
index 61adb2c2454b..662ec59ca0af 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
@@ -28,6 +28,9 @@ properties:
 
   spi-cpha: true
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -39,6 +42,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -48,6 +52,8 @@ examples:
                    spi-max-frequency = <5000000>;
                    spi-cpol;
                    spi-cpha;
+                   interrupt-parent = <&gpio>;
+                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
         };
     };
 ...
-- 
2.20.1

