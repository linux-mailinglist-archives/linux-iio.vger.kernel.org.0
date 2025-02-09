Return-Path: <linux-iio+bounces-15197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABBA2DFBB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16982164EB2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E91E0DE3;
	Sun,  9 Feb 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA6c5juv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61E1E131B
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124431; cv=none; b=eDwrFZ2JUcIgNxqwN9dolip/KcoALpOXJw84KNOgyRyF9pyTCGHI4uPljjiGMpEDRlRsyvidIA+b31uPGo0j3tYvgNhHfO0Oajh6M/5BtXx8MtvM3HAmk/oqyQLGBt5oASwG06XjdQtBQRT2c9xYmk9TEI/ESI3BEnd45Viz4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124431; c=relaxed/simple;
	bh=OM2Rk3PF+V8cR1qNXas+EjCz5a6Nm5ozRcl4dNshXsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTpBbU8MEuEwS3ZBVKdofOhtNobJ2N8hjD7lCHpxXV6C1TFMwQQr9a70fCgGoNIAxR6mS26ncfsjlOb1k5B6a9qcMPzubhTz7FLHvBhDRBXlg6Z8PnD21LnilLLpFmICqeIzWHC6C51Du6s4lG2cBkKJuGBdDFMioCdB+eBiWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA6c5juv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87369C4CEDD;
	Sun,  9 Feb 2025 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124431;
	bh=OM2Rk3PF+V8cR1qNXas+EjCz5a6Nm5ozRcl4dNshXsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA6c5juvwOj5M6uQ7rGT9PsAE3+mKh5hQv9ne1OTFDfFHihIWIhbCthEJKhSTXiCL
	 jTzrv6MXFRqm6BSWLlnMMOWMT5QKizen6Tv046GVRXs2WZPctjDp7hIgMd6GnT0vff
	 31ETyXAzgK3i4ty4p+W4u34vwg1nJFyh1DUh0bdSMX3b2RUpYfibjNXTZ4oEGPkAgB
	 QfYDss50jghWSEpcRdIntxplMmoYrMgzzDopZei0dDzzbDswC8M3Z0rIaPF4JBYTW3
	 c3WPa6sMcUUmWik2o19DVBEvN8Y3aMN0Z/ky/Jtib4DhpsQxUQ/jKk9KUZy+r5a1Pu
	 gE8PC0lswzrLg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 04/27] iio: temperature: tmp006: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:01 +0000
Message-ID: <20250209180624.701140-5-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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

Cc: Antoni Pokusinski <apokusinski01@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/tmp006.c | 33 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 1998047a1f24..b5c94b7492f5 100644
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
2.48.1


