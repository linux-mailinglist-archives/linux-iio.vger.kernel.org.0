Return-Path: <linux-iio+bounces-14137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0FA0A5D2
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 21:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A2C18884B7
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 20:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0471B87D7;
	Sat, 11 Jan 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGLaycdl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20091917EE;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736626270; cv=none; b=johFIzbb0KHE55uTBKoPlcUq/SGVFRiwshv5EsKdbeO/GXH12QQ5KJzecTZLADDMTiNaXdhMCOkjDCYA7AUM0i4ayXQEGdb9soxHUjNMRX0S4svhQg4X3Fu+cPwXUh/D2j462K217p8Wa/Ns7Hn++FdfaCh6DRcQ8czNaXATbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736626270; c=relaxed/simple;
	bh=2oDcjsM+xls74geaRGU02rSgJmLqWyUNLZxVDoUzLvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUuZFLt+6H6Q3QSQjLzOVl1IUNJcvwZtfIkms+1MCzX/2FG6UD9/8ym0WsWiPcy/SsMzKEsuSq808kj0mzR6RsiXH0itNQmtddUGZWTSOysruPDTem1vudW1PPWqOOz4w8bZI4UTPXOCAlTuLmqiGqRqCLuXHOlA/w+0OmBYZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGLaycdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CBBBC4CEDD;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736626269;
	bh=2oDcjsM+xls74geaRGU02rSgJmLqWyUNLZxVDoUzLvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WGLaycdlqyagkfWUliXhmo3tkLPKeI5Ub5nvxTSFpobG7bLLyhgA76aTuoF44+Ig4
	 akUZKP5vEn2o6mG/83OTVwoCsTwBW9fNiv2abc/kQHMuQ7+DO1vpqXUDsJTos7tvmm
	 rW82dh9VHPmcYuQ6l26xyJM48HEVgiRyOVs2DS7HQUmiw5LUNVh9PdeAyFVUyxmR6c
	 5h3riuNq5GP1Q2C1djO8agwzSNYakkmSGuTBIe02rXgug/GxZHmGJ9ZIOTIrMXKgtj
	 WdvvaaNRSKn+mtKdOLq1go8D0uJV7wksVYNcmCjtOZoIo1vppYwvRMMFBhXlGkYSEF
	 3HV2wiKI0e7YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E81E7719D;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sat, 11 Jan 2025 23:11:06 +0300
Subject: [PATCH 1/4] iio: accel: mc3230: add mount matrix support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-mainlining-mc3510c-v1-1-57be503addf8@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
In-Reply-To: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=SGUB0nJOPTqbOxbqJuC0hqRrN0BrPCLKg3CTaKtvEKI=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbLkQvLdgbGqH+9fl9rY+7ph9zeG60gzcj4l1454sze
 /84mMmxdZSyMIhxMciKKbLYbPSYLZYfLjlp2lMFmDmsTCBDGLg4BWAi+xkZGf4HnbWQn+UlWXgg
 7ZO5/NuWf0e9T4mf63SR1rvI+WnpyuOMDN2Zx99ofFyts2T9Nb51Apr+Tb/XBQav327bL6m96Gj
 /dnYA
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This patch allows to read a mount-matrix device tree
property and report to user-space or in-kernel iio
clients.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index caa40a14a6316acae3a972f0ebe0b325db96eb44..48787c0494ae6f0ef1d4d22bc5a4608035cbe123 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -44,18 +44,34 @@ static const int mc3230_nscale = 115411765;
 	.channel2 = IIO_MOD_##axis,	\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = mc3230_ext_info, \
 }
 
+struct mc3230_data {
+	struct i2c_client *client;
+	struct iio_mount_matrix orientation;
+};
+
+static const struct iio_mount_matrix *
+mc3230_get_mount_matrix(const struct iio_dev *indio_dev,
+			const struct iio_chan_spec *chan)
+{
+	struct mc3230_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mc3230_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, mc3230_get_mount_matrix),
+	{ }
+};
+
 static const struct iio_chan_spec mc3230_channels[] = {
 	MC3230_CHANNEL(MC3230_REG_XOUT, X),
 	MC3230_CHANNEL(MC3230_REG_YOUT, Y),
 	MC3230_CHANNEL(MC3230_REG_ZOUT, Z),
 };
 
-struct mc3230_data {
-	struct i2c_client *client;
-};
-
 static int mc3230_set_opcon(struct mc3230_data *data, int opcon)
 {
 	int ret;
@@ -141,6 +157,10 @@ static int mc3230_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "device_register failed\n");

-- 
2.47.1



