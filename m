Return-Path: <linux-iio+bounces-17443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D72A76584
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B048716992B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B51E3DFC;
	Mon, 31 Mar 2025 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+PmDPCr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFC1E3DC8
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423298; cv=none; b=nV79kGzvlZoZzxLxNprX6F8VFyH+BpHAjshl79jbxztT/dM7KR+KXG55f0qozJF7kCFuNGCi1dN5zVoFiDWWDDFvFdlpIonxCrpWYjxOBLwZ1GdWRtgc0wlkgKezFL65TA4triL11bzolaO0TkaUfjn/JY2++k8j+Utb3MnG6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423298; c=relaxed/simple;
	bh=0DAhGbMUnpRdCeGbudpqzFmD25sMNs0GOAoM2aWccSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG46Uvve9Pic8P/VAXSO/qMQt0KWY+t3pJze/YuTNM/eHsIkR1E3FF5VYSuHB9KNk4RBghfjCZO/AH+BQHlEE4GD6SjSubB2K3MyIKA7/vvewTRnl4lRoPHm0JPXfGdm4twlbWCBfRphG9wQPhWSaYcVjmLEtyK2BKD42ljWr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+PmDPCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE56C4CEE3;
	Mon, 31 Mar 2025 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423296;
	bh=0DAhGbMUnpRdCeGbudpqzFmD25sMNs0GOAoM2aWccSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+PmDPCr9mUwg9N95JKx4gS0XfGjEc8WIWqstYzA4VWx0PNMm52A0VXBf1y1hWYdb
	 lHJBRTLoSwkPhNt89V4d8tZPbVzVnRAYif7+uhypxBI9VwQyAzbUxzTaywNGt3uzTx
	 xLYlwgmiC0lTNkhq4jJidM1klXVil5gbYzJqNSn7wftvbOMZ+qX2Sc2RJYf1szYXFu
	 MB7JLjqQ6W5Yf1EyCgZXFNR8PICE6QsU17o8VoLWwq7HATQxqoHNBzgegnJGHAYJpo
	 g0UR8hH7uW+AY3jni49RcHmX+7t1ZG85uPHafSkWo7OCQiL/fdGFIVtLmcZ6tthkbx
	 sEnbnBkgLZpbQ==
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
Subject: [PATCH 13/37] iio: humidity: hts211: Factor out everything under direct mode claim into helper functions.
Date: Mon, 31 Mar 2025 13:12:53 +0100
Message-ID: <20250331121317.1694135-14-jic23@kernel.org>
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

Pulling out the functionality of read_raw() and write_raw() callbacks
so that only the mode claim is done in the initial call allows for
direct returns and simpler error handling in the new __hts211_write_raw()
/ __hts211_read_raw() functions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/hts221_core.c | 89 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 0be11470730c..ca4746f2ecba 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -418,31 +418,22 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
 	return IIO_VAL_INT;
 }
 
-static int hts221_read_raw(struct iio_dev *iio_dev,
-			   struct iio_chan_spec const *ch,
-			   int *val, int *val2, long mask)
+static int __hts221_read_raw(struct iio_dev *iio_dev,
+			     struct iio_chan_spec const *ch,
+			     int *val, int *val2, long mask)
 {
 	struct hts221_hw *hw = iio_priv(iio_dev);
-	int ret;
-
-	ret = iio_device_claim_direct_mode(iio_dev);
-	if (ret)
-		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = hts221_read_oneshot(hw, ch->address, val);
-		break;
+		return hts221_read_oneshot(hw, ch->address, val);
 	case IIO_CHAN_INFO_SCALE:
-		ret = hts221_get_sensor_scale(hw, ch->type, val, val2);
-		break;
+		return hts221_get_sensor_scale(hw, ch->type, val, val2);
 	case IIO_CHAN_INFO_OFFSET:
-		ret = hts221_get_sensor_offset(hw, ch->type, val, val2);
-		break;
+		return hts221_get_sensor_offset(hw, ch->type, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = hw->odr;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
 		u8 idx;
 		const struct hts221_avg *avg;
@@ -452,62 +443,72 @@ static int hts221_read_raw(struct iio_dev *iio_dev,
 			avg = &hts221_avg_list[HTS221_SENSOR_H];
 			idx = hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
 			*val = avg->avg_avl[idx];
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_TEMP:
 			avg = &hts221_avg_list[HTS221_SENSOR_T];
 			idx = hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
 			*val = avg->avg_avl[idx];
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 	}
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	iio_device_release_direct_mode(iio_dev);
-
-	return ret;
 }
 
-static int hts221_write_raw(struct iio_dev *iio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int hts221_read_raw(struct iio_dev *iio_dev,
+			   struct iio_chan_spec const *ch,
+			   int *val, int *val2, long mask)
 {
-	struct hts221_hw *hw = iio_priv(iio_dev);
 	int ret;
 
 	ret = iio_device_claim_direct_mode(iio_dev);
 	if (ret)
 		return ret;
 
+	ret = __hts221_read_raw(iio_dev, ch, val, val2, mask);
+
+	iio_device_release_direct_mode(iio_dev);
+
+	return ret;
+}
+
+static int __hts221_write_raw(struct iio_dev *iio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, long mask)
+{
+	struct hts221_hw *hw = iio_priv(iio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = hts221_update_odr(hw, val);
-		break;
+		return hts221_update_odr(hw, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = hts221_update_avg(hw, HTS221_SENSOR_H, val);
-			break;
+			return hts221_update_avg(hw, HTS221_SENSOR_H, val);
 		case IIO_TEMP:
-			ret = hts221_update_avg(hw, HTS221_SENSOR_T, val);
-			break;
+			return hts221_update_avg(hw, HTS221_SENSOR_T, val);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
+
+static int hts221_write_raw(struct iio_dev *iio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(iio_dev);
+	if (ret)
+		return ret;
+
+	ret = __hts221_write_raw(iio_dev, chan, val, mask);
 
 	iio_device_release_direct_mode(iio_dev);
 
-- 
2.48.1


