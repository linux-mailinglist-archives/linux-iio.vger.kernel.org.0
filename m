Return-Path: <linux-iio+bounces-17699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6476AA7CF24
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114EA3A73AE
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30518BB8E;
	Sun,  6 Apr 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFmC2aRU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4491487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960050; cv=none; b=Hl+jwUnuz/k88I7fSqHQaF9l5ayUzCMQLOn6X5hDGBvj/DYZ+MAPQSD6PxNL64XDRZOUZ/FUnkAQuoGGAA6yWY5YyipCcxqEAs4AUQukPLbYphfT+ANUSKSvjRLYFdTlKT6zVtMYpUFs4KdTB09mZjy0YBTT2GjgatGqX9f2bXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960050; c=relaxed/simple;
	bh=fNUFePM3b7ToKpeytHsJCtcpgi5vxQ2ucK/nslPCPcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxiX+TWjfALaknhNrd1tSgWIgVF7bpKX/jgXzZPkX+cXiFDCsF4FmExw8VKgdPPRfSPFc1GED/W7fD72MFGq667LUAHXZgzURb4SsLZtgZWCQueLQUMpHiw8fhHTcVxARavIcMu4Wpwh3RRCqhRk+rgumQKfsLCFZnhD9xHotuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFmC2aRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A0DC4CEE3;
	Sun,  6 Apr 2025 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960049;
	bh=fNUFePM3b7ToKpeytHsJCtcpgi5vxQ2ucK/nslPCPcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFmC2aRUMFWJn9f306nawkEB8iP9oDAT3wh5JdWzf7l3O1DrUzPSwPebAim3/KuiH
	 06Z3cmzojL28jAC1++Y6AvdWdE/I2mfN6sOUJwSyxQSfU47BsjCg5D4chMTvajKj2H
	 lX5KhwCUcnNBgb86mIZcwAN44tO+QJyskeq8Lp4VqyteWdXaV7pT2oZ9mvfJPjU+1P
	 74kTCiZUbKadi8OOb8oM/kehMVX7uAzk3NR53NbW1Wt8ON3+fWg7rZNSBxl+BRdq2c
	 tDsrNefwQcjGznI25u891PTIHu9NA6bEdpPCRqS++iYxwtFCARP+yLVDVFrbJB772W
	 RVbMRyJYPKxeQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 11/20] iio: accel: hid: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  6 Apr 2025 18:19:52 +0100
Message-ID: <20250406172001.2167607-12-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
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
index 078fab2abb68..fe3ef3592e91 100644
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


