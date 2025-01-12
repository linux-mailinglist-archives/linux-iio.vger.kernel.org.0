Return-Path: <linux-iio+bounces-14180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7295A0A8EE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB6A1887024
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AD1B21A6;
	Sun, 12 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPZuiBfh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16A1AB530;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683565; cv=none; b=SBvnLHLdwI9CzPB09T9Y/wjcDYlr8YSzBxtG4UUfmOe0nE51e7O4zRGTS9brJOSUuK0eDpj38fp7zkmzqPa9J3ux1q3vp5SgbykG6aE/BizMoDi2YRizkWzWJ2RKZDq4bbgUIRMykSFY1wC8Ycm3KP/htJ+HPOVQ0Rz0dvUbmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683565; c=relaxed/simple;
	bh=kvKC97JeAx/m1MCydo6d/Py+eTfMKM+AcUKKqHF3zc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/qTT+HpMP9D+k+rrU0I7I4Wgs1tvI7q9DXFrtKMmFO1lUmCC522ErFzWD5DaKXdTk3zrpXdOIo15RGi1haKjTfDfbqnDpgVciywDr+feBpD1KRYYlt7w6c8dsmoZVZFN+N1E1w5QA3dUK0x0NoKGi6m6hsOlyI0/xGnl7psZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPZuiBfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96A2BC4CEE2;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683564;
	bh=kvKC97JeAx/m1MCydo6d/Py+eTfMKM+AcUKKqHF3zc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hPZuiBfh9VUEar9jC2Ek5V3eUMAc+0gc0vCnG63BEJKXWvGGCtykeVcZk9a+0Tp5S
	 DjI3//0eMJ7D/d9lwNhVaHXHUBJEqWjr8oRhDRZIu10qYwBs+64GjK4DPrYXXoohve
	 yp9F9898Qvy4Q9EP+cDMG9kJUAQ9ZX9Tln6Do15lRy+Hrxppdy8GffUql61VZMZe3r
	 titOu8lxPWA7jYOuVFdNOXt/xWvkPpDNNs/bE6JdMXOcTJoVy/kwDpgmKFuSbh8X7j
	 BtoP8izSOYQ2LVNhfWP9nNfbOieFHIHptAWW94iLsxMaaBrrVGLCk3cjfnvDG89Rxx
	 BKtbXGIArsyRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0D8E77188;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:06:03 +0300
Subject: [PATCH v2 2/5] iio: accel: mc3230: add mount matrix support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v2-2-322804a545cf@gmail.com>
References: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=tt9zbmLm9qM5VxkCOcKg8jECB+aJJH6bwFRVLsKm6MY=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbN2j9cn+97c+ShWV+Pyp2hQexZmxhjbsRfejkbT6xO
 ddza/SkOkpZGMS4GGTFFFlsNnrMFssPl5w07akCzBxWJpAhDFycAjCRs06MDEeu5aazrdMS/Vqg
 rjx7XSOTqoOAJWOtX9eX4rYFoqsr3zP8r7Sc9yP+xGyNPW/PnVetifZ90hL+Jyo1rnR306wbHNf
 aWQE=
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This patch allows to read a mount-matrix device tree
property and report to user-space or in-kernel iio clients.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index caa40a14a6316acae3a972f0ebe0b325db96eb44..a153a3f715ed7f2f1417618715767f265b49191d 100644
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
+	{}
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



