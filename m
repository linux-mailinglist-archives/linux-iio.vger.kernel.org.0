Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D1D3E5E6C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhHJOzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 10:55:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21044 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232874AbhHJOzA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 10:55:00 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AEfWkD012611;
        Tue, 10 Aug 2021 10:54:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ab966aymq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 10:54:03 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 17AEs2oS027591
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Aug 2021 10:54:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 10 Aug 2021
 10:54:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 10 Aug 2021 10:54:01 -0400
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17AErxKZ005253;
        Tue, 10 Aug 2021 10:54:00 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     =Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: [PATCH 1/1] iio: ltc2983: fix device probe
Date:   Tue, 10 Aug 2021 16:56:53 +0200
Message-ID: <20210810145653.295397-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810145653.295397-1-nuno.sa@analog.com>
References: <20210810145653.295397-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DT6GkvaFyEm9qNYgYsIjwKH5iXLF2lUb
X-Proofpoint-ORIG-GUID: DT6GkvaFyEm9qNYgYsIjwKH5iXLF2lUb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_06:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100092
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no reason to assume that the irq rising edge (indicating that
the device start up phase is done) will happen after we request the irq.
If the device is already up by the time we request it, the call to
'wait_for_completion_timeout()' will timeout and we will fail the device
probe even though there's nothing wrong.

This patch fixes it by just polling the status register until we get the
indication that the device is up and running. As a side effect of this
fix, requesting the irq is also moved to after the setup function.

Fixes: f110f3188e563 ("iio: temperature: Add support for LTC2983")
Reported-by: Drew Fustini <drew@pdp7.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 3b5ba26d7d86..c6c4877bdcff 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -89,6 +89,8 @@
 
 #define	LTC2983_STATUS_START_MASK	BIT(7)
 #define	LTC2983_STATUS_START(x)		FIELD_PREP(LTC2983_STATUS_START_MASK, x)
+#define        LTC2983_STATUS_UP_MASK	GENMASK(7, 6)
+#define        LTC2983_STATUS_UP(reg)	FIELD_GET(LTC2983_STATUS_UP_MASK, reg)
 
 #define	LTC2983_STATUS_CHAN_SEL_MASK	GENMASK(4, 0)
 #define	LTC2983_STATUS_CHAN_SEL(x) \
@@ -1362,13 +1364,21 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
-	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0;
+	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status = 0;
 	int ret;
-	unsigned long time;
+	unsigned long time = 10;
 
 	/* make sure the device is up */
-	time = wait_for_completion_timeout(&st->completion,
-					    msecs_to_jiffies(250));
+	do {
+		ret = regmap_read(st->regmap, LTC2983_STATUS_REG, &status);
+		if (ret)
+			return ret;
+		/* start bit (7) is 0 and done bit (6) is 1 */
+		if (LTC2983_STATUS_UP(status) == 1)
+			break;
+
+		msleep(25);
+	} while (--time);
 
 	if (!time) {
 		dev_err(&st->spi->dev, "Device startup timed out\n");
@@ -1492,10 +1502,11 @@ static int ltc2983_probe(struct spi_device *spi)
 	ret = ltc2983_parse_dt(st);
 	if (ret)
 		return ret;
-	/*
-	 * let's request the irq now so it is used to sync the device
-	 * startup in ltc2983_setup()
-	 */
+
+	ret = ltc2983_setup(st, true);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, name, st);
 	if (ret) {
@@ -1503,10 +1514,6 @@ static int ltc2983_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = ltc2983_setup(st, true);
-	if (ret)
-		return ret;
-
 	indio_dev->name = name;
 	indio_dev->num_channels = st->iio_channels;
 	indio_dev->channels = st->iio_chan;
-- 
2.32.0

