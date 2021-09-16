Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DD140E9E3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Sep 2021 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbhIPSbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Sep 2021 14:31:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36242 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245367AbhIPSbM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Sep 2021 14:31:12 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFmm6m008763;
        Thu, 16 Sep 2021 14:29:41 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b40gctb7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 14:29:41 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 18GITdhs033508
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 14:29:40 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 16 Sep 2021 11:29:38 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 16 Sep 2021 11:29:38 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.224.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18GITO8s025646;
        Thu, 16 Sep 2021 14:29:36 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v5 6/6] drivers:iio:dac:ad5766.c: Add trigger buffer
Date:   Thu, 16 Sep 2021 18:29:14 +0000
Message-ID: <20210916182914.1810-7-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916182914.1810-1-mihail.chindris@analog.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oOn7nCgtb7ClvvWiuC-T-valIzGnDQEE
X-Proofpoint-GUID: oOn7nCgtb7ClvvWiuC-T-valIzGnDQEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_05,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This chip is able to generate waveform and using an
with the output trigger buffer will be easy to generate one.

Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 drivers/iio/dac/ad5766.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index dafda84fdea3..71491e6d466e 100644
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
@@ -41,6 +44,7 @@
 #define AD5766_CMD_DITHER_SCALE_2		0xD0
 
 #define AD5766_FULL_RESET_CODE			0x1234
+#define AD5766_NUM_CH				16
 
 enum ad5766_type {
 	ID_AD5766,
@@ -455,6 +459,7 @@ static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |		\
 		BIT(IIO_CHAN_INFO_SCALE),				\
+	.scan_index = (_chan),						\
 	.scan_type = {							\
 		.sign = 'u',						\
 		.realbits = (_bits),					\
@@ -576,6 +581,28 @@ static int ad5766_default_setup(struct ad5766_state *st)
 	return  __ad5766_spi_write(st, AD5766_CMD_SPAN_REG, st->crt_range);
 }
 
+static irqreturn_t ad5766_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_buffer *buf = indio_dev->buffer;
+	int ret, ch, i;
+	u16 data[AD5766_NUM_CH];
+
+	ret = iio_pop_from_buffer(buf, (u8 *)data);
+	if (ret)
+		goto done;
+
+	i = 0;
+	for_each_set_bit(ch, indio_dev->active_scan_mask, AD5766_NUM_CH - 1)
+		ad5766_write(indio_dev, ch, le16_to_cpu(data[i++]));
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
@@ -609,6 +636,15 @@ static int ad5766_probe(struct spi_device *spi)
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

