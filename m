Return-Path: <linux-iio+bounces-24373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BEAB96B8C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD143AFDBB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7127EFFB;
	Tue, 23 Sep 2025 16:06:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098B2356C7;
	Tue, 23 Sep 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643568; cv=none; b=BTqh+dQbnXzoZ4dHooSx46VsJuF8W8cRlJf6rso2EmltFLxZHxnJHbTrijfOB3UrHEnMBmGTFuzeWSRcFHGuXSNZ3HC9Lx/10da6F6AQDSIaTtSLcx6EEaFLQ7ppCaZjRFLUUooaXz6/PCoLZXzO8ZoQAz8YEdauvoKtujKmg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643568; c=relaxed/simple;
	bh=WkkC0kT5N1Q9IYtxl+k06yYtAGzKSUAMrKpNLaxFa6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsXwuGxuPDlcktKspPedbcXQuWuzp3FEb9laHC51rCPajBUqXfmLPG0OOkbOw72DwuRIYKjSpCX/wvyAsTHtiKsBOX1Ho3daJITbbvK0l3hhfWN0SpRvC+K7HUzjGIO1ynRzOtUqV4e21OtwIJVMPutq0btWQFy2Kz0NyhylHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: gyGMm+LbS6a0rEVG2hINUg==
X-CSE-MsgGUID: bs7SgK8uRsmkXt1mLdYZdA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Sep 2025 01:06:05 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E6D064008A2F;
	Wed, 24 Sep 2025 01:05:59 +0900 (JST)
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 1/7] clk: renesas: r9a09g077: Add ADC modules clock
Date: Tue, 23 Sep 2025 19:05:15 +0300
Message-ID: <20250923160524.1096720-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
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


