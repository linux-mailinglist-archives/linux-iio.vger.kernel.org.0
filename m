Return-Path: <linux-iio+bounces-15675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CAA385D7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083041892DF9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E828A2222B1;
	Mon, 17 Feb 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZB7w9Hg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7E21E08D
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801824; cv=none; b=CRaooUuVbePCzU7ZtY4k7XkL4Qlo7xsDnYKDFWw4fTnwu8h5w/fWW4I2vdA5wk414h7IuafE+svdV2jG2fq8Sim/L7oM6Oyv7jjxPffujbzmUSvoxXBnfVSCaMrABE3hwJ1/KUbaZWjiJwMbEukLu9xS5Vri6pBe6WjfISAT2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801824; c=relaxed/simple;
	bh=YUYZpYWu3qEndzwnWpszt3bx3yZgChkcVon2XZ2sCTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxwXy9q4RTHML1zIe3M9MEFnNePX5/9XpVvmggrA2soQLviay/p7X2sR8g1moyMV/E7gJkFKMGf5y0eAkDaSm2p1Rc5mXdLsk/fe2wQdRwCyrCIzXVuRsuMAstYLucDPmHtGhTz7Q2HJ48a22CfQ1mjUSKAfBNqybKhK3oR0bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZB7w9Hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BEEC4CED1;
	Mon, 17 Feb 2025 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801824;
	bh=YUYZpYWu3qEndzwnWpszt3bx3yZgChkcVon2XZ2sCTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZB7w9Hgf7Cl5HzqiwbR7UE+M/m1j9M+3ytNcnLAcIV9bD2r8tDrdeKQ0Ri8Lug9l
	 eB5nAXuHfY/v6KwVFoZ+/ewvF9BBqeG50clkG5y+YaTDu8cnIZ8/c7GBNrwyZVzbC6
	 1Wdg5waFnQ9tkFgcpw/hQYfnoacVWXfM1nmLcfGuoyrUdE6fnt2tBE9mVDfQ3eBFWP
	 AtiRb1H7S5O9WBVigcm6RxqUG6hygb3/KXpbTpae5ZWlpLPPKSqW0ekHHRoci1yPDh
	 V1ZBmVFN95ibFoujMh0Mj4EHjLTLcHQHHdLtHADYSk7H7OHSJr0JWSRdFdis4WPRjf
	 jvf8wIdWqpsEQ==
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
Subject: [PATCH 03/29] iio: adc: ti-ads1100: Use guard(mutex) to allow direct returns
Date: Mon, 17 Feb 2025 14:16:03 +0000
Message-ID: <20250217141630.897334-4-jic23@kernel.org>
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

Use of automated lock release simplifies the code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/adc/ti-ads1100.c | 39 +++++++++++++-----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 1e46f07a9ca6..0519f8afb033 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -219,36 +220,31 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ads1100_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
-			break;
+			return ret;
 
 		ret = ads1100_get_adc_result(data, chan->address, val);
-		if (ret >= 0)
-			ret = IIO_VAL_INT;
 		iio_device_release_direct_mode(indio_dev);
-		break;
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* full-scale is the supply voltage in millivolts */
 		*val = ads1100_get_vdd_millivolts(data);
 		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
-		ret = IIO_VAL_FRACTIONAL_LOG2;
-		break;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
 						   data->config)];
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int ads1100_write_raw(struct iio_dev *indio_dev,
@@ -256,23 +252,16 @@ static int ads1100_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct ads1100_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = ads1100_set_scale(data, val, val2);
-		break;
+		return ads1100_set_scale(data, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = ads1100_set_data_rate(data, chan->address, val);
-		break;
+		return ads1100_set_data_rate(data, chan->address, val);
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static const struct iio_info ads1100_info = {
-- 
2.48.1


