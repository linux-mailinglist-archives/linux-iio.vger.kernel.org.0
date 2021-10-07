Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6F424EBB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhJGILN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 04:11:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60818 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240630AbhJGILK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 04:11:10 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1971C9So007983;
        Thu, 7 Oct 2021 04:09:03 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bhq19sjp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 04:09:03 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 197891YY046835
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Oct 2021 04:09:02 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 7 Oct 2021 01:09:00 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 7 Oct 2021 01:09:00 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 19780oI3008100;
        Thu, 7 Oct 2021 04:08:57 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v6 6/6] drivers:iio:dac:ad5766.c: Add trigger buffer
Date:   Thu, 7 Oct 2021 08:00:37 +0000
Message-ID: <20211007080035.2531-7-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211007080035.2531-1-mihail.chindris@analog.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lfzYUhIIiZnzR-98iWPRJIla1K4HM57f
X-Proofpoint-ORIG-GUID: lfzYUhIIiZnzR-98iWPRJIla1K4HM57f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-07_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110070055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This chip is able to generate waveform and using an
with the output trigger buffer will be easy to generate one.

Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/dac/ad5766.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index dafda84fdea3..b0d220c3a126 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -5,10 +5,13 @@
  * Copyright 2019-2020 Analog Devices Inc.
  */
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <asm/unaligned.h>
@@ -455,6 +458,7 @@ static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |		\
 		BIT(IIO_CHAN_INFO_SCALE),				\
+	.scan_index = (_chan),						\
 	.scan_type = {							\
 		.sign = 'u',						\
 		.realbits = (_bits),					\
@@ -576,6 +580,35 @@ static int ad5766_default_setup(struct ad5766_state *st)
 	return  __ad5766_spi_write(st, AD5766_CMD_SPAN_REG, st->crt_range);
 }
 
+static irqreturn_t ad5766_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_buffer *buffer = indio_dev->buffer;
+	struct ad5766_state *st = iio_priv(indio_dev);
+	int ret, ch, i;
+	u16 data[ARRAY_SIZE(ad5766_channels)];
+
+	ret = iio_pop_from_buffer(buffer, data);
+	if (ret)
+		goto done;
+
+	i = 0;
+	mutex_lock(&st->lock);
+	for_each_set_bit(ch, indio_dev->active_scan_mask,
+			 st->chip_info->num_channels - 1)
+		__ad5766_spi_write(st, AD5766_CMD_WR_IN_REG(ch), data[i++]);
+
+	__ad5766_spi_write(st, AD5766_CMD_SW_LDAC,
+			   *indio_dev->active_scan_mask);
+	mutex_unlock(&st->lock);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int ad5766_probe(struct spi_device *spi)
 {
 	enum ad5766_type type;
@@ -609,6 +642,15 @@ static int ad5766_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	/* Configure trigger buffer */
+	ret = devm_iio_triggered_buffer_setup_ext(&spi->dev, indio_dev, NULL,
+						  ad5766_trigger_handler,
+						  IIO_BUFFER_DIRECTION_OUT,
+						  NULL,
+						  NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-- 
2.27.0

