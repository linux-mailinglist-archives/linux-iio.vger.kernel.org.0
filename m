Return-Path: <linux-iio+bounces-7162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E092431C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443C8B241D3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495C1BD50D;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHzyyNCH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E81BD4E2;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=FcduxiFUDts6ZjtIQMTq4SN/0MZhD4HwAiLDyQKOOUzj/0LkFaRpwoqjpyB8OqaIY5iRA89RmbL7qZQ9OCqOvq2M4A2a7jwcwnD7xnSC7gT+RM+nKnFv+YqZj9ft6oovi1s6Erd+y+l/khjYtUrLODt/B6KmL7Px1zpTryoax6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=uO8h95Raq2yO1cXDpXi+1Lxc+3OeSQ09Wa5SZdi33oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3Cs12eveeo2FJeUtHd9+refqkvHYvHsCVIrSyeZo2WeZ1iNg0BpabpxiPvETxwbwGHQgRhR6c6E5DmtMPbUy6OOtq+QL3nt64iLqYOw1LwbXzZB2Ug/yycT0HZRT/wEhvjDNmaDiQB5+3XEwc8L7iOzJmH1n+XePJX648cuT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHzyyNCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B7EC4AF48;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=uO8h95Raq2yO1cXDpXi+1Lxc+3OeSQ09Wa5SZdi33oY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FHzyyNCHLBPRBrODchSbYz9J4OsDNnnhjiHTghKk5VyvmMTjJ5ywqMLa5g0uyCqrQ
	 ipDEU9RkEXfKLqDBRD9jDCYKQVpAMHMUeF6vA2DbNpFtw14fH0V73NFh4F/0Db3Q7r
	 xjamZAewyLP7mS1uqZKc1chUrblF+7Al941uB7Tnep5teG7zOc+V5u45Uk1wSsxrqw
	 zaB0JRwTZwj6Ahlmj4Hxub3eAzCxKEXXPwudOPJ86PpoJnb/bT2GhmVQADpWsK28TN
	 YbLMY2D3uNoYWHLJB9+629xNRMZaSM8HHV/eVJEKSHlci/e6AD2xjRLv5C+KjAnoPt
	 V2T3nf2RsmpIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99228C3065C;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:43 +0200
Subject: [PATCH 11/20] iio: accel: sca3300: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-11-98193bf536a6@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=930;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NiKRjo63/+CijDcg34TeX86O2hQZxnlYkTzG1tnolLM=;
 b=jPnvlGu2A4lqfgW/FRAGVpZf3vAhpuc2SU3/FBNHyOU5fX8sYsPlhAeFv8kmHbE6KA5zkQ2+E
 mO5j0bhHf2OBadPDqmAb8uiWfq07u9LfBK0TjgkXcnZpPv23KfZLwka
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
 drivers/iio/accel/sca3300.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 306482b70fad..fca77d660625 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -494,8 +494,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 	int bit, ret, val, i = 0;
 	s16 *channels = (s16 *)data->buffer;
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);
 		if (ret) {
 			dev_err_ratelimited(&data->spi->dev,

-- 
2.45.2



