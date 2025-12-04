Return-Path: <linux-iio+bounces-26747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587BCA4428
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 086EF3019BF8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979A2D780A;
	Thu,  4 Dec 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoVk44gB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BD2D6E66
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861819; cv=none; b=fFGzwMjrNQ6kqdVUfvnnjd/rXTCsPN5LFIb2g77QBkSGXfp8dkCqN1q0wGPlFnlpr+z7FW9CoLaR7r7+DXkzZcYUycRDn+gijtjUS6GaCoCmdazX2uo/1v11I9XvW0tD17NV91NxS5EJ6+O5kWliwhmnBOE0zlnJMOY5q63m59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861819; c=relaxed/simple;
	bh=IMWWneiCV0F4gYI+/Vh9EsFpqc7wq0Yfye3xNyfpZD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKeIizIUv+BmgKxnTeLt/K0sDKhwhb9fJnGKsE/upTuM21hziHSTT/Alpt2FLCBgw8cVzYbcKbrOE0N/0bDcWFfC0GCuivJEHfq72bw+uX8uwSl1Q5iOTcq1LRKith/S093B0fD8phRWYM0+qU1a45NCUHSCckYRg4QkGByH6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoVk44gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE4DC19422;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764861818;
	bh=IMWWneiCV0F4gYI+/Vh9EsFpqc7wq0Yfye3xNyfpZD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HoVk44gBe/IA4Q1gL6HJoovHTI8QQiMR+G5vGn4q7iOIWElfA9tRzLAYROJxWL3Ne
	 +hr31qCh1sB/NaCfZXbpJwv3wVTe6zDGFga37bGq/gJcY/hT9+WRaXyR3Fx4Sgk3Tt
	 1v1m9/7r8w/7rDu6oHSIWkYJBIh+xUX3199q6BxuhT5GR4bku15ZANOy1Q/4jzbIck
	 zilMfZRfe2LQjZ4bBybpZe4RDxCkiz+OVotzARgW8DLPxeXaPtLcK7CGdt71y7ybnJ
	 buaeb7R2lwROu6AiVkpyuy5jiIyUVg3/Z3peWBaBpUL1KQi74ROutjV/3HCUi4qQle
	 LWEKT4WecBpeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D6D21690;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 04 Dec 2025 15:24:19 +0000
Subject: [PATCH 3/3] iio: adc: adi-axi-adc: Slightly simplify
 axi_adc_create_platform_device()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251204-iio-axi-adc-minor-change-v1-3-2d441d6c5b65@analog.com>
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
In-Reply-To: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764861858; l=1080;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=M3sXn3XZpAfRUaGPA0yUjTsmlXal1gTgD6ZYc2L8B4s=;
 b=XUZKTkQzo0esGtR2IPoM17ul2k561+g6JV6U1L457Hx79BgtP3QBDDGN8S2LAFmZ703nUV2wm
 tuOmbcTv6HvAcvEAcvpbQksxQ8xjMgZ03N4RaD8xXvC6fNfmWLfWoqe
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

There's no point in having a ret variable and checking for errors (as we
do nothing with it). Instead, save some lines of code and directly
return the devm_add_action_or_reset() call.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 32af2bfc2bf1..9079e7c7332d 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -591,17 +591,12 @@ static int axi_adc_create_platform_device(struct adi_axi_adc_state *st,
 	    .size_data = st->info->pdata_sz,
 	};
 	struct platform_device *pdev;
-	int ret;
 
 	pdev = platform_device_register_full(&pi);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
-	ret = devm_add_action_or_reset(st->dev, axi_adc_child_remove, pdev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_add_action_or_reset(st->dev, axi_adc_child_remove, pdev);
 }
 
 static const struct iio_backend_ops adi_axi_adc_ops = {

-- 
2.52.0



