Return-Path: <linux-iio+bounces-7154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A0924312
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A2128B44B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219D1BD4E8;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQZWwVx2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CA1BD00B;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=ui8yubEu8687tVh/1PTxU0Jx+dvDp/Rl3A98h7JC8qC/XCJEW1f683AGO3XP5uG19prrRQUmRHUkbR9F++Gi7YEyMoF/GepMHVhYKvgOO1/ZWLUz6+4CAk0AdS7K/QnWa4aShUrItN5/qAdCN6u7IRw8brtaxyJ0e02YPLW91uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=xVxyFNnUOQfVYMK63TbRRb8qAbFJCDubROXQiuFnah4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjWf/EWABLQV8WBZKnh5kJ3E6gR37lVi35eAMpMHdLGssiiVdql702YmjeoWO/WbuBwmgXYbjFuo7Czgj2BMAp94NLCceQp06QY79ueU3Nj/iLtjj8KSK3SHZG8b1H64DxkCdJvz6vr4ztE3jzf9AMmVVmOd0UrHRRFo4R4k50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQZWwVx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56C86C4AF13;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=xVxyFNnUOQfVYMK63TbRRb8qAbFJCDubROXQiuFnah4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZQZWwVx2YXn5Syk2PbUyJCw75rbwjjtC4lW3XJX5qh4WdtutMDDht2L2tTXeo6Nv1
	 DtRXewhesrqNKXOf6l7+Rt4sxv2qCzHVuTrOunueV4EGPHuG+tLC6UB/odygk7+Cv+
	 6P1PtQ55FhyVD8fopiuaUXmmzxOGfxH/lQC+kQOMNMGJlffzsMWOG+nCsE3BEgGTbL
	 xcFBhjf8jZ7ZLBSInPdpKP5m1NaZYeTzUKUkaMSSfS1KSQoF48Q+kPJlWFnMnwh55A
	 mIIuDjY3al+roxjtn3Ey9DwzG9zpLAM4lPruROiBv2yXIARR1f6raLAVf6jTnepp6j
	 P9qxKJ8SJpQxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1ACC3065C;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:38 +0200
Subject: [PATCH 06/20] iio: accel: bma180: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-6-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=852;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=cf8nH+C7ga2MXuJGs1LhW+Vpw2HhW0TtDxm5BRQV7AE=;
 b=uqji2JCwXdfwSMPdRVcuAb/d2Dl34B6/KSFtjmrqUxMgkRWE3YlbPtvfqbNr5hbh197ihNyIa
 +mYYUYZi9KLAkXqmYe/W6FDoDUOXPleO9cilkhT4a4DzC44FcRaDbeh
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
 drivers/iio/accel/bma180.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 6581772cb0c46..2445a0f7bc2ba 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -876,8 +876,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = bma180_get_data_reg(data, bit);
 		if (ret < 0) {
 			mutex_unlock(&data->mutex);

-- 
2.45.2



