Return-Path: <linux-iio+bounces-24944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21406BCFCD5
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A80189A7BE
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019F27E1C8;
	Sat, 11 Oct 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RA2ftuCb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6142056
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760216726; cv=none; b=U2icPrgQJSiCiYsBpSWGCr5Dku2H/UdfnYgc2NKAKHmNPTdpwwWiFwG/E4ARKTM2QXh4M65+azXnkH/XZieT8lu7ou9qv+JnPK/IbRCbPJ3Csk1Yi4D3Ml7l1Y11TxVD/78YvEeR5bZ9+1AU/jDOfibNcB5WsD7VNtlWzIFBNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760216726; c=relaxed/simple;
	bh=lZq0/HIDqU1GEB51DwgkgzlzKl1oqyCNOzJFZMKHILo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOEwmUOx06/7Y/GwqN703whSHSfhXesgmN0HKNjmKpF8eOC4ucnFix6gXLlOEzh/LoZcDxdf2UFxbXw8olej+DglJ7fsABss8JtYsZOiJ/uyyFuuBrzQn5PnBCIFkZe+SDTCD82wYhZQVNMHFvfCkqYnuSVpq3Vb1Rt0GHY51jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RA2ftuCb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=mvEVzJiKO7LW0C
	nz3icvifzXKIeD7yTZL7I9nQSxXLU=; b=RA2ftuCbZqBn9+PuLH2WITwZdY4kfR
	vwLK2YAh++o7eyQ7qFcsIqIIzgRIMaKoHV1Kr9s6x6eRnkC5xPZoD9Ur/LVzXsZ1
	dGOY0eXXXhr5zcuea59qqzFKnbhRYw2HYCYpFLAs8Zv/U4h+iZm1ZUhOIeLve1Qe
	Rg+tR+fmpmarhi4JeYkS7EqGEJjqNSWaAnDRyswea9Ys4I316KL+P2YseELhtkC3
	I0appC1tlX5+8Sc2825IdijJgo5JZPwhE3pp/iCNxNn1j5pyQUXIzGP0oEUilLTu
	tr0XWRMwo4mZ2/ZXTDlw/LiTaIZMtRZ59b+bE2g/1HI/exbCfPFYuBwg==
Received: (qmail 1927893 invoked from network); 11 Oct 2025 23:05:18 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Oct 2025 23:05:18 +0200
X-UD-Smtp-Session: l3s3148p1@U04yZOhAMsUujntw
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: accel: adxl345: document second interrupt
Date: Sat, 11 Oct 2025 22:59:09 +0200
Message-ID: <20251011210513.3253-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pinout of all the supported chips in this binding have two interrupt
pins. Document the second one, too, even though the Linux driver
currently does not support the second interrupt. Boards may have it
wired nonetheless. While here, drop the dependency of interrupt-names
which is already described in the core.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since v1 RFC:
* drop oneOf and encode interrupt-names differently (Rob)
* drop interrupt-names dependency (Rob)
* added tag from Geert, thanks!

 .../devicetree/bindings/iio/accel/adi,adxl345.yaml    | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index a23a626bfab6..61d7ba89adc2 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -35,15 +35,17 @@ properties:
   spi-3wire: true
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupt-names:
+    minItems: 1
     items:
       - enum: [INT1, INT2]
+      - const: INT2
 
 dependencies:
   interrupts: [ interrupt-names ]
-  interrupt-names: [ interrupts ]
 
 required:
   - compatible
@@ -84,7 +86,8 @@ examples:
             spi-cpol;
             spi-cpha;
             interrupt-parent = <&gpio0>;
-            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "INT2";
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+                         <1 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1", "INT2";
         };
     };
-- 
2.47.2


