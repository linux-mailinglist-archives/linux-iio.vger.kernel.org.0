Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7905C27AE57
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 14:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgI1MzN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 08:55:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17038 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgI1MzL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 08:55:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SCt5Lr003527;
        Mon, 28 Sep 2020 08:55:05 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg5y9s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 08:55:05 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08SCt0kS056643
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Sep 2020 08:55:01 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 28 Sep 2020 05:54:54 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 28 Sep 2020 05:54:54 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 28 Sep 2020 05:54:54 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08SCsrdi029765;
        Mon, 28 Sep 2020 08:54:56 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] iio: adc: at91_adc: const-ify some driver data
Date:   Mon, 28 Sep 2020 15:54:24 +0300
Message-ID: <20200928125424.35921-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928125424.35921-1-alexandru.ardelean@analog.com>
References: <20200928125424.35921-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280103
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

