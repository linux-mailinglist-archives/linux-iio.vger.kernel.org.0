Return-Path: <linux-iio+bounces-7697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F816934E60
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF681F23231
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A61420B8;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7e93tiP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFC14038F
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=me3+ZRNlB9w9x7a6yf56VuyLM3kGVu0Cof3tN1MZPuiQQXM7x3MlqVbSqEdGZFHoXiDfaL/9StTGKfbMQA0NlKeXhu0+IoPmM8Bp0vjsmQ7XfjYTUHaSDauwspRy2JvEeoA2BkDebWv0/2ZawNXm8iFFnejALKQyQRK0xUzkd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=d8EF/kTrIVEsN3ovYThuD8DWN/GxMnbPQ2HCi1/OdAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNAIfT9NU9JfTmltJfjXPS2eytIAjCKiSADDqVwqurglVIeVZL+piS2eGDEKS8ZM405HXP8uNM1edVRuLpeHz38QDSC5YLKDBJzHB/gkrpSuHWWrylqPPwGZp1nimP4r0vm8VmjB3n+qH38E/XA4MmvseTtBVlt8674+9bq0o9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7e93tiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E68FC4AF17;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=d8EF/kTrIVEsN3ovYThuD8DWN/GxMnbPQ2HCi1/OdAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r7e93tiP7vwKe0P8OqWHz9LJtRWwDkDcpFFrscPUpCOcOTkUCUWuUbV19ryL+jbVr
	 P3Ezy7FwHR27gBP0fEdKQdOztPsp7d+dmC+DIxOcyJSLxA5ZQyFENxOismSd5mGiX0
	 9o6yn8RguIhwx/xEgcvga3fOH/vpk6Tq3aQmh3ilavzIGipG6L+VZoUZi1R5YQ5JlK
	 MLN8q0vbmozlWF0vSVkqdw9dgE8SIKcsMDeO+CRpcyu+45FFszYPJT1Q+iqoNw1T96
	 HZYSn/0dK1Sk00dPA47PrDcW9zYbnpE9hLmrIJvnJwuBjPRDMqofre/xDpiZd6SY6k
	 IwnHUUIc6dEUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55727C3DA63;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:04 +0200
Subject: [PATCH 18/22] iio: magnetometer: rm3100-core: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-18-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=963;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=frSUer5X5YE5lOu3IYnGGZx2ucpdgn6sI7LuCnpdktI=;
 b=xdOL+QwavzRfy2D5EBRZBhvnsu2mRXMY8ENP4T+7uGuWmJp+6F/vunrkUg2ztPxgk57BMQnam
 KvMDhgZR9ChAIDHSxRTeBFFXFrMp9KI6H1M9oATqvQ3f+HnCpTrQ4XP
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
 drivers/iio/magnetometer/rm3100-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 42b70cd42b393..0e03a772fa43d 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -464,7 +464,7 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	unsigned long scan_mask = *indio_dev->active_scan_mask;
-	unsigned int mask_len = indio_dev->masklength;
+	unsigned int mask_len = iio_get_masklength(indio_dev);
 	struct rm3100_data *data = iio_priv(indio_dev);
 	struct regmap *regmap = data->regmap;
 	int ret, i, bit;

-- 
2.45.2



