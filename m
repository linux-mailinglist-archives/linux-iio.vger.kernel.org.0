Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5155122B9E7
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 01:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGWXD6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 19:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgGWXDs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 19:03:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0104C0619D3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u5so3924452pfn.7
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlXOk0hHJZhRIPU8I1ptWsva21U7aaIAzX5l2R4972o=;
        b=NPHmHdMsxSNkTOfl+TlcvZqmx7oUT6QgmOCbPkcRf6298vdxpB6rcIXyVM6M1ygDWD
         AxdQi3+sLegOD7bfh4/lH2JNvKsuQOXfI1QGq02sR6qOxWp006Wxnv4LaCohl43yV30q
         i7v9X9DVI5aOEM0zpkp8404bJSi63wn+8dRZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlXOk0hHJZhRIPU8I1ptWsva21U7aaIAzX5l2R4972o=;
        b=sKLgp6xTAr8Gp/WymVKl9I6HcMDETzH4pw25eUbetBqZsUp/K0RYi35Jc4YVjXpsmo
         B7YmyqvJ8Am0pT29pTnLIxQ4nkSg+Eib3p7ePOiH7nxj1UoHS/i8mSCWeGzGOQ5FZ+1g
         MBDUcG0vKTUcYg5xks337OEf9yT1+TTbSars3J4mPADRGxkip/1K8L3YDkJULE1ZO4L8
         TKg4HAzQEGh+fcr+l9tpSekHCOugRdsP/v6YEpAfeQo08KGulkTzH3wwlpjRJrcYUDQk
         6Il1b/RDzQZPASCL0bB4QkD6B4xKGVU5cHLnzJlSVm4LBMJrftCo9XltvDV8tw832wV1
         vMUA==
X-Gm-Message-State: AOAM533gpcwW0IGN+kL1jEwaoOnc51NG89+z5Jwm7w3MdVoTW5i/24hd
        HLyfmU3WN/JSLeX6wUgWya1F3w==
X-Google-Smtp-Source: ABdhPJwM4hsDU+8tCAQ7vdVBTk0lJRMcxjHoPhcCe0AIjCjHJzUVA3z1DEo3zNgbETy/U4d4Zm2nIQ==
X-Received: by 2002:a62:cd89:: with SMTP id o131mr6131457pfg.195.1595545427481;
        Thu, 23 Jul 2020 16:03:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k98sm3816070pjb.42.2020.07.23.16.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:03:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Thu, 23 Jul 2020 16:03:42 -0700
Message-Id: <20200723230344.1422750-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200723230344.1422750-1-swboyd@chromium.org>
References: <20200723230344.1422750-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Daniel Campello <campello@chromium.org>

Adds device tree bandings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
[swboyd@chromium.org: Add both regulators and make them optional]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 000000000000..ba734ee868c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9310 capacitive proximity sensor
+
+maintainers:
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9310/SX9311 capacitive proximity/button solution.
+
+  Specifications about the devices can be found at:
+  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
+
+properties:
+  compatible:
+    enum:
+      - semtech,sx9310
+      - semtech,sx9311
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The sole interrupt generated by the device used to announce the
+      preceding reading request has finished and that data is
+      available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+  svdd-supply:
+    description: Host interface power supply
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@28 {
+        compatible = "semtech,sx9310";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+      };
+    };
-- 
Sent by a computer, using git, on the internet

