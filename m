Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7F355B59
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhDFS3S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbhDFS3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 14:29:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A135C06174A;
        Tue,  6 Apr 2021 11:29:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l1so7973389plg.12;
        Tue, 06 Apr 2021 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5AGYsiqJyHgXtH1mqcGYpoWnWPmfEnCi1atKA6As80=;
        b=QwgCWIwDFLXH2RIXu0c2Bhgt5zn5T98U2GabpBBZRupv2NZJp/2a2zL4p0jvrZtvIE
         JogrC3gXrC054AFp+G3fjdH3+y+c9avP/03QmCNZ4qwXMEvbu5iqhL+rJEg0rbYCC0Nw
         Ho/+rKoMol826zOAQRWz9NVa5fKw0E1ynSz24rTz+4T4yKKCDPgCO1qdk1qfG10un7lx
         sp1BApVAUMRDsUKtJNBDSJmWuoP2AU3nFmBWEUI/eMMlU3cOhw1wHoEQsmvq+ZOX+G/a
         P1k5xesCHQmL9AZ1pYGQkE6gxTU2I/OX1/FubZc+pg1laZEfMYjjch5iqCdayfS5vBJu
         5ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5AGYsiqJyHgXtH1mqcGYpoWnWPmfEnCi1atKA6As80=;
        b=d6D1UQLTIWhZ0Ilk/hh2oCj6ZC8DJbo0WXErypX3FN7GdrF9GvMjTfy7LJB//x8Dov
         ru9kE0yckOkOUcqGaJsEjNM307OiMPmWqTQfWXWZP11dgd+HNSqUuwwCGBT7XJA4/KEi
         gjsixXHbwOaA4rSUCUlONqt7Wrt5RZBI1FbG6gN9oC6OiWAc5+xoUXDIGvwnpy9+pZo0
         IorCPkPOeLfGAX6PKmJDv4cuweaAax8KrW8OYVV0uSQNgh2JhDHlMub1cXZn5xZpyQ2n
         2k4tq+CBYFbQLYOLtBUJ68IvIZgqxje+5jK84gFXlT5d0kFuZ4O17uK09sXLGa6DBDkA
         ayDA==
X-Gm-Message-State: AOAM531s1cUXH2YJh0uM3IWzKGqzWgeN+pRAMYNUkpU3YLSqMYn+nKZr
        k9qWg7qFW4SC1mBbaWnM9ak=
X-Google-Smtp-Source: ABdhPJw7F4fkHsLgDa0MDKx3dgPVA5Q0BIpbtngwVG3afqRmWQOG7d/67f8HF3HLE7A2IntmoxN2Uw==
X-Received: by 2002:a17:902:6949:b029:e8:c22d:17ae with SMTP id k9-20020a1709026949b02900e8c22d17aemr19233909plt.57.1617733748545;
        Tue, 06 Apr 2021 11:29:08 -0700 (PDT)
Received: from localhost.localdomain ([124.253.94.185])
        by smtp.googlemail.com with ESMTPSA id x25sm19652383pfn.81.2021.04.06.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:29:08 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Tue,  6 Apr 2021 23:58:51 +0530
Message-Id: <20210406182852.263605-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406182852.263605-1-puranjay12@gmail.com>
References: <20210406182852.263605-1-puranjay12@gmail.com>
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

