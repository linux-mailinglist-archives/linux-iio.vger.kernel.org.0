Return-Path: <linux-iio+bounces-1471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAB826728
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 02:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D591C217AD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C70A42;
	Mon,  8 Jan 2024 01:48:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC67F;
	Mon,  8 Jan 2024 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636808:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 08 Jan 2024 09:47:30 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Mon, 8 Jan
 2024 09:47:29 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Mon, 8 Jan 2024 09:47:29 +0800
From: <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056 family
Date: Mon, 8 Jan 2024 09:47:27 +0800
Message-ID: <c1abb261bb00846f456eb8fe9b5919f59f287c24.1704676198.git.cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1704676198.git.cy_huang@richtek.com>
References: <cover.1704676198.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Add compatible support for RTQ6053 and RTQ6059.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3
- Add Reviewed-by tag.

v2
- Refine the 'compatible' description with oneOf and listed items.
---
 .../devicetree/bindings/iio/adc/richtek,rtq6056.yaml     | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
index 88e008629ea8..af2c3a67f888 100644
--- a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
@@ -25,7 +25,14 @@ description: |
 
 properties:
   compatible:
-    const: richtek,rtq6056
+    oneOf:
+      - enum:
+          - richtek,rtq6056
+          - richtek,rtq6059
+      - items:
+          - enum:
+              - richtek,rtq6053
+          - const: richtek,rtq6056
 
   reg:
     maxItems: 1
-- 
2.34.1


