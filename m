Return-Path: <linux-iio+bounces-17551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE52A795B0
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF0A1893EB7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35831EA7CF;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETQzIP2Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785981E5B90;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621305; cv=none; b=QhslOAxrw/Konlerpy20nkJ/JTpayyE7gsGU0NVtsdy4hDCBy0GxvbVt05Q/mYvnOr3JyO8AptLGx3LBsaDXt+K/RYjycoDT8xYR1dDoN2Stu9haCJlt+tGIMmV6PbBZlucz066jLQx2VcwqcA4bAyZYEpkCLHRMyQ/vGHaetr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621305; c=relaxed/simple;
	bh=fkR0Vzd8mzNnT68cGKzanNGlviPHtKVJhQdzXpi6kJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flH7qrbAFt9SBEXExIxJ0lubBZsr841vWX8D4e0GgZSdxnO0aYjB+FZVph+I9OF5QTsY6FEbMVlb4GP3pUcZ3y4PCkvzMT36gjK5Penmu/gWf7jU4u0fRxn5cvr7Fnf1GBsurHdRDJxa8u7U5UgxhzyoTLP8x+AfPaDUcWV8VCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETQzIP2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F9FCC4CEE5;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743621305;
	bh=fkR0Vzd8mzNnT68cGKzanNGlviPHtKVJhQdzXpi6kJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ETQzIP2QsM6dEzJq9iHwRkCvaG92noETM76bpJhYqELqiamOSRA6mNG6IdDMiKQi7
	 FW2pw5iO20PVpT0p0cdFfujrQu/4szzxEK7fVBDZCZZeaYLqkKJ/CM+X5XD0enw8S2
	 m5tj8KUtZfttewW17egoGh52cX8f/hi8gZd4bPElisd/sWgbSttvTuRvHsiK1ICdWL
	 QTvQbS/lYUImV4PvmkWvH/1oFC+7bWJKpR7tVO99j2KHtYrqFcC8kv83Y0mMGcf/Sp
	 PsAQefmdJPVyfZ+ECgvn0H/Vr2Tl0qeJ7KoCijsT2ts6/XZyCiADrr3g9VVMo5iiP2
	 03UKUYvGk/Vag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B04C36018;
	Wed,  2 Apr 2025 19:15:04 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:14:13 +0200
Subject: [PATCH v3 1/5] iio: light: al3010: Improve al3010_init error
 handling with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v3-1-cc3da273b5b2@ixit.cz>
References: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=gTAVbM5fFc5QokjDQ95bD2qhmu90RRaffipzE9qAgeM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7Yy2z6bI5zDrIbRTccUfbKEF9zMRSlNwd1PrR
 ubGSiB3LI2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2MtgAKCRBgAj/E00kg
 ciPbD/0ehgt16z5hkaK1f7naswyW1uVnfcDGxIBm/LlIWktjEKGcdo1yeG9/NEgiE+LBTIi5iC7
 yb8cox7jEr9UQB1bR+NH+hzVLRKpQqaP9+0mZx3CIDybmTIXHe9Zg9mE8YSe//02dZ31zEubA19
 fDLroie4+fXRCvVMDlNUzECerX2za1s4TO8mpWDDm9CEHEKTRFTwZUIQmdanD7NnW7i2xJ4kuHs
 1PHschta+u8tjvmXkZf/YVXUea817/ekz5ztXaQC/uXTxPbRn4KJrBFqhiwBPd0cjmXi4sQ//ZV
 utVGiW9DVUEOZEu6ObXP+dCK/WGexoN78ae44W0ecyjKQ0SzkxswZlFIhfwMPE9gf88vPV0XfO5
 qDVtwdlP5u24a8y5axZccSIaYJy6MF7le0CHMcGKqTwBM5+gxvlkoY7H0qD09R2Fe9J7QbEt3sR
 Mj6rTqCLzxOAAm7DEBoiHqEJtqVxxIjvUIbwjYBoM4SBgGd2s5JfkkrsFO83mkJABw+6ZQtbPHO
 SqSlcO9D9z/haXAPhs+a+8v+ECCnj+DHRJXwonjpzbuSNO3wcuvl1DyBr7q8r/XygpMD7ZPHLoD
 bJYv8F+qZ0QrkTEe2XcfkpRjd0IOJWaf0+4sKo3LmseziDMzIC9rJkOEi+Ty7aVTVSp8rHrCDtM
 cMhGS4fORo77qUw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Minor code simplifications and improved error reporting.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 8c004a9239aef246a8c6f6c3f4acd6b760ee8249..0fcf4253864843142f1a7c61c9a92dcfbdf72a60 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -92,8 +92,8 @@ static int al3010_init(struct al3010_data *data)
 	ret = devm_add_action_or_reset(&data->client->dev,
 				       al3010_set_pwr_off,
 				       data);
-	if (ret < 0)
-		return ret;
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
 
 	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
 					FIELD_PREP(AL3010_GAIN_MASK,
@@ -190,10 +190,8 @@ static int al3010_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = al3010_init(data);
-	if (ret < 0) {
-		dev_err(dev, "al3010 chip init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init ALS\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.49.0



