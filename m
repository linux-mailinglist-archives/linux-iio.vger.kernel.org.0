Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14D7DF2CB
	for <lists+linux-iio@lfdr.de>; Thu,  2 Nov 2023 13:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjKBMur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Nov 2023 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjKBMuq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Nov 2023 08:50:46 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB012F
        for <linux-iio@vger.kernel.org>; Thu,  2 Nov 2023 05:50:43 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A282J1t011165;
        Thu, 2 Nov 2023 08:50:22 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3u3935ae3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 08:50:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3A2CoK8g052327
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Nov 2023 08:50:20 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 2 Nov 2023 08:50:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 2 Nov 2023 08:50:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 2 Nov 2023 08:50:19 -0400
Received: from nsa.sphairon.box ([10.44.3.69])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3A2Co5P0022013;
        Thu, 2 Nov 2023 08:50:09 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH] iio: imu: adis16475: add spi_device_id table
Date:   Thu, 2 Nov 2023 13:52:58 +0100
Message-ID: <20231102125258.3284830-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: IPVjbd1ukgPTScTQHH8j5-LiLmIDA4iA
X-Proofpoint-ORIG-GUID: IPVjbd1ukgPTScTQHH8j5-LiLmIDA4iA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_02,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2311020103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This prevents the warning message "SPI driver has no spi_device_id for..."
when registering the driver. More importantly, it makes sure that
module autoloading works as spi relies on spi: modaliases and not of.

While at it, move the of_device_id table to it's natural place.

Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---

I'm adding the fixes tag as module autoloading might be a nice thing to
backport... Jonathan, if you don't see a real need for it, feel free to
drop the tag.

 drivers/iio/imu/adis16475.c | 117 ++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index b7cbe1565aee..04153a2725d5 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1406,50 +1406,6 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 	return 0;
 }
 
