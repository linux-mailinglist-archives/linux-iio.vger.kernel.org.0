Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45323181379
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgCKIks (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 04:40:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32756 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgCKIks (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 04:40:48 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B8dgfO004402;
        Wed, 11 Mar 2020 04:40:40 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yp9x3bwfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 04:40:40 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02B8edhk032271
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Mar 2020 04:40:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Mar
 2020 04:40:38 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Mar 2020 04:40:38 -0400
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02B8eSGJ028151;
        Wed, 11 Mar 2020 04:40:35 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/4] iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R
Date:   Wed, 11 Mar 2020 10:43:26 +0200
Message-ID: <20200311084328.17680-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311084328.17680-1-beniamin.bia@analog.com>
References: <20200311084328.17680-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_02:2020-03-10,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

When CONVST signal is generated internally, IIO_CHAN_INFO_RAW can be
made available for AD7091R for single reads. This patch enables it and
makes supporting more devices by this driver easier.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7476.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 32e857dfec9c..3b48073dd62d 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -29,6 +29,8 @@ struct ad7476_state;
 struct ad7476_chip_info {
 	unsigned int			int_vref_uv;
 	struct iio_chan_spec		channel[2];
+	/* channels used when convst gpio is defined */
+	struct iio_chan_spec		convst_channel[2];
 	void (*reset)(struct ad7476_state *);
 };
 
@@ -109,6 +111,8 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 {
 	int ret;
 
+	ad7091_convst(st);
+
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret)
 		return ret;
@@ -176,6 +180,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
 #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
+#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
+		BIT(IIO_CHAN_INFO_RAW))
 #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
 
@@ -183,6 +189,8 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7091R] = {
 		.channel[0] = AD7091R_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+		.convst_channel[0] = AD7091R_CONVST_CHAN(12),
+		.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.reset = ad7091_reset,
 	},
 	[ID_AD7276] = {
@@ -288,6 +296,9 @@ static int ad7476_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = 2;
 	indio_dev->info = &ad7476_info;
+
+	if (st->convst_gpio && st->chip_info->convst_channel)
+		indio_dev->channels = st->chip_info->convst_channel;
 	/* Setup default message */
 
 	st->xfer.rx_buf = &st->data;
-- 
2.17.1

