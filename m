Return-Path: <linux-iio+bounces-27459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B5CED278
	for <lists+linux-iio@lfdr.de>; Thu, 01 Jan 2026 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1219D300D15E
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jan 2026 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A12EDD5D;
	Thu,  1 Jan 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDlf11c+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158627874F;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767284293; cv=none; b=ptFwNSYKOic07YybgWDl3J5zfN0dmfiVn9Hi//3vpg1CN1TJkmvAmQ5PoGHtPcmF974LH6vHUeCFEBZqyFtx/ISiGe2bAloZNhCF+yDZwNRHYDkPCgVJNFsyjnb01SktdMljj6TLnd1nTGinLxTi8KVOJeY7P3wjJIaIDnjJHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767284293; c=relaxed/simple;
	bh=4MeX26Uz9CqThCeP7n61Cdxs3/XzsdN1BSOCj4rcVlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkyiJcWShPc3W6q3q0plIYD23M1UUv2IHfpkGPRIGLd60DLJX4KxoHY9LzhnueLMInoEqjuAToiTLxPpLFlXHNKR33g2ie6i5iwk0NsmLgsSD/r/pubMk2X8Y++PGi56ZKdfY2+B0DV4pRMCoFxA6AlEkGH4zupgRNhegsukWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDlf11c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79678C19422;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767284292;
	bh=4MeX26Uz9CqThCeP7n61Cdxs3/XzsdN1BSOCj4rcVlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IDlf11c+jTWfjwztVYkpaDmnRaFKns8LIl1ZbVhuDq+jOYrbuSteUvBPCcOBH65fU
	 oJwkaLikHEx6N46+FTfa1pzvukx802Z/JsSLjorvMXF+IBEgzLF1joBharH53BZ177
	 ylQYX2miEFLnTxtKGGB7G2GD6Pd3+VWPs3qyldn9kCxci6lIMLgMJaW6PRbkE3QjS0
	 xYFjLhYus52Zfl+0t+TLHInbYey4xavwlcEO/pgJcHo1VNWejjY/ikjgmBM9miQUHB
	 6IJwT0cExfKULQYjnAf2Wu7u4mr2tAC7QEg+AdjhjR3AypFV1Beb5+b192ru6T1U3l
	 3a8B7g6yy0J2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF4EED60F;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 01 Jan 2026 21:47:40 +0530
Subject: [PATCH v4 3/4] iio: proximity: rfd77402: Use kernel helper for
 result polling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-b4-rfd77402_irq-v4-3-42cd54359e9f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767284290; l=1779;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=LS/GSeSQrtkZGeuXrepvOA1K2RRvlQ1qjhZCkwokVvE=;
 b=C+NrC31Xzpph97j24fL29MGZ28F+Z2CvCubZfv7JLjNSG9Ci3juEc5vysFpIQLqcfPxmMljCG
 SFWfDAnHZkkBuN+smeYYMuOxwmAFeLN6ib8bO9ZMQXWWhlTvc8u3j/g
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Replace the manually written polling loop with read_poll_timeout(),
the kernel's standard helper for waiting on hardware status.
This makes the code easier to read and avoids repeating the same
polling code in the driver.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 3262af6f6882..496c1412ebf8 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 
 #include <linux/iio/iio.h>
 
@@ -113,7 +114,6 @@ static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 static int rfd77402_measure(struct i2c_client *client)
 {
 	int ret;
-	int tries = 10;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
 				 RFD77402_STATUS_MCPU_ON);
@@ -126,19 +126,15 @@ static int rfd77402_measure(struct i2c_client *client)
 	if (ret < 0)
 		goto err;
 
-	while (tries-- > 0) {
-		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
-		if (ret < 0)
-			goto err;
-		if (ret & RFD77402_ICSR_RESULT)
-			break;
-		msleep(20);
-	}
-
-	if (tries < 0) {
-		ret = -ETIMEDOUT;
+	/* Poll ICSR until RESULT bit is set */
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, ret,
+				ret & RFD77402_ICSR_RESULT,
+				10000,    /* sleep: 10ms */
+				100000,   /* timeout: 100ms */
+				false,
+				client, RFD77402_ICSR);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = i2c_smbus_read_word_data(client, RFD77402_RESULT_R);
 	if (ret < 0)

-- 
2.43.0



