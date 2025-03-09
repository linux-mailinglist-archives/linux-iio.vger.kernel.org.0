Return-Path: <linux-iio+bounces-16612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E568A58600
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA30188C451
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E191DF742;
	Sun,  9 Mar 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/QVmkcT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADD2AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540031; cv=none; b=RQ/86VOGy4SWQs1Ci9vEt5ANYCEZY1j2GTLXLF62ILZGFkwhMxBdwy1lT4muDRgM0EC7RWoR3clWUNO5emexyYIzUDWUVUmS/IkLfGRJuI+BcJ23/v+FYvldhB3Yo8JTF9HHz3Mqpokda7Ahi9WSgTJSuOYfwEA3KlrBRYmm66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540031; c=relaxed/simple;
	bh=aCIS8qvgFsE0d2xX4T35R8qNwCq0XunWzEx8tKpB2EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttbfAPngETnjRZTTewa/0rPUUjZdL8mTGVzGOlKH/hlh8vW4nMc8LnXXWpToAK4d5qUjNTgFbjN75IXZiKdRsLKY5XBAOWt/hbdJnbyq4gjuGtlpx312l/Z7SajzWZEXsaZ44ZTAkNeBeJvjkbalWGkrjplzADbcq/xeuLLOwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/QVmkcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747EEC4CEE3;
	Sun,  9 Mar 2025 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540029;
	bh=aCIS8qvgFsE0d2xX4T35R8qNwCq0XunWzEx8tKpB2EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/QVmkcTe/V4G39NJs8k9USvIxrCaBPdf3OVNcI1FAa0ZpKuXzGL81mF5NML7vONw
	 LL9AMxWh87cXmsopTBT9owGtZeBOz34+RJ678FKzf3IUEnq8QCwMjS8xJhBizNeiMX
	 Gbi9gFkWm1iivTQBWL9vWkjemz1/uunOmocrF+wbtV2k2NUsKKQJzqsPuPu15Uk1dH
	 zYIyF0DQgJZ7Qrg9Ts6295em+e8Bjtwuhqxts9jPp3TXF3nt5gnqW01XnCjf+PbkRx
	 7NLie/eEZXbZn5blEN5WBQ1sPRBkWWx4gWD4GrQvBvoz23zaSV87XaF5AaX76eZ3NO
	 aHz6ReNTdiaYg==
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
Subject: [PATCH 06/18] iio: light: ltr501: Factor out IIO_INFO_RAW leg of read_raw() callback.
Date: Sun,  9 Mar 2025 17:06:21 +0000
Message-ID: <20250309170633.1347476-7-jic23@kernel.org>
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

Factoring this code out allows for direct returns, simplifying code flow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 55 +++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 669da0840eba..b42df15b36e1 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -646,6 +646,36 @@ static const struct iio_chan_spec ltr301_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static int ltr501_read_info_raw(struct ltr501_data *data,
+				struct iio_chan_spec const *chan,
+				int *val)
+{
+	__le16 buf[2];
+	int ret;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		ret = ltr501_read_als(data, buf);
+		mutex_unlock(&data->lock_als);
+		if (ret < 0)
+			return ret;
+		*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
+				   buf[0] : buf[1]);
+		return IIO_VAL_INT;
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		ret = ltr501_read_ps(data);
+		mutex_unlock(&data->lock_ps);
+		if (ret < 0)
+			return ret;
+		*val = ret & LTR501_PS_DATA_MASK;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ltr501_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -679,30 +709,7 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		switch (chan->type) {
-		case IIO_INTENSITY:
-			mutex_lock(&data->lock_als);
-			ret = ltr501_read_als(data, buf);
-			mutex_unlock(&data->lock_als);
-			if (ret < 0)
-				break;
-			*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
-					   buf[0] : buf[1]);
-			ret = IIO_VAL_INT;
-			break;
-		case IIO_PROXIMITY:
-			mutex_lock(&data->lock_ps);
-			ret = ltr501_read_ps(data);
-			mutex_unlock(&data->lock_ps);
-			if (ret < 0)
-				break;
-			*val = ret & LTR501_PS_DATA_MASK;
-			ret = IIO_VAL_INT;
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
+		ret = ltr501_read_info_raw(data, chan, val);
 
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
-- 
2.48.1


