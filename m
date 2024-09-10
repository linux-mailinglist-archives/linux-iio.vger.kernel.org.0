Return-Path: <linux-iio+bounces-9433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0838974246
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 20:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD38E1C256FB
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6D1A4B74;
	Tue, 10 Sep 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VbDAOMQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6B1A38FD;
	Tue, 10 Sep 2024 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993385; cv=none; b=nelSWTgjvRG2mLjZbLAwgHA8Ybl3/eL2cfxqSrTegWS+fKmJ3EwKK7W3+rEdszjzqWXiJdt+X3XvxnIUDYNVoes5AW0ulPi3MMAZ59R4xpCy9CIGDWskXJTz6mEQkbW+0QVRxevrirDGjYt6AeU02owxT8++8PcV/cs0EJlG87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993385; c=relaxed/simple;
	bh=EMFEHniz3H66HIbuJVBw3wQcWSFqvEpY/2FLIbZowmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDoW6tn2ASwFR/Jgkb0bcT1bfo9vqRtwPPtdYljhy+BptzbjcDN12aAKYt24x0v6IW/3sQQa6D/0Cw8ADze6Piw/DATlsb0Gmyvv69aK5qdmiAnpG/Ons1BCjAa9UPd4b3Fs82Y7sdUuI7DGfXHNuiXQt0pGM2wc5Bu6RfB149A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VbDAOMQc; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id o5ilstG1TLYfJo5ilsAruj; Tue, 10 Sep 2024 20:36:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725993374;
	bh=3+hlWWz7FHyIV2LbvTYdfP31igBbCZjEUwW1GIeQCjs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VbDAOMQc2Mj3rpaP0VoioUSVRdJOcn28zLOV14J8AhAhV4CT71W52bHuKanDWbxvs
	 9Eze+IBCs0cvLuqD9R+MhEcgaX/6e6rc423wH0l/Jkf4EQK95LBXLa3oN9pKyy+HbR
	 LMiZXPZOvXIaxw/m8Kc3TJzwCNApumUqFvjkLCkdxzCoCNw37p6hLlihaythtT0gTI
	 CyNhSjE6yUSqSlSF3eboX7Q6acqATwnlOyTPfBmFmlYzeTroxJwszXxG3qqHz02Iap
	 CILqeT07J5VIXXGybX0YdSoqCSr65d09HIxa0Pzs0di2yIvIjpcBaMorkOHMxOUV8W
	 SkMbfzmGyJ5yA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 10 Sep 2024 20:36:14 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Heidelberg <david@ixit.cz>,
	Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: al3010: Fix an error handling path in al3010_probe()
Date: Tue, 10 Sep 2024 20:36:06 +0200
Message-ID: <ee5d10a2dd2b70f29772d5df33774d3974a80f30.1725993353.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If i2c_smbus_write_byte_data() fails in al3010_init(),
al3010_set_pwr(false) is not called.

In order to avoid such a situation, move the devm_add_action_or_reset()
witch calls al3010_set_pwr(false) right after a successful
al3010_set_pwr(true).

Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
This patch is speculative, review with care
---
 drivers/iio/light/al3010.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 53569587ccb7..7cbb8b203300 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -87,7 +87,12 @@ static int al3010_init(struct al3010_data *data)
 	int ret;
 
 	ret = al3010_set_pwr(data->client, true);
+	if (ret < 0)
+		return ret;
 
+	ret = devm_add_action_or_reset(&data->client->dev,
+				       al3010_set_pwr_off,
+				       data);
 	if (ret < 0)
 		return ret;
 
@@ -190,12 +195,6 @@ static int al3010_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&client->dev,
-					al3010_set_pwr_off,
-					data);
-	if (ret < 0)
-		return ret;
-
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.46.0


