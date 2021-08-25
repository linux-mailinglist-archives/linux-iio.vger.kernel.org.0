Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A033F7132
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhHYIjz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 04:39:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35982 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239402AbhHYIjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 04:39:54 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P5HkWu009860;
        Wed, 25 Aug 2021 04:38:56 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3amufyx44p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 04:38:56 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 17P8csaj002517
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 04:38:55 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 25 Aug 2021 01:38:53 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 25 Aug 2021 01:38:53 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 25 Aug 2021 01:38:53 -0700
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17P8cpRQ030444;
        Wed, 25 Aug 2021 04:38:52 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: [PATCH v2 1/2] iio: ltc2983: add support for optional reset gpio
Date:   Wed, 25 Aug 2021 10:41:48 +0200
Message-ID: <20210825084149.11587-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jGqkW_NOCmcrWFea5SqjQBy-mUuiTdp6
X-Proofpoint-ORIG-GUID: jGqkW_NOCmcrWFea5SqjQBy-mUuiTdp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-25_02,2021-08-25_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250051
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check if an optional reset gpio is present and if so, make sure to reset
the device.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:

* Increased the 'usleep_range()' upper limit so that we get better
chances for not having an IRQ triggered by the hrtimers.

 drivers/iio/temperature/ltc2983.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 3b4a0e60e605..22e6a26ce6b1 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1470,6 +1470,7 @@ static int ltc2983_probe(struct spi_device *spi)
 {
 	struct ltc2983_data *st;
 	struct iio_dev *indio_dev;
+	struct gpio_desc *gpio;
 	const char *name = spi_get_device_id(spi)->name;
 	int ret;
 
@@ -1494,6 +1495,16 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
+	if (gpio) {
+		/* bring the device out of reset */
+		usleep_range(1000, 1200);
+		gpiod_set_value_cansleep(gpio, 0);
+	}
+
 	ret = ltc2983_setup(st, true);
 	if (ret)
 		return ret;
-- 
2.33.0

