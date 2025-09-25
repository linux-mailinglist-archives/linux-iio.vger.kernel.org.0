Return-Path: <linux-iio+bounces-24447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA8BA1DBA
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4967188FF2A
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411053233EF;
	Thu, 25 Sep 2025 22:41:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE232252A;
	Thu, 25 Sep 2025 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840066; cv=none; b=GK8W4mg0sfGWD+HAUICcdO8CWmeQtzNghUePMGG+qWDqZvbMjmrafSGu1AePqGGmXP8xsjXkX4nWmyRGUSHBl6/OaYoMDVKTGNyLVKHAgde3ebN/RU6VjMDW4xyicQycpJB8IY1zdim7iW6EPMm+TxIePUePfFxSmb6WDBELWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840066; c=relaxed/simple;
	bh=k34C/W2IXwDBHyNllf0jyBB4tq4BgdGxE9GvTphqkJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkJmAipf/q9IMvXKUwbrYAUbT8HSewAVY1wA4zg6reZTJ/lRnHjQvpEBaDI3FVu2wjDo4D2KUzPyqRMK/P6lIGra8iJamvi4RdPEiROO0+n51Ga6cb5G3fVkRRWMQ+gBFjVVyKSfG4ZtGM6+kaIJKThDU8fO7ZmAcf9j/tmzl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: dGYGCEUrSuGdS3RnCm5gVg==
X-CSE-MsgGUID: OCcbb9uET8quZKSBHBnIgg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Sep 2025 07:40:55 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 989FF400CF0A;
	Fri, 26 Sep 2025 07:40:50 +0900 (JST)
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
Subject: [PATCH v2 1/7] clk: renesas: r9a09g077: Add ADC modules clock
Date: Fri, 26 Sep 2025 01:40:03 +0300
Message-ID: <20250925224013.2146983-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three 12bit
ADC peripherals, each with its own peripheral clock.

For conversion, they use the PCLKL clock.

Add their clocks to the list of module clocks.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 3aaa154102d5..5dca5c44043e 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -192,6 +192,9 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("sci4fck", 12, CLK_SCI4ASYNC),
 	DEF_MOD("iic0", 100, R9A09G077_CLK_PCLKL),
 	DEF_MOD("iic1", 101, R9A09G077_CLK_PCLKL),
+	DEF_MOD("adc0", 206, R9A09G077_CLK_PCLKH),
+	DEF_MOD("adc1", 207, R9A09G077_CLK_PCLKH),
+	DEF_MOD("adc2", 225, R9A09G077_CLK_PCLKM),
 	DEF_MOD("gmac0", 400, R9A09G077_CLK_PCLKM),
 	DEF_MOD("ethsw", 401, R9A09G077_CLK_PCLKM),
 	DEF_MOD("ethss", 403, R9A09G077_CLK_PCLKM),
-- 
2.51.0


