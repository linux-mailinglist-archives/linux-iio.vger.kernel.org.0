Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8395C182B59
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCLIfj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 04:35:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40321 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCLIff (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 04:35:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so5213414wme.5;
        Thu, 12 Mar 2020 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pi3izNgFJ8/Wn3g5uvUevM173nM22Xr7mDvSE98uAq0=;
        b=iygKix3k8tYPew0DKefQ5Z3MJaVCjgGhTqZe0HktLhOZJ0uvXqTFifYXCVCwh3ZzF4
         0yI8jvldsCtQupNBwiNphiv+f3kZ59gOb5wgRZHEp9G53cwdLzyIAt2z7MLNUac7QSZb
         6BsssXqFOwd0NXGJgSm6t1FBu03bM8TsAQN+Z4ZRBcuH3ktOIFWCz56xAvlHjPLeA01k
         a8ex8c0lYFwYate9tpLOPqLOkmJZbQRoK8f2X+dTaUq6praU77An5bj00F0BpwuJ5146
         K9083ddJom6yX/OCDQFxZ06zIlqNJodLUgVZ1nY1w4VcVl1AFy0xwyF1nK16X8yu6z9b
         iZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pi3izNgFJ8/Wn3g5uvUevM173nM22Xr7mDvSE98uAq0=;
        b=DC8i2dS35kXUaPQf7vuxlFlwSY04sdcRIY7hiEImNlMuf80uit0jW5zg0NnmD5wdX5
         noxZ9FzQVHcpy95ZJe0iiXvGJruHhgtSYeXJ2DhXK3gsCkhZXb+7WMLh34MJhPbjqekn
         PpD7a4uUrpBSg7veJkg6ZVbeYDGV056O4bOk8UzB46ooXCzxFgkHlPSyukYWogsQt60q
         oW4aCdUNXxOEjIkiZ/fhahnfZL29/F7vP/xkbTtWlb8dnCOSg34EKtNvlQ5jZl/uEbqR
         gLL1k3g7TYWtbYZb+3Hu0MY+on95jxAdamAE/75tXvy7nqQptyLlVpLPY6S7wBmcXS0O
         5p3g==
X-Gm-Message-State: ANhLgQ22s8+EsaG/kbzlVqnBe9g1+D/m9ekZ7rI6PexQlHbr/b5hLAyq
        dfMj3NXtrTzsPept9asGGwmP8kzff0I=
X-Google-Smtp-Source: ADFU+vvooBQ3lq8YA/+dE1Gl1upXgvevHPgfCB3c4nxm763tXD7qjzpNoNXZar8lY5x3PRGFC0cXiw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr3578623wmh.36.1584002130671;
        Thu, 12 Mar 2020 01:35:30 -0700 (PDT)
Received: from localhost.localdomain ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id 9sm11543334wmo.38.2020.03.12.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:35:30 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com, Michael.Hennerich@analog.com,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v9 8/8] dt-bindings: iio: adc: add bindings doc for AD9467 ADC
Date:   Thu, 12 Mar 2020 10:35:11 +0200
Message-Id: <20200312083511.28832-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312083511.28832-1-alexandru.ardelean@analog.com>
References: <20200312083511.28832-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds the binding doc for the AD9467 ADC.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/adc/adi,ad9467.yaml          | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
new file mode 100644
index 000000000000..c4f57fa6aad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad9467.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9467 High-Speed ADC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital
+  converter (ADC).
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9467
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: adc-clk
+
+  powerdown-gpios:
+    description:
+      Pin that controls the powerdown mode of the device.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Reset pin for the device.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+          compatible = "adi,ad9467";
+          reg = <0>;
+          clocks = <&adc_clk>;
+          clock-names = "adc-clk";
+        };
+    };
+...
-- 
2.20.1

