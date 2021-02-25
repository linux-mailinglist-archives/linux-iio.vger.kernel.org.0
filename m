Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2632574C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Feb 2021 21:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBYUIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 15:08:34 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:44334 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233452AbhBYUIc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Feb 2021 15:08:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 26F7341292;
        Thu, 25 Feb 2021 20:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1614283666; x=1616098067; bh=jfou+jGrfCGrJnW/hkwUwz5auJu9gH7RX/i
        t7GFlyvQ=; b=NzBao1LUlOy+ZJ/eEUpn5GghUGKAIXLi9qHcNheTICiS44ZJGmz
        9WSZsXkgZ0J4uzxfJiAFrceESlkNhlE0amJuevQP3dg2SxV1jBcczt4j5Mq3Cqzu
        8NnFLxQmiuYgcY0LVOVXBXdcMktArSEkycyoP4irNQ/D0pVEnMiThKs8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dhqJQrh2aL1Y; Thu, 25 Feb 2021 23:07:46 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id EC50841380;
        Thu, 25 Feb 2021 23:07:46 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.0.34) by
 T-EXCH-03.corp.yadro.com (172.17.100.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 25 Feb 2021 23:07:46 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: proximity: vcnl3020: add proximity rate
Date:   Thu, 25 Feb 2021 23:14:44 +0300
Message-ID: <20210225201444.12983-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210225201444.12983-1-i.mikhaylov@yadro.com>
References: <20210225201444.12983-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.34]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the proximity rate optional option and handling of it for
vishay vcnl3020.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/vcnl3020.c | 97 +++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 37264f801ad0..43817f6b3086 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -40,6 +40,17 @@
 #define VCNL_ON_DEMAND_TIMEOUT_US	100000
 #define VCNL_POLL_US			20000
 
+static const int vcnl3020_prox_sampling_frequency[][2] = {
+	{1, 950000},
+	{3, 906250},
+	{7, 812500},
+	{16, 625000},
+	{31, 250000},
+	{62, 500000},
+	{125, 0},
+	{250, 0},
+};
+
 /**
  * struct vcnl3020_data - vcnl3020 specific data.
  * @regmap:	device register map.
@@ -165,10 +176,51 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
 	return rc;
 }
 
+static int vcnl3020_read_proxy_samp_freq(struct vcnl3020_data *data, int *val,
+					 int *val2)
+{
+	int rc;
+	unsigned int prox_rate;
+
+	rc = regmap_read(data->regmap, VCNL_PROXIMITY_RATE, &prox_rate);
+	if (rc)
+		return rc;
+
+	if (prox_rate >= ARRAY_SIZE(vcnl3020_prox_sampling_frequency))
+		return -EINVAL;
+
+	*val = vcnl3020_prox_sampling_frequency[prox_rate][0];
+	*val2 = vcnl3020_prox_sampling_frequency[prox_rate][1];
+
+	return 0;
+}
+
+static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
+					  int val2)
+{
+	unsigned int i;
+	int index = -1;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
+		if (val == vcnl3020_prox_sampling_frequency[i][0] &&
+		    val2 == vcnl3020_prox_sampling_frequency[i][1]) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0)
+		return -EINVAL;
+
+	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
+}
+
 static const struct iio_chan_spec vcnl3020_channels[] = {
 	{
 		.type = IIO_PROXIMITY,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 };
 
@@ -185,6 +237,47 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
 		if (rc)
 			return rc;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		rc = vcnl3020_read_proxy_samp_freq(data, val, val2);
+		if (rc < 0)
+			return rc;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl3020_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	int rc;
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		rc = iio_device_claim_direct_mode(indio_dev);
+		if (rc)
+			return rc;
+		rc = vcnl3020_write_proxy_samp_freq(data, val, val2);
+		iio_device_release_direct_mode(indio_dev);
+		return rc;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl3020_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)vcnl3020_prox_sampling_frequency;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = 2 * ARRAY_SIZE(vcnl3020_prox_sampling_frequency);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -192,6 +285,8 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info vcnl3020_info = {
 	.read_raw = vcnl3020_read_raw,
+	.write_raw = vcnl3020_write_raw,
+	.read_avail = vcnl3020_read_avail,
 };
 
 static const struct regmap_config vcnl3020_regmap_config = {
-- 
2.26.2

