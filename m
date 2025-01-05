Return-Path: <linux-iio+bounces-13925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55DBA01AEF
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CB3A2E9C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915BE19066D;
	Sun,  5 Jan 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJodWHFi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1D8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098051; cv=none; b=ULPnzKJQOn7OrFRd5MuzJ9T0UYi94/qsbPG7UuEdqjN/e3dttzMQi1mOQlbQfDW+GeZCPxhxF24q4ike+29JAhnP3/Xhx/1aIF5rBD/WTbJRR7V+2uGpHGAWv+Cj4rnWHqERpvcHYQ/iF/XJzTV0xvqRWSZrLNamlLJQ6Um3g9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098051; c=relaxed/simple;
	bh=WgmCfcR6LyM/e7GGfwpOhveZgaF8JMYRnrXccjs4AMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmwvtvxsFN+tzGv4fLMaqyaiWQryi6W1VLmPBt8+DJKUnAdZCwUqIgDy9ufEV/OqnFLe5RtJseclqsH+D6rZJg7W2DfSRjsi6cTz2S+wu2nsgk1BWoSGJZO4l0T2vD3HrenEZ4Aqb7TUNcxu59u3esu2+RdFVm0jL2AAI+2d3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJodWHFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB96C4CEDD;
	Sun,  5 Jan 2025 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098051;
	bh=WgmCfcR6LyM/e7GGfwpOhveZgaF8JMYRnrXccjs4AMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJodWHFiAx91aPo/urevp6Y/wpHe4UEEPBUZbK5HHVB7zkRKuO17aXr8R9USVRlj7
	 G40lGaTk4ss//Mggtt5+/0stDgeIybgitXslx+nxMKqXEkPIi32TtnAAtDzygoc6d8
	 8NL9xJbfv9DCP5OebFZht6FD2jM8LX7YVer7DRYMofUVEv7ycMQTIPtYQs8FRFu3Sw
	 RB7+tRq32MUB1Pg4bWrpAYgQjQ60iPaa28P1etp5txFha58XYBGgtFkvptZHtMn6D5
	 fUQD8jJGtKP9AXsyX1UnUzagnALQVI1LMUtJ5GTiyg+hd67pgxphh85UKRC51kQmDl
	 kOkrKIogasPhA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 26/27] iio: imu: bmi323: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:11 +0000
Message-ID: <20250105172613.1204781-27-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 51 +++++++++++++++++-----------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 7f386c5e58b4..4c404e44a3f4 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1702,26 +1702,36 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
 			    int val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return bmi323_set_odr(data,
-					      bmi323_iio_to_sensor(chan->type),
-					      val, val2);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
+				     val, val2);
+		iio_device_release_direct(indio_dev);
+
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return bmi323_set_scale(data,
-						bmi323_iio_to_sensor(chan->type),
-						val, val2);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
+				       val, val2);
+		iio_device_release_direct(indio_dev);
+
+		return ret;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return bmi323_set_average(data,
-						  bmi323_iio_to_sensor(chan->type),
-						  val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = bmi323_set_average(data, bmi323_iio_to_sensor(chan->type),
+					 val);
+		iio_device_release_direct(indio_dev);
+
+		return ret;
 	case IIO_CHAN_INFO_ENABLE:
 		return bmi323_enable_steps(data, val);
 	case IIO_CHAN_INFO_PROCESSED: {
@@ -1747,6 +1757,7 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1755,10 +1766,12 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_ANGL_VEL:
-			iio_device_claim_direct_scoped(return -EBUSY,
-						       indio_dev)
-				return bmi323_read_axis(data, chan, val);
-			unreachable();
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+
+			ret = bmi323_read_axis(data, chan, val);
+			iio_device_release_direct(indio_dev);
+			return ret;
 		case IIO_TEMP:
 			return bmi323_get_temp_data(data, val);
 		default:
-- 
2.47.1


