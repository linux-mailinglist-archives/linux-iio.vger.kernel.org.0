Return-Path: <linux-iio+bounces-7158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A701924314
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D817028B62E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF7B1BD4F2;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsV9sKsp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C51BD025;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=ICX4ARqswth4V2SmLlyb/XaXYcUPa+5HFmDNeBHRzbDH9gWiBAjHPCtMXkCVf5i8t5XlwZsl8SSi1NlQ8LXWlDpBo+5dIyXqW7wRRAVlU2eXwCOvYTHQHXqpywNpi9oPN9Aq/jlvbd3KM82vc1Tlma3xRTPtpPB6lfIAKLqnnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=keSrboDdnEDk+BOxBBWN9hfl5VamPSjisDY1VWOq4Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLFBx9bwaMvHmigA/CUibQ2CIvvBKKOHn3GWggWR2LB7qs1SSxFhZpKdSqjmOeAFeC8alyJ15zxWuiNsXUer1iBsrrHJuJvetpyD7Bjm+9eonhhaNeKTOaLd/nDn0YJykZ+u/PRCOIvh6lFSHbZOWW8mwr8ZoUVIWjFfVFMHJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsV9sKsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8729FC4AF0E;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=keSrboDdnEDk+BOxBBWN9hfl5VamPSjisDY1VWOq4Ew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SsV9sKspSexexI2F7IzaVFT8w//xU7W4Mv40yapmj4TvLS6iwz1xktAqRlhinQmF8
	 Yr+CGSRkpzMqrGJwugTeiKCKvctiBPdGjsiFOp1a9opSjpbbh2qp8ERNUjpcNhzthK
	 jrD7uxA2XDaCGcdZRoxQG90v36z1n3RuGsvgs63MybgxQ5Da44EwBvX9ixDBHjowTV
	 rYO0yvI0WhBa7/GsDKB8FlyeuRAWfHi7IYlxJAPiCN4oAdRs3ql7h2s2dS35KHO8XL
	 U3kw4rAxWW198KiPxkEBNOcHShJacSs5ZAEY0oz+tUgM1/rpdAPhCwCpkbZEmjXhEq
	 VMj0OKE4Uhu4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D7C3064D;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:41 +0200
Subject: [PATCH 09/20] iio: accel: fxls8962af-core: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-9-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=913;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=4mWpFN+edUepEAApNSzBRyHgoD70Vxqq6Y9OZGqmjrU=;
 b=Q5tLlYPDxHAbfMtvcRj971Vl0lxoxT3px4ZQXt19F8RlGGCkWemotJzujrMz5YE5MM54lGnKB
 JgnHzH/TqZuBQ0hxTLS1Ohr7dDn4xnXlVSx928Bol5OMxW2lV0tR0Cf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there
are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/accel/fxls8962af-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 4fbc01bda62e4..7adb8937cb4b6 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -968,8 +968,7 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 		int j, bit;
 
 		j = 0;
-		for_each_set_bit(bit, indio_dev->active_scan_mask,
-				 indio_dev->masklength) {
+		iio_for_each_active_channel(indio_dev, bit) {
 			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 		}

-- 
2.45.2



