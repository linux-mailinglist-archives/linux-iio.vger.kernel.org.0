Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789F325AC2F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgIBNnw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 09:43:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46468 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbgIBNnV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 09:43:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082DdL0r011878;
        Wed, 2 Sep 2020 09:42:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 337gv6mg3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 09:42:30 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 082DgTrT063816
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 2 Sep 2020 09:42:29 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 2 Sep 2020 09:42:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 2 Sep 2020 09:42:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 2 Sep 2020 09:42:27 -0400
Received: from mircea-Precision-5530-2-in-1.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 082DgPck014095;
        Wed, 2 Sep 2020 09:42:25 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] iio: adc: ad7124: Fix typo in device name
Date:   Wed, 2 Sep 2020 16:42:22 +0300
Message-ID: <20200902134222.28357-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=1 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1011 mlxlogscore=730 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch fixes the device name typo.

Fixes: 951ad4700313 ("iio: adc: ad7124: move chip ID & name on the chip_info table")
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad7124.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 8dce06e9e69c..766c73333604 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -177,12 +177,12 @@ static const struct iio_chan_spec ad7124_channel_template = {
 
 static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
 	[ID_AD7124_4] = {
-		.name = "ad7127-4",
+		.name = "ad7124-4",
 		.chip_id = CHIPID_AD7124_4,
 		.num_inputs = 8,
 	},
 	[ID_AD7124_8] = {
-		.name = "ad7127-8",
+		.name = "ad7124-8",
 		.chip_id = CHIPID_AD7124_8,
 		.num_inputs = 16,
 	},
-- 
2.25.1

