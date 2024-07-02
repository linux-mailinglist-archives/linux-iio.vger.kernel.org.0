Return-Path: <linux-iio+bounces-7156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86640924315
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C426BB23FD0
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE91BD4ED;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRqPCCHR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E171BD01A;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=fz+9/GlGAgTyazPxRhGtWS+vwanb8br+E0b1t/fZ06Fl3KgnyKsjxzyKfmfvULEG2uufNCSw3h1UAiEkT66MpbdgZYp7IRyaG2DQ0vgk/1sqv8OLC+hNmHBm4jQ535b8BvjH6p6+YNSDsHBXQ3ySBvPomL5+YgJ4vR5m/7VjOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=sC6ETYZGhKeNPuj0zZiWjODno6oDUaoxrOkaAN4705Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMjXpV6tbaFj0cgqiUOgZKrtjs02afYLwdrsJcmMLqs2UIpGuD86d7TjyNmGHCEod6oD2sOouxs/VgGEkE+xLd7wAx5m2KOhSoNuXSAqSRNks+BVCwoSJbYTlQzrr/Gw0keEBdU3IWKiJxE7cNGJxmxHGZUWrTlOAFjkKsmwpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRqPCCHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92100C4AF1B;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=sC6ETYZGhKeNPuj0zZiWjODno6oDUaoxrOkaAN4705Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dRqPCCHRXxodNkirSyOOro7wnrfW9Cd2oxcptRRDGYzWwHZrj/GxHKtC1QYotZ13x
	 kfCP16V1+eTE2GgppDVcvy9l4uq4O1uqsrCit3R4okjYrXLjhdbGtwSnUZF7ceU+5E
	 wKzw5dTF80AB5JNR1FC8cYcJqyT3kcMatIIhqsWedNyKtvUEq+kDvxBJLj4A+4C3SP
	 TVK0DH80SsHh3CznrpbHDSBCs+CtOomIx/pgrZLHDWuTLGzb9XBbWWrYX8/DlDr1qb
	 L/hQb49CUsyDX1OkheSkpTy9LCK0xD2t/MbPfnrnm09pPApC7XHaaAnbpcelFkauhN
	 zOgsjgGJsHhcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E21C30658;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:42 +0200
Subject: [PATCH 10/20] iio: accel: msa311: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-10-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=842;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mlp145cykZFgcq0ksMJ0dMmg1Uqt+N31aaJsB4Dxu1A=;
 b=RKVvBr9oHa9ZYzfP7hszfF91tCbZHswMxdKBVlu19N9CRk3yM7Us+aLt5RvpjWY5oylhPI2U5
 Q4H4Fy7vETTAd564DZvXYO/AfA1Si4c12ORmJ+On4w5TqjqX1htJQgN
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
 drivers/iio/accel/msa311.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index b8ddbfd98f112..8861010256f2e 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -900,8 +900,7 @@ static irqreturn_t msa311_buffer_thread(int irq, void *p)
 
 	mutex_lock(&msa311->lock);
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		chan = &msa311_channels[bit];
 
 		err = msa311_get_axis(msa311, chan, &axis);

-- 
2.45.2



