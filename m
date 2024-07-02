Return-Path: <linux-iio+bounces-7159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF44924317
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B82F1F22BF3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F51BD502;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0o+Ko7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB81BD02F;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=dOIyO6bIEmjmWPsLP2YhvBczaf01KASINmrCf2YF6ONdsWBH1EoRsp8iSrfID1JAYZStFvXt8uqtRR09ZI9nE82zoZ//xe/RShdBLq/IsoT32wLTsJMDQ/gDz9Vek0IlUu6VCgDmthGIgwSzmbHSzlh4cyY9kQJwi5VeMoinAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=nfHKW/AF9PYmMiW+5wqrALl73lz8upCgwUkKe9Zapb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyclwgXPCc1JEGZBveHC/O2eUiu/61qiTzaqg8V1lJ8SPikY3cbGf6hVoRbwPkN+fXCor2wN/SQqU0rTw6j5R0UMnZVDRXp22eWRoAIijwwF8IjdSJFAqA0MFt+R853awY6481x97F5eWiqW8+JraQZ+17g0pTWLbLKdpzclEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0o+Ko7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B15FAC4AF49;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=nfHKW/AF9PYmMiW+5wqrALl73lz8upCgwUkKe9Zapb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G0o+Ko7sCr/Bm31UASvWzzwCMb6bUFhhwsXt7sRKF9fryxK4hziSjxJIjkxXX8qEE
	 xuqd0E0ifjZheGTea4byqsLfOgZ2+3AUDXvSBvMLSbbqN6J087iHjRCoaN4ES0c0st
	 07WPwg7FiMV8aeiDqSPIAS8GKGRU7PXsOyuvWIREH/f4hiPgO2nWB1utwGUM+msCiM
	 nmxsRUDvPW0iZM3ltJNxIxFp1SS6PUiuYb2UVFy4GDNLrW7Vq6jNTyvG305tLesL4m
	 /h7ZEOfAsmMGRbdR5+FgyFcG9q3+T2rGAQi0egim/i6PRyZgCeemVHkkjRgj4Vw8GN
	 nIQWTQZHDY3KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF8C3064D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:44 +0200
Subject: [PATCH 12/20] iio: accel: stk8312: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-12-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=860;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=sKvcghE5ThQXXY6IqazRh2jRyFRk4Gvhw2Dt6y9Vhp8=;
 b=kt0rMyqWMfymAI/q/Z0mnVnvXvK3GnHs++rHvCcBHM46WfZB++w555wevU7tgbbCqcgTdmB6j
 DpFqKVZfwP0AkzerK5hCIynsQ4wo/L0jH99Mjn/zsRlGOE0exxAh4Ko
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
 drivers/iio/accel/stk8312.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index b3534d5751b95..abead190254b5 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -448,8 +448,7 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 			goto err;
 		}
 	} else {
-		for_each_set_bit(bit, indio_dev->active_scan_mask,
-				 indio_dev->masklength) {
+		iio_for_each_active_channel(indio_dev, bit) {
 			ret = stk8312_read_accel(data, bit);
 			if (ret < 0) {
 				mutex_unlock(&data->lock);

-- 
2.45.2



