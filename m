Return-Path: <linux-iio+bounces-470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635857FC82C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 22:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DDA282953
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 21:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E946B9B;
	Tue, 28 Nov 2023 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC132B0;
	Tue, 28 Nov 2023 13:48:11 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso3656354a34.2;
        Tue, 28 Nov 2023 13:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208091; x=1701812891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrJ0LHtyb46py1wsTp8nuyQVcABfVvnzMH83rgwCH3U=;
        b=wyVuby5OnCprk+IwWtJ0/yMj5YuM2QJdkcyLvk+7McIuNcjB0lGekeMuCI+VCmry7l
         b8L5ppW9uPlxfZHBgzIybAhQluMjHdjO8G3YrqHsypNYMapH07+v2PEc1X8U5ySmVxoE
         lQ+zzxkMztuB67t1emnSF3GhSS2lFtH7M7TD+kcsp9lFd/f5wb4yIm797SDfkSVpODP1
         e1dXFDr9zdfGsb4y6zEROxKhSfyPsVuS2bHB/KneZRgD5uNom56WSNUAB38pesXUUPEs
         w1ejiKUNXSPIRTL+7BRPo00HC7DT7+AoGOYbygzXrObLPhIpInTaHlyBspslFiRyZKgz
         TOSg==
X-Gm-Message-State: AOJu0YzQnqDC8ITXIYfsMwmF2N1tNWrxUA8hrXN1RH9CWxV18+64Xx83
	lmE+ZPehSRprzR4rWiVngw==
X-Google-Smtp-Source: AGHT+IHqEJJFSEStAXI4DhX5amCfCmwugJtgNaAYjJgH64aasKenmGzatAY6vvhJcfUYjyMYnWkK2w==
X-Received: by 2002:a05:6870:b619:b0:1fa:3e11:e178 with SMTP id cm25-20020a056870b61900b001fa3e11e178mr12375997oab.10.1701208091189;
        Tue, 28 Nov 2023 13:48:11 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm2765905oab.11.2023.11.28.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:48:10 -0800 (PST)
Received: (nullmailer pid 3975662 invoked by uid 1000);
	Tue, 28 Nov 2023 21:48:06 -0000
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/adc: ti,palmas-gpadc: Drop incomplete example
Date: Tue, 28 Nov 2023 15:48:02 -0600
Message-ID: <20231128214803.3975542-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example for the TI Palmas ADC is incomplete as the binding is the
full PMIC, not just the sub-functions. It is preferred for MFD examples
to be complete in the top-level MFD device binding rather than piecemeal
in each sub-function binding.

This also fixes an undocumented (by schema) compatible warning for
'"ti,twl6035-pmic", "ti,palmas-pmic"'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/ti,palmas-gpadc.yaml         | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
index 720c16a108d4..f94057d8f605 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
@@ -67,19 +67,4 @@ required:
   - compatible
   - "#io-channel-cells"
 
-examples:
-  - |
-    #include <dt-bindings/clock/mt8183-clk.h>
-    pmic {
-        compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
-        adc {
-            compatible = "ti,palmas-gpadc";
-            interrupts = <18 0>,
-                         <16 0>,
-                         <17 0>;
-            #io-channel-cells = <1>;
-            ti,channel0-current-microamp = <5>;
-            ti,channel3-current-microamp = <10>;
-        };
-    };
 ...
-- 
2.42.0


