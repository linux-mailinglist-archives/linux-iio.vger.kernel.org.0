Return-Path: <linux-iio+bounces-16633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E4A58726
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64918188C228
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F91FDE39;
	Sun,  9 Mar 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuebzfDo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD11FC0E7
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544518; cv=none; b=lwofXI71iP6Bgw/dxR+kbt5C4BYYhVHkWbtvp4S7bJislqgHDjHQjHlr8cclefUsth/DLRg9x+3qkWbgpTTFI+Af0kyBn42iYWHN/ZLYs225t5Kft3vxsAKzm+sGMiF9Hn7bqua82ex6kjd7/NSZf9xXrfynbLR1O7GyfRN7zSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544518; c=relaxed/simple;
	bh=xBvx3rKrC2Gb5r13A8O3J4xicklYvapnAWSGKlPs8K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAxPVRNnZjhRDillNTjkfb2DIXFEReYPoA8Gm+k0+ZCzEP40/LzDLmpHEA0PB+8zn1CCCP9PbieC++VF6AeSFUn1IQShfp62eUTxQK8EoY5HUTqZLQq1tthrA1vFvlk+v22IoI5/KPTs7SDLm/Tcaz5MNYNheQGtD8E/xnUl4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuebzfDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD36C4CEE5;
	Sun,  9 Mar 2025 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544515;
	bh=xBvx3rKrC2Gb5r13A8O3J4xicklYvapnAWSGKlPs8K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuebzfDosMByXFRPd3++0O4clpQJ4X1qu/1S7D27BzP3ApXYhOIE4QqOVWt++9d5S
	 BQfbFa/wPjSUqXm+fWQhxLgkiK+5UkkApCOmQBG3lgk8f9Piyeks9j2kkHSfPctTXv
	 2Tjh8K6Te/SGB0L4f5GRUOjb7fnTnErxMhxbXyY7o3LcnUroS0Frf+TxXHH5g3kd4g
	 +JXM++CrKIhHPYoySr+zv5dKqCdMIjibb3djqHG5RCNBbsRPizrESuhliNNBqjfbBC
	 w88nH8ZbsinlheCurfqLCwg3bThMP6s2qk/3QGa6aLNOfC4BnW1/wsfSZxaVgmu3S6
	 r1ayk3csVKPIg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/16] iio: accel: hid: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:51 +0000
Message-ID: <20250309182100.1351128-8-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309182100.1351128-1-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
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
2.48.1


