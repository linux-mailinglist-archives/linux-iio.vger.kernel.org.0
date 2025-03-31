Return-Path: <linux-iio+bounces-17432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E9A76576
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C323E7A344B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11191E3769;
	Mon, 31 Mar 2025 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joGhdd6S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B481E32CD
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423228; cv=none; b=atEyfYLmSXbCms4wxVX9z8xRpeXeFEXUmd9CONzOUcu3v/bCrk+Gm2ZhsCPUMw4wMWjJ6KiSVmWDkxO/et7KRMfeLhyKuXSZLmkIc2AaoK6m5hySrCEEmUU4L0EHWx83fSj5aIsXqD8I3sJnk+0k6oU6TZMqow6aH33mxm7TmYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423228; c=relaxed/simple;
	bh=6iPQidScwC0vjegJMlujed5SswG/grxVLRzfUxxCCdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXY6JXv6IszYDKyK2mQthVTOA59mF+2WIvaPB+uJa9Tn6XwPPtj96NYKTHnhJ/1WJAEIDc8jS6wCvg0A/cH6OIk3n0RRKhD9R7PncFkNRCa+0A4f32OqWi0VcWVKeGwQ3mqJ+ojL/bfSUVwQs2rYRw/0dihkUUBjZlrjuLeDCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joGhdd6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F02BC4CEE3;
	Mon, 31 Mar 2025 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423227;
	bh=6iPQidScwC0vjegJMlujed5SswG/grxVLRzfUxxCCdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joGhdd6S6LinKIjquXqWApQlU1HU688lmi3y7TLqkdhyCIKtURC++zdBvXyRQ1zzx
	 G1vHeU1IzlsxuwLTB7Ff35rXlko3VqvcwB2vOCNZSex0Aw+xTP/VRbTxwAEGoNlhwy
	 HI8VpoTdNSmNBMMMvBduxGDhOnpQTCZ+6GsZDwLHN1jROnGSvj2a7hp9kXU0/F31eC
	 sIIikkBA66nAS57Nv1n9kwHdfvqPZr89J2IOATdVUtYy2ftPuYVEIfX7ppb/16hW4O
	 OunRECalZMcwRgGVwyDSus9S0DAdRDspnc63gbKbAYvou0zRW7BQnvd5cevQJUjC+0
	 GnjNgHUECxEmQ==
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
Subject: [PATCH 02/37] iio: chemical: ccs811: Factor out handling of read of IIO_INFO_RAW to simplify error paths.
Date: Mon, 31 Mar 2025 13:12:42 +0100
Message-ID: <20250331121317.1694135-3-jic23@kernel.org>
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

Factor out the implementation of this part of read_raw() and use
guard() to allow direct returns, simplifying both error and non error
paths.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/ccs811.c | 72 ++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 451fb65dbe60..75b0cb05dd86 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -15,6 +15,7 @@
  * 4. Read error register and put the information in logs
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -214,6 +215,40 @@ static int ccs811_get_measurement(struct ccs811_data *data)
 	return ret;
 }
 
+static int ccs811_read_info_raw(struct ccs811_data *data,
+				struct iio_chan_spec const *chan,
+				int *val, int mask)
+{
+	int ret;
+
+	guard(mutex)(&data->lock);
+	ret = ccs811_get_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		*val = be16_to_cpu(data->buffer.raw_data) & CCS811_VOLTAGE_MASK;
+		return IIO_VAL_INT;
+	case IIO_CURRENT:
+		*val = be16_to_cpu(data->buffer.raw_data) >> 10;
+		return IIO_VAL_INT;
+	case IIO_CONCENTRATION:
+		switch (chan->channel2) {
+		case IIO_MOD_CO2:
+			*val = be16_to_cpu(data->buffer.co2);
+			return IIO_VAL_INT;
+		case IIO_MOD_VOC:
+			*val = be16_to_cpu(data->buffer.voc);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ccs811_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -226,42 +261,9 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		mutex_lock(&data->lock);
-		ret = ccs811_get_measurement(data);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			iio_device_release_direct_mode(indio_dev);
-			return ret;
-		}
 
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			*val = be16_to_cpu(data->buffer.raw_data) &
-					   CCS811_VOLTAGE_MASK;
-			ret = IIO_VAL_INT;
-			break;
-		case IIO_CURRENT:
-			*val = be16_to_cpu(data->buffer.raw_data) >> 10;
-			ret = IIO_VAL_INT;
-			break;
-		case IIO_CONCENTRATION:
-			switch (chan->channel2) {
-			case IIO_MOD_CO2:
-				*val = be16_to_cpu(data->buffer.co2);
-				ret =  IIO_VAL_INT;
-				break;
-			case IIO_MOD_VOC:
-				*val = be16_to_cpu(data->buffer.voc);
-				ret = IIO_VAL_INT;
-				break;
-			default:
-				ret = -EINVAL;
-			}
-			break;
-		default:
-			ret = -EINVAL;
-		}
-		mutex_unlock(&data->lock);
+		ret = ccs811_read_info_raw(data, chan, val, mask);
+
 		iio_device_release_direct_mode(indio_dev);
 
 		return ret;
-- 
2.48.1


