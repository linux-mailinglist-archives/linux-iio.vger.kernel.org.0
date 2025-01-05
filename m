Return-Path: <linux-iio+bounces-13902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF12A01AD8
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B58161DFF
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BDF15A864;
	Sun,  5 Jan 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAJvzoGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C198F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736097995; cv=none; b=Fb6rpAZCeVfJs9ANh3/H7ZPllZDCe+lbwTra9Evg4XnFQw/bKyfO/WXpjbWFyvc3DJpJvYWDMuDvO826CAC759A8Iw4Nv9pSEDvfOCgw5yapAi7m1w51oAzx5AbU0/HbTgHfERwSxhfHWddWvmDKFUNxuA5hB9LJwQNXNR6Jyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736097995; c=relaxed/simple;
	bh=aKpFi2CFiqxwRwNoe/t7d/hwfIUVBzlXfZDW199DHIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UalFnsH4Kc4Rt8YLvoENooWCGUfC7TSJN4Qv6j6UMta8MAkw1yEwQsKy0muKa08RovLSGgQq74z/oQeymP6VzsF35RJx3oy4vpZX5WrtO2uAv4PWDj8AlCXAmQvcPaLnCm6TCJ2CC5DycmwD0ogFs9TknukMSmXNwCVQer/8vIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAJvzoGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB05C4CED0;
	Sun,  5 Jan 2025 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736097995;
	bh=aKpFi2CFiqxwRwNoe/t7d/hwfIUVBzlXfZDW199DHIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAJvzoGtkMEP19awp6Rtna4bGzu2LCJuvefdfHWIova9Wm1xeOJ6fOICE3MgVepCZ
	 AxMLtCS/2Sqozd2r2UzH/UGG3lYHFPlK6eZt+f+74Ik9NATd+oQh9uKmOhT8pylr+Y
	 nz5Uhnt6s57MJw1/6W5gXTrjylkPgmzO1kJ2b0Yxx+26Qr2RImEkC7wvkB3CJDt3o0
	 WKURSzDyx3V+c4bjewuvAeF/1x3iagaE85Y0B0t91ZlUFyUPnBYrTqUUrrXJzuQVr0
	 CcE0U5RA0+JSEuqocaVTydzjAZOXAxB+SKthH2At7HkdpNMg/9ttIF5fBPJ7cp/a4b
	 0AIewNE/rgGQg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 03/27] iio: temperature: tmp006: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:48 +0000
Message-ID: <20250105172613.1204781-4-jic23@kernel.org>
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
 drivers/iio/temperature/tmp006.c | 33 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 7beaabc9ecc7..4b3a90538eec 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -85,19 +85,25 @@ static int tmp006_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (channel->type == IIO_VOLTAGE) {
 			/* LSB is 156.25 nV */
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = tmp006_read_measurement(data, TMP006_VOBJECT);
-				if (ret < 0)
-					return ret;
-			}
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+
+			ret = tmp006_read_measurement(data, TMP006_VOBJECT);
+			iio_device_release_direct(indio_dev);
+			if (ret < 0)
+				return ret;
+
 			*val = sign_extend32(ret, 15);
 		} else if (channel->type == IIO_TEMP) {
 			/* LSB is 0.03125 degrees Celsius */
-			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-				ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
-				if (ret < 0)
-					return ret;
-			}
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+
+			ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
+			iio_device_release_direct(indio_dev);
+			if (ret < 0)
+				return ret;
+
 			*val = sign_extend32(ret, 15) >> TMP006_TAMBIENT_SHIFT;
 		} else {
 			break;
@@ -142,9 +148,8 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
 		if ((val == tmp006_freqs[i][0]) &&
 		    (val2 == tmp006_freqs[i][1])) {
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret)
-				return ret;
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
 
 			data->config &= ~TMP006_CONFIG_CR_MASK;
 			data->config |= i << TMP006_CONFIG_CR_SHIFT;
@@ -153,7 +158,7 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 							   TMP006_CONFIG,
 							   data->config);
 
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 	return -EINVAL;
-- 
2.47.1


