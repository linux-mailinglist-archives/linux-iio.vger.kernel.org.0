Return-Path: <linux-iio+bounces-27317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 712A5CD6455
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11D2A304468F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77AF33F8B8;
	Mon, 22 Dec 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4d4agOm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B133F375
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411246; cv=none; b=gwZIksP8klrvgWRbcUX7m1ONu9Q5sSI6LqWoQbDF4QK1xSF5S1bU0avfcJK90QSm8QCqjx0E1+rIfpS2zVdaS/Pi76aOnMA5ZNTZiarjBgtaRbb7ishYsGQtw6q57Ek28cnP0rFHuKy0ELrQB+7thYdb+nIjNFuZyEEaubSs3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411246; c=relaxed/simple;
	bh=Pg/Nv2eIU9DGjxsH6BMbEJThKf6/fYbO9xd5HNmDU/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2oNCRSZeh4eUq7+VwF2P8xZ08cfkGgEgc0PSwu7PzsKmVQOwkhI+/YXXKvmOEfxgLrQOCjPDt+vSJIDhUnZ5XrmcY0p0b9DAWgxxwFTp5BEmIRH176XANdvdceSQjh4zi3GD9vs5TC81n9cJAY/KIhWvVPUNJo2aJtKATd8FNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4d4agOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A22C113D0;
	Mon, 22 Dec 2025 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766411246;
	bh=Pg/Nv2eIU9DGjxsH6BMbEJThKf6/fYbO9xd5HNmDU/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c4d4agOmOA8Y9E8mVTIy0CpQEihNIvxuQmFDV0MKle2ByuhHbGtpZ/r2/uhpICBOb
	 62TL/tVcrwtppB8M2bzLXu7tT+pDLtqaxgnsj1xkAEj7DavEGgd6qAiWM8AWJROdp6
	 x72Xtw50BOjp8HMKUSuiPSFoV0xTmyc06d3tDaIdXJgrf+NwEJm8cRnQmbudED2i1i
	 OWWqQIixSQnzVm10kL/sV04S1sQhGW0XUvPymnXVQbVX4z56raViVAyVXy2IwdQcDq
	 4FUFIRKRGtGbL5aRjwsqZSblUx8Cb+upsUQ0Pa/1oaX7MnRnGrjZHVqekxegC4SD37
	 vki2SQwaEOe7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DAEE674B3;
	Mon, 22 Dec 2025 13:47:26 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 22 Dec 2025 13:48:02 +0000
Subject: [PATCH v3 2/2] iio: dac: adi-axi-dac: Make use of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251222-iio-axi-dac-minor-changes-v3-2-29199f239d9c@analog.com>
References: <20251222-iio-axi-dac-minor-changes-v3-0-29199f239d9c@analog.com>
In-Reply-To: <20251222-iio-axi-dac-minor-changes-v3-0-29199f239d9c@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766411287; l=1808;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SY3JK+/HNrlZmomtHnAKg89zL88xQuNk8wgu42OPM3Y=;
 b=YRGfTjE3H+Hf3BIVR13PdwmpqoU4jU/OPIF2oiZb7RD0/pDduVEXKRqufn1k0CUDQKNXI0lZT
 j56hxffPCIxA0tcRX0dqzP5uRr4c0aOWk4elQFfwXz8FxcNJKlX7OmV
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
 drivers/iio/dac/adi-axi-dac.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 851d837d7ced..9cc895bbe51a 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -942,18 +942,15 @@ static int axi_dac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
-		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
-		dev_err(dev,
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
+		return dev_err_probe(dev, -ENODEV,
+				     "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+				     ADI_AXI_PCORE_VER_MAJOR(st->info->version),
+				     ADI_AXI_PCORE_VER_MINOR(st->info->version),
+				     ADI_AXI_PCORE_VER_PATCH(st->info->version),
+				     ADI_AXI_PCORE_VER_MAJOR(ver),
+				     ADI_AXI_PCORE_VER_MINOR(ver),
+				     ADI_AXI_PCORE_VER_PATCH(ver));
 
 	/* Let's get the core read only configuration */
 	ret = regmap_read(st->regmap, AXI_DAC_CONFIG_REG, &st->reg_config);

-- 
2.52.0



