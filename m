Return-Path: <linux-iio+bounces-22771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F7B2844D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81001672D6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47554257858;
	Fri, 15 Aug 2025 16:47:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D8257837
	for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276440; cv=none; b=P/fsCRtWellTCD95TJeBZ7OpYNOZ0oZTsqu7IBKJN5Fi5xD6PwXUhFDWtBE75JymSqnvS5p+SqfeXssbxGouiLm7HN9IknPum2p0SENiSWd+ypXXhqex+8JHyBcEGuzjb1sJmAenWP4PH0JNWY0uTjPqT1GQTMmWvk7p+rt8K4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276440; c=relaxed/simple;
	bh=j/9cuIbYu6W4c22f86c6VTEKRD+z+7bxqk9N2+RmlZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox82hBWpyCIBfx8zlS1qywgMGU7CBBUNBHg6EUdOopoR9owPVO1XjOhlouzVuGWzDm7lG8LmXlo2sZIfSlDYDb5k1SlRj1ghTqi8K+ZUgiY2pBnbcpRYZKIwcAPuCe778oA/N5FkfCvP16QHKPWCtu5IYkumiSD+tDR0dg6FL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: Ben Collins <bcollins@watter.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for microchip,mcp9601
Date: Fri, 15 Aug 2025 16:46:03 +0000
Message-ID: <20250815164627.22002-2-bcollins@watter.com>
In-Reply-To: <20250815164627.22002-1-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The mcp9600 driver supports the mcp9601 chip, but complains about not
recognizing the device id on probe. A separate patch...

	iio: mcp9600: Recognize chip id for mcp9601

...addresses this. This patch updates the dt-bindings for this chip to
reflect the change to allow explicitly setting microchip,mcp9601 as
the expected chip type.

The mcp9601 also supports features not found on the mcp9600, so this
will also allow the driver to differentiate the support of these
features.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 .../bindings/iio/temperature/microchip,mcp9600.yaml         | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
index d2cafa38a5442..d8af0912ce886 100644
--- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Microchip MCP9600 thermocouple EMF converter
+title: Microchip MCP9600 and similar thermocouple EMF converters
 
 maintainers:
   - Andrew Hepp <andrew.hepp@ahepp.dev>
@@ -14,7 +14,9 @@ description:
 
 properties:
   compatible:
-    const: microchip,mcp9600
+    enum:
+      - microchip,mcp9600
+      - microchip,mcp9601
 
   reg:
     maxItems: 1
-- 
2.50.1


