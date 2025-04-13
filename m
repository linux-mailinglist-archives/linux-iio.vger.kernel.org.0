Return-Path: <linux-iio+bounces-18055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA53A87193
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3A616E8A0
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284219F42F;
	Sun, 13 Apr 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQCPsNG3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F419D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540525; cv=none; b=LuvL3gPo2n9XNTqRAslg08A/KIFdG1aoMdm3iwXrrMLsMEMWYCLzL3kdEx5pB4TllpQbbbbm8UN4JgyPTTqgIuNJdwPxjpZDw4L0T3iKBZWwdfXwdl016afWx3BmiWwzHs5rKbBpA+YgBj5n48q5vYGXHPaizGnziYBXZgjtOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540525; c=relaxed/simple;
	bh=7FgPDEuTAqUZvj26PtjNeIJtWCgEQnOO+W7C1fyHUQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZA47xNxGQL6qN2/4mN4+g2ngCsMSEOZkd1v1JXcpW2FXALgbVGeUXy6kPcUNSwGsn6QsQI5T5V5xrSgoTRKaluNjr8RYtotvtfY3/Qxm3mnxJQl3oxBEoYPVeGjH03xxWnDCzOe0RuBt+82EawfiR/sUFWEHS1Vz5ngLoA/XJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQCPsNG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47AAC4CEEB;
	Sun, 13 Apr 2025 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540524;
	bh=7FgPDEuTAqUZvj26PtjNeIJtWCgEQnOO+W7C1fyHUQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQCPsNG3CRRS9Ibf1GNbKccm4OpL1D70LhzeQiq521jp1GzmnXP0QJMJ7aLpGS5+I
	 Xs/9XexZUqogwIjG0Ds3myk8xgNZeqyOp4rich+uUkhvGGxCD4eYHMjxeqPy8eaUpd
	 8Xwg+VcohTkA8KMl1UWbW3Hppgik52UysloATHVdK+/hO2XnUqjj733xgoLvMrdmll
	 l7mzqoLZzXvGCinmT5RoxB5i2H015nIRoISoqo5MSFmwa5v7MlVi2i7+62cdKtYJXr
	 qaLpjc0YD8YwRTDIKGoicE0kfARnSNAQpOc8v+s5Dcp6v67csFrvVD3JKDHxTQQK3p
	 o1TbnnzKogZPg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 11/20] iio: accel: hid: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:34 +0100
Message-ID: <20250413103443.2420727-12-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new function allows us to perform debug checks in the helper to ensure
that the overrun does not occur. For this case, the length being provided
is already passed into the caller function so reuse that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 3214506d133d..2ff591b3458f 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -228,7 +228,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data,
 				 int len, int64_t timestamp)
 {
 	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, data, len, timestamp);
 }
 
 /* Callback handler to send event after all samples are received and captured */
-- 
2.49.0


