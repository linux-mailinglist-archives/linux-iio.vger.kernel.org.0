Return-Path: <linux-iio+bounces-14392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27327A13B4B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F653A33C8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25922ACE5;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkQgmyX5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B46DCE1;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035613; cv=none; b=Pq0bjLPfJ/7OcFE4ssf0lghRAw2V0dL6r9r6yUmyKwJT2OZXvPcUkXJrSG5SX4XmQNOJ57siGWtxWv21zkOuELyvbgqq4hhdOQN5e7cL0jnqaRoIlOR5cVRG9G1vuEJ9SsH8QDRE27x6jZH90h/69QGbH5C9Lmg33ibqQD2YQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035613; c=relaxed/simple;
	bh=2oIyvdA5lqjySX8l2Deg9R7DWN66uRbrlcnGgKpRqro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgLd7vDHwkY6pA8LXkKIWRFsOjNj6Bb/B4saROMrPhQUyQ/tALJd0QmcMLWftNa0CysxusQ0K2dzVqOscozbZXQuRJqIiG3RNiU90sqPR/1oRPNc87vnzwCArw/VQe1ZUfd3k07qmetM2LAD5uQ4WICHDKUDVZ2kEG/QjCWn3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkQgmyX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13A82C4CEE3;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035613;
	bh=2oIyvdA5lqjySX8l2Deg9R7DWN66uRbrlcnGgKpRqro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FkQgmyX5ItERGbpLd00fINs0tH6w1wNr1mT/AmUD6Wvjzo3laO0FVXVa4OEckqBpr
	 A+F+oQngm/hTtvgYQpSLR7JkmuDYdh9yyIBpE8bGb9I0evu4WK9dvC3qkYwjLUoTtU
	 oWrFyogu783E5UwIFt3JutTwOXGaBJenVDR9qnZtVQ9JavjtacH06Xp4TiBNzxYYkQ
	 p9WIbEKWku0d19xBYEjlUVishBO5oeva68TdVIe1EryoAJNhf7IQpZsbQXjMgX9Kh4
	 POc7BP+Q2aYrUNGNA8JpzdwVF1mCY0mMCY/AeKeZVz+WJuX2VkK6YCurEk7Lrv4zhR
	 eCU2OqWjjhoqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0479DC0218A;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 16:52:43 +0300
Subject: [PATCH RESEND v4 2/5] iio: accel: mc3230: add mount matrix support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-mainlining-mc3510c-v4-2-a41308b85ec2@gmail.com>
References: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
In-Reply-To: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=d1xov0qHxHQE7DYG5yJ4wuLkWhZ9BJAbb56t/my19Lo=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNI7+aNeRk6+etuiRaS3h7PIomXOnduf2J4b8shpmkeH3
 4t4lrC/o5SFQYyLQVZMkcVmo8dssfxwyUnTnirAzGFlAhnCwMUpABN5k8Twv3jqYmetEJtHX/oU
 lnw9whdpHl1SpXV9rsKVWXx/fZrnfWX4p/pwycFwYYtZ13yuabqKHDrB/p7h2NEnDEKhm183KVt
 osgMA
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This patch allows to read a mount-matrix device tree property and report
to user-space or in-kernel iio clients.

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



