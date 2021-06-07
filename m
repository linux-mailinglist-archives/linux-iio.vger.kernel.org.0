Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C48939DF2A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFGOuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:50:37 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:33639 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhFGOu1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:50:27 -0400
Received: by mail-qt1-f172.google.com with SMTP id e3so1147252qte.0;
        Mon, 07 Jun 2021 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSQgsaptdM1U/OrEHO8BXoNOmtXhejE81vLfj3GS23c=;
        b=fWxMBOVFykGdXAe2iKr2FHE1m3D0g87jNdHXvEItyd+66nCYQSQuS4JW4unMo39grk
         1PVbTbLhKn86IL+QKfOX6EqSrNJNehJ3QdKU6NGU4tp/cfccxG2eBDyKIkQKsbTa1TDg
         PPA9i/H6iAxT4W/vt+x3OsjVmTMYwn5r8/9tO+XCqEiHb43ThOX/MnWqtWo0kk1bKmbp
         YacYL2dPv7MiLJylEsGLMCp2y/Gsn44fcDTueMX/rF0wOmTA8rmRjDA5StrvpdNYQGKi
         wu6V9Q4UfkhDnbiQiuXAIrNeqIBlqb/b9nn8+DvOHJGz8NeSVW8gjohAnpOihlnKq1aY
         ckdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSQgsaptdM1U/OrEHO8BXoNOmtXhejE81vLfj3GS23c=;
        b=Jf5w+2xUtSOM0eiBS9LaXQLzQB14O+62PvKRXJMQONgqizMrm9Yndj1e5UxWVbpnZK
         FtcKH/IMtgJly2kRrq06NTulm9NP/LE72hk2y5Cw2Z92n3/KrCoXkKicq/wtzH+ZhT1W
         Z4+XQBYyNiiRRUUrLjDkutnocNMP7wNieFhNOek4efpbDEvJGEGYQyOYP8c5XkcrFLt6
         Qdjp3Ccl7wDY2NnuROITK8aX7wLJixcnbuMNwhzTAy2tgVozGBZcD6p447PMoBuE52NI
         gonTak6c+BYQ0cwh84MtogtHw+U9IGu7oorxop7FmaaWntArlypwMrCSH2z0g6+l3cFS
         Uubw==
X-Gm-Message-State: AOAM532AvC4ovOj1iNwmwl4UnJralTbefUiQFIJX4d0vHSKtx0JohpsV
        qtxNIrR418PMVbZicRlBPV0=
X-Google-Smtp-Source: ABdhPJwGs04xG7xD+h/nfK60BqL9dbRT47cBMwCFsiUXIM+7HZIrIYwKk3q9M3CeQFpM0Yg8+2IAzQ==
X-Received: by 2002:ac8:58d6:: with SMTP id u22mr16595953qta.81.1623077256074;
        Mon, 07 Jun 2021 07:47:36 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:35 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 8/8] dt-bindings: iio: afe: add binding for temperature-sense-amplifier
Date:   Mon,  7 Jun 2021 10:47:18 -0400
Message-Id: <20210607144718.1724413-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly. This
binding describe such a use case, the measurement of a temperature
through an analog front end connected to a voltage channel.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 .../iio/afe/temperature-sense-amplifier.yaml  | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
new file mode 100644
index 000000000000..08f97f052a91
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
@@ -0,0 +1,57 @@
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
+  When an io-channel measures the output voltage of a temperature analog front
+  end such as an RTD (resistance thermometer) or a temperature to current
+  sensor, the interesting measurement is almost always the corresponding
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
+  sense-gain-mult:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Amplifier gain multiplier. The default is <1>.
+
+  sense-gain-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Amplifier gain divider. The default is <1>.
+
+  sense-offset-millicelsius:
+    description: Amplifier offset. The default is <0>.
+
+additionalProperties: false
+required:
+  - compatible
+  - io-channels
+
+examples:
+  - |
+    pt1000_1: temperature-sensor {
+        compatible = "temperature-sense-amplifier";
+        #io-channel-cells = <1>;
+        io-channels = <&temp_adc 3>;
+
+        sense-gain-mult = <1000000>;
+        sense-gain-div = <3908>;
+        sense-offset-millicelsius = <(-255885)>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e679d422b472..4f7b4ee9f19b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8887,6 +8887,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
+F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
 
-- 
2.30.1.489.g328c10930387

