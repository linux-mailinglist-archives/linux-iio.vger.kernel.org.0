Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0D26AC3F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIOSkM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgIORhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 13:37:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B3C061352;
        Tue, 15 Sep 2020 10:36:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f2so2371761pgd.3;
        Tue, 15 Sep 2020 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+aE1ELAzgYKqHHzeFiypxalT4hgfY/xIUQkiDN+va0=;
        b=FaDdYcrR0aifpyTmq+TIfvqHdxcsTDpOBU2FMOsc7dG9l61ku8FivcMgAUhnQW2hA4
         xmkubi7hfP5sUbH7Nu9St0cci4gzseHoNbijYT17Z4dr5E/6nQlUgouOFY4sx6RnvT7r
         yHJCm3Ktc9iGTRKcxGV58f5zFF5JbGBzRzlBJw6SwF7DoebbS+7uUVPhQQmDKGIdZErY
         +GflYC0nMP5p4Wvrp+n6kYVoFaBnA5ATDPSRKiuxHOm3eW4qWgbj/424Q8mab6T//7YD
         ccxT3VztIFFl9+e94on1Rd/zS9DMp8WJSbVUStASPhbKsQu7+GPdIMLnoWJYfPPSp2Tq
         QoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+aE1ELAzgYKqHHzeFiypxalT4hgfY/xIUQkiDN+va0=;
        b=jhYjv/UO06vchCwaoHLkW/OiKIY2b2EUnzo7DSk4QscqXg5LYTSGb5QAsiKyyG6fFK
         wkRji2kzifbZM2ap/QTmDtLcMsmCs2DHtnf5T69ZTcTLA0P7D3wfGhAFhbfcPsoT2PIo
         X5bO9Lh5CyHK/fRfXTVqdl2moUNyBs6CSl9RWpstM6Z+2NwHjLPCrDWsebPvujQ7QbRQ
         Ewb5Wg009V4QB0ylMSathcuC79G7BM29RBigf1dxz6lDrlAoA+rtsYXnKwtchpiNcnxn
         UtzqwkfpPVwXQEeQxjuSEIf+2xd7a0MOPg4Mna4YEnH6dMQgEAcmjaCaTYMfthdAWnNZ
         RoWA==
X-Gm-Message-State: AOAM531mChVAq3GtYsM7VjQlUKKJPNHhs404y7/igtncRQga3wiHIeKV
        qMeQ1P08G+NbroAugI4pnVg=
X-Google-Smtp-Source: ABdhPJxVyXSCl2RPLvVB5n4rRYLsOtrFkc1vvGg0hXwSIaOeSQ0tF5wwWOR83BrjvzlI+LzXUrVe2w==
X-Received: by 2002:a63:4559:: with SMTP id u25mr15052932pgk.162.1600191378923;
        Tue, 15 Sep 2020 10:36:18 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id x3sm14025926pfq.49.2020.09.15.10.36.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:36:18 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: add bindings doc for MT6360 ADC
Date:   Wed, 16 Sep 2020 01:36:07 +0800
Message-Id: <1600191369-28040-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

This change adds the binding doc for the MT6360 ADC.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../bindings/iio/adc/mediatek,mt6360.yaml          | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml
new file mode 100644
index 0000000..2fa2fe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6360.yaml#
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
+examples:
+  - |
+    adc {
+      compatible = "mediatek,mt6360-adc";
+      #io-channel-cells = <1>;
+    };
+...
-- 
2.7.4

