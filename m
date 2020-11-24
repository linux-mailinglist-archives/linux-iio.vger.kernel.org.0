Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7943F2C25C5
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 13:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgKXMdZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 07:33:25 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16908 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbgKXMdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Nov 2020 07:33:14 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AOCUrmx022152;
        Tue, 24 Nov 2020 07:33:02 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y08v0h5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 07:33:02 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AOCX1D9024675
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 24 Nov 2020 07:33:01 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Nov 2020 07:33:00 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Nov 2020 07:33:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 24 Nov 2020 07:33:00 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AOCWwSd003530;
        Tue, 24 Nov 2020 07:32:58 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <alexandru.tachici@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3] iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack
Date:   Tue, 24 Nov 2020 14:38:07 +0200
Message-ID: <20201124123807.19717-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113094059.152651-1-alexandru.ardelean@analog.com>
References: <20201113094059.152651-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240078
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Use a heap allocated memory for the SPI transfer buffer. Using stack memory
can corrupt stack memory when using DMA on some systems.

This change moves the buffer from the stack of the trigger handler call to
the heap of the buffer of the state struct. The size increases takes into
account the alignment for the timestamp, which is 8 bytes.

The 'data' buffer is split into 'tx_buf' and 'rx_buf', to make a clearer
separation of which part of the buffer should be used for TX & RX.

Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 18 ++++++++----------
 include/linux/iio/adc/ad_sigma_delta.h |  6 +++++-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 86039e9ecaca..3a6f239d4acc 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL_GPL(ad_sd_set_comm);
 int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int val)
 {
-	uint8_t *data = sigma_delta->data;
+	uint8_t *data = sigma_delta->tx_buf;
 	struct spi_transfer t = {
 		.tx_buf		= data,
 		.len		= size + 1,
@@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(ad_sd_write_reg);
 static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 	unsigned int reg, unsigned int size, uint8_t *val)
 {
-	uint8_t *data = sigma_delta->data;
+	uint8_t *data = sigma_delta->tx_buf;
 	int ret;
 	struct spi_transfer t[] = {
 		{
@@ -146,22 +146,22 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
 {
 	int ret;
 
-	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->data);
+	ret = ad_sd_read_reg_raw(sigma_delta, reg, size, sigma_delta->rx_buf);
 	if (ret < 0)
 		goto out;
 
 	switch (size) {
 	case 4:
-		*val = get_unaligned_be32(sigma_delta->data);
+		*val = get_unaligned_be32(sigma_delta->rx_buf);
 		break;
 	case 3:
-		*val = get_unaligned_be24(&sigma_delta->data[0]);
+		*val = get_unaligned_be24(sigma_delta->rx_buf);
 		break;
 	case 2:
-		*val = get_unaligned_be16(sigma_delta->data);
+		*val = get_unaligned_be16(sigma_delta->rx_buf);
 		break;
 	case 1:
-		*val = sigma_delta->data[0];
+		*val = sigma_delta->rx_buf[0];
 		break;
 	default:
 		ret = -EINVAL;
@@ -395,11 +395,9 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	uint8_t *data = sigma_delta->rx_buf;
 	unsigned int reg_size;
 	unsigned int data_reg;
-	uint8_t data[16];
-
-	memset(data, 0x00, 16);
 
 	reg_size = indio_dev->channels[0].scan_type.realbits +
 			indio_dev->channels[0].scan_type.shift;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index a3a838dcf8e4..efc2413abaf4 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -79,8 +79,12 @@ struct ad_sigma_delta {
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
+	 * 'tx_buf' is up to 32 bits.
+	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
+	 * rounded to 16 bytes to take into account padding.
 	 */
-	uint8_t				data[4] ____cacheline_aligned;
+	uint8_t				tx_buf[4] ____cacheline_aligned;
+	uint8_t				rx_buf[16] __aligned(8);
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
-- 
2.17.1

