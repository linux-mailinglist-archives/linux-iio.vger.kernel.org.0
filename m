Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACA342BC1
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCTLMg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCTLMM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:12:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7CAC05BD0C;
        Sat, 20 Mar 2021 04:08:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h3so7673352pfr.12;
        Sat, 20 Mar 2021 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RArRJ3KrSsXGgvSpLUXkus1FiNSIwSvWr9imzk+34J0=;
        b=g9rgCau1/GByYgq8pbu+ZdIh71m8PpEtTTukzGGHDFDGrpJcT2K+Bgp7rbyNO+8krv
         CoGQp+/R0eJqbE4AcOjO60NaeuLJQHlwllseZEpzd9efETAyGJeU0SEv065FnHOOIdOM
         lNnpJSLRW1Xzf+T7w++zsLTJQClMd475EqkE9zn/c5jKkXvA9tPRwGfPSFH9TPBIlOSn
         gAwZuX/Qiy7J2J8GfKLhWT/8WwFm2uB+4sOKPHKUtxZjeXn6f+I0smlJ2l4PZ/K2togx
         tB/UPQa8b0mZW5zk6fU75wiCRu6jcWF5i+3JmAaF9LOE+HI71SzesQFwvkDC8m9s9pY/
         tnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RArRJ3KrSsXGgvSpLUXkus1FiNSIwSvWr9imzk+34J0=;
        b=ah0XBJmIwiVAWqgICisruOjojzCuNRr0Bkl6GLsnMNMw3bg+fa6rle26c6iFKtsqnn
         a8DmrfkD8C1Y75UcbsX5VbWDeKVVUOhSvJATfG6hHf7HLxZtcLZxBIjYPlXU4P/5x5zF
         7d8ozUjZNdmh2W1WLYd+QkWPsjwdg+/gylSLf09oFBa5L3rbsN1OVUsND7WtzVWUUlZ5
         fZmQKo5Py5AaS77HAVQIeJoCGqwafuzYULzDHiEFdyEOT+SJooKmkGA++o2N1bDvQkOw
         x2Nfm1h1cn5cTfpdl3ge7MNBtfzUFNWSPiPQxXyfidW4svMlHbSnu6KdhGKZcnbIvioV
         2Msg==
X-Gm-Message-State: AOAM5309OSFYwB+6YkJUVovWdG+0MAwpSrmeeyoTEZTxDZ0kuTNosTae
        eFmhYw1TU/n3C+WpAGJANJ9lT1pSz474qg==
X-Google-Smtp-Source: ABdhPJxVDcDYwMB0V+DxrfuLI/XmV/AMorIYQDcFsNkaMRkHpMwNKLZRP6guh5EpuHAQpPyyzv8bkw==
X-Received: by 2002:a63:4504:: with SMTP id s4mr14547017pga.184.1616222722079;
        Fri, 19 Mar 2021 23:45:22 -0700 (PDT)
Received: from localhost.localdomain ([27.255.177.158])
        by smtp.googlemail.com with ESMTPSA id f15sm7237887pgr.90.2021.03.19.23.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 23:45:21 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: temperature: Add DT bindings for TMP117
Date:   Sat, 20 Mar 2021 12:15:08 +0530
Message-Id: <20210320064509.119878-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210320064509.119878-1-puranjay12@gmail.com>
References: <20210320064509.119878-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for TMP117, a digital temperature sensor.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/temperature/ti,tmp117.yaml   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
new file mode 100644
index 000000000..927660461
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+description: |
+    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
+    I2C interface.
+      https://www.ti.com/lit/gpn/tmp1
+examples: |
+    tmp117@48 {
+        compatible = "ti,tmp117";
+        reg = <0x48>;
+    };
+maintainers: 
+  - "Puranjay Mohan <puranjay12@gmail.com>"
+properties: 
+  compatible: 
+    enum: 
+      - "ti,tmp117"
+  reg: 
+    maxItems: 1
+required: 
+  - compatible
+  - reg
+title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
+
-- 
2.30.1

