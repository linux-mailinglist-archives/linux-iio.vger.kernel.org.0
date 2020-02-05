Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4B15361D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBERPb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 12:15:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7980 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbgBERPa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 12:15:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015HE6eV022084;
        Wed, 5 Feb 2020 12:15:29 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhm9280d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 12:15:29 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 015HFRTD028178
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Feb 2020 12:15:28 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 5 Feb 2020
 09:15:27 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 5 Feb 2020 09:15:26 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 015HFNai010661;
        Wed, 5 Feb 2020 12:15:25 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 1/5 V2] staging: iio: adc: ad7192: fail probe on get_voltage
Date:   Wed, 5 Feb 2020 19:15:07 +0200
Message-ID: <20200205171511.25912-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171511.25912-1-alexandru.tachici@analog.com>
References: <20200202162215.50915c83@archlinux>
 <20200205171511.25912-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_05:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=943 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050131
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch makes the ad7192_probe fail in case
regulator_get_voltage will return an error.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index bf3e2a9cc07f..4780ddf99b13 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -899,10 +899,13 @@ static int ad7192_probe(struct spi_device *spi)
 
 	voltage_uv = regulator_get_voltage(st->avdd);
 
-	if (voltage_uv)
+	if (voltage_uv) {
 		st->int_vref_mv = voltage_uv / 1000;
-	else
+	} else {
+		ret = voltage_uv;
 		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
+		goto error_disable_avdd;
+	}
 
 	spi_set_drvdata(spi, indio_dev);
 	st->devid = spi_get_device_id(spi)->driver_data;
@@ -957,6 +960,7 @@ static int ad7192_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto error_disable_clk;
+
 	return 0;
 
 error_disable_clk:
-- 
2.20.1

