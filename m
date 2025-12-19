Return-Path: <linux-iio+bounces-27224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D85CCD0905
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4942F30B6722
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A4932827D;
	Fri, 19 Dec 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0NwLJZL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E532142A
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158798; cv=none; b=Rgu7P2MJH1UaDDVahYp9161W8Hnq3Kj9nANeQjlroLDGZZY7D4uN90H4gIq5mqIC5T9AGKpo2XpVRA6rBAkC4r+Gb/9gIvi9QNVpYCws4kfh5kAXty5r4HE7wnvw5mCAEF9bwnFpo2GBtFmjXnjDS6cGB3Ta+4WQUkYwFt0Kj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158798; c=relaxed/simple;
	bh=uzDCzTLG5916UpCoHZ0sRXWsZ/FG8G+kCtcWlbfOKuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqIG1r//ojEPkYGqoOdA3TsFjOuR7VkLWNx7xOCQ2GlVUwdIr0ELWSM/EqfoiagaH5VFbsJBCtilu3yezDO75vGqgh7T/imXPjscFNvWw5h8WK9rEFbr9S5FBjvFMOvXVwBkRZYUZmZlBtQpAY9Z7uLsz38o9V1FoHq/lz3I3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0NwLJZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53374C116D0;
	Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158798;
	bh=uzDCzTLG5916UpCoHZ0sRXWsZ/FG8G+kCtcWlbfOKuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I0NwLJZL0khfELOckA02uNOZnHKTW9XBkSE+uFV3Fsx+QxoXmfAFmleScw/4/wMIB
	 XeDc5s+uxDcQ6RCnGIzQYQem9tFewFv0s15A6ereA30qKmBm8ZS1NQ0VgIuEmqDMNL
	 9HvXge5k/nmp2p83JPPg4lJyVPjG+MDfao2AtCHgmkwGRNOb3Q+FvN0BOlW3fH/zTc
	 hXRjI0hn7FTMNVTTJ9f7RlueALH9fa84C4fGg5mhnJSNBTKF/3pGCv9NPrZ9Nk1zPO
	 L4M9gg7ztCIyPkT9cFFyeGc+8SlEOSAn5Cix2NCKKhtDxgrxfxAgZZhow7aSXrtcJG
	 cnhJbcWr7EnCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84AD78792;
	Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:40:39 +0000
Subject: [PATCH v2 2/2] iio: adc: adi-axi-adc: Slightly simplify
 axi_adc_create_platform_device()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-axi-adc-minor-change-v2-2-9d8e7270d19a@analog.com>
References: <20251219-iio-axi-adc-minor-change-v2-0-9d8e7270d19a@analog.com>
In-Reply-To: <20251219-iio-axi-adc-minor-change-v2-0-9d8e7270d19a@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158839; l=1128;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=eSSzk0RaR2Q7Wh4xhuLnatBHuxxp6eXT3J54PD457xY=;
 b=MlOkMyQzJfZNTLK7022s5XkmW2Sju2Vl1GfY1daoxzW18ME1m6vD6UEHVDFDzwif+O9t1kkYt
 WqL6J1kpAwCCsGYEdWLt+Fjqdgzn/8WJCSxWmKOZJnEFyH5C1A/U64t
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

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index fef4fdedb976..5f445e0de9ea 100644
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



