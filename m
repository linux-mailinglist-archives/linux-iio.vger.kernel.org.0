Return-Path: <linux-iio+bounces-24738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284CDBB960A
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799903BB6B2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145CC238D54;
	Sun,  5 Oct 2025 11:15:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20948277C94;
	Sun,  5 Oct 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662914; cv=none; b=uTMHBWmeT7YLC57fbBDgvUWZpmN0S1pqdky+YLTyykimuAOL493z1SvLXgZmULd6RobfA+QUhNh8EWL7dT2PDjNzfrmL/pe0nhs7a6akSqBjDe51bUB6BMKc+IKIRIKTWCQcFA+vBmyf7be4kRQsyfrksAewoG9NdbT5BaZAH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662914; c=relaxed/simple;
	bh=J4CNEHp4HvP3XE7b+mw/WOyh+fdkB63bMKeRpIS/Lkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNcWbJkt2GUWL72+wzlkkfQTXUUqNXS2YoqZ1L6HdVQL/x7uDy4tswtniTi+Wwbc9V0eIUGbFIVNA4UM6SJpybFUcfEavzcXz1fjdz/cqUFiXIbXpxTmkix3VRFa1hobiyS4ax9YE8/sLJ1c3MucIaaM+CSkaoxrNNwb0F50J8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: TMiLM7RYRKGFuew7C0n5Vg==
X-CSE-MsgGUID: zubjI6XdQiGmNvxhTdWaBw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Oct 2025 20:15:12 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9C92A40065D7;
	Sun,  5 Oct 2025 20:15:08 +0900 (JST)
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
Subject: [PATCH v4 6/6] arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver
Date: Sun,  5 Oct 2025 14:13:22 +0300
Message-ID: <20251005111323.804638-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


