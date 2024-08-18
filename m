Return-Path: <linux-iio+bounces-8578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8E3955FEA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 00:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5402EB2126F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C798D157A46;
	Sun, 18 Aug 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LNrC8vPJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80336153573;
	Sun, 18 Aug 2024 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020192; cv=none; b=XezaEYr89NUNcHCfFVmLByxi5VVHPrsV870kRsW2NOETfTtft2weSg7IE1rvzA7rtkZl8Y9S9BOesTlmMD9Trot/40UJglQQPN0iWrXm4/2eX9oW18L62oD9FyZLrEfhxKP21BRK8WwBs/RW0vcTalzFIRA5i5VSSaZz9jQvNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020192; c=relaxed/simple;
	bh=kCUhIyTsTYSg3sqrYwG+YSGwdQQY9tEFfxayR51Ymo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Flz9jv7VV1Eckmn8K6KTrK1LT+BMib+M5qZmN23hQ87baaY2ykjc/rwUR1F37HWKAB2ZDZ8XazbWf3VbbO9zbtKGYxtolfLRessE7MRwj74cuyaJVLmNaP5b93q9Ic2bw9zvSqe5IhpovsxoirGh5JfkhzUxWDUXBZDjuMVO86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LNrC8vPJ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC24970D.unconfigured.pool.telekom.hu [188.36.151.13])
	by mail.mainlining.org (Postfix) with ESMTPSA id E6A62E44F7;
	Sun, 18 Aug 2024 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1724020182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c17U+oe70bN+xppTxzXJcfr6ftLHNKpTYuryoKZ7BMc=;
	b=LNrC8vPJOlV9D4T5FTJmO/xJkg3LS420k0/d9J3d1pE/ws/EupnyLTNGr+WfpPsCLLEEfP
	74w9y8Q6Ni1XEki18LC4+063snuAv+eMA/r54JD3T5CyXyCpsu7UqIVkY4yeCkh8SP9Sc6
	Tsx/YJbRgwRl1byJiJWaQlX1c+twYRSPCoZKa1/Pnd/0dDUq07j8oU+/Sa/+cjKU/b/Pnf
	E3o9zIs/KvJK6jVdnSVszCfRLXZ7OTy8Vcitp3EZIZi/tYXsr5S7/M67bU252xwTTkotU4
	LVAm03RbOx9UWcxeWvWnW3aY7eN1D+VWiZyWmoEWvC0jGNc7QnBLDESyGiBUmg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 19 Aug 2024 00:29:40 +0200
Subject: [PATCH v4 2/4] iio: magnetometer: ak8975: Fix reading for ak099xx
 sensors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240819-ak09918-v4-2-f0734d14cfb9@mainlining.org>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
In-Reply-To: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Gwendal Grignou <gwendal@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724020180; l=2228;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=kCUhIyTsTYSg3sqrYwG+YSGwdQQY9tEFfxayR51Ymo8=;
 b=eboiDO4/oPJNAqprREepdYnOw8y4H7Zjl9dHOdq/T4DJINj9ig6IRABcuGUWDJi49edIt+lEE
 0x4c1wS36ZjBtx5ZJHdBiEvTcbNVTR5gmJa624zluf7TyCFbuCCdfTi
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Move ST2 reading with overflow handling after measurement data
reading.
ST2 register read have to be read after read measurment data,
because it means end of the reading and realease the lock on the data.
Remove ST2 read skip on interrupt based waiting because ST2 required to
be read out at and of the axis read.

Fixes: 57e73a423b1e ("iio: ak8975: add ak09911 and ak09912 support")
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/iio/magnetometer/ak8975.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 8eef4d5dd9e2..2fa6721aa66f 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -695,22 +695,8 @@ static int ak8975_start_read_axis(struct ak8975_data *data,
 	if (ret < 0)
 		return ret;
 
-	/* This will be executed only for non-interrupt based waiting case */
-	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST2]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST2\n");
-			return ret;
-		}
-		if (ret & (data->def->ctrl_masks[ST2_DERR] |
-			   data->def->ctrl_masks[ST2_HOFL])) {
-			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
+	/* Return with zero if the data is ready. */
+	return !data->def->ctrl_regs[ST1_DRDY];
 }
 
 /* Retrieve raw flux value for one of the x, y, or z axis.  */
@@ -737,6 +723,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret < 0)
 		goto exit;
 
+	/* Read out ST2 for release lock on measurment data. */
+	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in reading ST2\n");
+		goto exit;
+	}
+
+	if (ret & (data->def->ctrl_masks[ST2_DERR] |
+		   data->def->ctrl_masks[ST2_HOFL])) {
+		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	mutex_unlock(&data->lock);
 
 	pm_runtime_mark_last_busy(&data->client->dev);

-- 
2.46.0


