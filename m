Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855AB3C1C4E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 01:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhGHX71 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 19:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhGHX7V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 19:59:21 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34AAC061574;
        Thu,  8 Jul 2021 16:56:37 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v17so3720410qvw.12;
        Thu, 08 Jul 2021 16:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfWmtWC1DQCyuvoSdz/5o8vZ+brkrmb+OabgpXUg65w=;
        b=juL5qIUy0bfdYwZCznZUKEyzGNE4GhlTBlCgMHQAzu7+bM/AhDwHcHS2jpSbvLYCOu
         4QKjyXgXIw1Ra0K7S3HjlW+xeORXgVK2OEaxzt/lCBVzoDE3u0NGdElgMDTDVy7IcBOX
         3scFIUuRZTIXCFl2ZAYbnK65S7aIJTu5NCn2RT0/VkOt2cP/d8I7KJNj8KOQkCngcbMW
         zmHqigWJ1ArFllFhRWqsf1V9uxwL1cf6fGE8NRPz655d6gqDZbaDGx03o4MTbMOA/qTf
         TSBp+Pv8uhqiOBsMGrZuU6CQ9+xHwGb7fBWivdGrGww9nC2FHvPGB3044EyEiOnUlWdp
         qdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfWmtWC1DQCyuvoSdz/5o8vZ+brkrmb+OabgpXUg65w=;
        b=ceWDdQ1PFonhtvx2HN24Konc6b9lZ3EGN+VS7Z+F+VYPYKHQ7v2gKq5gomOwTNyeOM
         QzLUrllZmFABhoY64oimrUuKRV6gPMc725LEzCdgxPsH5YqDoQ2w1CkemSAuTQCG/Oq4
         gj0oXTaA3ooF8wqbGOMCu2fgAqJ8I/Tf3VRSco/RnF/AQI48maSfCfMJVebJbzTydP3F
         IOXqSpqEYnppS0uYd6URIMYkzaE1TZUcrqnnnwMhjrR3sw6EaQ6IxwfO+7DQjTgBzH1L
         mL51PZIzDXIsDreVpxAPfOsPS7cY9BnF60d2po5TFkG7HZ1NhlvAYs59/94kKQd+xdm1
         ViUw==
X-Gm-Message-State: AOAM532ig1uW7175v6HcIQkOoXCo1zHMVK+2KVSrsAzoCv9C4XhRb7Wt
        6RVX5DeBbIMlV8iQHknzzDI=
X-Google-Smtp-Source: ABdhPJzlpahJYZqrm2XcpeaARoi6Vly8KeK1CjQ71DPGoy7NXsKfxwGEln8j/+8GxpwhJ/Pd0ZRCVQ==
X-Received: by 2002:a0c:db01:: with SMTP id d1mr17923670qvk.38.1625788597126;
        Thu, 08 Jul 2021 16:56:37 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m68sm1733234qkc.109.2021.07.08.16.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 16:56:36 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 4/4] dt-bindings: iio: adc: ad7949: add adi,reference-source
Date:   Thu,  8 Jul 2021 19:56:18 -0400
Message-Id: <20210708235618.1541335-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210708235618.1541335-1-liambeguin@gmail.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add bindings documentation for the adi,reference-source property.
This property is required to properly configure the ADC sample request
based on which reference source should be used for the calculation.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../bindings/iio/adc/adi,ad7949.yaml          | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
index 9b56bd4d5510..3f4629281cc8 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
@@ -35,6 +35,28 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  adi,reference-select:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2, 3, 6, 7]
+
+    default: 7
+    description: |
+      Select the reference voltage source to use when converting samples.
+      Acceptable values are:
+      - 0: Internal reference and temperature sensor enabled.
+           Vref=2.5V, buffered output
+      - 1: Internal reference and temperature sensor enabled.
+           Vref=4.096V, buffered output
+      - 2: Use external reference, temperature sensor enabled.
+           Internal buffer disabled
+      - 3: Use external reference, internal buffer and temperature sensor
+           enabled.
+      - 6: Use external reference, internal buffer and temperature sensor
+           disabled.
+      - 7: Use external reference, internal buffer enabled.
+           Internal reference and temperature sensor disabled.
+
 required:
   - compatible
   - reg
-- 
2.30.1.489.g328c10930387

