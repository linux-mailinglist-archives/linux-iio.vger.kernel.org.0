Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3FF3511BC
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDAJRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhDAJRF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 05:17:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0EC0613E6;
        Thu,  1 Apr 2021 02:17:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w10so1186244pgh.5;
        Thu, 01 Apr 2021 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1l7C0z+2m429uRUTmhvtkukf3T2jU/8R8E5DJQIbUM=;
        b=mAIkONb++rJxVZHKqabxc8W8NOGcNBBL07tB+OyqJfqrvgehGk2Q3UF/LMv0wL26bL
         YOPazttL8U398SSsslHfxzm/I1nls+qvUAJ7PkpemXIL5SKceFTFB2D9mk6yuOqyTiAz
         qatof1hZR7jFWcmMdehl/pgMxhO2FbsUH4iA7rbzYZlj1QiX/at1MmbbO/euQQYOPNN6
         UbhrdffICaoQdQcfRd+OlM6K8/y8Xyv9gGXlG7XuycRompucYXPhSUL6/1XBAggaXhLa
         x1bWIuChIvUN87qx3q0xu17t9HWDvEekiPGTJyIQjnvv0mTwUhKLry5wXum6GfX/SKG1
         RIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1l7C0z+2m429uRUTmhvtkukf3T2jU/8R8E5DJQIbUM=;
        b=t+FTCNJqmVBN2RimhdZgJw4R2RoTPywW8kLfGMX96Y7BxlCzKKhFmq7n//mr5eW4BP
         3TIF9wps5aVHkZCrXszwnKgSYb/cfaiPHUBU532qjswwUB9ekIeQfdHqH6FPyirCMvXa
         CPvIQM5YSO/qN08B7K371d1embuH1DkCo0s65nNzjHw5vOyWHbvf2+a5dueKnaK3x7J4
         RKZp6PFTxXLgrK82oJOABAhdp0dhF48lyBrio81cKSRtF7x5xxnxz1eUJum81GcUxWGL
         H9u1VEuGsmJ1rbIGTB5ksmPLRMpU6/B92vjweYcA+ev1fsuk1neuQNLtzZkH5yvPb1no
         /DrQ==
X-Gm-Message-State: AOAM533A3oQ0Gm7Nf9QaeE0L5NQ0BL5Hbrxt0gKhxi2drpfEpts+iFeT
        SRYqGJRi5sqOUv72VWAdkzm9hSCiFVBGEHA1
X-Google-Smtp-Source: ABdhPJxz4HTRGngeS3HtIrOCuiy2kXbGpwE9MZEWZSVL3YkE7DfT1Wa1zjCVdiKfUUlALi/QWa8Ipg==
X-Received: by 2002:a63:2c8f:: with SMTP id s137mr6568483pgs.51.1617268624538;
        Thu, 01 Apr 2021 02:17:04 -0700 (PDT)
Received: from localhost.localdomain ([49.156.72.145])
        by smtp.googlemail.com with ESMTPSA id q8sm4897044pgn.22.2021.04.01.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:17:04 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Thu,  1 Apr 2021 14:46:47 +0530
Message-Id: <20210401091648.87421-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210401091648.87421-1-puranjay12@gmail.com>
References: <20210401091648.87421-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for TMP117, a digital temperature sensor.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/temperature/ti,tmp117.yaml   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
new file mode 100644
index 000000000..1ead22317
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
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
+  - "Puranjay Mohan <puranjay12@gmail.com>"
+
+properties: 
+  compatible: 
+    enum: 
+      - "ti,tmp117"
+  reg: 
+    maxItems: 1
+required: 
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - | 
+    tmp117@48 {
+        compatible = "ti,tmp117";
+        reg = <0x48>;
+      };  
-- 
2.30.1

