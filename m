Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6671E0F1B
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbgEYNKe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 09:10:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28886 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388757AbgEYNKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 09:10:34 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04PD7c4t027485;
        Mon, 25 May 2020 09:10:32 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3170r5xecg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 09:10:32 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04PDAVWt032470
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 May 2020 09:10:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 09:10:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 09:10:30 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 25 May 2020 09:10:30 -0400
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04PDASNt016371;
        Mon, 25 May 2020 09:10:29 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dac: ad5592r: remove usage of iio_priv_to_dev() helper
Date:   Mon, 25 May 2020 16:10:34 +0300
Message-ID: <20200525131034.230738-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-25_08:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 cotscore=-2147483648 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This was partially removed when the mlock cleanup was done. Only one more
call is left in the ad5592r_alloc_channels() function.
This one is simple. We just need to pass the iio_dev object and get the
state via iio_priv().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ad5592r-base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 410e90e5f75f..272c97bb841c 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -508,11 +508,11 @@ static void ad5592r_setup_channel(struct iio_dev *iio_dev,
 	chan->ext_info = ad5592r_ext_info;
 }
 
-static int ad5592r_alloc_channels(struct ad5592r_state *st)
+static int ad5592r_alloc_channels(struct iio_dev *iio_dev)
 {
+	struct ad5592r_state *st = iio_priv(iio_dev);
 	unsigned i, curr_channel = 0,
 		 num_channels = st->num_channels;
-	struct iio_dev *iio_dev = iio_priv_to_dev(st);
 	struct iio_chan_spec *channels;
 	struct fwnode_handle *child;
 	u32 reg, tmp;
@@ -636,7 +636,7 @@ int ad5592r_probe(struct device *dev, const char *name,
 	if (ret)
 		goto error_disable_reg;
 
-	ret = ad5592r_alloc_channels(st);
+	ret = ad5592r_alloc_channels(iio_dev);
 	if (ret)
 		goto error_disable_reg;
 
-- 
2.25.1