-static const struct of_device_id adis16475_of_match[] = {
-	{ .compatible = "adi,adis16470",
-		.data = &adis16475_chip_info[ADIS16470] },
-	{ .compatible = "adi,adis16475-1",
-		.data = &adis16475_chip_info[ADIS16475_1] },
-	{ .compatible = "adi,adis16475-2",
-		.data = &adis16475_chip_info[ADIS16475_2] },
-	{ .compatible = "adi,adis16475-3",
-		.data = &adis16475_chip_info[ADIS16475_3] },
-	{ .compatible = "adi,adis16477-1",
-		.data = &adis16475_chip_info[ADIS16477_1] },
-	{ .compatible = "adi,adis16477-2",
-		.data = &adis16475_chip_info[ADIS16477_2] },
-	{ .compatible = "adi,adis16477-3",
-		.data = &adis16475_chip_info[ADIS16477_3] },
-	{ .compatible = "adi,adis16465-1",
-		.data = &adis16475_chip_info[ADIS16465_1] },
-	{ .compatible = "adi,adis16465-2",
-		.data = &adis16475_chip_info[ADIS16465_2] },
-	{ .compatible = "adi,adis16465-3",
-		.data = &adis16475_chip_info[ADIS16465_3] },
-	{ .compatible = "adi,adis16467-1",
-		.data = &adis16475_chip_info[ADIS16467_1] },
-	{ .compatible = "adi,adis16467-2",
-		.data = &adis16475_chip_info[ADIS16467_2] },
-	{ .compatible = "adi,adis16467-3",
-		.data = &adis16475_chip_info[ADIS16467_3] },
-	{ .compatible = "adi,adis16500",
-		.data = &adis16475_chip_info[ADIS16500] },
-	{ .compatible = "adi,adis16505-1",
-		.data = &adis16475_chip_info[ADIS16505_1] },
-	{ .compatible = "adi,adis16505-2",
-		.data = &adis16475_chip_info[ADIS16505_2] },
-	{ .compatible = "adi,adis16505-3",
-		.data = &adis16475_chip_info[ADIS16505_3] },
-	{ .compatible = "adi,adis16507-1",
-		.data = &adis16475_chip_info[ADIS16507_1] },
-	{ .compatible = "adi,adis16507-2",
-		.data = &adis16475_chip_info[ADIS16507_2] },
-	{ .compatible = "adi,adis16507-3",
-		.data = &adis16475_chip_info[ADIS16507_3] },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, adis16475_of_match);
 
 static int adis16475_probe(struct spi_device *spi)
 {
@@ -1463,7 +1419,7 @@ static int adis16475_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->info = device_get_match_data(&spi->dev);
+	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -EINVAL;
 
@@ -1503,12 +1459,83 @@ static int adis16475_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id adis16475_of_match[] = {
+	{ .compatible = "adi,adis16470",
+		.data = &adis16475_chip_info[ADIS16470] },
+	{ .compatible = "adi,adis16475-1",
+		.data = &adis16475_chip_info[ADIS16475_1] },
+	{ .compatible = "adi,adis16475-2",
+		.data = &adis16475_chip_info[ADIS16475_2] },
+	{ .compatible = "adi,adis16475-3",
+		.data = &adis16475_chip_info[ADIS16475_3] },
+	{ .compatible = "adi,adis16477-1",
+		.data = &adis16475_chip_info[ADIS16477_1] },
+	{ .compatible = "adi,adis16477-2",
+		.data = &adis16475_chip_info[ADIS16477_2] },
+	{ .compatible = "adi,adis16477-3",
+		.data = &adis16475_chip_info[ADIS16477_3] },
+	{ .compatible = "adi,adis16465-1",
+		.data = &adis16475_chip_info[ADIS16465_1] },
+	{ .compatible = "adi,adis16465-2",
+		.data = &adis16475_chip_info[ADIS16465_2] },
+	{ .compatible = "adi,adis16465-3",
+		.data = &adis16475_chip_info[ADIS16465_3] },
+	{ .compatible = "adi,adis16467-1",
+		.data = &adis16475_chip_info[ADIS16467_1] },
+	{ .compatible = "adi,adis16467-2",
+		.data = &adis16475_chip_info[ADIS16467_2] },
+	{ .compatible = "adi,adis16467-3",
+		.data = &adis16475_chip_info[ADIS16467_3] },
+	{ .compatible = "adi,adis16500",
+		.data = &adis16475_chip_info[ADIS16500] },
+	{ .compatible = "adi,adis16505-1",
+		.data = &adis16475_chip_info[ADIS16505_1] },
+	{ .compatible = "adi,adis16505-2",
+		.data = &adis16475_chip_info[ADIS16505_2] },
+	{ .compatible = "adi,adis16505-3",
+		.data = &adis16475_chip_info[ADIS16505_3] },
+	{ .compatible = "adi,adis16507-1",
+		.data = &adis16475_chip_info[ADIS16507_1] },
+	{ .compatible = "adi,adis16507-2",
+		.data = &adis16475_chip_info[ADIS16507_2] },
+	{ .compatible = "adi,adis16507-3",
+		.data = &adis16475_chip_info[ADIS16507_3] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16475_of_match);
+
+static const struct spi_device_id adis16475_ids[] = {
+	{ "adis16470", (kernel_ulong_t)&adis16475_chip_info[ADIS16470] },
+	{ "adis16475-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_1] },
+	{ "adis16475-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_2] },
+	{ "adis16475-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16475_3] },
+	{ "adis16477-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_1] },
+	{ "adis16477-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_2] },
+	{ "adis16477-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16477_3] },
+	{ "adis16465-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_1] },
+	{ "adis16465-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_2] },
+	{ "adis16465-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16465_3] },
+	{ "adis16467-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_1] },
+	{ "adis16467-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_2] },
+	{ "adis16467-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_3] },
+	{ "adis16500", (kernel_ulong_t)&adis16475_chip_info[ADIS16500] },
+	{ "adis16505-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_1] },
+	{ "adis16505-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_2] },
+	{ "adis16505-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_3] },
+	{ "adis16507-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_1] },
+	{ "adis16507-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_2] },
+	{ "adis16507-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16507_3] },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adis16475_ids);
+
 static struct spi_driver adis16475_driver = {
 	.driver = {
 		.name = "adis16475",
 		.of_match_table = adis16475_of_match,
 	},
 	.probe = adis16475_probe,
+	.id_table = adis16475_ids,
 };
 module_spi_driver(adis16475_driver);
 
-- 
2.42.0

