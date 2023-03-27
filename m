Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996106CA83C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Mar 2023 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjC0Oww (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Mar 2023 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjC0Oww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2023 10:52:52 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD590E5
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 07:52:48 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32REdZj5020717;
        Mon, 27 Mar 2023 10:52:26 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3phwv7hpvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:52:26 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 32REqOCs044121
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:52:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Mar
 2023 10:52:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Mar 2023 10:52:23 -0400
Received: from nsa.sphairon.box ([10.44.3.102])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 32REqC1t025692;
        Mon, 27 Mar 2023 10:52:14 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-staging@lists.linux.dev>, <linux-iio@vger.kernel.org>
CC:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging: iio: resolver: ads1210: fix config mode
Date:   Mon, 27 Mar 2023 16:54:14 +0200
Message-ID: <20230327145414.1505537-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: FQlByd-5snak8J6dm0-vdpfiW4sAORTS
X-Proofpoint-GUID: FQlByd-5snak8J6dm0-vdpfiW4sAORTS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270117
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As stated in the device datasheet [1], bits a0 and a1 have to be set to
1 for the configuration mode.

[1]: https://www.analog.com/media/en/technical-documentation/data-sheets/ad2s1210.pdf

Fixes: b19e9ad5e2cb9 ("staging:iio:resolver:ad2s1210 general driver cleanup")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index e4cf42438487..636c45b12843 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -101,7 +101,7 @@ struct ad2s1210_state {
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 0 },
+	[MOD_CONFIG] = { 1, 1 },
 };
 
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
-- 
2.40.0

