Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40901DB2A4
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETMDl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 08:03:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMDk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 08:03:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC1nNd103882;
        Wed, 20 May 2020 12:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Y1MQEGvu3gYYA3UnM30EvWDDEUH6sHJ1Ye683uSiDbA=;
 b=dRB1pciYlmPTqkGte2eeREKajM0WHft1RnWt0l5OJaWmh8QlgKlDR91iMuI5TUV80cdj
 xK4afpy2ZxC3LcSrgMi4zJEsrMmne7VA0TmZrSyKDTdo8+bNExd5Ih9GJ+EES7Q7eSav
 X0QyhJB/+IHZZDDQVdiiDpTBGWYlEf/FvPK8oxW4Ig2c68guVqKKyvaOx/oEfypoe+G/
 tHLGs9DdFkD+9HYV2WzIz8YeHY1j1t6WvZa8S8L4g/9UptqRT8fmWVsJrZokOX0qX5NJ
 gKxq5y95a/hT6wMcYdaisjFLuyV0mwFDunN5k7CMeKGOIEJGSvgWQZoh9B0ZiP5x8ULv Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31284m2pfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:03:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC3BbR104689;
        Wed, 20 May 2020 12:03:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3150205tmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:03:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KC3EKv014477;
        Wed, 20 May 2020 12:03:14 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:03:14 -0700
Date:   Wed, 20 May 2020 15:03:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: dummy_evgen: Fix use after free on error in
 iio_dummy_evgen_create()
Message-ID: <20200520120306.GD172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=2 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to preserve the "iio_evgen->irq_sim_domain" error code before
we free "iio_evgen" otherwise it leads to a use after free.

Fixes: 337cbeb2c13e ("genirq/irq_sim: Simplify the API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/dummy/iio_dummy_evgen.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index 409fe0f7df1c..ee85d596e528 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -45,6 +45,8 @@ static struct iio_dummy_eventgen *iio_evgen;
 
 static int iio_dummy_evgen_create(void)
 {
+	int ret;
+
 	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
 	if (!iio_evgen)
 		return -ENOMEM;
@@ -52,8 +54,9 @@ static int iio_dummy_evgen_create(void)
 	iio_evgen->irq_sim_domain = irq_domain_create_sim(NULL,
 							  IIO_EVENTGEN_NO);
 	if (IS_ERR(iio_evgen->irq_sim_domain)) {
+		ret = PTR_ERR(iio_evgen->irq_sim_domain);
 		kfree(iio_evgen);
-		return PTR_ERR(iio_evgen->irq_sim_domain);
+		return ret;
 	}
 
 	mutex_init(&iio_evgen->lock);
-- 
2.26.2

