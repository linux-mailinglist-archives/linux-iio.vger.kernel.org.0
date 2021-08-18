Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F23EFE8D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhHRIFc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 04:05:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9174 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239288AbhHRIDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 04:03:31 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17HHmblS023819;
        Wed, 18 Aug 2021 04:02:35 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ag9e6e8s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 04:02:35 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 17I82XX0015366
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Aug 2021 04:02:34 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 18 Aug 2021
 01:02:32 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 18 Aug 2021 01:02:32 -0700
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17I82Uow017679;
        Wed, 18 Aug 2021 04:02:30 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] iio: ad5770r: make devicetree property reading consistent
Date:   Wed, 18 Aug 2021 10:05:25 +0200
Message-ID: <20210818080525.62790-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 2V0qE1MtmwXuxv2SqZELURYaiLwGuNma
X-Proofpoint-ORIG-GUID: 2V0qE1MtmwXuxv2SqZELURYaiLwGuNma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-18_02,2021-08-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180050
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bindings file for this driver is defining the property as 'reg' but
the driver was reading it with the 'num' name. The bindings actually had
the 'num' property when added in
commit ea52c21268e6 ("dt-bindings: iio: dac: Add docs for AD5770R DAC")
and then changed it to 'reg' in
commit 2cf3818f18b2 ("dt-bindings: iio: dac: AD5570R fix bindings errors").
However, both these commits landed in v5.7 so the assumption is
that either 'num' is not being used or if it is, the validations were not
done.

Anyways, if someone comes back yelling about this, we might just support
both of the properties in the future. Not ideal, but that's life...

Fixes: 2cf3818f18b2 ("dt-bindings: iio: dac: AD5570R fix bindings errors")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
v2:
 * Updated the commit description and added a fixes tag.

 drivers/iio/dac/ad5770r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 8107f7bbbe3c..7e2fd32e993a 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -522,7 +522,7 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
 		return -EINVAL;
 
 	device_for_each_child_node(&st->spi->dev, child) {
-		ret = fwnode_property_read_u32(child, "num", &num);
+		ret = fwnode_property_read_u32(child, "reg", &num);
 		if (ret)
 			goto err_child_out;
 		if (num >= AD5770R_MAX_CHANNELS) {
-- 
2.32.0

