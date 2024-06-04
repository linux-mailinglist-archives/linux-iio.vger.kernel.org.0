Return-Path: <linux-iio+bounces-5756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3498FB243
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33962B2245A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044D147C7D;
	Tue,  4 Jun 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kDFUSPMQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969751474A6;
	Tue,  4 Jun 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504226; cv=none; b=oie7HRtICpsmBvlwyb0fd9M1sgkOLQqpDVmOZi1P9RvxQsF4Mj+0vVTbQgzXeR7GUCHg2WVMa+Hkt6Vhp50QGgnpFWmxUA6pD0K+4uc+tsjN8qYfJy710nIEC5EpgL9Vg/4v153j4FETSlu51omS5SGcANnxIUhRJ7DR68g6I1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504226; c=relaxed/simple;
	bh=4isRwFg+lFtocx2ttK9dTVWtREPPc/h5BSwfHPf+To0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLCbKVUQ8M6aGZHej7/EtR8HA1GXpKBieufn9LgxoJsG43Owr8/GjGuErxQ5L14d8LMnxrnZgVmkWlDSf8C8+8OcMePJEmMDD8BsKDR61862ZmVa3XVE9caydaXuWdSDiDIrpggyGS3CPROHkAcrvsyvQMlCWQxWNPVbUkfMRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kDFUSPMQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504223;
	bh=4isRwFg+lFtocx2ttK9dTVWtREPPc/h5BSwfHPf+To0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDFUSPMQgViXEXAe/nwxu4sO/3IfQMTtY58QNx41aL2W/3ilHMMLXOXaeW8j4WAil
	 tqzXsdCWy+xfiFDOxInXvt1uEspY4iOgFMShoFU27mmIwC17E1kh7LpaADywBFzQMy
	 OJEGrapfv+udD32gIHQWeoz/FqoJXW0XIgNBQvfzbwsaD0FMOHWCwYp2RLnD/dza9k
	 K7cy6HDewopEZecN3MJmQ992Mi183dePq4gHwGpnuM4tYYNJtZxr7HWK0SU+pfgGAV
	 ea00b2yt+WJmy5O1CZWkU37HwqNriI2KorKpLpgUCxZUaIKcM3+SaQ+M/bg8zEUT/p
	 9vdCQQArjPo1Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B443737821FA;
	Tue,  4 Jun 2024 12:30:21 +0000 (UTC)
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
Subject: [PATCH v2 5/5] arm64: dts: mediatek: Add ADC node on MT6357, MT6358, MT6359 PMICs
Date: Tue,  4 Jun 2024 14:30:08 +0200
Message-ID: <20240604123008.327424-6-angelogioacchino.delregno@collabora.com>
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

Add support for the ADC on MT6357/8/9 and keep it default enabled
as this IP is always present on those PMICs.
Users may use different IIO channels depending on board-specific
routing.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6357.dtsi | 5 +++++
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 5 +++++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
index 3330a03c2f74..5fafa842d312 100644
--- a/arch/arm64/boot/dts/mediatek/mt6357.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
@@ -10,6 +10,11 @@ &pwrap {
 	mt6357_pmic: pmic {
 		compatible = "mediatek,mt6357";
 
+		pmic_adc: adc {
+			compatible = "mediatek,mt6357-auxadc";
+			#io-channel-cells = <1>;
+		};
+
 		regulators {
 			mt6357_vproc_reg: buck-vproc {
 				regulator-name = "vproc";
diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index a1b96013f814..641d452fbc08 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -10,6 +10,11 @@ pmic: pmic {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		pmic_adc: adc {
+			compatible = "mediatek,mt6358-auxadc";
+			#io-channel-cells = <1>;
+		};
+
 		mt6358codec: mt6358codec {
 			compatible = "mediatek,mt6358-sound";
 			mediatek,dmic-mode = <0>; /* two-wires */
diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index df3e822232d3..8e1b8c85c6ed 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -9,6 +9,11 @@ pmic: pmic {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		pmic_adc: adc {
+			compatible = "mediatek,mt6359-auxadc";
+			#io-channel-cells = <1>;
+		};
+
 		mt6359codec: mt6359codec {
 		};
 
-- 
2.45.1


