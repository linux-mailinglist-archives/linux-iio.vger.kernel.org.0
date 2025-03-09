Return-Path: <linux-iio+bounces-16617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432C3A58605
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A7C3ABFD1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A91DF742;
	Sun,  9 Mar 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV1oW5ri"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBE2AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540051; cv=none; b=UwNDcdWUOpMVCHwWw8xGYiqTW6dLKf/uXdx8bfdpi8Kd13gV6v3nnTS8sFKB/WyqOjimds1RxP8xnJFw0am1Qu3YDjl16woGvbkUdNuWtOmHANwdz7Glxs/okD1LOXTmFZ/yIS95gJ8tSWrSlNIsPfP4mlXClVtySgyKxxJqadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540051; c=relaxed/simple;
	bh=nl0FlgcxsFaRR9z0+d9or+p5BH2Xz6zq/f5Q7AzqVQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKlSCWwbE4BlKTbh1c7N1gtKGh0AJ7hbPi4LA5zAJvY8fr0eST1q3l+57X+jYsnB1plLcAU+/KwK8E9vMAx9jpmxJMOTyJxYBFjAr8/43C/kcz/mwgZUbvfBof4T1pB323HCuiOVAe93I1dNcC4SrnYOGX8nh4YUMcTMQ/3fU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV1oW5ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42844C4CEE3;
	Sun,  9 Mar 2025 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540051;
	bh=nl0FlgcxsFaRR9z0+d9or+p5BH2Xz6zq/f5Q7AzqVQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PV1oW5rimoUHtU1fQ7RIZ4MqB9yA9eZN1cV5dg4erxFUVr4EPns1Ky5Bd0HV2bODj
	 sVzCP7iXMdLQHvCSfALjfSBHiiRoTVJ8leWQobe6Rp/9C206Hfb0RDXxp36DnDSUXG
	 POsXUdfaoNidanTN2WOkl38WfDc7kOPjfxkKVHFqaqsMAcWZvILFi7Iqgp6Q0N2Yi2
	 qjuFtFwtrsfG/Q1qFFbuKoXfJR8V5y+bXQbM0B2VMHbVjUSmQ1U/30hnMoL7z4xhCo
	 JM17e01CfietiHBGawkjH/xywso5ZE/k8AzUwoUHxNy3Wc7o0a9ozy9B0hPwYd1oSl
	 U8KT5M1xUaAGA==
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
Subject: [PATCH 11/18] iio: light: rpr0521: Factor out handling of IIO_INFO_RAW and use guard()
Date: Sun,  9 Mar 2025 17:06:26 +0000
Message-ID: <20250309170633.1347476-12-jic23@kernel.org>
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

Factor out the code which is only called with the direct mode claimed.
This and the use of guard(mutex) allows direct returns simplifying
code flow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/rpr0521.c | 57 ++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 2ba917c5c138..65c60a1d2f0b 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -704,6 +705,38 @@ static int rpr0521_write_ps_offset(struct rpr0521_data *data, int offset)
 	return ret;
 }
 
+static int rpr0521_read_info_raw(struct rpr0521_data *data,
+				 struct iio_chan_spec const *chan,
+				 int *val)
+{
+	u8 device_mask;
+	__le16 raw_data;
+	int ret;
+
+	device_mask = rpr0521_data_reg[chan->address].device_mask;
+
+	guard(mutex)(&data->lock);
+	ret = rpr0521_set_power_state(data, true, device_mask);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap,
+			       rpr0521_data_reg[chan->address].address,
+			       &raw_data, sizeof(raw_data));
+	if (ret < 0) {
+		rpr0521_set_power_state(data, false, device_mask);
+		return ret;
+	}
+
+	ret = rpr0521_set_power_state(data, false, device_mask);
+	if (ret < 0)
+		return ret;
+
+	*val = le16_to_cpu(raw_data);
+
+	return 0;
+}
+
 static int rpr0521_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -711,8 +744,6 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 	struct rpr0521_data *data = iio_priv(indio_dev);
 	int ret;
 	int busy;
-	u8 device_mask;
-	__le16 raw_data;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -723,31 +754,11 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 		if (busy)
 			return -EBUSY;
 
-		device_mask = rpr0521_data_reg[chan->address].device_mask;
-
-		mutex_lock(&data->lock);
-		ret = rpr0521_set_power_state(data, true, device_mask);
-		if (ret < 0)
-			goto rpr0521_read_raw_out;
-
-		ret = regmap_bulk_read(data->regmap,
-				       rpr0521_data_reg[chan->address].address,
-				       &raw_data, sizeof(raw_data));
-		if (ret < 0) {
-			rpr0521_set_power_state(data, false, device_mask);
-			goto rpr0521_read_raw_out;
-		}
-
-		ret = rpr0521_set_power_state(data, false, device_mask);
-
-rpr0521_read_raw_out:
-		mutex_unlock(&data->lock);
+		ret = rpr0521_read_info_raw(data, chan, val);
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
-		*val = le16_to_cpu(raw_data);
-
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-- 
2.48.1


