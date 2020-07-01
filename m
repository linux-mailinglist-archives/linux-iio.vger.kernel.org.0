Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70A5210ABF
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgGAMH3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 08:07:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51136 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730103AbgGAMH3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jul 2020 08:07:29 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061C6nwc011112;
        Wed, 1 Jul 2020 08:07:13 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31x315mekd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 08:07:13 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 061C7B2A039343
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 1 Jul 2020 08:07:12 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Jul 2020 05:07:10 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Jul 2020 05:07:10 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 1 Jul 2020 05:07:10 -0700
Received: from NSA-L01.ad.analog.com (fpaumier-l01.ad.analog.com [10.32.224.81] (may be forged))
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 061C77dJ020784;
        Wed, 1 Jul 2020 08:07:08 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH] iio: adis16480: Use irq types instead of flags
Date:   Wed, 1 Jul 2020 14:07:02 +0200
Message-ID: <20200701120702.365-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=657
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=1
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010090
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The value retrieved by `irqd_get_trigger_type()` is not an irq flag.
While the values are the same, the meaning is different.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 5163749f568e..1eb4f98076f1 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1102,12 +1102,12 @@ static int adis16480_config_irq_pin(struct device_node *of_node,
 	/*
 	 * Get the interrupt line behaviour. The data ready polarity can be
 	 * configured as positive or negative, corresponding to
-	 * IRQF_TRIGGER_RISING or IRQF_TRIGGER_FALLING respectively.
+	 * IRQ_TYPE_EDGE_RISING or IRQ_TYPE_EDGE_FALLING respectively.
 	 */
 	irq_type = irqd_get_trigger_type(desc);
-	if (irq_type == IRQF_TRIGGER_RISING) { /* Default */
+	if (irq_type == IRQ_TYPE_EDGE_RISING) { /* Default */
 		val |= ADIS16480_DRDY_POL(1);
-	} else if (irq_type == IRQF_TRIGGER_FALLING) {
+	} else if (irq_type == IRQ_TYPE_EDGE_FALLING) {
 		val |= ADIS16480_DRDY_POL(0);
 	} else {
 		dev_err(&st->adis.spi->dev,
-- 
2.25.1

