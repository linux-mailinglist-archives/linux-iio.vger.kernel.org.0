Return-Path: <linux-iio+bounces-15189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7BA2D8ED
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 22:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91D93A7556
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C023244EBB;
	Sat,  8 Feb 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="dm6Vvw24"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36522244E99;
	Sat,  8 Feb 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739050001; cv=none; b=j2/PviEA8SOvIztSR/ckJDCheBWuWEIUdpKTFUYvo8Qak6h/yMbNY8dUXefVa5sn1dIGUmObshVH0uv+yGK9ywwZ92B6NrGszxnCWGo3XsirBtXuZpv8BKym4aQ2tf0vdXSCLiFNq5Fy8T8PkcpgdkvvEH9QtI8qOkmwx6MlL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739050001; c=relaxed/simple;
	bh=hMAM7CUBGn2KUNz4ahL7cPYMznPAMm670fG0T+OBdoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1qaKCC5Ug4KgQFEpIL95eNeYJdLsKm5jEqylL9q0AXCn4P309toUWH+uSLYBN+XR1x0/dL+U6/H7h8ElF84m+I7zjt6gzZa4cn+/IRMEKfjulHx1Z4U03ojhuplXa2o6b+euYLRlLTOji0MpXLdPQhWzJgyuQqyw0sxRPJyXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=dm6Vvw24; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 7843541B55;
	Sat,  8 Feb 2025 21:16:32 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/8] dt-bindings: iio: light: stk33xx: add vdd and leda regulators
Date: Sat,  8 Feb 2025 16:13:19 -0500
Message-ID: <20250208211325.992280-3-aren@peacevolution.org>
In-Reply-To: <20250208211325.992280-2-aren@peacevolution.org>
References: <20250208211325.992280-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ******
X-Spamd-Bar: ++++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739049393;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=5yaZnhLbJDYzxUuUS1CTmE6SRmYxieOewJarS/4KATs=;
	b=dm6Vvw24T+EkZZZWOvulzhEhaUCWTi/vG6PFpZtwIaR1X4siFgN8khNXjmV8mZWhekoRPS
	hCcH+G1iWplrqCbloeF69NmZP+j1E3djNOrUkLuUoukTamlWGh3mqYgoy9D65xgQ+1fCVq
	R4pZ9ZRmXfKNxANvP7qtAqgLPdI8wIE=

stk3310 and stk3311 are typically connected to power supplies for the
chip (vdd) and the infrared LED (leda). Add properties so we can power
these up / down appropriately.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    Changes in v2:
     - add leda-supply
     - add supplies to examples

 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index e4341fdced98c..96ee8ec16463d 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -34,6 +34,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+  leda-supply: true
   proximity-near-level: true
 
 required:
@@ -57,6 +59,8 @@ examples:
                 proximity-near-level = <25>;
                 interrupt-parent = <&gpio1>;
                 interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+                vdd-supply = <&vdd_regulator>;
+                leda-supply = <&led_regulator>;
         };
     };
 ...
-- 
2.48.1


