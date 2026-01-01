Return-Path: <linux-iio+bounces-27460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD6CED27B
	for <lists+linux-iio@lfdr.de>; Thu, 01 Jan 2026 17:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6079B300E7A3
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jan 2026 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439492EDD76;
	Thu,  1 Jan 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4Amq/Z6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FD2DCF52;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767284293; cv=none; b=CjhBCbERLTFBvFGUMgblkhR8FW7cwfuZOYvSX6JR0VFrd9OIaruqWxt6FQGPCLeKL7rOelv8yO4tr41RCyEek55SJ8QpOrwLThAQRGonTrgCkeku3o09y0gjeCfym6L8o0wKhtFb6T42b+gSIQaEDyN9MzBDUMQDXg6e22gIbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767284293; c=relaxed/simple;
	bh=NbLST8l1hY2ztieLg0GKRhQ61QRNSErpZcGOxuaun7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POvimocFj+encz9UDdYuoYxaSCKZrERFlCPzxlaI3TM/XRppI2W9oEVUr2qxBptzDkEkM9USVTNZuSMrInbu2nVFd37r19e3dD0BA7T5a2cGv82ap7+0N12HFf03k+QkV9O/KNZfCtXeYdISkMkFV3jReLrBx6dmBxFz9UwGTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4Amq/Z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DAB3C16AAE;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767284292;
	bh=NbLST8l1hY2ztieLg0GKRhQ61QRNSErpZcGOxuaun7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o4Amq/Z6VZMhmzTQ2DRBWxvW8F5RJMXe/DLuwU4Q2lg+u+k7BAk+EdA0wvdGn31H0
	 fhqKGNMFgfwal27qgndfPJR1AbnYsMKUKb99Z6cqJJQb95B9X6xJCIr35CG+NWxURA
	 sNRWQYw3bjEXAQvEqE4ZY8ez4USHClQ8khed/pelyG0GqCdQ6WGcAorOb60J7UgDjb
	 siHbSPGgoGMtNHJmgw+VG7s/6PdZbTCN+VjwRHktZDEefGnokcKZ+kRnm0KQj1sy7A
	 RQAWCjjfOJ0cnOIem109g+afwBoqYLx9zYDlumi27XEtOoduFFPKcaNHZWG2IclTXF
	 9EfLIx18komxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE6EEED618;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 01 Jan 2026 21:47:39 +0530
Subject: [PATCH v4 2/4] iio: proximity: rfd77402: Add OF device ID for
 enumeration via DT
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-b4-rfd77402_irq-v4-2-42cd54359e9f@gmail.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
In-Reply-To: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: raskar.shree97@gmail.com, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767284290; l=1125;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=vqy/DEvaK2P0nm0mNsxwW8n+PXruCd9gkMKLRnARTow=;
 b=frtbWm1r4IhTdmJDt/qUUyVWIuZQ4oI98i6dPTEhD5SabnuSda4wo8Tm3aqoUnIOG4QeaWneq
 m1futJKEcg1Dm+HlKaO297UHXcqZgg9sUnfevh8uxHaZdFE+HwdyZXk
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Add an OF device ID table so the driver can bind automatically when
the RFD77402 sensor is described in Device Tree. This enables proper
enumeration via its compatible string and allows instantiation on
DT-based platforms.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index aff60a3c1a6f..3262af6f6882 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -313,10 +313,17 @@ static const struct i2c_device_id rfd77402_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rfd77402_id);
 
+static const struct of_device_id rfd77402_of_match[] = {
+	{ .compatible = "rfdigital,rfd77402" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rfd77402_of_match);
+
 static struct i2c_driver rfd77402_driver = {
 	.driver = {
 		.name   = RFD77402_DRV_NAME,
 		.pm     = pm_sleep_ptr(&rfd77402_pm_ops),
+		.of_match_table = rfd77402_of_match,
 	},
 	.probe = rfd77402_probe,
 	.id_table = rfd77402_id,

-- 
2.43.0



