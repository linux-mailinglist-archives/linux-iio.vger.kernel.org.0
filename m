Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45629366C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Oct 2020 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbgJTIIj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Oct 2020 04:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgJTIIi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2020 04:08:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D769C061755;
        Tue, 20 Oct 2020 01:08:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y1so614943plp.6;
        Tue, 20 Oct 2020 01:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R47c8IJlDfJaqH2Rm6EUjlvpHInRK3+ab54pNsvjd9M=;
        b=YSZFpB1GZjW/lvoux4A3VSm4jmqdVsMXV5awGVOpMUXYdF56GRYI1EEeGbzG9G/zc4
         tBG5w3tC/UkzGrtaYzHjr4PqKi7A6po/SjMIhtHMicqg8MowMBiBEhWaDWmGB0s2jE5f
         c3cK5KhATQJwokl26GMJXlDQUkLN/KWaIJm7JRrONnqofCrdyoinI9d1wVNs+hKYc5UL
         1ppj/NSWCyoM9gfiCmoS7sSeL68eb/7l9DER1NrxumAYCST+6cYe8qTD4lUUsrqVyGea
         YD3CfA+9KRrde01nleyikmRntvh3aBkzFsBzcsjc/JGOZmOKPJ4R8gjW1NTWNsg/21hz
         wT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R47c8IJlDfJaqH2Rm6EUjlvpHInRK3+ab54pNsvjd9M=;
        b=oePUNCVgbW+MCD7uS97nGxm70mfm/Gz+vut2pc+NOQzXChSuHjxLjYcR2Gqeh7jo5M
         BKiyTtQlG/j2nPGvDlccQvhfrCFDvkslsNnuE/QYhW0FRrqQCJwrMb4ZLmLsfvaa3Sd8
         dPA0XlJdiQvfh+1ilxPb8FM4C7zCeeuuXhgxBr802FjWTcXUm+iFv8PczysUlRXynJPp
         EHZAVWbSSPfhijsQJP9i32yII0hGcV2LYfEu8i8ETB9Hcc5npZd9OOsGHktu6pRhtEop
         R5slQrks00K6hfmWzXrAZK55OQMSQZcAhv6RHYdN18X1M5CA6ogcmeCWemTChUT0XAVW
         vn7g==
X-Gm-Message-State: AOAM531jhOlayNr/vwHclb6Kpi8JeiQY7mseA61uFxDo9LFrjqlcIDrA
        KFIOKfv6xyvYzm9TIzrEISM=
X-Google-Smtp-Source: ABdhPJz+seHCMqIEtQxTSJpqKz3QaHTqHPCpNbZlw4TDTHXgKsE6nxCuV4e1TDNUCddvocRKYb3FPg==
X-Received: by 2002:a17:902:d710:b029:d3:7e54:96d8 with SMTP id w16-20020a170902d710b02900d37e5496d8mr52751ply.65.1603181318160;
        Tue, 20 Oct 2020 01:08:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:477:195c:4b74:c749:e0fe:9e69])
        by smtp.gmail.com with ESMTPSA id 17sm1347270pfi.55.2020.10.20.01.08.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 01:08:37 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 1/3] dt-bindings: iio: adc: add bindings doc for MT6360 ADC
Date:   Tue, 20 Oct 2020 16:07:45 +0800
Message-Id: <1603181267-15610-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com>
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

