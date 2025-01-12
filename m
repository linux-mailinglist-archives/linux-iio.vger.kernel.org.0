Return-Path: <linux-iio+bounces-14190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC17A0A919
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2094E18874F1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E131B3948;
	Sun, 12 Jan 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWC1Ok2C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09511B0F36;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684780; cv=none; b=TcgySCUEg+1zYvsmNogAs1VpfhxAbUykXBzxJ9ARIW1gBPdr4WBhlc6gEPsyJqnVXJTYqYrNxFwbQ+aNrTeZ8R7tZVCgs5/i2YFEynzZwAjEPrktHWtfCX7vc96SCf6ap/kKNjwkXBt+4W8wrJajDMqT9hlBmOY/nPYeetATNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684780; c=relaxed/simple;
	bh=kvKC97JeAx/m1MCydo6d/Py+eTfMKM+AcUKKqHF3zc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GcIRn7Mjotkds7EUA2KvqmqUhGaJKcKEwZeuhyb3EpSfl3k4JlJOtiZYT2KSPKS8rcSDBtJSoA9tNd+/uqQxCry751FWzInBDnTF8NGwK2MHkv2v1k9Hgzio+OdNTCIAvz/i+DaJHWTa08k+SYFhCJihHCMOjuszSDquU9VUvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWC1Ok2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A3D5C4CEE2;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684780;
	bh=kvKC97JeAx/m1MCydo6d/Py+eTfMKM+AcUKKqHF3zc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qWC1Ok2C6XbzrgJu1iJfPlWTOYob9LOZ0ajgyTfox/t7EoWPRCp2N9Z8ux6XBgHMj
	 NNoqJl/TRqQJgujxdrVitl0WAEGyzXibDqt7Njd/S3NNIjZRCXQUDosSqY587wYORX
	 sqnKLn7Ye2+638Ny+r/zinosc516Pyh3ysp6kikwmDfH1EOHR8uDFLFFuOrP64B6Y5
	 HZxZcOdx5a86oJC0LofnbqqSJO1iGrTlwekp8HwdKKtEO/cbx/SuQv1DimXuy7Kp7K
	 V7i/+aUqAUpmyArPyNin7LBZ3P4mvBzfWCasol7Clxpz6uXMUhIzNhOIqL9YzTzGVv
	 QgdLDxd7IS1IQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A093E7719E;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:25:36 +0300
Subject: [PATCH v3 2/5] iio: accel: mc3230: add mount matrix support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v3-2-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbt7w6ye9ad372xnshd61MT3N8v77Zfw8fT+F3iZfBx
 x+s/i4+t6OUhUGMi0FWTJHFZqPHbLH8cMlJ054qwMxhZQIZwsDFKQATEdjJyHB323ybSuYFhg5N
 GZzrmfnOr3rC3SxeM+GG/e6a9ayn9oUx/HcKm9H37cKfe5p8AcGWs/X2sr1wOq+6Te/IFOPvD3+
 ckmQEAA==
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



