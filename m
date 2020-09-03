Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D112925C45D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgICPJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgICN6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 09:58:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99482C061247;
        Thu,  3 Sep 2020 06:10:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so1444244pjb.5;
        Thu, 03 Sep 2020 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7a9czeHx1WaehdjYOh4c7Ybw7Lr7mUZE1bLwOuZyr+k=;
        b=uDQKIdW6nFsQhpyMvKSXhPBLoW4lNZWf3KnQPF/INyG3dnqvwClq7KFVMQUzr63bIl
         CNiFIEBaqS6rLKVAddY6n+QUuJfvY6sUbDOIS4tuCkO6jmiEWxC3ul08yTwwSD45kq6f
         SpVlmPDDsuZZ6YzOo9AnTnjtINWpUigZHBw3Gz4Z/30QrELWOklVZeh8m/GdtY8k1eTk
         i0WodxY3eVSxjSfRMvhDZPe+eXSZwf/cOpuB24fTcUKUWCB/Q/iNKNIZk5qmhEkDx9eJ
         gOF7DK5qT5h51Oh8ucSvnUG5DoP69Io2xp3tsq/vE5+Yqn8Yp8m0Xj5Z7VGpPHcR/9cM
         YAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7a9czeHx1WaehdjYOh4c7Ybw7Lr7mUZE1bLwOuZyr+k=;
        b=P324reEtF5wjaj3I8AjFYx7C8jybvPoHOuBc1U2id7xbe9s68ctbGjV0mJ6Gkue3Df
         VttG5objxZfk3AlUvyqwo8HdnKEQeWLZj/ErKq1Hkl/o5Kl1QD7id7sY0Wlgyp045HKc
         MCg1waWV6c630+xq6qWFR19lHoCgNlXUgwZAw6uYD4GnWmSXLscZYPV3l9abZoTxTKQq
         VUPGptY5VUXTD/YjueyVTFjlU8RSdZob8HmImhzDNL0F4zsTWh2usKK7Hf+l7towcTqo
         ThukNfkMwYdHLDCmG0NUiduS5XjuEsNGHFHVtn5STvzIR3i5rib3gNQL/Cj7pY3mwEny
         heTw==
X-Gm-Message-State: AOAM5329gU9AAzTKiBvOMn6B0zXunLQucCUH1iV2qc4Jcb+xLd4DOEBv
        Bp6i/nAt+4bKRTKONKlVzy0=
X-Google-Smtp-Source: ABdhPJzkp3rDbFqzGkkdj3P3Q5mTKZgz9MZmbQHQVVLRXloiMwmwITc8VOGi+MgiXj0Bm2my5d0pgw==
X-Received: by 2002:a17:90a:fcc:: with SMTP id 70mr3097179pjz.220.1599138609200;
        Thu, 03 Sep 2020 06:10:09 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6085:e35d:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id o23sm3052249pgm.18.2020.09.03.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:10:08 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: gyro: adxrs290: Add interrupts support
Date:   Thu,  3 Sep 2020 18:39:49 +0530
Message-Id: <20200903130950.6274-3-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903130950.6274-1-nish.malpani25@gmail.com>
References: <20200903130950.6274-1-nish.malpani25@gmail.com>
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

Changes in v2:

  - remove 'interrupts' property from the required properties list
  - rewrite commit message
---
 .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
index 61adb2c2454b..a5f209e8bbef 100644
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
@@ -39,6 +42,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -48,6 +53,8 @@ examples:
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

