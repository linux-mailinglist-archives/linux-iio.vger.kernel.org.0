Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A32757CA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 14:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWMSe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 08:18:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13348 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWMSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2020 08:18:33 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NCALBb024115;
        Wed, 23 Sep 2020 08:18:20 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u982va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 08:18:20 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08NCIJOH006721
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 23 Sep 2020 08:18:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 23 Sep
 2020 08:18:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 23 Sep 2020 08:18:18 -0400
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08NCIGSI009889;
        Wed, 23 Sep 2020 08:18:16 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: buffer-dmaengine: remove non managed alloc/free
Date:   Wed, 23 Sep 2020 15:18:10 +0300
Message-ID: <20200923121810.944075-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_07:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=2 clxscore=1015
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230099
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is to encourage the use of devm_iio_dmaengine_buffer_alloc().
Currently the managed version of the DMAEngine buffer alloc is the only
function used from this part of the framework.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 6 ++----
 include/linux/iio/buffer-dmaengine.h               | 4 ----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 5789bda0745b..93b4e9e6bb55 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -159,7 +159,7 @@ static const struct attribute *iio_dmaengine_buffer_attrs[] = {
  * Once done using the buffer iio_dmaengine_buffer_free() should be used to
  * release it.
  */
-struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
+static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
@@ -211,7 +211,6 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(iio_dmaengine_buffer_alloc);
 
 /**
  * iio_dmaengine_buffer_free() - Free dmaengine buffer
@@ -219,7 +218,7 @@ EXPORT_SYMBOL(iio_dmaengine_buffer_alloc);
  *
  * Frees a buffer previously allocated with iio_dmaengine_buffer_alloc().
  */
-void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
+static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 {
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(buffer);
@@ -229,7 +228,6 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 
 	iio_buffer_put(buffer);
 }
-EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
 
 static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
 {
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 0e503db71289..5b502291d6a4 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -10,10 +10,6 @@
 struct iio_buffer;
 struct device;
 
-struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel);
-void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
-
 struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 						   const char *channel);
 
-- 
2.25.1

