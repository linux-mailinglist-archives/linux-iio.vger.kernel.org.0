Return-Path: <linux-iio+bounces-7926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D993CF8F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E738282922
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8D17838D;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRpII1Kx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151E178375;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=Orl4epgHKqRLzm4U2C8U2c7tZ6jZ+8EzZzm9tyM5OIgl/QoZQDDaBjcixyYw5fisgsPY+cJk7xlIe4z008qGaiDF22yTC0KQmqoDuCy1aiXnUeNVDoyHqoBwOHg8/IgQwsW4ZiA8ymMS415zM7FEjtTTDua5tr0TOipJSXEq6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=23pWAgKQNvp8ViudLo/jPakwoDoYaMh00PxvEu7Tme8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTJ3FHuQU/8P7TZOBzObpO42MQhNuvAS0gdL+SoKfOtiWeIUr/qBUni64vSHchpQUKnDJ7uYFwxCz2Mrnkh6emkdIUd1+1MZJq6Dvoc7BUAF2c+gCKvn1PFlts38tY7qPN3C7FxLev+7RAznPGDYokcjFosGZiZrSrcclQ+xoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRpII1Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54173C4AF51;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=23pWAgKQNvp8ViudLo/jPakwoDoYaMh00PxvEu7Tme8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eRpII1KxyLroO+W8X1lQkM/J1q8PJrUZ40HHV2QT8U+skY3e1n5Dmp49nYS9HzboP
	 gDvuqLB826rke7mSp0WazgwFkhX0FR8aTwv42kZg9LLeN7uJl8vzgw1PYKSK/xCdjg
	 75XHbA71t4FUorSb7ZIwKYdWOraWO/JOi/+ErFugo8E1LXdjdJ3ktkBjLYjvvETcQ3
	 U4MDjuJo1qgKN1WG3uvpBhHoyUVzVepvouq39BEMYckaq9FIf+w6RwF5mSNBwtrr3p
	 inyZxRf3q9rixgltNolbELjj2KmxQk7iLjo2uzaJ1qJRan/xSTjvreboXyBTKQdvTa
	 GWuz5hTVIxyCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4998FC3DA7F;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:10 +0200
Subject: [PATCH 18/23] iio: adc: ti-ads8688: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-18-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=915;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CXE9n1OTERPreNfjFIenBnsa4hUQh2QY6CgmvZVjglQ=;
 b=2LKulSG61dERd041aYUSUleOkTZyYUSHMCQBWl82M2dCuByYPlBFm7A9NwRxgLfy8l3ZQnOo5
 8+I8g2/S+1/DVXeMdvi9BcrLXIIY1TRZW5Yln/Tm2DfMzISokyqEPyO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there are
no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ti-ads8688.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 7a79f0cebfbf..94cc823b26f3 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -384,9 +384,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
 	int i, j = 0;
 
-	for (i = 0; i < indio_dev->masklength; i++) {
-		if (!test_bit(i, indio_dev->active_scan_mask))
-			continue;
+	iio_for_each_active_channel(indio_dev, i) {
 		buffer[j] = ads8688_read(indio_dev, i);
 		j++;
 	}

-- 
2.45.2



