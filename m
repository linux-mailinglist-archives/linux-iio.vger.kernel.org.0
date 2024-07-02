Return-Path: <linux-iio+bounces-7167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB392431F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E0A28B789
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D501BD4F1;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpZRbxI0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657F1BD511;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=KuPqv4flwaolTEp3FeG52V9dIUbZB/7CO0KFhu1ZbUMjJqYFr8pdWDTAf4O792Wwyf8l/2F7rbtHfnKLgKm1kOx3fHKwBZgN8M3M4pM5rYPnuXH4ahECqVlcnJC7JgqE3UUKY01aOxpFxmj/fB/o7e3AjaR4StyFksGCFSl9wIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=mpdIPf2JJyuaQzZPivxG0g8giXcm2FQ29mHR6NwT0Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiUHkRYDXGjFnUdpvPgqV+YMpDAdkgLD7reA8L/msJQP/YyM4fWU56ahCDJxRlKLSPoA9e+7kQJQg1882QyvAkboaSIYsqL86B4BnS0yUfATxS7uir4XidyqknPLE4ZrJ3k8zEhz8LunXDy9m08PyuyCHjhEkczR2Xny4t/vhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpZRbxI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3685EC4AF13;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936160;
	bh=mpdIPf2JJyuaQzZPivxG0g8giXcm2FQ29mHR6NwT0Pw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EpZRbxI0GenslmjeOX8hSVnqDQS+RiaydEx3/92bIxJncMdwv9pPlh2zHzPoyjc+O
	 u3w6m8Pjw1VyHHk7jZmUFeSx/MJ1iDLGRUF8OnsuzcKY0QPQku1Qj+rKlFvBfaU6l+
	 dvawAhYyzONpHDnY2jkfp9fN7pSA8KxsmKT/4PGyc2b9ZdNGGAczjRpM8GtNYUYlSR
	 VWtX3Cghj9stii2XErXQBG9czeuazUj7sxqIC7PoG3SbACO3npOqGYJdkN/NHaOD5z
	 4Vsiv6buPwBEtO46wQZJVhUyaLFS1i9EN7k2jHidPlYwlnQftpdjbxgkQ+sUCp9bmr
	 awc9Gt6lmHiAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E58CC3065C;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:51 +0200
Subject: [PATCH 19/20] iio: imu: adis16475: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-19-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=891;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=R0wwlEsuLBVxnsU+A/xQqthiBloXGcKrV9R2Xe/WNOk=;
 b=ig8hNaFeuY+6AqHCCCLWYv++S5uIRb3T50cfV7rToGdVwa4/sz19fb3vXj3FPvwcRRv4fEkYs
 ipUbY1hCjTzBb5+pF1iDYBRZBlX4YQe8ZMXCQhzqRwIWF+ie83Ry+8w
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
 drivers/iio/imu/adis16475.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index cf73c6f46c79d..1cc2a66a78ff3 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1608,8 +1608,7 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
 		return -EINVAL;
 	}
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		/*
 		 * When burst mode is used, system flags is the first data
 		 * channel in the sequence, but the scan index is 7.

-- 
2.45.2



