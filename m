Return-Path: <linux-iio+bounces-5035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B826A8C4CD9
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F971C20D87
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7233086;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKXNoS0e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD525765;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671399; cv=none; b=DpOGmUR/Kj7VGSuCkpnQrwIMrmWzUK4toJqoJVFCf9zG8Ku3Oue4fyxms57cqJ6Dyga+zKm07FfQpxAd9XZ3rmMYUlevNSLryyGAYODDGXl7DTHBiDsASeE/chwjpFPudGOF4oLJ3O3l9VBQY8ZtWZJekBwo4Cn+MzriBDN0t1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671399; c=relaxed/simple;
	bh=1YgStPTBqOXTZn/yGxVC0i4oXFG75QVcdPJh3J/HwHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qb1Thx8PQxoqx0rYwPZvX5zXo4+CSqHp7rLm5fuJWO72HrSdB4h7XZwoE2cIh7z9KWsBu2aL1o/fTgbq/WV90/YdEBL99gz8sEWiSaps6iSPBM+wsGz4LAtJoC0zhLgxs6qAjQW2H0xuWa4k1pV2p3W3ern7RPpCkiRkNaYlqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKXNoS0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFE86C4DDF2;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=1YgStPTBqOXTZn/yGxVC0i4oXFG75QVcdPJh3J/HwHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UKXNoS0efappWY/f21aEeftbGe4DpYwHuV0RA6MbMGGewgXLSTr08oIq1VC1kek6L
	 i8EwpvjhVwPs8meeE2+KAD/ahapa9FnjqEQlhOMAUgSsyzr+1aZYO/oWtaJ5//L9uK
	 TBdWp4uo7dL2BcAauGoBK3WRqFdhOE3U9vsCpHpSlCmEx02J/6jOg5VLEzfoxu+GrC
	 q9pWJLGKc5pIZ6xpq05B4cXVywhyCgpO5HkGJZkTYhe+sFEURoh+6U+yFm0i8IDxZm
	 Z9BGTkniaNKPzwj3+Pj+VcdMDBw40TyyJ+xjghGYIFNliyopbV2QSnSH539IznlmyQ
	 1Wa82H5NKZ7dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CFC25B75;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:54 +0300
Subject: [PATCH v2 9/9] iio: adc: ad7173: Reduce device info struct size
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-ad4111-v2-9-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=1076;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=RmIUo6Mi25zkqE47X3KPvkctN+OcwkN8pU6glB5Vkrs=;
 b=rzsfG15wDQ+1f9c6J8mg/V77m6QEu332viIRx2GWiZgtebRG93ls/4H1z9xLYV+VM551lCcq4
 wKwALbRSrbpAfDYDCXinF1na7NgfPMqR2r7GHjJTUm1jyC8MUNx2ZXs
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Reduce the size used by the device info struct by packing the bool
 fields within the same byte. This reduces the struct size from 52 bytes
 to 44 bytes.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index f049d79380ac..f963c731cae3 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -180,15 +180,15 @@ struct ad7173_device_info {
 	unsigned int clock;
 	unsigned int id;
 	char *name;
-	bool has_current_inputs;
-	bool has_vcom_input;
-	bool has_temp;
+	bool has_current_inputs		:1;
+	bool has_vcom_input		:1;
+	bool has_temp			:1;
 	/* ((AVDD1 − AVSS)/5) */
-	bool has_common_input;
-	bool has_input_buf;
-	bool has_int_ref;
-	bool has_ref2;
-	bool higher_gpio_bits;
+	bool has_common_input		:1;
+	bool has_input_buf		:1;
+	bool has_int_ref		:1;
+	bool has_ref2			:1;
+	bool higher_gpio_bits		:1;
 	u8 num_gpios;
 };
 

-- 
2.43.0



