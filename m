Return-Path: <linux-iio+bounces-7688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F7934E57
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34D11F23BF4
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B413F435;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDxdzADX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876F13DDD9
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=aYaRG9c2z5qEV49AzfnAjJhux5w5KAnE3Qxk+Y+0wCgnHWqdJW5aK+UI1P/SoJSY8ZacQsrTx6t1neA+YSw3JFJyru5N09L1iPCGSSUsH2222UjK3wo1qHqC6YqsJv9hTKfrMjkeSNx8vJYrioVpEkseGE1diqnMF3wSUGfHy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=35zwJv0FwMSgv84/FYd5MG0nOxNCuNaUIxyUXC5BwAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCJppN4WnGXODkwlMcVVgKHCwFMQeBRPiYBkj/xwH5rSpqKUJ7JWFmFg9QwTgbMEG+HXHzaXDcTjsEevyxGEqkPqSFowbOYeLG5y4cvZQN+J8o4X+7tXI6dq2xMoBurfPhRpeOT84JEwJ/o7cHGDYVodOmq3EOKy0hJ/6yLh4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDxdzADX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8F68C4AF1A;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=35zwJv0FwMSgv84/FYd5MG0nOxNCuNaUIxyUXC5BwAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TDxdzADXqF1TL4Zb5L9g/nRslFSouWsGZDxwLmpqLSeIjyqZTUmP5fcojwW3deS4I
	 4NSmLpHrWRfvRcEc+jtDYcBJAgvrDQ8iD2fVwrH3SbCiNTpIpOoRTzQ86cVfmuXab2
	 CM268BUvi5WpSzjsQXNRZ3OBCcSmJxA/McM2cfpd8JhNcIIlzV5AGrgoKs84bRMt/6
	 17ftibvYhqieueu458Yv7jYdO+8cMMwi+5M/isHptZ2Vse03TUsA67Btvl6CLBHrFr
	 vNzxErnS31HKCuEKWy4x0fFHDV1Eyv0LPhlUqsWHFFkJ1peHsaODW2DiVe6v9dobGc
	 9IlJOi4H3TPIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E650C3DA63;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:54 +0200
Subject: [PATCH 08/22] iio: humidity: am2315: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-8-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=916;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=v1J9CeLrZGFCPkvoSSiWK6wlv3vsQ+PI5KbphUEl53U=;
 b=Ztg7v5y8eCCuJgT3EaRbFW3AJPABX5Sgl2lxvBXdr+eYOxsmItf/J/RBrmmwM61bKR5PmqtCx
 +3ZkoWmV+N8DQBCyJvsclCOEYiark1NI9T6mll66N+WOKE/QwNQ8w6O
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
 drivers/iio/humidity/am2315.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index a56474be5dd2..6b0aa3a3f025 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -174,8 +174,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
 		data->scan.chans[1] = sensor_data.temp_data;
 	} else {
 		i = 0;
-		for_each_set_bit(bit, indio_dev->active_scan_mask,
-				 indio_dev->masklength) {
+		iio_for_each_active_channel(indio_dev, bit) {
 			data->scan.chans[i] = (bit ? sensor_data.temp_data :
 					       sensor_data.hum_data);
 			i++;

-- 
2.45.2



