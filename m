Return-Path: <linux-iio+bounces-4369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267108AB215
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5724F1C21736
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A6A1350F9;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amhmumE/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BF1304A7;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=Hb4tyMGgbEpshDeNyedLhBAfE2So+F80XbFSYilWDtcfx4RxUeiTprrIg2DJvDedgMFbYpmUQAMvOIQUjsX45eYu2t31Ya2TuafvbM0XAU54QLZsSQWNlpQiG+ZClHMm5Y06lpGoLsyZI++lb4zooEWpFsKjcBQrR/jBRlqa7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=KKVLahGVov+3Ev8//vGWIT9Ky/0x/0vrY7Px/D3ptpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccDBm2tYNKbfZAOLRU/9Z4tbkLVEOoi8RwQnW97QzBiV5KFB+QVRiOlckX6SDJ/ewjDRC7oTqQ2fuXK13bfHHT0jie5jKfndBdfewMjpohh5Lk7ysKqfIJmvROHPL0mYFiOPWPnB/TJqW322BvEM0CLwHGsoXm4gQRsPHuqTaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amhmumE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D19BC32786;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=KKVLahGVov+3Ev8//vGWIT9Ky/0x/0vrY7Px/D3ptpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=amhmumE/kqag85+e3rCsGZQqUd0n9THSSUNKPmcb1E5sf4uVDpMVuJeXaV7Zq48bb
	 Cg5Fja2J4XiqCkI3SAxRAsbsQnjbBwNaQ0pv0ns0Bgp26txkIeooy6i51kAcl1i5s5
	 vC8bgJa5NVNJwA04ScAN/LVlBABr/sJaZbVhmKXdsrtp3lYOXqm/PicLFoSyzqlAew
	 ypoP9QuD9Rr28I/+ks1yQohBI6ipLu5EWOlSojrCUejnFPSjd9GsKRlUwP2pnelaAB
	 sHqhycYHNlnP3Enh6CX9pzrF7S+b+vG/Ouea6dbe0a796srh6vr4yMl6d/71XeA1XG
	 ghI1JtYlzZXOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9FC4345F;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:46 +0200
Subject: [PATCH 3/8] dt-bindings: adc: axi-adc: add clocks property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-3-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=1048;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZntCSlHgOIAf1gqisnjrXuzKRZVpUr7uIRrPEaUInis=;
 b=HJBmv5brfYl/udSe+tJNa4T7w9PlMfU2vjNLhq6bstQ7ivb98lNF82DJyakUMqIx0+ruqr9p/
 WLZEwd5JWahAPaQUKzPGm4HIAQ3H7lwNiIpXpRCmuZrPAj1LIRYCH20
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Add a required clock property as we can't access the device registers if
the AXI bus clock is not properly enabled.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 3d49d21ad33df..e1f450b80db27 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -28,6 +28,9 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   dmas:
     maxItems: 1
 
@@ -48,6 +51,7 @@ required:
   - compatible
   - dmas
   - reg
+  - clocks
 
 additionalProperties: false
 
@@ -58,6 +62,7 @@ examples:
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
         dma-names = "rx";
+        clocks = <&axi_clk>;
         #io-backend-cells = <0>;
     };
 ...

-- 
2.44.0



