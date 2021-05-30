Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A9394ED7
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhE3BBZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhE3BBS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1FC061349;
        Sat, 29 May 2021 17:59:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c15so5551032qte.6;
        Sat, 29 May 2021 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKiBv8SqRWswr8z7Bsl/7/WuL9D2vpQOGyxVKImo6UE=;
        b=YD4MojyU5VsvDpuAE927XF5te4GbhcoFFrPKaT7XLIQ+jgV2pu5Stn4oRNMs9Folpl
         D8Ci35CJBYSGwj5Z3FUxzlEfQe0jKAG7+3fLsZiD4xoUvjY+gi4mZfh8DSwKx+C04WlH
         ZhGcRMJkOpGQ55O48xFaLJbaP0BciQ1xDAMufHWJLmdarKq2j+dKSx+QWjs5Dtd1X+li
         wkdEMjveCtrk2X6OXbjcBQHzYqI3mRNQNtzLkn4WhHfc/6DSJHYUelmOiI4DtpyOjsuH
         kw4uXOwP+fgmc6kpw+Put3FYqO6VryQPD5syJY82QBsuyBcqxx/dpzTtI6G9iMmqamQf
         cdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKiBv8SqRWswr8z7Bsl/7/WuL9D2vpQOGyxVKImo6UE=;
        b=qqdiLqkWj1GznetlnMT8bAtN0XtxkNnYsMxsS+FNJlj99WfXuxSYJXF0b+Ok9pbS/9
         Xhj2A1X3GNXEbg10ip6zDiaPyvdwYwhLtTvGHaNDa3FjsM4rAuSKcO730TkuXdjnqLjM
         Sw72OUqD+L2Ow4qf/7WEYQG/qsMsMhZ03mZNEFcTT6XyqhqPk3Nageq0uQU7eQ9xfxMC
         zKMixj8lJqWRfE1QOSaL6lGKOjbi2SuAT+zt+13+p8S7542P3yy4PYrAfKCZiqYFbCBH
         T1upaE2tN0T9PzvC3WwRWVGyWB3MDXDEHRDswMPODjVleTcnwMjJgoiVNQCS/ExoAvZX
         A1iw==
X-Gm-Message-State: AOAM533vnyOx7ZdryQbFgJV5meincBuBj9vbLRq2/bhQDPDeTLJhy2sL
        +f+6PqVQoKsZeKoiygJv0zY=
X-Google-Smtp-Source: ABdhPJyoKDTAs8PrRuRQCDpoLPMkOr3GOLt6qxRAAEx6R4vsnAgOv91qMLEcUhoiNFxqgBu8vmrj4A==
X-Received: by 2002:ac8:6699:: with SMTP id d25mr9502077qtp.326.1622336378921;
        Sat, 29 May 2021 17:59:38 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:38 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 9/9] dt-bindings: iio: afe: add binding for temperature-sense-amplifier
Date:   Sat, 29 May 2021 20:59:17 -0400
Message-Id: <20210530005917.20953-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly. This
binding describe one cases, the measurement of a temperature through a
voltage sense amplifier such as the LTC2997.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../iio/afe/temperature-sense-amplifier.yaml  | 55 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
new file mode 100644
index 000000000000..015413cbffbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/temperature-sense-amplifier.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sense Amplifier
+
+maintainers:
+  - Liam Beguin <lvb@xiphos.com>
+
+description: |
+  When an io-channel measures the output voltage of a temperature IC such as
+  the LTC2997, the interesting measurement is almost always the corresponding
+  temperature, not the voltage output. This binding describes such a circuit.
+
+properties:
+  compatible:
+    const: temperature-sense-amplifier
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  '#io-channel-cells':
+    const: 1
+
+  alpha-micro-volts-per-degree:
+    description: |
+      Output voltage gain of the temperature IC.
+
+  use-kelvin-scale:
+    type: boolean
+    description: |
+      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.
+
+additionalProperties: false
+required:
+  - compatible
+  - io-channels
+  - alpha-micro-volts-per-degree
+
+examples:
+  - |
+    znq_temp: iio-rescale0 {
+        compatible = "temperature-sense-amplifier";
+        #io-channel-cells = <1>;
+        io-channels = <&temp_adc 3>;
+
+        use-kelvin-scale;
+        alpha-micro-volts-per-degree = <4000>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0eb7fcd94b66..f224bd8e6125 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
+F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
 F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
-- 
2.30.1.489.g328c10930387

