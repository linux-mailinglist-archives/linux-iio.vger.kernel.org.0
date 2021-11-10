Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F303444BFCC
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 12:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhKJLKW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 06:10:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4650 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231330AbhKJLKV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2021 06:10:21 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AA82klH018634;
        Wed, 10 Nov 2021 06:07:34 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c8a7p0jdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 06:07:33 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1AAB7W6c020115
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 06:07:32 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 06:07:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 10 Nov 2021 06:07:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Wed, 10 Nov 2021 06:07:31 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AAB7OD7030773;
        Wed, 10 Nov 2021 06:07:29 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 2/5] iio: adc: ad7192: Add update_scan_mode
Date:   Wed, 10 Nov 2021 13:17:47 +0200
Message-ID: <20211110111750.27263-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110111750.27263-1-alexandru.tachici@analog.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: OGRl-FkAAdsK9F61EjyLshTMCTqJvA7_
X-Proofpoint-GUID: OGRl-FkAAdsK9F61EjyLshTMCTqJvA7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111100059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

In continuous mode neither sigma_delta.c nor ad7192.c
will disable previously enabled channels.

Before this patch a channel stayed enabled indefinetly,
even when one another one was supposed to be sampled.
This causes mixed samples in continuous mode to be delivered
to the host.

By adding an update_scan_mode callback, every time the
continuous mode is activated, channels will be enabled/disabled
accordingly.

Fixes: 3f7c3306cf38 ("staging:iio:ad7192: Use common Sigma Delta library")
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7192.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 2121a812b0c3..1fc0f4eb858e 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -782,6 +782,20 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	int i;
+
+	st->conf &= ~AD7192_CONF_CHAN_MASK;
+	for (i = 0; i < 8; i++) {
+		if (test_bit(i, scan_mask))
+			st->conf |= AD7192_CONF_CHAN(i);
+	}
+
+	return ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
+}
+
 static const struct iio_info ad7192_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -789,6 +803,7 @@ static const struct iio_info ad7192_info = {
 	.read_avail = ad7192_read_avail,
 	.attrs = &ad7192_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
 };
 
 static const struct iio_info ad7195_info = {
@@ -798,6 +813,7 @@ static const struct iio_info ad7195_info = {
 	.read_avail = ad7192_read_avail,
 	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
 };
 
 #define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _extend_name, \
-- 
2.25.1

