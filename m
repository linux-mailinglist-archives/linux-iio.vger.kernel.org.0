Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8D14B90A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgA1O0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 09:26:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59696 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733098AbgA1O0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 09:26:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SEHZhb008962;
        Tue, 28 Jan 2020 09:25:48 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xrkfah3e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 09:25:47 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00SEPkJo028606
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 28 Jan 2020 09:25:46 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 28 Jan
 2020 09:25:45 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 28 Jan 2020 06:25:45 -0800
Received: from mircea-Precision-5530-2-in-1.ad.analog.com ([10.48.65.114])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00SEPgIx007832;
        Tue, 28 Jan 2020 09:25:42 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea <mircea.caprioru@analog.com>
Subject: [PATCH] iio: adc: ad7124: Add direct reg access
Date:   Tue, 28 Jan 2020 16:25:49 +0200
Message-ID: <20200128142549.1370-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_03:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=818 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280115
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Mircea <mircea.caprioru@analog.com>

This patch adds the posibility do read and write registers from userspace
using the kernel debug direct register access option.

Signed-off-by: Mircea <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad7124.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 52f45b13da4a..38e67e08a79a 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -93,6 +93,14 @@ static const unsigned int ad7124_gain[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128
 };
 
+static const unsigned int ad7124_reg_size[] = {
+	1, 2, 3, 3, 2, 1, 3, 3, 1, 2, 2, 2, 2,
+	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
+	2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3,
+	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
+	3, 3, 3, 3, 3
+};
+
 static const int ad7124_master_clk_freq_hz[3] = {
 	[AD7124_LOW_POWER] = 76800,
 	[AD7124_MID_POWER] = 153600,
@@ -360,6 +368,25 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7124_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	int ret;
+
+
+	if (readval)
+		ret = ad_sd_read_reg(&st->sd, reg, ad7124_reg_size[reg],
+				     readval);
+	else
+		ret = ad_sd_write_reg(&st->sd, reg, ad7124_reg_size[reg],
+				      writeval);
+
+	return ret;
+}
+
 static IIO_CONST_ATTR(in_voltage_scale_available,
 	"0.000001164 0.000002328 0.000004656 0.000009313 0.000018626 0.000037252 0.000074505 0.000149011 0.000298023");
 
@@ -375,6 +402,7 @@ static const struct attribute_group ad7124_attrs_group = {
 static const struct iio_info ad7124_info = {
 	.read_raw = ad7124_read_raw,
 	.write_raw = ad7124_write_raw,
+	.debugfs_reg_access = &ad7124_reg_access,
 	.validate_trigger = ad_sd_validate_trigger,
 	.attrs = &ad7124_attrs_group,
 };
-- 
2.17.1

