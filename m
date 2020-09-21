Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3980727224D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIULYR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 07:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgIULYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 07:24:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFDC061755;
        Mon, 21 Sep 2020 04:24:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so8982590pfi.4;
        Mon, 21 Sep 2020 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R47c8IJlDfJaqH2Rm6EUjlvpHInRK3+ab54pNsvjd9M=;
        b=J5w/HeosvzO7XIIFoWtyNmMMiub0Db+IHevN5Sj4ysEnqIaYa+x9wfXgLFW+AWLG6j
         eRCgWNuCsyHd4no7pGNCAcUxezBHzGY2CKIBkrcSm0vjK3bDGg8K9UCnn0sAzbFGtR77
         cgPDOnEX7FjUUO+J4ZbRnYO1uHrb+edNh3XGRlbpRoj9Z+g9oigdbeJ8MrpQJDRCd0Vj
         lJgkuaHXeLGh9/bCA65XTPj1+NCHa8LXhbJC+bemsWUvo2cFWlGAiEipNR/BXhC2HeiX
         0lWNs8DxMfyJ0hqxdr3Ip6d/0AhKcKF+4OgzbHJ0RiCNyzfM7alpYuUuK2fHbJ+mpduF
         Vpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R47c8IJlDfJaqH2Rm6EUjlvpHInRK3+ab54pNsvjd9M=;
        b=VAZ9x46NK0S9SQV00qB60+69HSZUuEOc1Qlp0P97g01osAtlYYThBnmMrEDw5ALuxM
         8omDCJ9io0xZU594vKvLXpl9SzoQV/kvZdhLkc5yjNqJ1f4V5AaYaJ6D5LR9ZAQ598l1
         0er9QiFeu9WHadQGg2bGpKd+UY+TvYJ0d+ttpaejSTc0fpFosPK3tCdWn8vZUWiNWoC7
         BcMsD1Nl7qm/LNVUEtUVWtlzf2mCIl47Eg3YTaOCv56UpqnGeWLXQDiiz2NYGAdwRGPl
         HXAxKh2WKBn7JofYw9QXH4oizp9c5PC0W8033MlF736Tm5sNzxDm1wLnx9c4F7+eoiVB
         HXRQ==
X-Gm-Message-State: AOAM531Dps1z6OiOpycCmXfrUvYb8ii6GsXeIe9tOr0NfuohiqiyXiWg
        NbVtvlj4X6bdNpKq8z1JCH8=
X-Google-Smtp-Source: ABdhPJx97v7qwdIXIkbCSicpl9/UNMxMCPfFKlRoFY5LsNRsmm8+tQukuQcEw6iDvEUBxNXjPV8X7A==
X-Received: by 2002:a17:902:c1d5:b029:d1:f2ab:cf6e with SMTP id c21-20020a170902c1d5b02900d1f2abcf6emr21808980plc.67.1600687457048;
        Mon, 21 Sep 2020 04:24:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:8024:8a0d:5d5f:6f8a:a2bd])
        by smtp.gmail.com with ESMTPSA id x7sm9978663pjv.16.2020.09.21.04.24.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 04:24:16 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: add bindings doc for MT6360 ADC
Date:   Mon, 21 Sep 2020 19:24:00 +0800
Message-Id: <1600687442-23658-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
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

