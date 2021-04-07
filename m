Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE0357421
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348501AbhDGSWO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348459AbhDGSWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 14:22:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA548C06175F;
        Wed,  7 Apr 2021 11:22:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so1780660pjb.4;
        Wed, 07 Apr 2021 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5AGYsiqJyHgXtH1mqcGYpoWnWPmfEnCi1atKA6As80=;
        b=DMznewSezTVv8X6OalBqrJkzlLdVm4QS2CQsqkD8FfccbcJ8PtFHJ+ANnMKUBh8c6l
         WN4VUYsqK24Idva5LoHlAHHSQh7FzvchO7F/OreB25EUj+JojHB/bsblYbz1R+SdD1rb
         B2FEjBJcRi2828GC7eRDZpg64nM7kNNlJSpfwhQNvTgFcDwu5Qi0Tib9KLi5FmMn2bbf
         BskOtigCyH8+7e6ZJN/mHzRgClMu5qTQYphRzIi/foVrwt+WQNe+6DR/AbiJLv1ZGhHD
         bEmbw7GHOUgqLOuiVc81S3LJOuRQobbjMHKSnQRwi3VsX7I+ViIW5LD/V7y4qWajTAjh
         3usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5AGYsiqJyHgXtH1mqcGYpoWnWPmfEnCi1atKA6As80=;
        b=bicyBwXWkk+wy4kfcFJrpa7d7/CUvA6YczJnDovl49cvMw0pos4u/u2Atci1fAtJPu
         llC4bXwSgLKkj9nuNOtMRwmIyn7WawQ9gV/VdxfgXcUffvSBPOJPvDAZLFqFnqqjFxaZ
         GUpQjtP3iovoTNilva0Sc+ixaETMCcvlzeLRfcQmOtK/3L8TJFogm9gU4pCM5jnNLHie
         +oYtGFPHImSd/C2Al1JAC3p8+3SzFZbWgQsM1wDTMUk1sybVKC0tZMwkplsZ0+l7y0oB
         qFfOB41vBDAEaxu8zOZHNoHkGN19KH9FlC/KIx+6SGWl2+WiV53eHk2T2WYdvTkEoysY
         tndw==
X-Gm-Message-State: AOAM533laxIwAmfvU0uFpwHz2rBsvufYJe60jnFPR/QHbIW8A46WWmTN
        eCVKsX1cFLsgcAnH6Sofooo=
X-Google-Smtp-Source: ABdhPJzIEX9k/vONZmBkgli4jgV6RXkuDtCNftL8jYjVYjftLMCthp17YaS/e3cyD/uAYfPmDZ5DcQ==
X-Received: by 2002:a17:902:6541:b029:e6:27a4:80fb with SMTP id d1-20020a1709026541b02900e627a480fbmr3970671pln.15.1617819721884;
        Wed, 07 Apr 2021 11:22:01 -0700 (PDT)
Received: from localhost.localdomain ([49.156.71.81])
        by smtp.googlemail.com with ESMTPSA id q22sm20563015pfk.2.2021.04.07.11.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 11:22:01 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Wed,  7 Apr 2021 23:51:46 +0530
Message-Id: <20210407182147.77221-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210407182147.77221-1-puranjay12@gmail.com>
References: <20210407182147.77221-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for TMP117, a digital temperature sensor.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/temperature/ti,tmp117.yaml   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
new file mode 100644
index 000000000..347bc16a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
+
+description: |
+    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
+    I2C interface.
+      https://www.ti.com/lit/gpn/tmp1
+
+maintainers:
+  - Puranjay Mohan <puranjay12@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,tmp117
+
+  reg:
+    maxItems: 1
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tmp117@48 {
+             compatible = "ti,tmp117";
+             reg = <0x48>;
+        };
+    };
-- 
2.30.1

