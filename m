Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC26400115
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhICOMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:12:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16434 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235838AbhICOMn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:12:43 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1833XtY8015161;
        Fri, 3 Sep 2021 10:11:32 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3aubwmtua5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:11:32 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 183EBVte040547
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 10:11:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 3 Sep 2021
 10:11:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 3 Sep 2021 10:11:30 -0400
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 183EBOFE024311;
        Fri, 3 Sep 2021 10:11:28 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 4/5] iio: adis16460: make use of the new unmasked_drdy flag
Date:   Fri, 3 Sep 2021 16:14:22 +0200
Message-ID: <20210903141423.517028-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903141423.517028-1-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: AiKJlHAN4Yh3K5OsE1l6RquJHJUA0-VO
X-Proofpoint-ORIG-GUID: AiKJlHAN4Yh3K5OsE1l6RquJHJUA0-VO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=896 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The library can now handle enabling/disabling IRQs for devices that
cannot unmask the data ready pin. Hence there's no need to provide an
'enable_irq' callback anymore.

The library will also automatically request the IRQ with 'IRQF_NO_AUTOEN'
so that we can also remove that from the driver.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16460.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index a6f9fba3e03f..b01988170118 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -319,20 +319,6 @@ static const struct iio_info adis16460_info = {
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
-static int adis16460_enable_irq(struct adis *adis, bool enable)
-{
-	/*
-	 * There is no way to gate the data-ready signal internally inside the
-	 * ADIS16460 :(
-	 */
-	if (enable)
-		enable_irq(adis->spi->irq);
-	else
-		disable_irq(adis->spi->irq);
-
-	return 0;
-}
-
 #define ADIS16460_DIAG_STAT_IN_CLK_OOS	7
 #define ADIS16460_DIAG_STAT_FLASH_MEM	6
 #define ADIS16460_DIAG_STAT_SELF_TEST	5
@@ -373,7 +359,7 @@ static const struct adis_data adis16460_data = {
 		BIT(ADIS16460_DIAG_STAT_OVERRANGE) |
 		BIT(ADIS16460_DIAG_STAT_SPI_COMM) |
 		BIT(ADIS16460_DIAG_STAT_FLASH_UPT),
-	.enable_irq = adis16460_enable_irq,
+	.unmasked_drdy = true,
 	.timeouts = &adis16460_timeouts,
 };
 
@@ -400,8 +386,6 @@ static int adis16460_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	/* We cannot mask the interrupt, so ensure it isn't auto enabled */
-	st->adis.irq_flag |= IRQF_NO_AUTOEN;
 	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
 		return ret;
-- 
2.33.0

