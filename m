Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCC36EA75
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 14:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhD2M3I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 08:29:08 -0400
Received: from first.geanix.com ([116.203.34.67]:50672 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232657AbhD2M3F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Apr 2021 08:29:05 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id BBB7A466693;
        Thu, 29 Apr 2021 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619699296; bh=9RFIp34R8dOCPLYSj4YJHVUXoQjw99Td2vb3UssDJec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EmKa7lKoZ77N+iWfoN0d6HWrCoi85XEJmBn6LeVY7kp1vPMJTy4n7liS6UpuFpB3G
         5UNFOgHOkadlBZPFlWUA5hZtyp+pu4V1gahtyo7DsY0jXBZw+VhbGY2reATLKY8Obc
         8DJeAgsqaaKmK6DjFr94kFNInpyYdGBmIW5Vdo9zLjAyI5rzHhfkWT+1fR8bsJOV2P
         hC582v5SJbp8jR1Hng4EIA/j5IhxiC0LdcMCym1qWqKO2RDJPkhmuQ5X2UNXreiCiK
         uVrp87dTnMD10LQBVO25mPOfQxEeFssL3+7jO1acuJz9SzYb11qo7/PB8w7FUxPrYq
         7GjMenh1upJ+g==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v4 3/6] iio: accel: fxls8962af: add set/get of samplerate
Date:   Thu, 29 Apr 2021 14:28:03 +0200
Message-Id: <20210429122806.3814330-3-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210429122806.3814330-1-sean@geanix.com>
References: <20210429122806.3814330-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for setting de accelerometers output data rate.
Primarily used for hardware buffered reads.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 77 +++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 6ae47eac4490..9de30e8539b1 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -50,6 +50,9 @@
 
 #define FXLS8962AF_SENS_CONFIG2			0x16
 #define FXLS8962AF_SENS_CONFIG3			0x17
+#define FXLS8962AF_SC3_WAKE_ODR_MASK		GENMASK(7, 4)
+#define FXLS8962AF_SC3_WAKE_ODR_PREP(x)		FIELD_PREP(FXLS8962AF_SC3_WAKE_ODR_MASK, (x))
+#define FXLS8962AF_SC3_WAKE_ODR_GET(x)		FIELD_GET(FXLS8962AF_SC3_WAKE_ODR_MASK, (x))
 #define FXLS8962AF_SENS_CONFIG4			0x18
 #define FXLS8962AF_SENS_CONFIG5			0x19
 
@@ -96,6 +99,7 @@
 #define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
 
 #define FXLS8962AF_SCALE_TABLE_LEN		4
+#define FXLS8962AF_SAMP_FREQ_TABLE_LEN		13
 
 static const int fxls8962af_scale_table[FXLS8962AF_SCALE_TABLE_LEN][2] = {
 	{0, IIO_G_TO_M_S_2(980000)},
@@ -104,6 +108,12 @@ static const int fxls8962af_scale_table[FXLS8962AF_SCALE_TABLE_LEN][2] = {
 	{0, IIO_G_TO_M_S_2(7810000)},
 };
 
+static const int fxls8962af_samp_freq_table[FXLS8962AF_SAMP_FREQ_TABLE_LEN][2] = {
+	{3200, 0}, {1600, 0}, {800, 0}, {400, 0}, {200, 0}, {100, 0},
+	{50, 0}, {25, 0}, {12, 500000}, {6, 250000}, {3, 125000},
+	{1, 563000}, {0, 781000},
+};
+
 struct fxls8962af_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
@@ -228,6 +238,11 @@ static int fxls8962af_read_avail(struct iio_dev *indio_dev,
 		*vals = (int *)fxls8962af_scale_table;
 		*length = ARRAY_SIZE(fxls8962af_scale_table) * 2;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = (int *)fxls8962af_samp_freq_table;
+		*length = ARRAY_SIZE(fxls8962af_samp_freq_table) * 2;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -237,7 +252,14 @@ static int fxls8962af_write_raw_get_fmt(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan,
 					long mask)
 {
-	return IIO_VAL_INT_PLUS_NANO;
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return IIO_VAL_INT_PLUS_NANO;
+	}
 }
 
 static int fxls8962af_update_config(struct fxls8962af_data *data, u8 reg,
@@ -300,6 +322,42 @@ static unsigned int fxls8962af_read_full_scale(struct fxls8962af_data *data,
 	return IIO_VAL_INT_PLUS_NANO;
 }
 
+static int fxls8962af_set_samp_freq(struct fxls8962af_data *data, u32 val, u32 val2)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fxls8962af_samp_freq_table); i++)
+		if (val == fxls8962af_samp_freq_table[i][0] &&
+		    val2 == fxls8962af_samp_freq_table[i][1])
+			break;
+
+	if (i == ARRAY_SIZE(fxls8962af_samp_freq_table))
+		return -EINVAL;
+
+	return fxls8962af_update_config(data, FXLS8962AF_SENS_CONFIG3,
+					FXLS8962AF_SC3_WAKE_ODR_MASK,
+					FXLS8962AF_SC3_WAKE_ODR_PREP(i));
+}
+
+static unsigned int fxls8962af_read_samp_freq(struct fxls8962af_data *data,
+					      int *val, int *val2)
+{
+	int ret;
+	unsigned int reg;
+	u8 range_idx;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_SENS_CONFIG3, &reg);
+	if (ret < 0)
+		return ret;
+
+	range_idx = FXLS8962AF_SC3_WAKE_ODR_GET(reg);
+
+	*val = fxls8962af_samp_freq_table[range_idx][0];
+	*val2 = fxls8962af_samp_freq_table[range_idx][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val, int *val2, long mask)
@@ -324,6 +382,8 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		return fxls8962af_read_full_scale(data, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return fxls8962af_read_samp_freq(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -347,6 +407,15 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
 
 		ret = fxls8962af_set_full_scale(data, val2);
 
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = fxls8962af_set_samp_freq(data, val, val2);
+
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	default:
@@ -360,8 +429,10 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
 	.modified = 1, \
 	.channel2 = IIO_MOD_##axis, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+					      BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.scan_index = idx, \
 	.scan_type = { \
 		.sign = 's', \
-- 
2.31.0

