Return-Path: <linux-iio+bounces-22942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93985B2B073
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB8C7A5960
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA281253355;
	Mon, 18 Aug 2025 18:32:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0072618
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541951; cv=none; b=KMq4xxETrQFQeyB6wK2vhOQ7Na9xHq2xRh1isXrdqaqpwhYfv/6B3BsLQYL05jKw3ajEApQpyMMvzhhZp9RCMwAGAsiExoEDaezdXEYf0/XFl8BCWpKb2hSAeNdHYX43rFCBwBKz1eYJqQJXxrFaIeaYPRh6qbj13jxUO9+R5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541951; c=relaxed/simple;
	bh=wFAQBvDPC15RotmXu1BO07WKmXxW+BAHy5N+pqi2mQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1PedfdHbE1yXijG1rJZN4Kc5juznQujnU0AvBB//t77GMyLhUlayNz1aY41ULc6s7nSWnfB5uri7M2PLBuaJDsewMIVvdNm2dddNy20bM56xezGBR2knY7tGzekVto1F7vOZVnNhBntr4ATorWnvipyE2T51ZKMh1zbUyCNqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
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
Subject: [PATCH 1/6] dt-bindings: iio: mcp9600: Set default 3 for thermocouple-type
Date: Mon, 18 Aug 2025 14:32:09 -0400
Message-Id: <20250818183214.380847-2-bcollins@kernel.org>
In-Reply-To: <20250818183214.380847-1-bcollins@kernel.org>
References: <20250818183214.380847-1-bcollins@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ben Collins <bcollins@watter.com>

As is already documented in this file, Type-K is the default, so make
that explicit in the dt-bindings.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 .../devicetree/bindings/iio/temperature/microchip,mcp9600.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
index d2cafa38a544..57b387a1accc 100644
--- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
@@ -37,6 +37,7 @@ properties:
 
   thermocouple-type:
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 3
     description:
       Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
       Use defines in dt-bindings/iio/temperature/thermocouple.h.
-- 
2.39.5


