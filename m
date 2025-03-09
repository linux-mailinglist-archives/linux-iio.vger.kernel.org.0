Return-Path: <linux-iio+bounces-16623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBDAA5860B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEAA188C012
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED11E51FC;
	Sun,  9 Mar 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="comrTFty"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1711D8DFE
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540076; cv=none; b=rvhwj81DpOrJO8gnOSBpU5+waa+ztpnn3MENbRHvS2DcHcAzNZDvaBEabVybpaxRvOC4nLQmS6Pc0AvMj1j+al+aPaHUwXc1xG/aBHA56U7VhlQkEVEm053GQth6yjZWoykggVX7XShoTG0D7K8CcSLp0+e4EZcBVsimghQLMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540076; c=relaxed/simple;
	bh=2v0OsbW7CxsBMBIHAD4v0g3/l3HGruF7af11l21SRds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtaRtM3CcUSK3IfY0fEamMkS3YC9sRJeVr33I9tmmrZlkELJUSupSRg+jyBYvTwcHcTgEKWe7H/Y6Sc/6NayFblEW/OP3t8crWAwQepaojoEXuEEEddwHH9spCPz6t8m3QxuTeSTez6047JLdrTjdQKUOE+NhbAtQ/hNCThDMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=comrTFty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC02C4CEE5;
	Sun,  9 Mar 2025 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540075;
	bh=2v0OsbW7CxsBMBIHAD4v0g3/l3HGruF7af11l21SRds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=comrTFtyC2gU1FrsFlb21KwnWyALUGujf2L9C5aEqkWnbu4YfzdAh9D8a9p0y2vrL
	 2t1JCxzSPLmj4R5LLz7NQz5VmFt6tqc18KkGpxSSytPUZVlLZ30UOFpRRjzJBzCrSc
	 0Z4jmbMoANgEhHuDb83No9IKd8xctgNZbTHXUjNpJd4koxgycvOnzDuPz9wPLUzm9j
	 IIvRMPhxnEVfTI4ksTuzu8QNjINdGJYc+MtLumISHcwwq+/3/Axbnz0WFuD4foAwlb
	 cb0VyGcrkGNqC90oB6ZokpHkz4evRTCp52o/M3zNfOlKcyrsyax75B+JxJHq08diBi
	 x4k1RKHjoBDqg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 17/18] iio: light: vcnl4000: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:32 +0000
Message-ID: <20250309170633.1347476-18-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Also split the enabling and disabling of thresholds into separate
functions given overlap is small.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 78 +++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e19199b17f2e..d7489bee2dff 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1084,9 +1084,8 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		/* Protect against event capture. */
 		if (vcnl4010_is_in_periodic_mode(data)) {
@@ -1096,7 +1095,7 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
 						mask);
 		}
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
@@ -1157,9 +1156,8 @@ static int vcnl4010_write_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	/* Protect against event capture. */
 	if (vcnl4010_is_in_periodic_mode(data)) {
@@ -1183,7 +1181,7 @@ static int vcnl4010_write_raw(struct iio_dev *indio_dev,
 	}
 
 end:
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
@@ -1410,46 +1408,52 @@ static int vcnl4010_read_event_config(struct iio_dev *indio_dev,
 	}
 }
 
-static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool state)
+static int vcnl4010_config_threshold_enable(struct vcnl4000_data *data)
 {
-	struct vcnl4000_data *data = iio_priv(indio_dev);
 	int ret;
-	int icr;
-	int command;
 
-	if (state) {
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+	/* Enable periodic measurement of proximity data. */
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
+					VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN);
+	if (ret < 0)
+		return ret;
 
-		/* Enable periodic measurement of proximity data. */
-		command = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
+	/*
+	 * Enable interrupts on threshold, for proximity data by
+	 * default.
+	 */
+	return i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
+					 VCNL4010_INT_THR_EN);
+}
 
-		/*
-		 * Enable interrupts on threshold, for proximity data by
-		 * default.
-		 */
-		icr = VCNL4010_INT_THR_EN;
-	} else {
-		if (!vcnl4010_is_thr_enabled(data))
-			return 0;
+static int vcnl4010_config_threshold_disable(struct vcnl4000_data *data)
+{
+	int ret;
 
-		command = 0;
-		icr = 0;
-	}
+	if (!vcnl4010_is_thr_enabled(data))
+		return 0;
 
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
-					command);
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
 	if (ret < 0)
-		goto end;
+		return ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, icr);
+	return i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
+}
 
-end:
-	if (state)
-		iio_device_release_direct_mode(indio_dev);
+static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool state)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return ret;
+	if (state) {
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = vcnl4010_config_threshold_enable(data);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	} else {
+		return vcnl4010_config_threshold_disable(data);
+	}
 }
 
 static int vcnl4010_write_event_config(struct iio_dev *indio_dev,
-- 
2.48.1


