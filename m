Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DEE2CD063
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 08:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgLCH1i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 02:27:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37334 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbgLCH1i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 02:27:38 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B37PmJG003595;
        Thu, 3 Dec 2020 02:26:56 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vj5mwg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 02:26:56 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0B37QtF2063428
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 02:26:55 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 02:26:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 02:26:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 02:26:54 -0500
Received: from saturn.ad.analog.com ([10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B37Qqx6019743;
        Thu, 3 Dec 2020 02:26:52 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()
Date:   Thu, 3 Dec 2020 09:26:50 +0200
Message-ID: <20201203072650.24128-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_03:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=2 mlxscore=0 bulkscore=0
 mlxlogscore=752 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030044
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the conversion was done to use devm_iio_kfifo_allocate(), a call to
iio_kfifo_free() was omitted (to be removed).
This change removes it.

Fixes: 3c5308058899 ("iio: adc: ti_am335x_adc: alloc kfifo & IRQ via devm_ functions")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Seems I was doing too many things at once when I wrote this.

 drivers/iio/adc/ti_am335x_adc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index b11c8c47ba2a..e946903b0993 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -397,16 +397,12 @@ static int tiadc_iio_buffered_hardware_setup(struct device *dev,
 	ret = devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
 				flags, indio_dev->name, indio_dev);
 	if (ret)
-		goto error_kfifo_free;
+		return ret;
 
 	indio_dev->setup_ops = setup_ops;
 	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
 
 	return 0;
-
-error_kfifo_free:
-	iio_kfifo_free(indio_dev->buffer);
-	return ret;
 }
 
 static const char * const chan_name_ain[] = {
-- 
2.27.0

