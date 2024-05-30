Return-Path: <linux-iio+bounces-5491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08D8D48A9
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C11C21E29
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AFF17C7B4;
	Thu, 30 May 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4FIwHtX7"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF116DEBD;
	Thu, 30 May 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061673; cv=none; b=Mh3UkmURw2StL0fRoxFzMagYnzlOdd+dvtIFCe5v0c2AvLOjCW+J0q53GB1jvEYJ4/xxOq4PpnfW+R45+h+DY36M77ttrNVx1ab1W93mISSRaKG8tzZQVSt2cGAItwY6X4cOcoW3cXfuxS7dD+07tbgZYghR8k0b2KEgPrQqkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061673; c=relaxed/simple;
	bh=4isRwFg+lFtocx2ttK9dTVWtREPPc/h5BSwfHPf+To0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HY5fvt87GeMPG2jTdBwkwFr1XbsxIGin+6KoCf96yUuOfz7iywNXCw5WsQCZGsxlbJBLSqw3d/2E7ydp8OlhCWB32O1BInDrlRTsIQ/ZydApUmyHunRdvgP1FGki37P5TY0GYIYhiCj0w/AN4kRh4tQz1Hb4rhH6rwwEpo6wtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4FIwHtX7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717061669;
	bh=4isRwFg+lFtocx2ttK9dTVWtREPPc/h5BSwfHPf+To0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4FIwHtX73FL2IKfENyklA3RqOGZFhuTT6kI+0WxRLTSvzAfyk7NzNYAlGVABpGv0z
	 irfD92ROMgRL8WQs8oMBuni/z+PCJ7rH6CvKmm0KT7LxigjhlhOoD6x/gw3WfllBbW
	 rCI9Qm4D7ranhlRqORJXie+W6O8/tJhapF3hxNNT7qg6IyhEll1acVaFnYS2M0Sz9D
	 sdWKSfwRruPFt7oc92VDqEDNPt04vqCitu/j/JwTaFVKn+4ySf6JzaV2r1c7T2gROP
	 JMHfsvUojG30Nq04IyUTFsnPikh5dveXQikcykjvrMHWsZc3R0PbQ3vRImus4mRtyN
	 gO7Cn1xHL98nA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 832F237821AE;
	Thu, 30 May 2024 09:34:28 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH v1 4/4] arm64: dts: mediatek: Add ADC node on MT6357, MT6358, MT6359 PMICs
Date: Thu, 30 May 2024 11:34:10 +0200
Message-ID: <20240530093410.112716-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
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


