Return-Path: <linux-iio+bounces-4547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141B8B3BEB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332D283A8B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE81156F40;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP/I1KwP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFD155A2A;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146150; cv=none; b=atJx/en9dnrXN8E8JEa0CvXoB4PDTbcSKcxir0TNedtz7iaoIAsoJdGpm92y8pTSCW48mrRgOmW8EVF0QWx2332ZtXDX4Rjicm7hZhzZQlRVUKF3YFbH3pfOr0fxTjoFIOgX66LaADr6MDi1qkG/MqeH89jZTvAkSsmoQiQpt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146150; c=relaxed/simple;
	bh=Sy/61I4jsVV/SaO4Tqs7G3FDOtNf3pkPBFQ4yg8YP5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEU6TS/r/ABNUEwUYsL4F7eEEOM2J5EQeVJvv+H6jFWuKCKIYF2PZgQ0AVeUTkAu1wwwTXoAF8P0rHK0S7Qc0jlq2ZbCFe/nq0OSCMgSMbyyz4a4fXzayf/1CHOeGH8RIIwCz4vtY2840masT9T/jdMkBaUdc/JTIphMZsNeiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP/I1KwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9EDFC2BD11;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146149;
	bh=Sy/61I4jsVV/SaO4Tqs7G3FDOtNf3pkPBFQ4yg8YP5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LP/I1KwPkPAg2w/ZkbqPYQnW8taQKuHJL9Wo0jo7VWljZAToGtayp+p+CM7gQ5g8F
	 PBGkK2qbqSATN0b4G7VEXjDBVp+PstStdbkFW20ezDLReEjfMcCVlQiI34Z6pbR4qq
	 qVEIfIta1bvC2e8VUXqOxciP3g55ly81ZnBw8nSjKBl9sM42kZ8LSldqz618axjvmX
	 ZXOhXvakgtC5voJD1GaSQTRbYZ4qc6K5x5HbOM7LAMzm3ilcpQFcflD8n5QoOKdKVM
	 Yc1COsrs56KE/9RqSfYpOFPrOPYPcX76WmBMjzo/Jj++p3BXakUV3c2MUot03g7eEI
	 Drp6CsSG9iLcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5BEC04FFE;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Apr 2024 17:42:13 +0200
Subject: [PATCH v2 4/7] iio: adc: axi-adc: make sure AXI clock is enabled
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-ad9467-new-features-v2-4-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
In-Reply-To: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714146147; l=1318;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wD4frVePbFQZ5GZZY+496L8YqjIUAosy1WOB2P0XRHA=;
 b=+ecaEiuo3EuEcqcy+s8TO3a9lqzk+HTfyD+VE2WgEpF5kn3+ev0LlrZ5+c2HjWucKesGdp7pt
 amki9w4q6+OCzkuH13f/dWxH3eTP+NRbl7Zf2YWZ9xiYDM9wwP1Vzc1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

We can only access the IP core registers if the bus clock is enabled. As
such we need to get and enable it and not rely on anyone else to do it.

Note this clock is a very fundamental one that is typically enabled
pretty early during boot. Independently of that, we should really rely on
it to be enabled.

Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index a543b91124b0..e3b215882941 100644
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



