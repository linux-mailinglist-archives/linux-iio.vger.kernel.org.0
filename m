Return-Path: <linux-iio+bounces-5753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20D8FB239
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222B1281186
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDAA146A94;
	Tue,  4 Jun 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y3u6b6nh"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3291465BF;
	Tue,  4 Jun 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504221; cv=none; b=YLBdT1yBTlLa3M9hi+hprgkOF5KXL4ArP2bM2JPaFxHc090xmykttSV8XHUJ2/r1O0JyaJmYPPyNgZSiz5fGKmqdOM35IglXEjivJrr1yIMLbv5MvufffgvbETLlJww9N8+w8XRmgwr70uN91vffcErjp29mrXEWt89kSl1tcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504221; c=relaxed/simple;
	bh=J+OODm0wIrA4401PrNQAK4+hIQjVOMpoja1yNcRjEB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLHc+pluNgopcGcK/4E9lmYvUJ+nvYoGPUsiFNOetl1wlhG0xfICzb548zCrwQ5rbYe2kRxV+uNm2Xqzg5HE58JJIwiTj4GrTztprU/h4gizMwqCVsrwi9Qoypgkth7dk7NjJ/fDggoUJ1/Mk3Wbq8uXZjJl4OFytFx1uF7A2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y3u6b6nh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504218;
	bh=J+OODm0wIrA4401PrNQAK4+hIQjVOMpoja1yNcRjEB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3u6b6nhuVviydEeQMze5zcUyK7shBy8vbhJkNbqjqLP3vjhy7quqXGjuGJ9IGGE3
	 YT43XegJBf56Dz+XFBwFdWb8aQDQ7Y9qcKEpDuxEwbORnZ3pV1JLNSXbf7oqM30OTQ
	 CCuugYGjo+906Iwuf/uBa+HJK6TzzwNhhrWJZqaXo7DRl5/1Tdf4gFqJf8rMLjN9iQ
	 uUGKqR2BvnvFN0rtw3uN5Gq+p1VVCQlPQtgiNVCYrge5V230VedlST9RuIfvJB17pj
	 SrunTHa/2aTYun3vbvnb8RqI2ldG60gJpkWt/3SR/E7GWQjt6QOWbP3iekijX7tRwC
	 yVtXw7hoMaPfA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7770C37821F4;
	Tue,  4 Jun 2024 12:30:16 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	marius.cristea@microchip.com,
	marcelo.schmitt@analog.com,
	fr0st61te@gmail.com,
	mitrutzceclan@gmail.com,
	mike.looijmans@topic.nl,
	marcus.folkesson@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	andy.shevchenko@gmail.com,
	kernel@collabora.com
Subject: [PATCH v2 2/5] dt-bindings: mfd: mediatek,mt6357: Describe Auxiliary ADC subdev
Date: Tue,  4 Jun 2024 14:30:05 +0200
Message-ID: <20240604123008.327424-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the PMIC-integrated Auxiliary Analog to Digital Converter
subdevice node.
Full description is available in the mediatek,mt6359-auxadc.yaml
binding relative to that hardware.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
index 37423c2e0fdf..e3513cad25f6 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
@@ -37,6 +37,11 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  adc:
+    type: object
+    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml
+    unevaluatedProperties: false
+
   regulators:
     type: object
     $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
@@ -83,6 +88,11 @@ examples:
             interrupt-controller;
             #interrupt-cells = <2>;
 
+            pmic_adc: adc {
+                    compatible = "mediatek,mt6357-auxadc";
+                    #io-channel-cells = <1>;
+            };
+
             regulators {
                 mt6357_vproc_reg: buck-vproc {
                     regulator-name = "vproc";
-- 
2.45.1


