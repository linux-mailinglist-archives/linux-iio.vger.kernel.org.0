Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D360727E436
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 10:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgI3Iy3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3Iy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 04:54:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F70C061755;
        Wed, 30 Sep 2020 01:54:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id o25so722989pgm.0;
        Wed, 30 Sep 2020 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R47c8IJlDfJaqH2Rm6EUjlvpHInRK3+ab54pNsvjd9M=;
        b=JvzERQVQPGqQCN8X2IH9mVeQmtRCPSP5Xf2uIxgztZo79fyP0v4tUCcWoJqUzAFipA
         Tt0hYEKiz4cTZHu80aD0k94E3JcSmJpomI7tYqIkNnHsnsHbdSn+845KQkKcCobvSB75
         clkt/YUSBCAEMRXJRc2LamkHdF/vq7fjRLvlBqmBEO8YC5NdbU4DFglPcSZM9lEpnNX0
         +pl6xLTLY1CR7G8a6Y0JAVXzCBWlupctkvdhmMukszP3K7IcmQTBK7OMkMUUXh3VrJPp
         URB3Gys5hUKcMr4Fu9bSfwCSxNVhnGuRrtlEY1LbpWD/sZqTUqm1RZZAx8HZJ7XdDsKZ
         SqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R47c8IJlDfJaqH2Rm6EUjlvpHInRK3+ab54pNsvjd9M=;
        b=aT6FoTUGSYTbPIcQkGttPTomnSO2yULLwBeFgRf17Q2nOSrP6NeFzCP6rJ3QV9wx95
         RNeTV2Tb7qZiYKq9IWS/9HMqgNR/stx5euw+bLOfHyr67foyyLy68ol1dBByBlYTB4za
         0ebwr94A5ubKF9eWmYgYGRAgP0cP008KmDsjYAJ1mvNvlr+K/MzjXOdu69A0ChJpGqnZ
         0CJbp+/naW5jVgHH5kNniJ7sxz0DnkF9wW08hwYsgJ0DquCLwWgKjpo1SwS6LEsjmjDq
         jSUto5YLe1LTdX1xY0MSei4sntp+wvVSSRbo6bF9efvIDSUf7eNTwGCMcpZVrUHvqB+0
         4apQ==
X-Gm-Message-State: AOAM531pF0wgA1GM56NOlXkUA5Ri5Uoz+xJlXDqL+4snycQEUOQFFoKh
        u2ivH9yH5OX6Y+qoBgG8/Xw=
X-Google-Smtp-Source: ABdhPJwzr2vBL5N2ejGDjUjQiOUt4onfhVWvhsNawi5014zLNf+DNWB1b9pUsQVkmNnNhZcLXT7Faw==
X-Received: by 2002:a63:e94a:: with SMTP id q10mr1353780pgj.189.1601456068133;
        Wed, 30 Sep 2020 01:54:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56b:d17:8c76:3dc4:5429:d7e4])
        by smtp.gmail.com with ESMTPSA id x13sm1513938pff.152.2020.09.30.01.54.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 01:54:27 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 1/3] dt-bindings: iio: adc: add bindings doc for MT6360 ADC
Date:   Thu,  1 Oct 2020 16:54:06 +0800
Message-Id: <1601542448-7433-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

This change adds the binding doc for the MT6360 ADC.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../bindings/iio/adc/mediatek,mt6360-adc.yaml      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml
new file mode 100644
index 0000000..a7350ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6360-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6360 and similar ADCs
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  Family of simple ADCs with i2c interface and internal references.
+
+properties:
+  compatible:
+    const: mediatek,mt6360-adc
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    adc {
+      compatible = "mediatek,mt6360-adc";
+      #io-channel-cells = <1>;
+    };
+...
-- 
2.7.4

