Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9A27E0B9
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 07:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgI3F4B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 01:56:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62066 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgI3F4B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 01:56:01 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U5tJcU015253;
        Wed, 30 Sep 2020 01:55:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg666b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 01:55:56 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08U5tsEu004176
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 30 Sep 2020 01:55:54 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 22:55:45 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 22:55:45 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 22:55:45 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08U5tkgh031934;
        Wed, 30 Sep 2020 01:55:49 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/4] iio: adc: at91_adc: use of_device_get_match_data() helper
Date:   Wed, 30 Sep 2020 09:00:05 +0300
Message-ID: <20200930060008.42134-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930060008.42134-1-alexandru.ardelean@analog.com>
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_03:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300047
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a small tidy-up. The of_device_get_match_data() helper retrieves
the driver data from the OF table, without needed to explicitly know the
table variable (since it can retrieve it from the driver object).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91_adc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9b2c548fae95..c9ec0a4a357e 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -829,8 +829,6 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
 	return ticks;
 }
 
-static const struct of_device_id at91_adc_dt_ids[];
-
 static int at91_adc_probe_dt_ts(struct device_node *node,
 	struct at91_adc_state *st, struct device *dev)
 {
@@ -878,8 +876,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
 	if (!node)
 		return -EINVAL;
 
-	st->caps = (struct at91_adc_caps *)
-		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
+	st->caps = (struct at91_adc_caps *)of_device_get_match_data(&pdev->dev);
 
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
-- 
2.17.1

