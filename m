Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D893D4963
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 21:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhGXSZN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhGXSZC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 14:25:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E18CC06175F;
        Sat, 24 Jul 2021 12:05:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so2691486wmq.2;
        Sat, 24 Jul 2021 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6mgIBbDERHrkCfdLTeeBkkROy6MNNlPhpbr+IZWCG0=;
        b=kWO5kTX6qOZhjysoEpAtRpAwW9NLPsN7Xm1DOg6ApYo1yJDVOOy7mGzGWSWqoHnDUG
         sCGCHK/Qg31NBII+CppsVqz4W5fu9g09DbhK1EDAffkOrsdXWbNYfGvgRuiUmdcApaKu
         YbiIMUqHx+VriAIpvsFY3LOh95ERz1kc9tPPoJYviYdwcVNDhjm6G7XC859pdQws+Ugs
         82TTq6TJzcIwwlVuZdr4G/HUAdFzczbMQJvjtXi9NzMtWSlQnrO5sd/zXYvLMwJ7xNaE
         dwqJM75lrgsbstFK9xIU7n4Aa1BxH5XE++LME/4zYR0fZHm0sgezUc1nERcZ0DVt0CH9
         xvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6mgIBbDERHrkCfdLTeeBkkROy6MNNlPhpbr+IZWCG0=;
        b=Sz6Pg6qEMD7dQykBoE2Fl3Hs4AIYLEV1eoePEEhapOB0zClh2B8fR/XCc41ODDxO+2
         d+ro8wgAGzepfxn1X3Gw+yFMFk6ZQPmAV65B5bFLZcWNwhOKELSESqoD+Xx3axBmuqu7
         SgB5ipHGxmRr6AMEUwpAoH7SU2YUUN3+twhE5auLwCbcVzwzkfdikWCVIcvoAtNzyLB/
         Z1ooSS3tKpENaT230tlTHo0UH5u/F3jnr7iH1yMm445e82OBOzhfeJ/ugHEQE7qNVQgb
         XitVSDpoq8iK/W/RYGXcWR+qxQ+E/ebcH8rCGEMPg8IuHgD1s73TYXZDbAhdJJRCaaF3
         kYSA==
X-Gm-Message-State: AOAM530tyaM77WKtEcR0EydGegnpT9tBuIQSZQUZAHBxe4HEhask3pjM
        +uqoPpx4sQzZjyOIjhKHDuX7BUUCPAEnjIlF
X-Google-Smtp-Source: ABdhPJwiri0wRQuVWzxKRd7O64i3yhmC0ux1B5nJV+Lp05qiUNKbpFW6GZHthZto9WkNOLlr0aFMtg==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr20214045wmc.136.1627153530699;
        Sat, 24 Jul 2021 12:05:30 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id j15sm1117798wms.20.2021.07.24.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 12:05:30 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc Documentation
Date:   Sat, 24 Jul 2021 21:04:49 +0200
Message-Id: <20210724190449.221894-6-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724190449.221894-1-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add both the jz4760 and jz4760b, plus a property to use the internal
divider on the b variant and document it.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../bindings/iio/adc/ingenic,adc.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
index 433a3fb55a2e..3eb7aa8822c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
@@ -23,6 +23,8 @@ properties:
     enum:
       - ingenic,jz4725b-adc
       - ingenic,jz4740-adc
+      - ingenic,jz4760-adc
+      - ingenic,jz4760b-adc
       - ingenic,jz4770-adc
 
   '#io-channel-cells':
@@ -43,6 +45,23 @@ properties:
   interrupts:
     maxItems: 1
 
+  ingenic,use-internal-divider:
+    description:
+      If present, battery voltage is read from the VBAT_IR pin, which has an
+      internal 1/4 divider. If absent, it is read through the VBAT_ER pin,
+      which does not have such a divider.
+    type: boolean
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          const: ingenic,jz4760b-adc
+then:
+  properties:
+    ingenic,use-internal-divider: false
+
 required:
   - compatible
   - '#io-channel-cells'
-- 
2.30.2

