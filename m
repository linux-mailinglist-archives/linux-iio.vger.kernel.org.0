Return-Path: <linux-iio+bounces-17448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199EA7658B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76ED17A3512
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80631E230E;
	Mon, 31 Mar 2025 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqlQ7Jzx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DE154C15
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423328; cv=none; b=pIihtEIm7CKNeTqXqCyRXASBVFb37pR4KfxOSB8SmQCjyYgF9IbKeTCR5Q5v6e4oDvHaZg6IcOB2w6CZ8qPvMe4PPc3P28X/dQziN9x1filRKfl8PCQxiedLIa8+KtWz8R0DiBZeiNIgdRgkvEurwAvUXwln2gvFYRLH+AqgOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423328; c=relaxed/simple;
	bh=JjWPuy+b+QXmgLam8m5ZykHsPQVA7cECRMcOy85gTR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4erCjn9MRgUlmxlLvM8QgdjDufXUnYjeEUpFQF1hm77jgXtQRzAO2/7SZmei0ocezcO9Ivu0FwVceQH3PiQNEZQHtdEQyWlMwgNFwiZhukzQdjtCO3yIaOQbRUApLscAwtW7yyR8OjL4IGehvWjq0oh5akkxDDe3ySAiDRCBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqlQ7Jzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685A2C4CEE5;
	Mon, 31 Mar 2025 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423327;
	bh=JjWPuy+b+QXmgLam8m5ZykHsPQVA7cECRMcOy85gTR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqlQ7JzxXzOQ48slTqRSTGIqW32LJAo0X2dd1rQgf4wWkIfA9flxQxqShXjVQ9Dc/
	 +xbmG7VOxBpcPWaq60K2jkCFUK+g0W4wUhKw94B8lV8lo4y/j91KvIzPp4f3i+Fn3I
	 eqbqC8vXQeT2xiVIzR87h1cEJmv9A0o7XpTszxMh+hYnAage/tDQXbqmcWeRTIFO8/
	 M9sy1+ks7WYlJfJDs4+C1ieXtoIxoZ7xxq8M5Mi6oScRd7izEnzrHTf960C8wjrkcv
	 HW6kmvrNAXUpTjjM4zPzozdIB+sspVyhulXUwH/EjrcekJcFjy5X70zXAjc+QBxh4Y
	 5YWYqvDbm7FsA==
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
Subject: [PATCH 18/37] iio: imu: st_lsm6dsx: Factor out parts of st_lsm6dsx_shub_write_raw() to allow direct returns
Date: Mon, 31 Mar 2025 13:12:58 +0100
Message-ID: <20250331121317.1694135-19-jic23@kernel.org>
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

By factoring out all the code that occurs with direct mode claimed
to a helper function, that helper function can directly return simplifying
code flow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 65 +++++++++++---------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index c1b444520d2a..17a74f5adfc0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -614,53 +614,58 @@ st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 }
 
 static int
-st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
-			  struct iio_chan_spec const *chan,
-			  int val, int val2, long mask)
+__st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	int err;
 
-	err = iio_device_claim_direct_mode(iio_dev);
-	if (err)
-		return err;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ: {
+		struct st_lsm6dsx_hw *hw = sensor->hw;
+		struct st_lsm6dsx_sensor *ref_sensor;
+		u8 odr_val;
 		u16 data;
+		int odr;
 
 		val = val * 1000 + val2 / 1000;
 		err = st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
-		if (!err) {
-			struct st_lsm6dsx_hw *hw = sensor->hw;
-			struct st_lsm6dsx_sensor *ref_sensor;
-			u8 odr_val;
-			int odr;
-
-			ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-			odr = st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
-			if (odr < 0) {
-				err = odr;
-				goto release;
-			}
-
-			sensor->ext_info.slv_odr = val;
-			sensor->odr = odr;
-		}
-		break;
+		if (err)
+			return err;
+
+		ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+		odr = st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
+		if (odr < 0)
+			return odr;
+
+		sensor->ext_info.slv_odr = val;
+		sensor->odr = odr;
+		return 0;
 	}
 	case IIO_CHAN_INFO_SCALE:
-		err = st_lsm6dsx_shub_set_full_scale(sensor, val2);
-		break;
+		return st_lsm6dsx_shub_set_full_scale(sensor, val2);
 	default:
-		err = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
+
+static int
+st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
+			  struct iio_chan_spec const *chan,
+			  int val, int val2, long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(iio_dev);
+	if (ret)
+		return ret;
+
+	ret = __st_lsm6dsx_shub_write_raw(iio_dev, chan, val, val2, mask);
 
-release:
 	iio_device_release_direct_mode(iio_dev);
 
-	return err;
+	return ret;
 }
 
 static ssize_t
-- 
2.48.1


