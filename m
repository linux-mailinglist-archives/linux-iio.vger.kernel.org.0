Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA01022EB23
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG0LXr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 07:23:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39742 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG0LXr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 07:23:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBMjtd087912;
        Mon, 27 Jul 2020 11:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=4g8Mg/f4ko6sYKfDKAQgbqJbY3cbZ2DqaE6bhsDlpnI=;
 b=zmU/y3pV+IRRyZNt1ksr/yXkQURQXKclNX9CmmxhC4KZwyaoF7GKsZLHqZYo9b4wB3ve
 94A0OGhfYwo64Oo6Z6YrMRnGmjvAgpwsqRiFtdHXCpbSk7a1zU7885AbQIcXm7JEmSP1
 uDX7BbqZJsu3mVVbL/Xh0La52t7++xG4FO4Ckq4Zp1AO4R5P7GpFrS/DwtUT/imcxQhM
 qV0H3DLpfVMDPqbabWeoHHEh8aEg4gqQO+aR3O0I1o2wiLUi6ReJPs/ksQ5XQH31Mj00
 Jl+aLnH/6QOrVRZ3fJgVsVfwTCpmfhJuAKzAX2IPouILg1d61uz7L7iOp61pQC8gM6zv 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1j0xud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 11:23:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBMdNV001885;
        Mon, 27 Jul 2020 11:23:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32hu5sf1pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 11:23:25 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06RBNNGi004797;
        Mon, 27 Jul 2020 11:23:23 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 04:23:23 -0700
Date:   Mon, 27 Jul 2020 14:23:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] counter: microchip-tcb-capture: check the correct variable
Message-ID: <20200727112316.GG389488@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270084
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This should be testing "regmap" instead of "priv->regmap".  The
"priv->regmap" variable is always zero so it's not an error pointer.

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The commit 106b104137fd ("counter: Add microchip TCB capture counter")
doesn't use the correct patch prefix.  This is a common mistake for the
the first commit which adds the driver.  There is no kernel wide
standard for patch prefixes so it's difficult for people sending fixes
to know the correct prefix should be.

 drivers/counter/microchip-tcb-capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index f7b7743ddb94..b7b252c5addf 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -320,8 +320,8 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	}
 
 	regmap = syscon_node_to_regmap(np->parent);
-	if (IS_ERR(priv->regmap))
-		return PTR_ERR(priv->regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	/* max. channels number is 2 when in QDEC mode */
 	priv->num_channels = of_property_count_u32_elems(np, "reg");
-- 
2.27.0

