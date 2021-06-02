Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8784E398AF7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFBNsO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 09:48:14 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:44650 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFBNsO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 09:48:14 -0400
Received: by mail-ed1-f41.google.com with SMTP id u24so2960270edy.11
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Je98vdwgGtbCcmC1tL2m4rsfwT5eXzFMJ/wydFAVxI=;
        b=qAZURPoO+mrW2955SUeqTdd3gBQzn3ww5H6OCwSZtqRdiUqGReDpbKkMkJ7+09XAs5
         kq/PnWEVQ8O6nOL1MDCo2ZHXupu21tSnCgqc1na7btj27JCKT4jUhcV0AG0cxxenKS1m
         +UxW46IpqFltfwSqPz4/hCkEWbLx2sCDmXeK7+UjZ3qQ4T1aJ/fEKIrCTn6f0LJyiwOB
         lRnMjMxUqKhPwy91nJZocyLAw4DxWWVqAqfcYUBGuOXON8Ibi4bWVzT55mcxzCyrSqBN
         f2cV8INcFhSBhM4UdLoTy4nBk1KVZ4UDN8FdTCV49qp1FUe0LOcl2kQXKcBg0eGAdFfh
         ABYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Je98vdwgGtbCcmC1tL2m4rsfwT5eXzFMJ/wydFAVxI=;
        b=gdYcPtqkOW7rhgCRVO3nLZV+AaTHQbBghHJuTrX6Vlz1eiSHHecscJB0nqBmppfg0d
         xyAGhiW6/BxxGxcMz2NlOz5sSATx/ewDQnL58OpjiupoU8mYfOfNQvUQdMF5S+jyLIFm
         4J9e2jPr44LFen9TLQmalBlu4rW0FoEkEj09lNiZhyauZ4UNb0Or1lfqxj1a0yHxH8T3
         icMzroPZfnvXcJzoseDgnyoL4E62PQyOolJiYTlcDURKNInNUf5p8HtMc88/N6f0VyCk
         eYYcVg9Xlkn4/pnT9Z1w81Y0vEZU4MVFyRRLiPt97SI/Pdn+vA06+8mmgJV5ZzKJUW6B
         xGxA==
X-Gm-Message-State: AOAM5336LLSqL1wWlBaOPkvxGzPaLfeKm4ubdXwU1dwL3YD4bYT1quSD
        9dzqsSIAXKMCiN9ertHtab9wGLvGAB8=
X-Google-Smtp-Source: ABdhPJwvO/ACc14d4Dmtv1yHqRGr32r69GMQ0fnLgLNj/NkpaAz9BJn4waCGCtaEGnWVBSmZkOXD7g==
X-Received: by 2002:aa7:d419:: with SMTP id z25mr15366665edq.2.1622641530333;
        Wed, 02 Jun 2021 06:45:30 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:bee0:f4e2:68f9:3d11])
        by smtp.googlemail.com with ESMTPSA id n2sm1372305edi.32.2021.06.02.06.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:45:29 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: light: add isl76683 light bindings
Date:   Wed,  2 Jun 2021 15:45:12 +0200
Message-Id: <20210602134512.193186-3-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210602134512.193186-1-chf.fritz@googlemail.com>
References: <20210602134512.193186-1-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds documentation of device tree bindings for Intersil
isl76683 light sensor.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 .../bindings/iio/light/isil,isl76683.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml b/Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml
new file mode 100644
index 000000000000..3e802a29892b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/isil,isil76683.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intersil isl76683 ambient light sensor
+
+maintainers:
+  - Christoph Fritz <chf.fritz@googlemail.com>
+
+description: |
+  https://www.intersil.com/content/dam/Intersil/documents/isl7/isl76683.pdf
+
+properties:
+  compatible:
+    enum:
+      - isil,isl76683
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        isl76683@74 {
+            compatible = "isil,isl76683";
+            reg = <0x74>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <20 IRQ_TYPE_FALLING>;
+        };
+    };
+...
-- 
2.29.2

