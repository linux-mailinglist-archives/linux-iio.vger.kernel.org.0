Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD16E142D2E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 15:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgATOVN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 09:21:13 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55200 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgATOVM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 09:21:12 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KEHdMG020981;
        Mon, 20 Jan 2020 09:21:09 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkyta4mvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 09:21:09 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00KEL8ph044586
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 20 Jan 2020 09:21:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 20 Jan
 2020 09:21:08 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 20 Jan 2020 09:21:08 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00KEKwie024435;
        Mon, 20 Jan 2020 09:21:04 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <dragos.bogdan@analog.com>,
        <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/4] iio: adis16460: Make use of __adis_initial_startup
Date:   Mon, 20 Jan 2020 16:20:51 +0200
Message-ID: <20200120142051.28533-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120142051.28533-1-alexandru.ardelean@analog.com>
References: <20200120142051.28533-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

All of the actions done in `adis16460_initial_setup()` are now done in
`__adis_initial_startup()` so, there's no need for code duplication.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16460.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 42fa473c6d81..6f94e81c41eb 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -333,40 +333,6 @@ static int adis16460_enable_irq(struct adis *adis, bool enable)
 	return 0;
 }
 
-static int adis16460_initial_setup(struct iio_dev *indio_dev)
-{
-	struct adis16460 *st = iio_priv(indio_dev);
-	uint16_t prod_id;
-	unsigned int device_id;
-	int ret;
-
-	adis_reset(&st->adis);
-	msleep(222);
-
-	ret = adis_write_reg_16(&st->adis, ADIS16460_REG_GLOB_CMD, BIT(1));
-	if (ret)
-		return ret;
-	msleep(75);
-
-	ret = adis_check_status(&st->adis);
-	if (ret)
-		return ret;
-
-	ret = adis_read_reg_16(&st->adis, ADIS16460_REG_PROD_ID, &prod_id);
-	if (ret)
-		return ret;
-
-	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
-	if (ret != 1)
-		return -EINVAL;
-
-	if (prod_id != device_id)
-		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
-				device_id, prod_id);
-
-	return 0;
-}
-
 #define ADIS16460_DIAG_STAT_IN_CLK_OOS	7
 #define ADIS16460_DIAG_STAT_FLASH_MEM	6
 #define ADIS16460_DIAG_STAT_SELF_TEST	5
@@ -392,6 +358,7 @@ static const struct adis_timeout adis16460_timeouts = {
 static const struct adis_data adis16460_data = {
 	.diag_stat_reg = ADIS16460_REG_DIAG_STAT,
 	.glob_cmd_reg = ADIS16460_REG_GLOB_CMD,
+	.prod_id_reg = ADIS16460_REG_PROD_ID,
 	.self_test_mask = BIT(2),
 	.self_test_reg = ADIS16460_REG_GLOB_CMD,
 	.has_paging = false,
@@ -441,7 +408,7 @@ static int adis16460_probe(struct spi_device *spi)
 
 	adis16460_enable_irq(&st->adis, 0);
 
-	ret = adis16460_initial_setup(indio_dev);
+	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		goto error_cleanup_buffer;
 
-- 
2.20.1

