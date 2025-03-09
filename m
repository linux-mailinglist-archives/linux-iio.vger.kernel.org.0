Return-Path: <linux-iio+bounces-16614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49853A58602
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16383A1C23
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9141DFE0A;
	Sun,  9 Mar 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBy9LhwO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0222AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540039; cv=none; b=SVFzV4Wt00pu0oyZ2NSn+NZ7Sa0S29tIu7jCIxs4rCIa3k4lxKJWe6Cg3bnvGyKiE57oR/ssnZaV36hSUdfgWYRPU1/PskuI/ZHW57R9uTcwS/KhDJ7M713G5FtYruGB2qL814UvlpfQEa0eaVrF3Nfw6GprLW/fv5rFHitoqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540039; c=relaxed/simple;
	bh=9jKDp5d8Bu+EFeg0vWzLuK9kfEjqSuXuIQktGx8eX/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G85sFddnz3qt5J2ealeK3phx1VfBBWQahycdaxWKoNrmPrx01xNWEhuTND1ouaQXtQWyYSo/pbSbQVhZ/S+vytbvA6WwXRduYqW9lJTTicXwOFcWewdS38zxH/rUP0FROybXZ3I7yw5fIp+aYJCmmJUTk8utZsJeOm1LIwByEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBy9LhwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F542C4CEE3;
	Sun,  9 Mar 2025 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540038;
	bh=9jKDp5d8Bu+EFeg0vWzLuK9kfEjqSuXuIQktGx8eX/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBy9LhwOKRN/URbur3VhQydA34t214mDMdWm9Rb3WPjfN6zrVfcrkQDMKEuUZWEgG
	 +HJsaMv5eY1gMVuQDzs8jh/3sPKyLHXHDRcLLB87CY0VcA7GiTNQ21mzE+kQVe65hP
	 o+etM/ksVw2REjW7qYt6wQjTIiOegshkZ/FuemtuX4YG6CVg/VTvxebjO2WTKU3G3m
	 LbA0hK15wf+vSoVhP28C3VytQypwCFDwwUqNgvmFTk6NJ83EfoToEclnUK/8+nyAVE
	 I1/Q6V1Y9rZ2DJN4jORj3uGXigK/j0VdWve/J2vMBTkH3jDaR6OiuSzPl2i3GN8UoB
	 aBCNG2nkQhDSw==
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
Subject: [PATCH 08/18] iio: light: ltr501: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:23 +0000
Message-ID: <20250309170633.1347476-9-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index c44c852a7d76..23fd0713c64b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -688,14 +688,13 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_LIGHT:
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
 
 			mutex_lock(&data->lock_als);
 			ret = ltr501_read_als(data, buf);
 			mutex_unlock(&data->lock_als);
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			if (ret < 0)
 				return ret;
 			*val = ltr501_calculate_lux(le16_to_cpu(buf[1]),
@@ -705,13 +704,12 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ltr501_read_info_raw(data, chan, val);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -870,13 +868,12 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = __ltr501_write_raw(indio_dev, chan, val, val2, mask);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
-- 
2.48.1


