Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3505F35A61A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDISua (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 14:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISu3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 14:50:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F479C061762;
        Fri,  9 Apr 2021 11:50:15 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c3so6863333qkc.5;
        Fri, 09 Apr 2021 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TxCHjocfvolgLMKcJMUAXR2MQWXiJcrJ6XGdnV3UFSQ=;
        b=ojboIib+LAJLAK2R8WPLMMcSqk+duxlFCwkfYsg9J1bKE8gUkzMQqCqRLq0H6K+yl3
         pbhzBrbhRrg6OuSvzamOvj6kwcyqFhGPnfTfXTZOQ8/PpbL/S1gukY53VzZZUY+U0Md3
         XB2U82/29krHpOWRH35hesUBKWShbwez+UJeH72RQq8HdVJHcFcP9+HJlIJpHON3K/Qw
         iGyLrK9p9Wk9re3dsgV3XuZPokr00Ip5i9zdmB/vnZ79OitE6rM1fS84og6tFNKwGYPl
         J2RF1mzWKZ3GKtfSMcQIUulzby/dxVaiYssy+l0C7k1BvA/YDXW42KV9VW4lD0v2N/Ih
         E1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TxCHjocfvolgLMKcJMUAXR2MQWXiJcrJ6XGdnV3UFSQ=;
        b=nwPL/IuUp0vH6Rvxajot2FXHr+sKboPwoEQy65tdS2EmWFluSw9dpwmPX2QAng+6vG
         DnP7s9AKAREmZ4ptnfqIavynQ/92IXOG9SAZnxZnY8HqQ8vR2czopVWiwAYc7vSsda9E
         DwHbE8GnAiYf3PoMnyFX7BaUxXPthSO7dvET7+nWbUxWg0mQp+VDWa75HRyK90A+20J7
         laCircWymZqjIKNQbk4al01lVGL7uMNa4y3XC6bHdcpGAaLO78SuZvZwPrmEv1fquk6i
         kjwVgQAK0sAXj/ZfhMhJHUd2nNeSf0QxBfW385Jxm7TGXFxp8eJXuvmpZ2ILJgTs6UiC
         Tnpg==
X-Gm-Message-State: AOAM531llr3Wd31gv1y2ZaR6UjCq/NjL0O8CHUc9hJK3F3ABFBVKWwTR
        /RpMSDuZAL6XzkV40BTNuGdV0I6LZ2UI8YWh
X-Google-Smtp-Source: ABdhPJwplwfUkzNEF2GL+6/qzxFO2fQsmh1/BJO08c880AYwwprUUfBzaG8l2b2S9+xiMJaqpqpNyQ==
X-Received: by 2002:a37:7147:: with SMTP id m68mr14899919qkc.286.1617994214783;
        Fri, 09 Apr 2021 11:50:14 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01:86f3:17eb:e23c:86fd])
        by smtp.gmail.com with ESMTPSA id h62sm2347198qkf.116.2021.04.09.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:50:14 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:50:10 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: staging: iio: cdc: ad7746: add binding
 documentation for AD7746
Message-ID: <4be8e3e40794474d8622192c6a5ea0fb4af527e1.1617993776.git.lucas.p.stankus@gmail.com>
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617993776.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding documentation for AD7746 cdc in YAML format.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 .../bindings/iio/cdc/adi,ad7746.yaml          | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml

diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
new file mode 100644
index 000000000000..5de86f4374e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/cdc/adi,ad7746.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
+
+  Specifications about the part can be found at:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7745
+      - adi,ad7746
+      - adi,ad7747
+
+  reg:
+    description: |
+      Physiscal address of the EXC set-up register.
+    maxItems: 1
+
+  adi,excitation-voltage-level:
+    description: |
+      Select the reference excitation voltage level used by the device.
+      With VDD being the power supply voltage, valid values are:
+      0: +-VDD / 8
+      1: +-VDD / 4
+      2: +-VDD * 3 / 8
+      3: +-VDD / 2
+      If left empty option 3 is selected.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  adi,exca-output:
+    description: |
+      Sets the excitation output in the exca pin.
+      Valid values are:
+      0: Disables output in the EXCA pin.
+      1: Enables EXCA pin as the excitation output.
+      2: Enables EXCA pin as the inverted excitation output.
+      If left empty the output is disabled.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  adi,excb-output:
+    description: |
+      Analoguos to the adi,exca-output for the EXCB pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad7746: cdc@0 {
+        compatible = "adi,ad7746";
+        reg = <0>;
+        adi,excitation-voltage-level = <3>;
+        adi,exca-output = <0>;
+        adi,excb-output = <0>;
+      };
+    };
+...
-- 
2.31.1

