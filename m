Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEC3426E9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 21:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCSUap (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 16:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhCSUaW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 16:30:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4859C06175F;
        Fri, 19 Mar 2021 13:30:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f17so3485586plr.0;
        Fri, 19 Mar 2021 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiFhJY/XmFpGNDX1w0pF3EBmSkOJw+L7xsDBx5EWS60=;
        b=IYByJR+l+qAy6WziotlkXvjzNldd/MmWdjP7/hoeaZVbfGIfnj2L8TrGb6Wn4mFkcr
         pxR0MpTduBdYzQNpb7MI2tNTw8fCytbckiGNpyltRAjCTT3x7syXhpLzioj/ZUohaNzs
         2oIYUgcSYDyIxY7Rz/RjSUQ2eLk/iKcs0XgR1HxLstPDkg3A3C896VvMWTOwYfRabNua
         eiE9oAh5JN6DGlEYVaoCCycuVL7NbEqKwwglwbDt2nSatMPLuIU8BcN+Y0x9aP5u+gcy
         6jTIa5jhYVWyTqOSATU9yWsY30i2kbnenj82MnARCNHbv9F0Dgj4A3ratHjPTpqHd/ZA
         MFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiFhJY/XmFpGNDX1w0pF3EBmSkOJw+L7xsDBx5EWS60=;
        b=IiQNVMWJ0qL64quV8OmizSgr9pHDqnujhQ9YTFVmckL6wy7wjDBVcYJXDBv4qViRSU
         3SDFWjxJ/umcDnYB0F7OheHGyvTsYT+ptW3xJqIFOenZiYO4/iE3FlLZEAD8zKJLr6TQ
         LH5rI7vCeFSGpC9WvXmE90opR//Kbp9LUkzsntCjUeQoUH2hTffRNHwh56Q/5NhpuZik
         LVYpCsQx6N2g/20WW16gLFYlEyun3MdtKviMbKJnDkt2Sehq7r38pzDY1Mb8zswdrIum
         3RtHqzxMJWaVxSdnP4AC3wAJq9eF4qKW6tB8C+cMaO9fpJcAJzrGSDnjAPpaxH/SgSmR
         ZvZg==
X-Gm-Message-State: AOAM533DK7sbHltIUecz1ftGw2d+r9HYWO5VKc2GSVq9iQFLKIs8twNr
        sqPWetj3DDncqBxxvY5Vydk=
X-Google-Smtp-Source: ABdhPJwkbA+icpzWFo2U3z2itF9zSqPJ3TjyYB3Ia9j33+A+pwvp09XQdDsZStPKM7pAOSEE0yHnhQ==
X-Received: by 2002:a17:902:eac5:b029:e6:34e2:8378 with SMTP id p5-20020a170902eac5b02900e634e28378mr15700832pld.35.1616185822156;
        Fri, 19 Mar 2021 13:30:22 -0700 (PDT)
Received: from localhost.localdomain ([27.255.182.86])
        by smtp.googlemail.com with ESMTPSA id m21sm6340406pff.61.2021.03.19.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:30:21 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Sat, 20 Mar 2021 02:00:06 +0530
Message-Id: <20210319203007.287802-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319203007.287802-1-puranjay12@gmail.com>
References: <20210319203007.287802-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for TMP117, a digital temperature sensor.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/temperature/ti,tmp117.yaml   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
new file mode 100644
index 000000000..c9ea5db12
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 Puranjay Mohan.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/temperature/ti,tmp117.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TMP117 - Digital temperature sensor with integrated NV memory
+
+maintainers: Puranjay Mohan <puranjay12@gmail.com>
+
+description: |
+  datasheet- https://www.ti.com/lit/gpn/tmp1
+		-----------------------------
+		|   ADD0    | Device Address|
+		-----------------------------
+		|   Ground  |      0x48     |
+		|     V+    |	   0x49     |
+		|    SDA    | 	   0x4A     |
+		|    SCL    |	   0x4B     |
+		-----------------------------
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
+examples:
+    |
+    tmp117@48 {
+        compatible = "ti,tmp117";
+        reg = <0x48>;
+    };
+
-- 
2.30.1

