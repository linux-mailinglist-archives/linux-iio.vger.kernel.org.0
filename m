Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F19A26E57C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIQTmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 15:42:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55492 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728366AbgIQQRQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 12:17:16 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HFTck2001177;
        Thu, 17 Sep 2020 11:50:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p677ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 11:50:55 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08HFosLF011809
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Sep 2020 11:50:54 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 17 Sep
 2020 08:51:00 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 17 Sep 2020 08:50:59 -0700
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08HFojFL030124;
        Thu, 17 Sep 2020 11:50:49 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] iio: adis16475: Drop adis_burst usage
Date:   Thu, 17 Sep 2020 17:52:22 +0200
Message-ID: <20200917155223.218500-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917155223.218500-1-nuno.sa@analog.com>
References: <20200917155223.218500-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_10:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=1
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170119
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Burst mode variables are now part of the `adis_data` struct. The driver
also has now to explicitly define the length of the burst buffer.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 35d10ccb66c2..197d48240991 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -565,6 +565,9 @@ static int adis16475_enable_irq(struct adis *adis, bool enable)
 		BIT(ADIS16475_DIAG_STAT_CLK),				\
 	.enable_irq = adis16475_enable_irq,				\
 	.timeouts = (_timeouts),					\
+	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,			\
+	.burst_len = ADIS16475_BURST_MAX_DATA,				\
+	.burst_max_len = ADIS16475_BURST32_MAX_DATA			\
 }
 
 static const struct adis16475_sync adis16475_sync_mode[] = {
@@ -910,20 +913,6 @@ static const struct iio_info adis16475_info = {
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
-static struct adis_burst adis16475_burst = {
-	.en = true,
-	.reg_cmd = ADIS16475_REG_GLOB_CMD,
-	/*
-	 * adis_update_scan_mode_burst() sets the burst length in respect with
-	 * the number of channels and allocates 16 bits for each. However,
-	 * adis1647x devices also need space for DIAG_STAT, DATA_CNTR or
-	 * TIME_STAMP (depending on the clock mode but for us these bytes are
-	 * don't care...) and CRC.
-	 */
-	.extra_len = 3 * sizeof(u16),
-	.burst_max_len = ADIS16475_BURST32_MAX_DATA,
-};
-
 static bool adis16475_validate_crc(const u8 *buffer, u16 crc,
 				   const bool burst32)
 {
@@ -1279,7 +1268,6 @@ static int adis16475_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
-	st->adis.burst = &adis16475_burst;
 
 	st->info = device_get_match_data(&spi->dev);
 	if (!st->info)
-- 
2.28.0

