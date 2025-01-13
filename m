Return-Path: <linux-iio+bounces-14284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9DBA0B8F2
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3754818871B8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D922397B8;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3IluTOu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBD40BE5;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776923; cv=none; b=iI5UGF2G5GmDtttGT/YL2uffeaNt2y4g4YB8rck8xnrLexdBv8KX05oWV3P9w6/BXgC0eDTT38xx206D6aA4z5MihahO3m5UcirTB8d/t6a6FRckldD259aBnPSrC77jGQgUXObqJfb3valpA1xlJ/PILHAbHgAlwzZpsCwIVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776923; c=relaxed/simple;
	bh=2oIyvdA5lqjySX8l2Deg9R7DWN66uRbrlcnGgKpRqro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpDhBBxBhDDxJx0ua7eqLqNiu6t9/kYlKSfM72o+Ru/2qvYL1hSMCi7OhMmgorwGJPBmuXdqyW8DWG0Bf1DPonhS+bHzffBUbATgQVU51fex1vi9LDRIGTcx01OIDi5bKGzxQgRgia9ENk3rFKw4l+7+h9TiEu9ws/wc6Lvpdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3IluTOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF64FC4CEE3;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736776922;
	bh=2oIyvdA5lqjySX8l2Deg9R7DWN66uRbrlcnGgKpRqro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e3IluTOuK5aYFAwRr1mIQ3oYYc2yqAnsEhdHPsg+5dusCfxpDW2IYgRsqNMFjlyJu
	 8hV2DkIcr+V70zIcpfkfM4paPzNOqs3GYxcWRWgOdZWLhdHrwGx8AKOHWO54tUVCFi
	 usZiRCf/ytxX2MVUCtNnTXexscqC3VzNrJsKl30LjLvfbqp1FPygWCqKlOqt5FI3Ms
	 JkyCwDo2oI4xnjzB14YDl/F7g2zSoaBq8ExvDr5ke9gms013oxamo6klYDnHQPOFTt
	 FOU9yx7AiItOHDgMr4SyHm5bFlrLb6LWlt7JulG6LVBdJxcr0Ozfd7ax3pgJPNLRSd
	 6ON7CIV84zriQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB69C02184;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Mon, 13 Jan 2025 17:02:01 +0300
Subject: [PATCH v4 2/5] iio: accel: mc3230: add mount matrix support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mainlining-mc3510c-v4-2-4118411ef569@gmail.com>
References: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
In-Reply-To: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNJbZW4s2bfsZnP7FSv3RcssZxXIrOw0LSmX1l4kdF/T9
 3DQS4WHHaUsDGJcDLJiiiw2Gz1mi+WHS06a9lQBZg4rE8gQBi5OAZjInnOMDOe7+i0fTPp4WSnP
 YsmEA2bf7gVt0mtO1I5XVtfWrljWtIHhf2aCsLVputzZ09tWbdPyea5TuTpM7GM+263QbbOyP1/
 p4gcA
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



