Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75F181377
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgCKIko (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 04:40:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28508 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728242AbgCKIko (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 04:40:44 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B8dgfN004402;
        Wed, 11 Mar 2020 04:40:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yp9x3bwfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 04:40:34 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02B8eXsr032248
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Mar 2020 04:40:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 04:40:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 04:40:32 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Mar 2020 04:40:32 -0400
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02B8eSGI028151;
        Wed, 11 Mar 2020 04:40:29 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        "Beniamin Bia" <beniamin.bia@analog.com>
Subject: [PATCH 1/4] iio: adc: ad7476: Generate CONVST signal internally
Date:   Wed, 11 Mar 2020 10:43:25 +0200
Message-ID: <20200311084328.17680-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_02:2020-03-10,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

Compared to the other supported parts, AD7091R are dependent of
a CONVST signal that initiates the conversion. At this moment, only
sampling in buffered mode is supported for AD7091R and the only
option until now was to generate this signal externally using an
IIO trigger. This patch adds the option of generating it internally,
more compatible triggers being available in this case.

Also, it is an intermiate step of adding support more devices.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7476.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 76747488044b..32e857dfec9c 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -12,9 +12,11 @@
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -34,6 +36,7 @@ struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
 	struct regulator		*reg;
+	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
 	/*
@@ -64,6 +67,17 @@ enum ad7476_supported_device_ids {
 	ID_ADS7868,
 };
 
+static void ad7091_convst(struct ad7476_state *st)
+{
+	if (!st->convst_gpio)
+		return;
+
+	gpiod_set_value(st->convst_gpio, 0);
+	udelay(1); /* CONVST pulse width: 10 ns min */
+	gpiod_set_value(st->convst_gpio, 1);
+	udelay(1); /* Conversion time: 650 ns max */
+}
+
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
@@ -71,6 +85,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	struct ad7476_state *st = iio_priv(indio_dev);
 	int b_sent;
 
+	ad7091_convst(st);
+
 	b_sent = spi_sync(st->spi, &st->msg);
 	if (b_sent < 0)
 		goto done;
@@ -254,6 +270,12 @@ static int ad7476_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
+						  "adi,conversion-start",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(st->convst_gpio))
+		return PTR_ERR(st->convst_gpio);
+
 	spi_set_drvdata(spi, indio_dev);
 
 	st->spi = spi;
-- 
2.17.1

