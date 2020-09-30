Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14A27E0BF
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgI3F4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 01:56:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62506 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbgI3F4B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 01:56:01 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U5pfqU032548;
        Wed, 30 Sep 2020 01:55:56 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4p1d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 01:55:56 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08U5ttTd062606
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 30 Sep 2020 01:55:55 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 30 Sep 2020 01:55:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 30 Sep 2020 01:55:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 30 Sep 2020 01:55:46 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08U5tkgi031934;
        Wed, 30 Sep 2020 01:55:50 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/4] iio: adc: at91_adc: const-ify some driver data
Date:   Wed, 30 Sep 2020 09:00:06 +0300
Message-ID: <20200930060008.42134-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930060008.42134-1-alexandru.ardelean@analog.com>
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_03:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300047
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The main intent is to get rid of the cast for the void-pointer returned by
of_device_get_match_data().

This requires const-ifying the 'caps' and 'registers' references on the
at91_adc_state struct.

The caps can be obtained also from the old platform_data (in the
at91_adc_probe_pdata() function), but that cast is not touched in this
patch, since the old platform_data should be removed/cleaned-away.
Also, that cast deals with converting a kernel_ulong_t type to a pointer.
So, updating that cast doesn't yield any benefit.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index c9ec0a4a357e..7d846a2852a5 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -202,7 +202,7 @@ struct at91_adc_state {
 	struct mutex		lock;
 	u8			num_channels;
 	void __iomem		*reg_base;
-	struct at91_adc_reg_desc *registers;
+	const struct at91_adc_reg_desc *registers;
 	u32			startup_time;
 	u8			sample_hold_time;
 	bool			sleep_mode;
@@ -214,7 +214,7 @@ struct at91_adc_state {
 	u32			res;		/* resolution used for convertions */
 	bool			low_res;	/* the resolution corresponds to the lowest one */
 	wait_queue_head_t	wq_data_avail;
-	struct at91_adc_caps	*caps;
+	const struct at91_adc_caps	*caps;
 
 	/*
 	 * Following ADC channels are shared by touchscreen:
@@ -550,7 +550,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *idev = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(idev);
-	struct at91_adc_reg_desc *reg = st->registers;
+	const struct at91_adc_reg_desc *reg = st->registers;
 	u32 status = at91_adc_readl(st, reg->trigger_register);
 	int value;
 	u8 bit;
@@ -876,7 +876,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
 	if (!node)
 		return -EINVAL;
 
-	st->caps = (struct at91_adc_caps *)of_device_get_match_data(&pdev->dev);
+	st->caps = of_device_get_match_data(&pdev->dev);
 
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
-- 
2.17.1

