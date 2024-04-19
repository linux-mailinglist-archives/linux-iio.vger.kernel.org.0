Return-Path: <linux-iio+bounces-4368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43368AB214
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46361C21E72
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD601350EC;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC4q56x6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71214131BC3;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=Ii42sq00aN7HxcwQphGKjVrm398XQYrUaa7A6WHEiF09Q6E/HtCa5icd42kZ5JNgqoVBieE2V9+d6wjW1y6wGC5b9vRadRHkLVXDhQL9bdv9NW5tnAloC80iwdDNdNbAgMkphLXMKxY05FniN5VeOiAZ3M9/YftqY+HatllnWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=GDtgREF7AuO6QjknBMOjXCBlXRJsLRlx/8Nk4OtwUys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqsQojmgP10nh9MrPKcl+4GvnTAWsxaPLlDtmArj9J8HZJwPhubPZ+OFzfEjGRl0v7s93udQtNAelLALybbwjRSl3+IS8HWJmu/0cz3IrKtWVXOSXrGdfzFlIPBA8PKc7xiaR1ZKZkgDvUzlPEV7Uw5wEFVLeAOjtlhW3J3wX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC4q56x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E6D3C4AF0A;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=GDtgREF7AuO6QjknBMOjXCBlXRJsLRlx/8Nk4OtwUys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MC4q56x6MGkNMcCSqvi6fUBv+rpCBGqlCKBLXA63yOplq4qUIPTF01XCzVWYq/mcE
	 rlLKpIwOmcwjYzGzg4JkWuiXJXaBIxySchPiNpWgVi62k+DCoB8FM5cyJaPN8lNEUs
	 3lOSI1zaeN3QZRk32fw0C09Mfgekt5qtwCI1WusX+hVVy0rsVRBNrIVl97j/rwVRCn
	 8hr0lYdUnk67D5XpPyVFAsvXgrULNPXyzRMJKEi11WsAFxBRgENgFOWvQbxVb2plNi
	 Sb6yH/1Av7a1g0HGWi3g6vwzcVs2hIGs02j0sN0voMtuJZfXApm76+/bJZDgpAZlCd
	 uNe5XP38GQo4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23529C04FF6;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:47 +0200
Subject: [PATCH 4/8] iio: adc: axi-adc: make sure AXI clock is enabled
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-4-3e7628ff6d5e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=1075;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vcTpXfTnayLjDiRZnxJ+F5aPNAy5eajFubKg0Cjp4PM=;
 b=DJqz9cqAlXa2S8X6UlnFqgxQpwj+itH3404Ns1gnu3EjcUw0EhCiJKm9YwHY82rX9ZEvp/9R7
 Mjva1Fe/xVeBDo064MiyI6ztaWaeeY9F5RsUuyOFwWyFcXGzYed56zd
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

We can only access the IP core registers if the bus clock is enabled. As
such we need to get and enable it and not rely on anyone else to do it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index a543b91124b07..e3b2158829416 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -175,6 +175,7 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	struct adi_axi_adc_state *st;
 	void __iomem *base;
 	unsigned int ver;
+	struct clk *clk;
 	int ret;
 
 	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
@@ -195,6 +196,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!expected_ver)
 		return -ENODEV;
 
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	/*
 	 * Force disable the core. Up to the frontend to enable us. And we can
 	 * still read/write registers...

-- 
2.44.0



