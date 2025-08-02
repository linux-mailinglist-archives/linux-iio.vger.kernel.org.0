Return-Path: <linux-iio+bounces-22207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2188CB18F74
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5047116BCB8
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D3246794;
	Sat,  2 Aug 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSLaXrGd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0E210FB
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153153; cv=none; b=oyYWM3BQLb2vcq4ikEsr2qLHMeAwphx5snpMj78tkFSflko2106OU7rhaRCU9guYUwIkUrWzj7ZHrDs9qPGlE1iJ7f2gOJ0+avheMzJ0ALoM0KlzAdMYmEqV4mPKkprRlBlEOXmwt8+SNyigovAAlYI5bbcxmNKkSl1rmkzDhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153153; c=relaxed/simple;
	bh=MkA1qC2k6CaGpClKU5IYAWPYCiWQiPXbOj65W6XvCWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tL60GybADTTbdDAQ0FJSlQV99UBZRdKD5ZFJwByef1tUZbmtNAUbsKAeRxdkSA48B5z8jhY3w81kb7FuvR2svo3p9oWcx/7tcoY0EcETKyPS8ehJmLrlEUOqX7/LZfLx4enAquLG8X42fdGQa2fJM+Ox6MfQ+NC5eqaxYFyQHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSLaXrGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8774C4CEEF;
	Sat,  2 Aug 2025 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153153;
	bh=MkA1qC2k6CaGpClKU5IYAWPYCiWQiPXbOj65W6XvCWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSLaXrGd2XMpY8Bgr7VYtEayhRrZ+cqQ1OEHHp3AUY6xfEGPbhmUIfQNKAGH0Cc/K
	 hqBMTbMUOQCYXnssQ2kQHmOG/FlcBndgRXVbtyOnI6J+CPHGHAdd9FouFIDAwe8BLB
	 G5kEY9ZwtGQ/YJ9+v+HWZPGHiPfB5CrUueGgKNQF3YS0kKdfMovZT6kfhrQ9eqKS+y
	 gR0mjC6rlmHTxFDhLMzWX8C+k64y5ujlt4IpQsSN/IWFKnDB34ylSuuruy8fLc80uv
	 2g4MEQbD9aWsZnI2NwqZm3sntldZlxC7CnZr0qBDci+rXWw8d5zirwCTUqG5J+JR1H
	 xwqANb7htzkTw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/16] iio: light: isl29125: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:29 +0100
Message-ID: <20250802164436.515988-10-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also move the structure used as the source to the stack as it is only 16
bytes and not the target of an DMA or similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/isl29125.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 6bc23b164cc5..3acb8a4f1d12 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -51,11 +51,6 @@
 struct isl29125_data {
 	struct i2c_client *client;
 	u8 conf1;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		u16 chans[3];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 #define ISL29125_CHANNEL(_color, _si) { \
@@ -179,6 +174,11 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29125_data *data = iio_priv(indio_dev);
 	int i, j = 0;
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u16 chans[3];
+		aligned_s64 timestamp;
+	} scan = { };
 
 	iio_for_each_active_channel(indio_dev, i) {
 		int ret = i2c_smbus_read_word_data(data->client,
@@ -186,10 +186,10 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto done;
 
-		data->scan.chans[j++] = ret;
+		scan.chans[j++] = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 		iio_get_time_ns(indio_dev));
 
 done:
-- 
2.50.1


