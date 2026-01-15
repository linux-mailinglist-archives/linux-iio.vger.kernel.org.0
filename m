Return-Path: <linux-iio+bounces-27814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE45D232A4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE54C3030D89
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5A334C25;
	Thu, 15 Jan 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfS0Rbfh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA4334695;
	Thu, 15 Jan 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465695; cv=none; b=OhZW/gbzgE4C/OCfY04zqCyNgqvFwjU7q1l6ahh7feGmoiUF1jxUfTSzupwVlPsHyKQhRsc6JMHNjgOLsI8NzyocpenSpfnenRyg4FOLdS44gXjD23a+LsvTEDEBy+tWMe54xh/AXVuoCLaRP9YpruLOhx3nfLCTiEIPX+9B0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465695; c=relaxed/simple;
	bh=EJQpB8ztvuFwk/JTI9GV2rI0aztC9FlGjnEGKJjdkYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNIU1IBJHtTyFoB0R9N9IS7BfGGMx/wEM/RkDWbaYk76WxDgE/UXqt+xQY3OFFrDvEc5E5bXzocBViZLxuYyw1w+Ocl0zWr7TRbmhi84SqIOG0COkyje+P+CSgpnh44jYON9AqX6BW7du17N2FhEWulpgtQ67TtCrjraNJ7kHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfS0Rbfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D114AC2BC87;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465694;
	bh=EJQpB8ztvuFwk/JTI9GV2rI0aztC9FlGjnEGKJjdkYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RfS0RbfhOJalUPD3ROXMAns62t59uoh4bBBg/xCxbHBZ/6/aB3FbwQ1tcofvEqVno
	 xvwcZSIqaVeqOZ8OnKUXG7Exbv86gul4ob48KeoQM6P2F+AAygJIPUIgaIEWq0C5Y2
	 +FmtTjYQusXJrt4tZp+X+AULaFYQDx2ow7CWwhzg7iOWiv47eoXbnuU1pHPUZBqGfW
	 T/pgy9bvhRMbt8gGgMi6Wj+r3FCoxlvQuh7vyW4sfbiwwvNqxnQSf/SKtHmpQN9HS8
	 FcrHBxiIrfMvsIiY3WY8mzQhJ43IWpTMxmPcNHLjv+qncGREVYq4KyvTOYsK8KcEBo
	 LDto+rLz23OMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA624D33A01;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 15 Jan 2026 13:57:41 +0530
Subject: [PATCH v5 5/5] iio: proximity: rfd77402: Document device private
 data structure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-rfd77402_v5-v5-5-594eb57683e4@gmail.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
In-Reply-To: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465693; l=1014;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=syP1cm34ZXh86vqwrGpgNSQse/6+lSSS0BKSNLhKPRA=;
 b=oibpHuX+teA2H+P/KXELrdZmcO+PBGhxDxww3biLMzBD1aIdbHw6U1NEY9MZsqEadHLne+3vj
 zhVxhqOzWIBBVRjZsfNJTgub0wKzcXYkEvHRlVJ3NapC+NfFd/5wjSJ
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Add kernel-doc style comments for struct rfd77402_data to describe
the purpose of each member.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 43ace2beef7e..e6a499cfb232 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -86,9 +86,15 @@ static const struct {
 	{RFD77402_HFCFG_3,	0x45d4},
 };
 
+/*
+ * struct rfd77402_data - device-specific data for the RFD77402 sensor
+ * @client: I2C client handle
+ * @lock: mutex to serialize sensor reads
+ * @completion: completion used for interrupt-driven measurements
+ * @irq_en: indicates whether interrupt mode is enabled
+ */
 struct rfd77402_data {
 	struct i2c_client *client;
-	/* Serialize reads from the sensor */
 	struct mutex lock;
 	struct completion completion;
 	bool irq_en;

-- 
2.43.0



