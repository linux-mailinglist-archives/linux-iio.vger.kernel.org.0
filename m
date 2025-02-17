Return-Path: <linux-iio+bounces-15702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6891A3862E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4920F17766F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9F224896;
	Mon, 17 Feb 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rORQNnoZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC931BC2A
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801974; cv=none; b=DN/V/RPrQ+NzmE4LIuWs4Hi/t4z1W/aTNOiErh80slEuDhBHIkru9byZ1P9fBch6HrxWkC+nKFKlXyw4rn6FzZYQtwjOYk2CHpYyqORB7HwHg84m6gx7EAxqX/Ts1P8fmthA97CpP3bI+vte7nL5JnRyjuwqkj2NSwn1yiatwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801974; c=relaxed/simple;
	bh=Vob11+Gd5RyzkOeYaKuLm0+pPhwr+l5MxHgbES3hS5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5wCZHx2qJIwzofCXfomBL6RK2k8KIov7nZqMk4dCjloiBrYOpWkEwJ3gcEfl0eoUpPVDdoju59MfsuPi1it5RcjovkrmqeLDT74mrAlz7QlNxXFrWS/+jdc7F/paYmxHf7YrtrKgTudtl0UUNQrAw/XKViI53MeVM+Mw5Z+7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rORQNnoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0CCC4CED1;
	Mon, 17 Feb 2025 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801974;
	bh=Vob11+Gd5RyzkOeYaKuLm0+pPhwr+l5MxHgbES3hS5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rORQNnoZsBVsLrwg7kzl6OEhEQOgxRX/CFro2SHFPP4cuYHncNobgmTSV3Wijl2Y6
	 eNjo9IWFZA7wSABX6q89HxhI2w9Kpaoezt8DXRa6OzVOhvZgV39K4z7dXAV02M42LG
	 FGprQo+jbxq6KAE9aOSrHpaaGOEn54aAmVJgrls8JvtpjvlQN7NbSwbaa3EMuvvfmj
	 W+TQ349qXzMElV+dywV++ymKpgfaC6n0XTFikHM7gfE/LllWJDIYNcwrGkQOLijjQd
	 vUr6LVknRoEYxQfhzdk1QGnS6+BlF108s6pCLbsua7g5Nfl3mKJrQSD2GldVzJzwq8
	 VuQlPt3CPaffg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 29/29] iio: adc: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:29 +0000
Message-ID: <20250217141630.897334-30-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Single patch for all the relatively simple cases.

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/adc/ad7173.c        |  9 +++---
 drivers/iio/adc/ad7266.c        |  7 ++---
 drivers/iio/adc/ad7298.c        |  7 ++---
 drivers/iio/adc/ad7380.c        | 56 ++++++++++++++-------------------
 drivers/iio/adc/ad7476.c        |  7 ++---
 drivers/iio/adc/ad7887.c        |  7 ++---
 drivers/iio/adc/ad7923.c        |  7 ++---
 drivers/iio/adc/ad7944.c        |  7 ++---
 drivers/iio/adc/dln2-adc.c      |  7 ++---
 drivers/iio/adc/stm32-adc.c     |  7 ++---
 drivers/iio/adc/ti-adc084s021.c |  9 +++---
 drivers/iio/adc/ti-adc108s102.c |  7 ++---
 drivers/iio/adc/ti-ads1298.c    |  7 ++---
 drivers/iio/adc/ti-ads131e08.c  | 14 ++++-----
 drivers/iio/adc/ti-tlc4541.c    |  7 ++---
 15 files changed, 71 insertions(+), 94 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 54f9cc5a89f5..ca2b41b16cc9 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1157,11 +1157,10 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 	struct ad7173_state *st = iio_priv(indio_dev);
 	struct ad7173_channel_config *cfg;
 	unsigned int freq, i;
