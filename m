Return-Path: <linux-iio+bounces-1024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D6816141
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B091C20ECE
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD446456;
	Sun, 17 Dec 2023 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/8YNEAV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E401DFD8
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7456DC433C7;
	Sun, 17 Dec 2023 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834576;
	bh=lleMsw8MDdn7Tb0CXj4Iu6NIDefpKUPjO3HgQRi+ulM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/8YNEAVDbuLz78+G3rNdknUzPJ8XlsJmZnYvN889oFI5p3mARniCVcHSIp/XFVN2
	 t5G6FsBrNXXHDBFeWbtttprhJSSz2cDBgOo1rMpAPze2MRlrE8vrf7bHCYMCIGccu3
	 +96/coaspoly7TqRK5OT+KB2dfVVGsBGJFw022MInSdocbgNpVPIQ1PYMAORo9HKWe
	 K0GFangHpsgrN7P8hVcaoi62bbxzagrjJ+TXYh1gb/eAQpPyI2VmHmn/Tlg748ymn+
	 6eFwxZMjEpdi+36GuOP+W4nTcGVoJrZ2jfxYEZnNTBwayjjtYP8Ws1e0TbuzEMcjvA
	 RRAxDhgAULsSA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 04/10] iio: imu: bmi323: Use cleanup handling for iio_device_claim_direct_mode()
Date: Sun, 17 Dec 2023 17:35:42 +0000
Message-ID: <20231217173548.112701-5-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217173548.112701-1-jic23@kernel.org>
References: <20231217173548.112701-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Similar to existing use of guard() in this driver,
iio_device_claim_direct_scoped() will ensure that scope based cleanup
occurs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 53 ++++++++++------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 183af482828f..6a7da517d8c6 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1672,33 +1672,23 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
-				     val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return bmi323_set_odr(data,
+					      bmi323_iio_to_sensor(chan->type),
+					      val, val2);
+		return -EINVAL;
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
-				       val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return bmi323_set_scale(data,
+						bmi323_iio_to_sensor(chan->type),
+						val, val2);
+		return -EINVAL;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = bmi323_set_average(data, bmi323_iio_to_sensor(chan->type),
-					 val);
-
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return bmi323_set_average(data,
+						  bmi323_iio_to_sensor(chan->type),
+						  val);
+		return -EINVAL;
 	case IIO_CHAN_INFO_ENABLE:
 		return bmi323_enable_steps(data, val);
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1724,7 +1714,6 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1733,14 +1722,10 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_ANGL_VEL:
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
-
-			ret = bmi323_read_axis(data, chan, val);
-
-			iio_device_release_direct_mode(indio_dev);
-			return ret;
+			iio_device_claim_direct_scoped(return -EBUSY,
+						       indio_dev)
+				return bmi323_read_axis(data, chan, val);
+			return -EINVAL;
 		case IIO_TEMP:
 			return bmi323_get_temp_data(data, val);
 		default:
-- 
2.43.0


