Return-Path: <linux-iio+bounces-24623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF300BB058A
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9FD3B1D69
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FB2EBB85;
	Wed,  1 Oct 2025 12:24:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8C52EA477;
	Wed,  1 Oct 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321482; cv=none; b=cb7EPxtrCtZDheoTSinnKv/zHULU2YTv3cmIynwRGNxWrsTGRFh88fxw1xjfC7l7UC73YmYmANK03/5BVLhsTZnfn1ATENyc3c4u3aXilmRTWPEx9XRSFbAg14SbnhmzsqS3SZFqAlONpBG+STohvJ9nGu/40hEfI9KjmwdH8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321482; c=relaxed/simple;
	bh=tnTqUW1CCfg20bZn8bGpLx7RaTcWjSs1bsmxkTRlM+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIaDqE558jd5uH1l/P4hnA/2dgkJsbZ3om84uXDFRet2S4bQImG+oLz0tCDbpGE+KYBBDns8iF7BVpJgwF9IPafkITIypAvKMqrAPNcdpOpT7CpopA/f1uGnshse2Dtfhp9QepREs15qzbX0FOazWFgp9AQGtBV/+jCiO+oEUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 63swcoD6QeOm+Cpw9G+new==
X-CSE-MsgGUID: M/r6d7RCQz2F/1Mjjlqzvg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Oct 2025 21:24:40 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E0AD34196E62;
	Wed,  1 Oct 2025 21:24:35 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver
Date: Wed,  1 Oct 2025 15:23:14 +0300
Message-ID: <20251001122326.4024391-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
12-Bit successive approximation A/D converters.

RZ/T2H has two ADCs with 4 channels and one with 6.
RZ/N2H has two ADCs with 4 channels and one with 15.

Enable the driver for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8fd1bf869942..3a1326652d47 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1581,6 +1581,7 @@ CONFIG_QCOM_SPMI_VADC=m
 CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
 CONFIG_RZG2L_ADC=m
+CONFIG_RZT2H_ADC=m
 CONFIG_SOPHGO_CV1800B_ADC=m
 CONFIG_TI_ADS1015=m
 CONFIG_TI_AM335X_ADC=m
-- 
2.51.0


