Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2966F3D373F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 11:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGWISJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 04:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbhGWISG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 04:18:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF143C06175F;
        Fri, 23 Jul 2021 01:58:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j34-20020a05600c1c22b029024e75084404so211404wms.1;
        Fri, 23 Jul 2021 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2XETmwuPuczOkgqS4dTvF+SPhEzUC1DL4T7X6rHN5Vw=;
        b=d+qXlQISGDqV5tlBOLexsQ/1TPhQNMV2cXETQvCnrqgoTOzPfEDey/nXKC56lwYtLI
         M5dvWFlbSS3kKyA4DwW+DeH6QLzxFxde6MTQG+P9Bpfx1eJbUJLJZuQJSvXf6YZOA5u0
         If+p9m6fGbFBNP3HPz/AAihBKbWklWuCAVff/lza1MzNHmkNVqVEGV9LPh79dySuAAA+
         Fqcw2uEKZHDnY5y55dypqzdc8uH2j6EDCMpRiCbtfqw/JUorzz+nT7uhWn2nS/l+2UPH
         BN9C+11se/Wj5/mQ9Pwt+N3XlY87kOcqwkCYIhQOsuL5I0T9gHg9KQ7C6q5qE1bHe3Ym
         M4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XETmwuPuczOkgqS4dTvF+SPhEzUC1DL4T7X6rHN5Vw=;
        b=aky/OlBbjZB7QO5V6IZ3czjGO0Qom037NwNuft+n9N3QgHpj5NbM/VjZe11BhH27Wb
         6O0o1mv+76ZGOcuavGO8ZVhoBQnglyX38YK19gnvd5ljakAVrg9YWCVcGxeTXrpBOZ/3
         ZV5bYS1EXZaSpLWY/+rpgKHMDdSjq3fyU1SPG1YoMW5hGLnG9n6N66UFrRw/a25oNjum
         vZxO0gW88osqmnCg0puVxPYqRk5AK0wnkV4g5u9G535Myi1jIgY0zFtvf9xuDbfGek5r
         wX3OUiYUIta5d/w+5KSLUk0ZMQzZmtrc8neVd5+jaEbMtzkUIOOveZYZOF/9nNVpA/wr
         GU4A==
X-Gm-Message-State: AOAM532NqasjDBNMSyET5QReA+dIIzERuA19Zu6YRFgGk5lkLlbGoDCC
        7CbWluWMm0eTScGYO/IHmiE=
X-Google-Smtp-Source: ABdhPJxy0Z9lOr7dGqdcCV7FrKtSSSEkdkzK2BCZxllZVgGqRfxWDHkvj/0VmzZQZqgj4cEKZyzA+A==
X-Received: by 2002:a05:600c:3644:: with SMTP id y4mr13394625wmq.85.1627030718502;
        Fri, 23 Jul 2021 01:58:38 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id l23sm17503607wme.22.2021.07.23.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:58:38 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH V2 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc Documentation
Date:   Fri, 23 Jul 2021 10:58:13 +0200
Message-Id: <20210723085813.1523934-6-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723085813.1523934-1-cbranchereau@gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
 <20210723085813.1523934-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The jz4760b variant differs slightly from the jz4760, add a property to 
let users sample the internal divider if needed and document it.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
index 433a3fb55a2e..0dc42959a64f 100644
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
@@ -43,6 +45,13 @@ properties:
   interrupts:
     maxItems: 1
 
+  ingenic,use-internal-divider:
+    description:
+      This property can be used to set VBAT_SEL in the JZ4760B CFG register
+      to sample the battery voltage from the internal divider. If absent, it
+      will sample the external divider.
+    type: boolean
+
 required:
   - compatible
   - '#io-channel-cells'
-- 
2.30.2

