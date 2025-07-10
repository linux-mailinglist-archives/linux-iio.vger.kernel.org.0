Return-Path: <linux-iio+bounces-21502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9BAFFB12
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5016CEF9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42A28A1CC;
	Thu, 10 Jul 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Z0hwItwD"
X-Original-To: linux-iio@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BF289807;
	Thu, 10 Jul 2025 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133156; cv=none; b=K327BpOYUODzSZ3qOyVXCRatipOgf0TZn09hG4w/sMOxjth7+R5m9EiM9kBtpo69xafWHGeMXOMOgE3Jcovikthg8A3rEapynS+Ww95TxSUQOKHu1fx+vwgtgaTVMEQbOWqRAj3PbIRSaTwvYIHXRcXOm0pSW0skI3y81iV1R7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133156; c=relaxed/simple;
	bh=oeqGG4I9j4OVhOCiXiLtlfp12mxGfRfIE+hba6dt51A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G14oehK32dwqcRpxvrgnq4B67AGWy0neBTXuX8vXSYhcHRhtWuDsqR5RXs5HIHo9EYuJy1V/vxvIUDwwVMNMDQfQWI84ivlBFs84mWrKwJIWiJdMTTPx5xOsPN/t+BcDSvuO7whNhW4B4yYoF00lDUG4pZG1uZ6PUj6eq1WZw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Z0hwItwD; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0o3ZpWxtZvYJQQGhpqTBpq+m/IPV00LyVOTLAYt/dNs=; b=Z0hwItwDzqmFgHbUrDa6tgxHKR
	+uphq1RFa+XCKba7eej/wUQe1HRPD2S6lVLmlmkZpAk7LZ4mZYo59GpsDvx5f8wGcC4hjJlrwD9Ud
	vtJSQJCiMG1Lmt5sc3g7rLJMnvL4ajOGw03JbS/wewlTYTLbQfefTjuMKSL1KU1eu/wbIJZM+G7J4
	bgzd79vC8pySjEfhTbOxK9DurYCSAmWP8jrVtlfgB1tZUE+ea6Tt92CySt9SNzch+oOVnsTamgNl3
	gKVWYWkttMOxCAZIwyCtG9X8D7YxCoT5OHctUe97Arhvr0LsP6MHyirANlgdd5/DP5cTT+V/JsUQz
	pBRnH+pQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:48064 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uZls3-006IV5-0e;
	Thu, 10 Jul 2025 09:39:06 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	andrej.picej@norik.com
Subject: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration properties
Date: Thu, 10 Jul 2025 09:39:03 +0200
Message-Id: <20250710073905.1105417-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710073905.1105417-1-primoz.fiser@norik.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Andrej Picej <andrej.picej@norik.com>

Document i.MX93 ADC calibration properties and how to set them.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 .../bindings/iio/adc/nxp,imx93-adc.yaml       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
index c2e5ff418920..d1c04cf85fe6 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
@@ -52,6 +52,27 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  nxp,calib-avg-en:
+    default: 1
+    description:
+      Enable or disable calibration averaging function (AVGEN).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+
+  nxp,calib-nr-samples:
+    default: 512
+    description:
+      Selects number of samples (NRSMPL) to be used during calibration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 16, 32, 128, 512 ]
+
+  nxp,calib-t-sample:
+    default: 22
+    description:
+      Selects sample time (TSAMP) of calibration conversions in ADC clock cycles
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 8, 16, 22, 32 ]
+
 required:
   - compatible
   - reg
-- 
2.34.1


