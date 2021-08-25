Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00333F7131
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhHYIjz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 04:39:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35820 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239399AbhHYIjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 04:39:54 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P4sQEq004266;
        Wed, 25 Aug 2021 04:38:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3amuapx759-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 04:38:56 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 17P8ctAd025643
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 04:38:55 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 25 Aug 2021 04:38:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 25 Aug 2021 04:38:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Wed, 25 Aug 2021 04:38:53 -0400
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17P8cpRR030444;
        Wed, 25 Aug 2021 04:38:53 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v2 2/2] iio: ltc2983: fail probe if no channels are given
Date:   Wed, 25 Aug 2021 10:41:49 +0200
Message-ID: <20210825084149.11587-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825084149.11587-1-nuno.sa@analog.com>
References: <20210825084149.11587-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: A-aogImFxaQfM7fqcSwJ8W4FsoNuzYTH
X-Proofpoint-ORIG-GUID: A-aogImFxaQfM7fqcSwJ8W4FsoNuzYTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-25_02,2021-08-25_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=993 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250051
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If there are no channels defined in the devicetree, there's no point in
probing the device. We were actually requesting a zero sized 'kmalloc'
array but since we were not touching the ZERO_SIZE_PTR afterwards,
nothing bad was actually happening. Hence this is not really a fix but
rather an improvement.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Nothing changed in v2.

 drivers/iio/temperature/ltc2983.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 22e6a26ce6b1..301c3f13fb26 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1275,6 +1275,11 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 			     &st->filter_notch_freq);
 
 	st->num_channels = of_get_available_child_count(dev->of_node);
+	if (!st->num_channels) {
+		dev_err(&st->spi->dev, "At least one channel must be given!");
+		return -EINVAL;
+	}
+
 	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
 				   GFP_KERNEL);
 	if (!st->sensors)
-- 
2.33.0

