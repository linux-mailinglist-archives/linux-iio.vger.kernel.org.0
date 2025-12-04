Return-Path: <linux-iio+bounces-26745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E76ECA43D6
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB16B304EB13
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB12D73B5;
	Thu,  4 Dec 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faztTxpC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762B2D4B57
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861819; cv=none; b=Xik2cFU/Bmabsa574Mn9gUUJb0+euBoO19h9qRYpxwBgCF9yPcscdq/RvTNPDOxN3p1Szem9SwWKBeNtIYdonWHmU4wkXdbgTFt2CihQIZEWHtI7uoSidpKb7jDiArykL1uWEa3hYEjkscDammr0gmbBDIxzp5m+2lyyh7pJYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861819; c=relaxed/simple;
	bh=W7eeAmhisWPDozh/dECA1ngrPogsYW8NRsjkfzFF3PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btsn5M/jqEdj05HseeBjIVKUbGX+KI/aLNK5nyG1ubnXXMBavJZza2IkPA670ssuqFjjMct2Ew/aTXMuwKlmvBT4jH9PDW4INHOXWpJWwyfNZCaK6Jy++uhdXbDtzXk+DTk5nMVXFGEbI1cHDaJiEpc8VtKzeDquwa0j9aVyWOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faztTxpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BF4DC116B1;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764861818;
	bh=W7eeAmhisWPDozh/dECA1ngrPogsYW8NRsjkfzFF3PQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=faztTxpCzOllgQwS2IoEHsZkArmI3Vovb7+vymzm5Qlt232KPf9RdwnEHFXvCW0mu
	 F5YCngrrnVqTNVtYOJslLuEeoHDoTE0StHLRM+Jejz/Dg2+09nO6g3wyfZk/FSOcFI
	 T7bEabOWzk7r6t+gefUjJQrxxsG14mF95PdTgQd8tsqIYCfqE8UisugV1R4ePfUiu+
	 b4scjD0XNIgBSO/b739K33cXkPt98jICVNRmldVNhMZuHMe2hshy1Y1O2bXKbs/10T
	 Prx+9bOiBFjl4MGgT3ArNzI2Y6vd8pPR9ScVj9kTDZrxPIN06W/DeK3BAJSaa0Zib6
	 MUQKfw1yCjBhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1DD21692;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 04 Dec 2025 15:24:18 +0000
Subject: [PATCH 2/3] iio: adc: adi-axi-adc: Turn dev_info() into dev_dbg()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251204-iio-axi-adc-minor-change-v1-2-2d441d6c5b65@analog.com>
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
In-Reply-To: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764861858; l=1066;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=OePNUCXm116ME9HrJY6rNf7OR2YjvC53VyV6nWYOz84=;
 b=DIxewfLl515CJKJ/cqdp8asPzOrG8UhLdACYGPEZ/wF3ZuyQ+FTwuWFdSM3xPfTx3KpE0POW1
 FeBL1mnEdggADitiS+4HsqKPeY9JVYcL4oc6wakLcYiToAYSCz+Xn9P
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

We should not abuse logging and logging a successful probe is clearly
abuse. Turn it into dev_dbg().

If it turns out the IP version is that relevant we can make it easy to
get through a new debugfs interface later on.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 8b8955841afa..32af2bfc2bf1 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -753,10 +753,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 					     "cannot create device.");
 	}
 
-	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
-		 ADI_AXI_PCORE_VER_MAJOR(ver),
-		 ADI_AXI_PCORE_VER_MINOR(ver),
-		 ADI_AXI_PCORE_VER_PATCH(ver));
+	dev_dbg(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
+		ADI_AXI_PCORE_VER_MAJOR(ver),
+		ADI_AXI_PCORE_VER_MINOR(ver),
+		ADI_AXI_PCORE_VER_PATCH(ver));
 
 	return 0;
 }

-- 
2.52.0



