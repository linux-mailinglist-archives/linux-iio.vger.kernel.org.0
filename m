Return-Path: <linux-iio+bounces-26690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD9CA090E
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D9A342C65D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE733343C;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mek3rXd2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E1332EBC
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777177; cv=none; b=tk1x3bxfr78Fd1qrj4f0R9h+yDBYk50MJzsCUIOps8uRnhT/vGYcNWwkjmgRCgBkyYz0/JywyG0ctK4Sj+JGBvJ1luoFopq4g6cJmxTJnXR9FseNWoOMRWPhjzUpVQwqMh4tpMmRoCfbuzhyesptq8AKKrdFLVH/J0AXn11wNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777177; c=relaxed/simple;
	bh=gOj9M5s7HhAtVxrcMAU9Z2q5IcUAxorQfGhPir1e+VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHcQa+HrWkXQunOrYKP6rHmobrhaVaiowmuw0iYyeOFSe/ujBqZedswXluUDPyXgo26v+p10ccH3Y9/ia9alsroQSTeaxr+32C3M3Wmd3rh+IvmeEhGiGB8FyLlKd/Vom18UdZgW5j1DwgT1SQ35g8+A7jXWBlTLy0H0JPL6YjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mek3rXd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5305EC16AAE;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764777177;
	bh=gOj9M5s7HhAtVxrcMAU9Z2q5IcUAxorQfGhPir1e+VM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mek3rXd2lrjs5BwF02mvJ15djcNNPcjO/3wH4zYoLDSEkb0am8+5u1wPJbnUFquO2
	 0132DRDJNlOwsOrvx87RvvixStpzRtBwWFZiMoY3Gmsg6Q077E8k4XDa4nb8fN33f7
	 vcOCmARM5Z6UaW/atHGp3Ij30efqs+ykzWVv2FEAHAfijSt64DcJvN/7iZl3zCmita
	 lBK6NEWj5++qtCXYOIZAmv+6j4mqDTYAbTYNJE1TSJ8O2uIE5pTbiutc/7FEcvzv4l
	 2vUJVOtwXUs+LuB0ZTf0DAYCPX1ikdbwuJRq5ckV39Tu0MGdZhs41X2SRYY6HZrWkD
	 KPRZrmo1HltqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A077D15DAA;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 03 Dec 2025 15:53:36 +0000
Subject: [PATCH 1/2] iio: dac: adi-axi-dac: Make use of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-iio-axi-dac-minor-changes-v1-1-b54650cbeb33@analog.com>
References: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
In-Reply-To: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764777217; l=1752;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8mvNrUBom7hQsbFUetN1gZgHBDbTPlojxNzlZxLUsoQ=;
 b=ny2Ss3RaoTCpYGC7+VUE7aaooNC2eVT3XX7ukwTp/8kbu5jvYCKF+bCkAmQ4mC7NwTcB6WEc2
 r+rG87ynjPBBVUH0V7HzWNYSLHq0VG/FdDyyBU3M6DAJQEpavY7ecAQ
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
 drivers/iio/dac/adi-axi-dac.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0d525272a8a8..0c7b62f5357d 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -942,17 +942,15 @@ static int axi_dac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
-		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
-		dev_err(&pdev->dev,
-			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
-			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
-			ADI_AXI_PCORE_VER_MINOR(st->info->version),
-			ADI_AXI_PCORE_VER_PATCH(st->info->version),
-			ADI_AXI_PCORE_VER_MAJOR(ver),
-			ADI_AXI_PCORE_VER_MINOR(ver),
-			ADI_AXI_PCORE_VER_PATCH(ver));
-		return -ENODEV;
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+				     ADI_AXI_PCORE_VER_MAJOR(st->info->version),
+				     ADI_AXI_PCORE_VER_MINOR(st->info->version),
+				     ADI_AXI_PCORE_VER_PATCH(st->info->version),
+				     ADI_AXI_PCORE_VER_MAJOR(ver),
+				     ADI_AXI_PCORE_VER_MINOR(ver),
+				     ADI_AXI_PCORE_VER_PATCH(ver));
 	}
 
 	/* Let's get the core read only configuration */

-- 
2.52.0



