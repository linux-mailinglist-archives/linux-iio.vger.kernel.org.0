Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E964810194B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2019 07:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKSGWM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Nov 2019 01:22:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33358 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKSGWL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Nov 2019 01:22:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ69EIY164680;
        Tue, 19 Nov 2019 06:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=1zXRhfPb+27DJIITzkZtg4bFw63qjUcLjk05ln1sXm0=;
 b=oMQ0wRM7vsKtTcCKwK2Jru2j2J4ssTJMdFzn7FcD/9TVUjCcOQT+XVUVXdu1q5nJijpF
 ESrmG5dc4deQkPieJmokDzZUSm3j8mnG2PHl4eEtaTEuzHgpcpllAZSmpRGJVfkQTXKM
 OzxIbokCbJTvwFKxxRMRxxxssKpyraSnTnmBu9RvFNDGYv2t2qxklU5B2KrxS2WBgKKj
 1iUMM9ppvJAKuKK4IFEr6JYt1TVXS6Hm+So9896673yDMKGGQgvnKvIV2KoafSvLE8XB
 nb1VeIw56Ccz/vMW+Gg4JpVH8gtaT5iDxtlU93ncvi0w34830ozXwoyJ6OUkvOSD7+uB Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htmtm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:21:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ68Y43074535;
        Tue, 19 Nov 2019 06:21:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wbxgedvcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:21:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ6LXvZ006597;
        Tue, 19 Nov 2019 06:21:33 GMT
Received: from kili.mountain (/41.210.141.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 22:21:33 -0800
Date:   Tue, 19 Nov 2019 09:21:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: intel_mrfld_adc: Allocating too much data in
 probe()
Message-ID: <20191119062124.kgwg7ujxe6k2ft3o@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190057
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This probe function is passing the wrong size to devm_iio_device_alloc().
It is supposed to be the size of the private data.  Fortunately,
sizeof(*indio_dev) is larger than sizeof(struct mrfld_adc) so it doesn't
cause a runtime problem.

Fixes: a7118662734a ("iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/adc/intel_mrfld_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index 67d096f8180d..c35a1beb817c 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -185,7 +185,7 @@ static int mrfld_adc_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*indio_dev));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mrfld_adc));
 	if (!indio_dev)
 		return -ENOMEM;
 
-- 
2.11.0

