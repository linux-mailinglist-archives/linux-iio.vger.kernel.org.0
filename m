Return-Path: <linux-iio+bounces-7155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75C924313
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36AFB23F28
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB941BD4EE;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIsEo9gl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF41BD010;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=JrhQ7QJnidydyCkaBeyptHc+gDQRAr20d1aiKFzYYT7SWi2uDuY8o3tjtxbKkzHAnonIioXizH8wxSoZUCfCEFeWkAOHNj+sZ/I9kb3/8ZCgLILwd5qkClLjKP+1xgu7gOS1uTFu+aehLlPlr5rwk8ZcH0n/kMP8xDpa4lKpacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=P006j2vq5FFKg/037/BLpRC4GtOGeEzgy0ToSf1ZAxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDykp6/arAflUE3/r7e5OuqbKyBfrSoXHxhY3M9vMFko58dhzzzcXGO0NLHu95jslvTTyRyyl1aNvmY4q+EiuReuqf5PEBpvyTZqXNTP3/8O4LjDvG/u1zhRCYyR0UGtVqN4YHZF5ayoqLP66Q+JNGlMyU+4yInZRfGaDlwVpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIsEo9gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D2DEC4AF11;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=P006j2vq5FFKg/037/BLpRC4GtOGeEzgy0ToSf1ZAxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gIsEo9glS+gXg1z7maaeNX+13nZHc61CxOwODQT7E12lj9txYWFqDf4icUQTQfKNr
	 2vvGxo4eVCB6pEVmpZY99BHF4MyvARBKhQUglcCT5gcW6U7t4nkRgPTiqhwip4rkx3
	 y7BywhA4gN3G9Zw9LzufTORjfveze6vrK0OVhnxVAX4uQAZCU5+EP7nPjattNdlOjh
	 UXniKAg6FRHOpVaT0IXYUN+fFS9464JWlM6zML6qIMjl3eqvpwnFHpk/XRt6N2s9fL
	 mfSh6NbsE3TvjtpuINAXxLNK6oAAkOl0fyQOxGIocvFrX+ld2+l2oojYDxE6N9vEma
	 BccjmyXUmYC5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA36C30658;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:37 +0200
Subject: [PATCH 05/20] iio: accel: adx1372: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-5-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=915;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2EHdpJoQbj+k3J/CWxWS22/x7Zsq5ayA38mR5vpDteM=;
 b=HqGJD3hvrnZvHwYeCHrVGiJTDHQ7E6p+zcjNhkmu9gmiIdn8ADUJohk+uNH00HrlnzDF3XAXL
 +0ew+gitwztA3oLuTgEsLnowhzmOXwPzxz0T+g+HI0QTHeOapeqk/uh
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
 drivers/iio/accel/adxl372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index c4193286eb05..ef8dd557877b 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1050,7 +1050,7 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
 	st->fifo_axis_mask = adxl372_axis_lookup_table[i].bits;
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
-					  indio_dev->masklength);
+					  iio_get_masklength(indio_dev));
 
 	/* Configure the FIFO to store sets of impact event peak. */
 	if (st->peak_fifo_mode_en) {

-- 
2.45.2



