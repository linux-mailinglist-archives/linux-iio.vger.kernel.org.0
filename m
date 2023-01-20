Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1E6754DC
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jan 2023 13:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjATMp0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Jan 2023 07:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjATMp0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2023 07:45:26 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55212422C
        for <linux-iio@vger.kernel.org>; Fri, 20 Jan 2023 04:45:25 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K8a7cp000447;
        Fri, 20 Jan 2023 07:45:12 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3n736yqs93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:45:12 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 30KCjAWC056633
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jan 2023 07:45:10 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 20 Jan
 2023 07:45:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Jan 2023 07:45:09 -0500
Received: from nsa.ad.analog.com ([10.44.3.102])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 30KCj0QU030429;
        Fri, 20 Jan 2023 07:45:02 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: adc: ad7791: fix IRQ flags
Date:   Fri, 20 Jan 2023 13:46:45 +0100
Message-ID: <20230120124645.819910-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FaSd_9Zv0lYNHMPmyI2K8BLls8BiuT-Y
X-Proofpoint-ORIG-GUID: FaSd_9Zv0lYNHMPmyI2K8BLls8BiuT-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 mlxlogscore=740 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200120
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interrupt is triggered on the falling edge rather than being a level
low interrupt.

Fixes: da4d3d6bb9f6 ("iio: adc: ad-sigma-delta: Allow custom IRQ flags")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index fee8d129a5f0..86effe8501b4 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -253,7 +253,7 @@ static const struct ad_sigma_delta_info ad7791_sigma_delta_info = {
 	.has_registers = true,
 	.addr_shift = 4,
 	.read_mask = BIT(3),
-	.irq_flags = IRQF_TRIGGER_LOW,
+	.irq_flags = IRQF_TRIGGER_FALLING,
 };
 
 static int ad7791_read_raw(struct iio_dev *indio_dev,
-- 
2.39.1

