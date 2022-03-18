Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A474DDE4A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Mar 2022 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiCRQTR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Mar 2022 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiCRQTG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Mar 2022 12:19:06 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB691D788F;
        Fri, 18 Mar 2022 09:17:47 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22IEsfmG002515;
        Fri, 18 Mar 2022 12:17:45 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3evfqpcu6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 12:17:45 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 22IGHigE035523
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Mar 2022 12:17:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 18 Mar
 2022 12:17:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 18 Mar 2022 12:17:43 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22IGHWUi024583;
        Fri, 18 Mar 2022 12:17:40 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v2 3/8] iio: adc: ad7192: Add update_scan_mode
Date:   Fri, 18 Mar 2022 18:27:17 +0200
Message-ID: <20220318162722.51215-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220318162722.51215-1-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: HihOv4Xqcs6K6UZJMocoh8H1e_jTwg3o
X-Proofpoint-ORIG-GUID: HihOv4Xqcs6K6UZJMocoh8H1e_jTwg3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_11,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180088
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

The callback .set_channel cannot be used to enable
multiple channels at once, only one is allowed
simultaneously.

By adding an update_scan_mode callback, every time the
continuous mode is activated, channels will be enabled/disabled
accordingly.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7192.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 770b4e59238f..adff6472e075 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -783,6 +783,18 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	int i;
+
+	st->conf &= ~AD7192_CONF_CHAN_MASK;
+	for_each_set_bit(i, scan_mask, 8)
+		st->conf |= AD7192_CONF_CHAN(i);
+
+	return ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
+}
+
 static const struct iio_info ad7192_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -790,6 +802,7 @@ static const struct iio_info ad7192_info = {
 	.read_avail = ad7192_read_avail,
 	.attrs = &ad7192_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
 };
 
 static const struct iio_info ad7195_info = {
@@ -799,6 +812,7 @@ static const struct iio_info ad7195_info = {
 	.read_avail = ad7192_read_avail,
 	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
 };
 
 #define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _extend_name, \
-- 
2.25.1

