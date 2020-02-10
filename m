Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9B157B4C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 14:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgBJN2t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 08:28:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14072 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729300AbgBJN2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 08:28:48 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADOBZP009654;
        Mon, 10 Feb 2020 08:28:47 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1tyq81sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 08:28:46 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01ADSjwS022113
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Feb 2020 08:28:45 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 05:28:44 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 05:28:43 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Feb 2020 05:28:43 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01ADSVZs017670;
        Mon, 10 Feb 2020 08:28:41 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 9/9] iio: adis16460: Make use of __adis_initial_startup
Date:   Mon, 10 Feb 2020 15:26:06 +0200
Message-ID: <20200210132606.9315-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_04:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100105
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
 drivers/iio/imu/adis16460.c | 38 +++----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 42fa473c6d81..0027683d0256 100644
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
@@ -392,6 +358,8 @@ static const struct adis_timeout adis16460_timeouts = {
 static const struct adis_data adis16460_data = {
 	.diag_stat_reg = ADIS16460_REG_DIAG_STAT,
 	.glob_cmd_reg = ADIS16460_REG_GLOB_CMD,
+	.prod_id_reg = ADIS16460_REG_PROD_ID,
+	.prod_id = 16460,
 	.self_test_mask = BIT(2),
 	.self_test_reg = ADIS16460_REG_GLOB_CMD,
 	.has_paging = false,
@@ -441,7 +409,7 @@ static int adis16460_probe(struct spi_device *spi)
 
 	adis16460_enable_irq(&st->adis, 0);
 
-	ret = adis16460_initial_setup(indio_dev);
+	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		goto error_cleanup_buffer;
 
-- 
2.20.1

