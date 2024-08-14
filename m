Return-Path: <linux-iio+bounces-8479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DF952298
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 21:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31430281FCD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2A1BE84E;
	Wed, 14 Aug 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="HcWafual"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871D1B1505
	for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663206; cv=none; b=nwccjw4XdkMXB7zS8fXPl+HlayLOdOMKRzw5ZqBlo+I2rGeMKyklcrNuWS/V0157J94VkDW8rTgZaxZT6qpOaVLXQXV+CaL0Dz5o1Q+r8MFWpB4bH6ZxuPBi3aOt+GHjayGhlPr6jXl5XG6w4RLKYeeRI7tyrE30AxuHCfIt+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663206; c=relaxed/simple;
	bh=QSEuQq0rj8v/G4QNFEhYU9WHdZcR+ADsKIXnYWgpieQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9OXCD8mUPf91ZgIa00tNFFpNI1+WiCwTu3fZSOE6qwcQ5V9ON/DLRNVqkHik453RoxZAUEZyd9WYqGXq+Lt2E+RGJiMQGhQZyHk+1EBbHoZmTeUyFiSWk67LNlV5NM4bphGgsNJWP8pS7Ipg+ReHpy3PxOLlmLtnVDsNdTWilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=HcWafual; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 37100889F1;
	Wed, 14 Aug 2024 21:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723663201;
	bh=C5NRJe7kXhFNqGNhcwOq8nuWw71CmqwK3o9EWQ18Jco=;
	h=From:To:Cc:Subject:Date:From;
	b=HcWafual1tcgAAB2LdBz9CFOZSRV4TgNoyUAHma9w4FVAXmKMP+87wfmxvnzyLBJG
	 Q4Qd+GJgCoR1pDbkzqJOR3DGpE0N0Z0S+29JMCapAffbyAb+PjtlhtzPZgusm2GqQ4
	 oF35rBAeGG197ZyO+ngwqeSwsQwXKYbcpQkgtPcAEGJL0HT+rJF/mAEpY/v5OOvVpg
	 vQfkSsWIbMgfgtMmYtiDG78Ql9QoYkZGbKzUdkbEZgNlnZoQOax89wPVQzvXjiJf4O
	 WkSL5e7v8Qb94Pd5m5q9cSTmafJvmp8BbWb+/Nhm4xHX4lBlUZZ++i5FcfYxiv7EQJ
	 SJp19sRUCFyoQ==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: light: noa1305: Fix up integration time look up
Date: Wed, 14 Aug 2024 21:19:09 +0200
Message-ID: <20240814191946.81386-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The current code is always iterating over two fields in the
noa1305_int_time_available array. Fix iteration limit, which
has to be halved to avoid out of bounds access in case the
value that is being looked up is not in the array.

Fixes: 025f23cfebad ("iio: light: noa1305: Make integration time configurable")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/noa1305.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index da83425fd9100..25f63da70297e 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -197,7 +197,7 @@ static int noa1305_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	/* Look up integration time register settings and write it if found. */
-	for (i = 0; i < ARRAY_SIZE(noa1305_int_time_available); i++)
+	for (i = 0; i < ARRAY_SIZE(noa1305_int_time_available) / 2; i++)
 		if (noa1305_int_time_available[2 * i + 1] == val2)
 			return regmap_write(priv->regmap, NOA1305_REG_INTEGRATION_TIME, i);
 
-- 
2.43.0


