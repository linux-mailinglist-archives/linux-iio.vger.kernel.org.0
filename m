Return-Path: <linux-iio+bounces-7168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B745E924320
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734B2281A81
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027E1BE221;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX4ybv3a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9651BD51A;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=KEre18zrySd6SsnUnTVFC57l/EE+C54gpUojJiQxFUM5VW8ZgjfzSjC2zZAMvumSsIMsZ2ED0+oUJEw2Dr89niPIfu8mjxTGCg5gaAosqhQGUudZmU0Cj++hTW+usspxqsRRIVaUCRXm0XArvkhYLaCE9uAeLpPHMEaEFJuLJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=66crgnursJi2B2eq0VvNe1euuje5cNpdlKdf9yiBQ5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUNhn75uANEsFQ6zFBqpsOdN7ylS5E9RELQs/yt3C9m5CBSB/SOuTjYtSWRMEzjKs2OAWyqW++PFBGWh+HRCokfdKtMe6XNq5hL9SwVQS2+iSI8TmlhtbEVE4YJpyisVbjkeCVt2h51SAH+E2zD9Czd+s3qDKTSiW9rOGt9afW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX4ybv3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4797DC4AF17;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936160;
	bh=66crgnursJi2B2eq0VvNe1euuje5cNpdlKdf9yiBQ5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uX4ybv3a6Z3mfPKeNbWh4RfSjDaMSWtQTyu6nIqPkcR0t8MvIzAuA68/7BFq4G9jO
	 0PnFuq0vn2f9lwqCmRg5/IDIzw04V62frhAkVbx7HjomWq6ZJ7aqXHyYZO/Hray97v
	 s7ZvaZvm0OQCAOSzFT0BejepkFxud9G79EUbFv7FHwxqplSyj+PWqGJBBVzLSyCz8I
	 dgBxEH8xUZbKaQlAkaQk34EzGwD3mcYDbGizZYOVP5QoEIsIiGXa3Zsbv2TOhwAsUF
	 OyEQ6+SFzxJhg1Qv+JeB2VR1KF0yazmhRG8at74lm4rKYM0kk4B8ge/kRt43B5IY2M
	 13yV3pq/zovYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D814C30658;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:52 +0200
Subject: [PATCH 20/20] iio: imu: adis16480: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-20-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=884;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=9JQj/jSVCDw6YceIOCpJXsyqqh4Yh0od5ovTl7zFZaw=;
 b=WbKDEozkTJlTjNGGrlbP8WBXQHbJ9MxM+I/TdvuUkOeC2Du4VJFmRNR/8xcAc92ZixIlu+VhD
 X8ML6nmxoN0BUGffY3qH5gMINA/SRS1OC/SWA7+oK2DFped747Yb4fc
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
 drivers/iio/imu/adis16480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 56ca5a09fbbfc..2f08268bd724a 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1410,7 +1410,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 		goto irq_done;
 	}
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		/*
 		 * When burst mode is used, temperature is the first data
 		 * channel in the sequence, but the temperature scan index

-- 
2.45.2