-	int ret;
+	int ret = 0;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	switch (info) {
 	/*
@@ -1195,7 +1194,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 858c8be2ff1a..18559757f908 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -153,11 +153,10 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = ad7266_read_single(st, val, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index b35bd4d9ef81..28b88092b4aa 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -232,16 +232,15 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		if (chan->address == AD7298_CH_TEMP)
 			ret = ad7298_scan_temp(st, val);
 		else
 			ret = ad7298_scan_direct(st, chan->address);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index a18dcd664c1b..f232ad1a4963 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -716,16 +716,15 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	struct ad7380_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	if (readval)
 		ret = regmap_read(st->regmap, reg, readval);
 	else
 		ret = regmap_write(st->regmap, reg, writeval);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
@@ -1018,14 +1017,13 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ad7380_read_direct(st, chan->scan_index,
 					 scan_type, val);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
@@ -1056,13 +1054,12 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ad7380_get_osr(st, val);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret)
 			return ret;
@@ -1155,13 +1152,12 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ad7380_set_oversampling_ratio(st, val);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		return ret;
 	default:
@@ -1186,13 +1182,12 @@ static int ad7380_read_event_config(struct iio_dev *indio_dev,
 	struct ad7380_state *st = iio_priv(indio_dev);
 	int tmp, ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	if (ret)
 		return ret;
@@ -1209,16 +1204,15 @@ static int ad7380_write_event_config(struct iio_dev *indio_dev,
 	struct ad7380_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = regmap_update_bits(st->regmap,
 				 AD7380_REG_ADDR_CONFIG1,
 				 AD7380_CONFIG1_ALERTEN,
 				 FIELD_PREP(AD7380_CONFIG1_ALERTEN, state));
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
@@ -1265,13 +1259,12 @@ static int ad7380_read_event_value(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ad7380_get_alert_th(st, dir, val);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	default:
 		return -EINVAL;
@@ -1332,13 +1325,12 @@ static int ad7380_write_event_value(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ad7380_set_alert_th(indio_dev, chan, dir, val);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	default:
 		return -EINVAL;
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index aeb8e383fe71..37b0515cf4fc 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -138,11 +138,10 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = ad7476_scan_direct(st);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 69add1dc4b53..87ff95643794 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -152,11 +152,10 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = ad7887_scan_direct(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index acc44cb34f82..87945efb940b 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -260,11 +260,10 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = ad7923_scan_direct(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 9a7825ea5087..2f949fe55873 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -407,12 +407,11 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ad7944_single_conversion(adc, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 221a5fdc1eaa..b9029fa13b32 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -314,15 +314,14 @@ static int dln2_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;;
 
 		mutex_lock(&dln2->mutex);
 		ret = dln2_adc_read(dln2, chan->channel);
 		mutex_unlock(&dln2->mutex);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 9d3b23efcc06..5dbf5f136768 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1471,9 +1471,8 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		if (chan->type == IIO_VOLTAGE)
 			ret = stm32_adc_single_conv(indio_dev, chan, val);
 		else
@@ -1482,7 +1481,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 		if (mask == IIO_CHAN_INFO_PROCESSED)
 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index da16876c32ae..9c845ee01697 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -96,19 +96,18 @@ static int adc084s021_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = regulator_enable(adc->reg);
 		if (ret) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 
 		adc->tx_buf[0] = channel->channel << 3;
 		ret = adc084s021_adc_conversion(adc, &be_val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		regulator_disable(adc->reg);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 9758ac801310..7d615e2bbf39 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -181,13 +181,12 @@ static int adc108s102_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = adc108s102_scan_direct(st, chan->address);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 03f762415fa5..ae30b47e4514 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -319,13 +319,12 @@ static int ads1298_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ads1298_read_one(priv, chan->scan_index);
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		if (ret)
 			return ret;
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 91a79ebc4bde..c6096b64664e 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -505,12 +505,11 @@ static int ads131e08_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ads131e08_read_direct(indio_dev, channel, value);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 
@@ -551,12 +550,11 @@ static int ads131e08_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ads131e08_set_data_rate(st, value);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	default:
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 08de997584fd..5a138be983ed 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -131,11 +131,10 @@ static int tlc4541_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = spi_sync(st->spi, &st->scan_single_msg);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = be16_to_cpu(st->rx_buf[0]);
-- 
2.48.1


