Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365BE400113
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhICOMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:12:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14934 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234951AbhICOMm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:12:42 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1838x6Ke008649;
        Fri, 3 Sep 2021 10:11:31 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3augp61cjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:11:31 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 183EBUAk040542
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 10:11:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 3 Sep 2021 10:11:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 3 Sep 2021 10:11:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 3 Sep 2021 10:11:29 -0400
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 183EBOFD024311;
        Fri, 3 Sep 2021 10:11:27 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 3/5] iio: adis16475: make use of the new unmasked_drdy flag
Date:   Fri, 3 Sep 2021 16:14:21 +0200
Message-ID: <20210903141423.517028-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903141423.517028-1-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: quXX766OwlWPp48unTny7puewA9FsNys
X-Proofpoint-ORIG-GUID: quXX766OwlWPp48unTny7puewA9FsNys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030088
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
 drivers/iio/imu/adis16475.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index eb48102f9424..b76d8482bbd5 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -606,20 +606,6 @@ static const char * const adis16475_status_error_msgs[] = {
 	[ADIS16475_DIAG_STAT_CLK] = "Clock error",
 };
 
-static int adis16475_enable_irq(struct adis *adis, bool enable)
-{
-	/*
-	 * There is no way to gate the data-ready signal internally inside the
-	 * ADIS16475. We can only control it's polarity...
-	 */
-	if (enable)
-		enable_irq(adis->spi->irq);
-	else
-		disable_irq(adis->spi->irq);
-
-	return 0;
-}
-
 #define ADIS16475_DATA(_prod_id, _timeouts)				\
 {									\
 	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,				\
@@ -640,7 +626,7 @@ static int adis16475_enable_irq(struct adis *adis, bool enable)
 		BIT(ADIS16475_DIAG_STAT_SENSOR) |			\
 		BIT(ADIS16475_DIAG_STAT_MEMORY) |			\
 		BIT(ADIS16475_DIAG_STAT_CLK),				\
-	.enable_irq = adis16475_enable_irq,				\
+	.unmasked_drdy = true,						\
 	.timeouts = (_timeouts),					\
 	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,			\
 	.burst_len = ADIS16475_BURST_MAX_DATA,				\
@@ -1254,9 +1240,6 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 		return -EINVAL;
 	}
 
-	/* We cannot mask the interrupt so ensure it's not enabled at request */
-	st->adis.irq_flag |= IRQF_NO_AUTOEN;
-
 	val = ADIS16475_MSG_CTRL_DR_POL(polarity);
 	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
 				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
-- 
2.33.0

