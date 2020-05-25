Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9A1E115F
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391089AbgEYPNk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390911AbgEYPNk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 11:13:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B20C061A0E;
        Mon, 25 May 2020 08:13:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q8so1248162qkm.12;
        Mon, 25 May 2020 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+oCV4nRbYNUq3uy56ypQlMlQHdGFj6LYw1i9ejafKrc=;
        b=Ni4yXWC71m9yWzw6hnlFq8+MoeuGDA+C1jZn2PQK6A1G8OryU4zzvNssJ4Dgm8pJyl
         FjDWgFcnEa4cIA3uiamrl8Fwi9wGJHSn2knw5vqYeyhiilg55Z89+GCWvEZgeilOQ0o5
         Sw10Xp0YaRZ2VPG1v3kOge+ViI5f0/Dldzcpt0jMg/1MycA9cBgfzgXp25C1u/B/ZRNv
         7TmSya7XXwCXfE6bnm7vToVC5pbgfieZGg+0o4SOlY/hnA8iJX4HTMqzzL1OLaek2cqR
         ajtXTj33XT1PEQSGzsDsks4Pf11iP2toVWD83kl6WhU5hJTOIpl2tElGVEeTg4jzxsv1
         +orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+oCV4nRbYNUq3uy56ypQlMlQHdGFj6LYw1i9ejafKrc=;
        b=SVLm1rfpkir+nKZDI4CBpbOx1Q/MANC5DBOJeO2x2cS0qAdygnsrREm04G/OhGk1C5
         fTOCJnW2Fz1/Lp3rc0hv8rS8POL3l5/NRkZV+DXnYwzZBmwh2t/JTnRssfeNDvEZHCmo
         r9mClCaMzeLw0wJ7m4mXFcK/4CA2EfceIcoqJ5MptGRiOjruAzXQm1mn2b4uar24xoK8
         14eBBtGdZ7eo+krIOCDaKXYLbMX3BtA8egFNYoL7TtBelrUUAqf54jVJ4gphSx1repUU
         q5ev+u/4Z0c524/huMq2oT6SzskaG6kjeT8aboNpJNy5r2znfWrQ+c7p8pIrs0U/3Reo
         phnA==
X-Gm-Message-State: AOAM530weJVRAsTZW6Em4usBSp+T837rmzWWylXD69Mbph2iC0xvnC2D
        XQWZE3Dt+cPieu6jlt0lyVud4gF2hMU=
X-Google-Smtp-Source: ABdhPJzWpuoqyDq6wmhiJtMAUOFWz15qHfZD5TiuZO4MP7FhOBxmm0ED1lgoAw6vInophDbAFiPZ2g==
X-Received: by 2002:a37:4f97:: with SMTP id d145mr7008981qkb.191.1590419618632;
        Mon, 25 May 2020 08:13:38 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m59sm15161709qtd.46.2020.05.25.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:13:38 -0700 (PDT)
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
Subject: [PATCH v6 1/5] dt-bindings: iio: magnetometer: ak8975: reword gpios, add interrupts, fix style
Date:   Mon, 25 May 2020 17:10:35 +0200
Message-Id: <20200525151117.32540-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reword gpios documentation, add interrupt documentation and fix styles.
Update example to use interrupts instead of gpios.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
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

