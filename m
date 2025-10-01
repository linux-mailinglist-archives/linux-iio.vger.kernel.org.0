Return-Path: <linux-iio+bounces-24617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FABB0545
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 14:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AB32A4A53
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF322DECB1;
	Wed,  1 Oct 2025 12:24:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB082EA15E;
	Wed,  1 Oct 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321456; cv=none; b=QVkM2hEVy16OIqR1OSUZJeD0XGOz9nIEAWJpUuZbXwhjKn+sgBC4GaiKVemd0ZPCdXEmsM0PypOwEA6lxiVAqsTN8xGbY4H35J8O7q4vcq+PMyMa+fGt3hYuIbzn4FZIy9F9IE9CqDwR2Wa7p+AojBPBDHFi97KRT5xKHglj3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321456; c=relaxed/simple;
	bh=k34C/W2IXwDBHyNllf0jyBB4tq4BgdGxE9GvTphqkJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUNV5oU+JeKYHPoX7D6QByINb87ji6eiSrbx0Dbq3d0fNA0uq1vw+4lYf8yB0huvvGrHF1hNA8TeKfBwDuHkGPS5na+q64pxrzZhmCuqwxI+OQNDji6LgR54P/nKfWKKdrm6Aiqqx+FzW/Gxd77EeemLEDePXT9mtu7Msczr1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: n8t/+BFNT26ZpKj+0sgN3w==
X-CSE-MsgGUID: +hhme2h2TyitBhKLeExAyw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Oct 2025 21:24:07 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DB0014196E7E;
	Wed,  1 Oct 2025 21:24:02 +0900 (JST)
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
Subject: [PATCH v3 1/7] clk: renesas: r9a09g077: Add ADC modules clock
Date: Wed,  1 Oct 2025 15:23:08 +0300
Message-ID: <20251001122326.4024391-2-cosmin-gabriel.tanislav.xa@renesas.com>
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


