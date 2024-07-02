Return-Path: <linux-iio+bounces-7164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B21392431A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC531C231F8
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FFA1BD512;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4NyZUi3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364C1BD4F1;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=PXk8J8FpWbpbQBMWeUsRinVxWt0HA+NgB09jkPDJ4jpyqvo0yeLwz6QsTxWXegG+JKEZUWiUnapL9YE/zcIoGTsRsT5vzQ0Kr8e8uqQ1m3qmRUb4LOYLcLqd9gyqTLsM84kmaLwQXDR670Ttc8aqA11PmRs/MkWDLZ1OQONn4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=3C7xNuV7g+Pf5OBq4kNLo3mjBqcMTFSkkJEkXizSXuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwkziBor2x7Mti15foDAKFfBZwdivnC6S36e/CqmSzEnqEtpS3SJPCaIALeYIbAdomN4XY5PvcyjVaKpg0mJaffrkjyoDzIbVFs0m6it8XPccNbXuYioJeVZ9Rv3y84KbOTgBFu1VXoDJL0u4JJ4NZCqL5PLFdgWngV8RMzd5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4NyZUi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECB95C4AF61;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936160;
	bh=3C7xNuV7g+Pf5OBq4kNLo3mjBqcMTFSkkJEkXizSXuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S4NyZUi3OIU2n/fcHqJiRu1Fy24oXFT9thNvHhOEPPmrLhfLdMTzrflFTI/9z0UPa
	 RMmr5dgV3EzQ6tOZJoPPA9ult14syGC9hwatSRtyXMeKkvDQANnM1ucYTcG6HF5NSW
	 E/0pGhL7Gqcg90n5KCwOe8iWF0UR7qesfJ3zWKvzRVMdAPcy1UgQph5wH8cbAMaDx6
	 rvKn0/rF7ry7RAZnROpoJRfqBOCHzlOgKv2OBP20v/2VxeQTucT7aXFxTXBF33Lt2E
	 1/rgVdaid03gB7Fuz8+zliY8ttw90tCe9I5Ft3HZqevPAoi5aupz7xKOAbfx12QGjP
	 /Es8YFDMUDH/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE707C30658;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:48 +0200
Subject: [PATCH 16/20] iio: adc: ad799x: make use of iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-16-98193bf536a6@analog.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
To: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=791;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wWndx9yRTDx49TztOjVCAJ5yEItwvGvV8lgnhI1efkk=;
 b=h45vVL4Ul2B1DhYLqcsnz1Wp/Q8mkB+/gpyHYoVmBZuWoZ1M6bMprsUorUO2yz6D8zWbYsDBz
 eOPXJHEaY5nDuJuHTISepLyyHz0WZG4h2xB9hbMrT1qh+vX3r4jOBxg
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad799x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 0f0dcd9ca6b60..0f107e3fc2c85 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -237,7 +237,8 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 	if (!st->rx_buf)
 		return -ENOMEM;
 
-	st->transfer_size = bitmap_weight(scan_mask, indio_dev->masklength) * 2;
+	st->transfer_size = bitmap_weight(scan_mask,
+					  iio_get_masklength(indio_dev)) * 2;
 
 	switch (st->id) {
 	case ad7992:

-- 
2.45.2



