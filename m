Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9375226BF51
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIPIbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 04:31:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65512 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgIPIbg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 04:31:36 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08G8FKwZ016626;
        Wed, 16 Sep 2020 04:31:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p61pns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 04:31:34 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08G8VWdp016112
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 16 Sep 2020 04:31:33 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 16 Sep
 2020 01:31:40 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 16 Sep 2020 01:31:40 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08G8VTMD020230;
        Wed, 16 Sep 2020 04:31:29 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: ad9467: refine mismatch vs unknown chip-id messages
Date:   Wed, 16 Sep 2020 11:31:28 +0300
Message-ID: <20200916083128.73729-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_02:2020-09-15,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=756
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160061
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We should probably print what the expected chip-ID is. We already have
that information available, based on the device specified via
device-tree.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad9467.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 8a6682b567be..f068256cfca9 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -390,7 +390,8 @@ static int ad9467_probe(struct spi_device *spi)
 
 	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
 	if (id != conv->chip_info->id) {
-		dev_err(&spi->dev, "Unrecognized CHIP_ID 0x%X\n", id);
+		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
+			id, conv->chip_info->id);
 		return -ENODEV;
 	}
 
-- 
2.17.1

