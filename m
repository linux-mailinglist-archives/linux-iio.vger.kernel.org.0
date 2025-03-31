Return-Path: <linux-iio+bounces-17466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AABFA765A1
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FDE16A295
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C546C1E51F5;
	Mon, 31 Mar 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx4sQHh8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662F1E51F3
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423442; cv=none; b=Ejp49fhEKEm1r40UovprgVNYdBeb7onCjXSlbJA4b3FOGXXJ3JiFFgC6/U+Vo0xov9fHGNhJvn8qCIx9nwhQQPTwPP1O/r04uJR/xTsXZEOecO8QTi1KspzTxBWcPATj0nByBLEcuQju3ZHXrngCgnOC/R5AtDfsqa1hRdOrWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423442; c=relaxed/simple;
	bh=DHd94nGDnYSPb9QKvVExslBDhfDX6ifKjxIsWc983VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REOgFD3114F06WKILTlUykVfFAEV2Cp9WXKNOfycPJx+0Jn2xft0q2xb6vH/pVM0h0qbp4Hyzp9t1NUt0or0/buWZO6CQ2s+nMIaCZ5GbAtYVJzmFLWKD5fELve8AlQjeu88mnGVOe6o79cv2YjHr2VhSSjGyEsUiugJF1vcfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx4sQHh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63157C4CEE3;
	Mon, 31 Mar 2025 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423442;
	bh=DHd94nGDnYSPb9QKvVExslBDhfDX6ifKjxIsWc983VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fx4sQHh89jJw2QdrxGxe3yiv30Dhn+BnuXoi2QJMy9jlCE3BxRc7YLRUOW3rkhAzz
	 57sWHzqTqGxrbnmvEFBetU2oq3AD2O28XQOBAaIBd7W2I0x2eRctMRdr9F6HgG0OSZ
	 1FoOvz1xuuy3w9Ex0XteV3StTZm23f+mSufbAE6e3JOGCbYAOMT6VtVz/4aQq8zkp9
	 1JxUkRi6fVhLZRw2uZEF4eWgFjlnS9P+LsxwkBp5Ebqdlc5irNez7hdTD2LzKh4fJv
	 3jF+C5xREUwpmCCns+dnJOpSZkr6laKuwLICUAUpyRMVSVUMKberEht2WP/rEeAWCp
	 UsLSjYKPFCTKQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 36/37] staging: iio: ad5933: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:16 +0100
Message-ID: <20250331121317.1694135-37-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 38 ++++++++++---------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d5544fc2fe98..5aaa43e94c52 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -271,11 +271,12 @@ static ssize_t ad5933_show_frequency(struct device *dev,
 		u8 d8[4];
 	} dat;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	ret = ad5933_i2c_read(st->client, this_attr->address, 3, &dat.d8[1]);
-	iio_device_release_direct_mode(indio_dev);
+
+	iio_device_release_direct(indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -305,11 +306,12 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
 		return -EINVAL;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	ret = ad5933_set_freq(st, this_attr->address, val);
-	iio_device_release_direct_mode(indio_dev);
+
+	iio_device_release_direct(indio_dev);
 
 	return ret ? ret : len;
 }
@@ -384,9 +386,9 @@ static ssize_t ad5933_store(struct device *dev,
 			return ret;
 	}
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD5933_OUT_RANGE:
@@ -438,7 +440,8 @@ static ssize_t ad5933_store(struct device *dev,
 	}
 
 	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
+
+	iio_device_release_direct(indio_dev);
 	return ret ? ret : len;
 }
 
@@ -506,9 +509,9 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
 		ret = ad5933_cmd(st, AD5933_CTRL_MEASURE_TEMP);
 		if (ret < 0)
 			goto out;
@@ -521,7 +524,8 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 				      2, (u8 *)&dat);
 		if (ret < 0)
 			goto out;
-		iio_device_release_direct_mode(indio_dev);
+
+		iio_device_release_direct(indio_dev);
 		*val = sign_extend32(be16_to_cpu(dat), 13);
 
 		return IIO_VAL_INT;
@@ -533,7 +537,7 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 
 	return -EINVAL;
 out:
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
-- 
2.48.1


