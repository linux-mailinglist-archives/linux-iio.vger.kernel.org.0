Return-Path: <linux-iio+bounces-24365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EABB950A4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 10:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1C33AADE6
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 08:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCD31DD89;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPJIE2D7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8931D754
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616888; cv=none; b=VshJnODopIANC61eImH/TVtR5VO250yscgRTKbiexPQ7ShTtUo9HC08lIjMOmcWKL8IDKASx0KOls1J1ZVogt8ytcKoDOjbXmOJFgKkm7NZZ4ZhKLHZOIUNKWqTcqRN9GSJOxnz4CBw/4B7M+Ai7G2xa9RvAt1E6Zh00BykgIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616888; c=relaxed/simple;
	bh=AMqkpJ+SvJjxQy1DPw5YOoYIhBMY6gZx1IDTepfaQwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3XNM2zv3t4JAsqi7kFvsjxy14ch2uqe5YCTrdKOfFWFbvaE6BzAX7PNi8rH+DrrAEkvGske7XtD28P0L9wDdoCIHvnY0C64dj21acYuJcCuPk67+SbMfEbMQsD1/UTWHfpF2HV9nd71Hf1BuOxWtpadvzH7AGGOou0auuJi0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPJIE2D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62894C4CEF7;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616888;
	bh=AMqkpJ+SvJjxQy1DPw5YOoYIhBMY6gZx1IDTepfaQwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XPJIE2D7NDHaVfZIN76iN6F5E8AafGfu6R0b8yLTvfHLBK8Ubk8fnlBncZ8z9iBk+
	 9TP/vAFjA8IlpAvBvIuty+oV/K4vF4ts0Eba4khsU0T6G94wGBrDNliD5N6fEIDpJD
	 jhSqJ2VLO5HsQpTt7ugGJ6+kwTIAi8gKTWXXrr1OMw4PcDVR7139PH5mAgzA2yWuzF
	 XUcPDuMrM9W2zpY0Se/KIQEWvR22dCrx56LHp0pfdvqq/wTF7i6XfkMIZY1bzK/faN
	 kMDJtu0L0CXCrjjlTL2383/kwWyoTXawXPPCWLntvN4qZ0tw5gfHskbFQLgCFoEXfh
	 S2pkapEJGdLhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B6CAC5A7;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Sep 2025 09:41:47 +0100
Subject: [PATCH 1/2] iio: dac: ltc2688: make use of devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-dev-ltc2688-minor-v1-1-ef92c441dc42@analog.com>
References: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
In-Reply-To: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758616915; l=859;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=F6YQv/dp6fldG+irAJWIirOEKqwL81H4FDi4A6vD6/I=;
 b=E0G3sBJ3E1Twic4uQJikMhi82lPs4k7FexI9NZTGakeiNxCXROAu5TiQVb+hfY19/oRvDGDe7
 WDC/pGAvbD0B8TIHExlNZKwN8bDCcRgxlYv+S88P692YRJvw/U/CgvI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use devm_mutex_init() since it brings some benefits when
CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ltc2688.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 7a2ee26a7d68730fe90d9cc91ea764f05eb61791..57028d422868ec48e6900ef1cc4be6dee9cd4547 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -953,7 +953,9 @@ static int ltc2688_probe(struct spi_device *spi)
 
 	/* Just write this once. No need to do it in every regmap read. */
 	st->tx_data[3] = LTC2688_CMD_NOOP;
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	st->regmap = devm_regmap_init(dev, &ltc2688_regmap_bus, st,
 				      &ltc2688_regmap_config);

-- 
2.51.0



