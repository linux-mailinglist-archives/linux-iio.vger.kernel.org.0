Return-Path: <linux-iio+bounces-26746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B12DDCA4425
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD9FE30142D6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FF2D77E6;
	Thu,  4 Dec 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc3yDAKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A02D5A14
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861819; cv=none; b=pnGK4qBwp20+y+uCRqy7i1HawpI2E3Ugu4RsrtFqrIOgWJthbH3xFZkEzwq91kPG4ykAo8t94kqpfTWjIDMCpOXZ0TShJgw4wZ9uJtERVnnkS+MZOvEWYHBqjNJWUI4umDNlBTyKDj4OLLihdApIQZpa54hyimC1EtHDVl9amog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861819; c=relaxed/simple;
	bh=7BVm1M7MHqeymvHnXp5jriVbNOrtTzh+DaUw0p6hpas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CwFmJ44V4PSZs7AKqfySs2XTlj8uA/PIzD7V8THwGXCx9lHkDvPlkTT2lVvHX9X7gmyYw2Ldpi1JPHM7/EvNLSrvktB2Jp6EOIvw58JkPz1Z573G5E5pdk4ZRlUrYQ4ocA2zWQCVDlQ5t54Q0NDfBi3nVW8EJVecWVHBr81Vmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc3yDAKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81CABC116C6;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764861818;
	bh=7BVm1M7MHqeymvHnXp5jriVbNOrtTzh+DaUw0p6hpas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uc3yDAKu1oK/KTn7sJZJulRndZQVGev7zQcM/v78DO+B0yqJqSF6gin0y4iKl/P8+
	 k/Cbae4X/bQF077dF0c9uW7Gij6vzbuhLb6NjLagli8F5PBpW/iEIvD/afiHoSEO+Q
	 BqzIuq0B22qcHdTJurFtCB3Co/co8BEp1S0lc47Lxa9/9zbDLJu6iIPUYrcLIXkj8l
	 ybU1GqjtjhiW5FddMkp50aAA2HnRCJT1G5KyK9SqU74xehv1Z0rexhEdMkvNdDF9B7
	 Fh3S2bEMwyqCwxhmU0KbzSfMznTyFP1f7Gpy+8MCVLKgeocmt6UVDLSCZSSoSqvlgg
	 uifKRYv1Y30gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB9D21691;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 04 Dec 2025 15:24:17 +0000
Subject: [PATCH 1/3] iio: adc: adi-axi-adc: Make use of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251204-iio-axi-adc-minor-change-v1-1-2d441d6c5b65@analog.com>
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
In-Reply-To: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764861858; l=1794;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tw6VZGqh8trkqPWcy4nlBi6CvMFugkbzo3qHKWV0j0M=;
 b=EqOnWFmbbRQ6foASWdySKDLpPtFuVSAeEKZqe2mqz7Tafn14hu59rsIJwUDZsV8RZ8uktfEIo
 8KJXy6bYu+/Ds59qPnj4YfmVdzl+dB7ds8QWTOU0K/AoXUdUr4Z0zxm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Be consistent and use dev_err_probe() as in all other places in the
.probe() path.

While at it, remove the line break in the version condition. Yes, it
goes over the 80 column limit but I do think the line break hurts
readability in this case.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 14fa4238c2b9..8b8955841afa 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -716,18 +716,15 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
-	    ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
-		dev_err(&pdev->dev,
-			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
-			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
-			ADI_AXI_PCORE_VER_MINOR(st->info->version),
-			ADI_AXI_PCORE_VER_PATCH(st->info->version),
-			ADI_AXI_PCORE_VER_MAJOR(ver),
-			ADI_AXI_PCORE_VER_MINOR(ver),
-			ADI_AXI_PCORE_VER_PATCH(ver));
-		return -ENODEV;
-	}
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(st->info->version))
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+				     ADI_AXI_PCORE_VER_MAJOR(st->info->version),
+				     ADI_AXI_PCORE_VER_MINOR(st->info->version),
+				     ADI_AXI_PCORE_VER_PATCH(st->info->version),
+				     ADI_AXI_PCORE_VER_MAJOR(ver),
+				     ADI_AXI_PCORE_VER_MINOR(ver),
+				     ADI_AXI_PCORE_VER_PATCH(ver));
 
 	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info, st);
 	if (ret)

-- 
2.52.0



