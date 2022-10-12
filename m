Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313C5FC822
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJLPQ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJLPQn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 11:16:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC7DD8AB
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 08:16:39 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CDvmWI010798;
        Wed, 12 Oct 2022 11:15:51 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3k3325xu4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 11:15:51 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 29CFFogr049242
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Oct 2022 11:15:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Oct
 2022 11:15:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Oct 2022 11:15:49 -0400
Received: from nsa.ad.analog.com ([10.44.3.62])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 29CFEune022095;
        Wed, 12 Oct 2022 11:15:39 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux-imx@nxp.com>
CC:     Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 3/4] iio: health: max30102: do not use internal iio_dev lock
Date:   Wed, 12 Oct 2022 17:16:19 +0200
Message-ID: <20221012151620.1725215-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221012151620.1725215-1-nuno.sa@analog.com>
References: <20221012151620.1725215-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: a56Xv0rjtvFVayxQI_MPNd_DYA726jsv
X-Proofpoint-ORIG-GUID: a56Xv0rjtvFVayxQI_MPNd_DYA726jsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The pattern used in this device does not quite fit in the
iio_device_claim_direct_mode() typical usage. In this case, we want to
know if we are in buffered mode or not to know if the device is powered
(buffer mode) or not. And depending on that max30102_get_temp() will
power on the device if needed. Hence, in order to keep the same
functionality, we try to:

1. Claim Buffered mode;
2: If 1) succeeds call max30102_get_temp() without powering on the
   device;
3: Release Buffered mode;
4: If 1) fails, Claim Direct mode;
5: If 4) succeeds call max30102_get_temp() with powering on the device;
6: Release Direct mode;
7: If 4) fails, goto to 1) and try again.

This dance between buffered and direct mode is not particularly pretty
(as well as the loop introduced by the goto statement) but it does allow
us to get rid of the mlock usage while keeping the same behavior.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/health/max30102.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 437298a29f2d..66df4aaa31a7 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -477,12 +477,23 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 		 * Temperature reading can only be acquired when not in
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
-		mutex_lock(&indio_dev->mlock);
-		if (!iio_buffer_enabled(indio_dev))
+any_mode_retry:
+		if (iio_device_claim_buffer_mode(indio_dev)) {
+			/*
+			 * This one is a *bit* hacky. If we cannot claim buffer
+			 * mode, then try direct mode so that we make sure
+			 * things cannot concurrently change. And we just keep
+			 * trying until we get one of the modes...
+			 */
+			if (iio_device_claim_direct_mode(indio_dev))
+				goto any_mode_retry;
+
 			ret = max30102_get_temp(data, val, true);
-		else
+			iio_device_release_direct_mode(indio_dev);
+		} else {
 			ret = max30102_get_temp(data, val, false);
-		mutex_unlock(&indio_dev->mlock);
+			iio_device_release_buffer_mode(indio_dev);
+		}
 		if (ret)
 			return ret;
 
-- 
2.38.0

