Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1ACA22557
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfERWPz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:15:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42814 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfERWPz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:15:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id j53so12118990qta.9
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y87QQQeaLiI1oNeEvmjlObGb959ta9/nwNHRHt6yTIY=;
        b=i7EWYzfUI7wZ55lYvmgrWJibFvXkvP5ATGyedFaUpxf2Id68eWrJgZFQPE8bwx3s9g
         SFuKshGbYvq6oKTjm/JUp1AN6XhIAgNjhZb9QbD+cCEeaf3eS3LVUuTVC1e2DSYst9Vu
         Tu8E8xjmY1j30fA/tQSj4Jnmvm21rPpI1NpWRY8F6s91eceoEMZBXJ4RVkXUBKskpYo8
         0wpDfL0JnajFkvF3i7s8ZdivBubFt7t+AsgSnv+/TeElhkhq4pDaaPSuGoRlViNtz7aG
         X1PvJ2B/5flcObh5uGyUdtZ8k8dFyMynjhbBSvoCAbhIrK3LY3TlVUGL/P98JOvBtCDS
         p2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y87QQQeaLiI1oNeEvmjlObGb959ta9/nwNHRHt6yTIY=;
        b=D5M5N139zy69X7zpPrw5fafS4TSagsQ/NF8WZBCV/Rr/R6o7CT2E28JTAl6eELcHAM
         VnzH+d+wNOaI0cJgL/XoiwSgaD+nURzUk5zJbHvhnLbqCIbVoFW+MhtWsPXczRUTZ+td
         F+IQGkLTRn1z6cHwM1sEAw4rFRKM2Clq3UpbVyCktsykHJ6Beq7ACeEjGIWAp/14eWfB
         86uLFCDLkT04Qnq36KD77EMXB4K/qheiCVbLvqORLfUI5+byzTa6Pj5F8+OZ/PdaIJj7
         uUUMs7LRA53x752UJo7HpUcwVlHSMERAJVAF7+Nryu7jgZMkI/fdmrQUQq7MJCL5N2ny
         qlYQ==
X-Gm-Message-State: APjAAAVLuwP+9dvDK2qkLlhpVxfnnBfOQAucYGD0Z3BjI33ax/OKUhCP
        LZ2ajXXkuhrCq1K2auxPUhk=
X-Google-Smtp-Source: APXvYqwg0K0VCuYjngl+wFVaIlBXJoCL0u/uoZfGo/MXwGzsNURXWzE9n9+Gn4qk06cQ2zrYdtInkg==
X-Received: by 2002:aed:2307:: with SMTP id h7mr54881137qtc.87.1558217754601;
        Sat, 18 May 2019 15:15:54 -0700 (PDT)
Received: from tallys-pc.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s17sm7702970qke.60.2019.05.18.15.15.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 15:15:54 -0700 (PDT)
From:   Tallys Martins <tallysmartins@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.or, kernel-usp@googlegroups.com,
        Tallys Martins <tallysmartins@gmail.com>,
        Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
Subject: [PATCH 2/2] staging: iio: ad2s1210: Add devicetree yaml doc
Date:   Sat, 18 May 2019 19:15:58 -0300
Message-Id: <20190518221558.21799-2-tallysmartins@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190518221558.21799-1-tallysmartins@gmail.com>
References: <20190518221558.21799-1-tallysmartins@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver currently has no devicetree documentation. This commit adds a
devicetree folder and documentation for it. Documentation must be moved
as well when the driver gets out of staging.

Signed-off-by: Tallys Martins <tallysmartins@gmail.com>
Signed-off-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
Co-developed-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
---
 .../Documentation/devicetree/ad2s1210.yaml    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml

diff --git a/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml b/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml
new file mode 100644
index 000000000000..733aa07b4626
--- /dev/null
+++ b/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/iio/ad2s1210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: |
+  Analog Devices Inc. AD2S1210 10-Bit to 16-Bit R/D Converters
+
+maintainers:
+  - Graff Yang <graff.yang@gmail.com>
+
+description: |
+  Analog Devices AD2S1210 Resolver to Digital SPI driver
+
+  https://www.analog.com/en/products/ad2s1210.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad2s1210
+
+  reg:
+    maxItems: 1
+
+  clock-frequency:
+    minimum: 2000
+    maximum: 20000
+    default: 8192
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+  resolver@0 {
+    compatible = "adi,ad2s1210";
+    reg = <0>;
+  };
+...
-- 
2.21.0

