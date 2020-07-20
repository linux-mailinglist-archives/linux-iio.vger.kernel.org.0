Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF4226143
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgGTNqx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 09:46:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14326 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgGTNqw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 09:46:52 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KDgkiF024488;
        Mon, 20 Jul 2020 09:46:51 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32bx03y1mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 09:46:51 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06KDkofh047422
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 20 Jul 2020 09:46:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 20 Jul
 2020 09:46:49 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 20 Jul 2020 09:46:48 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06KDklKW003129;
        Mon, 20 Jul 2020 09:46:47 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adxl372: change indentation for of_table
Date:   Mon, 20 Jul 2020 16:48:39 +0300
Message-ID: <20200720134839.71124-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The change is mostly stylistic. The table should be indented with tabs
instead of spaces.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 3ef7e3a4804e..7741890674c1 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -40,8 +40,8 @@ static const struct spi_device_id adxl372_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
 
 static const struct of_device_id adxl372_of_match[] = {
-        { .compatible = "adi,adxl372" },
-        { },
+	{ .compatible = "adi,adxl372" },
+	{ },
 };
 MODULE_DEVICE_TABLE(of, adxl372_of_match);
 
-- 
2.17.1

