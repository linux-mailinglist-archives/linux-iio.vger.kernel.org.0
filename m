Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50D32CD2E3
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 10:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgLCJuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 04:50:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5790 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728789AbgLCJuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 04:50:55 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B39VCfr022503;
        Thu, 3 Dec 2020 04:50:14 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vj5n7ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 04:50:13 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0B39oCJe054227
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 04:50:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 3 Dec 2020
 04:50:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 04:50:11 -0500
Received: from saturn.ad.analog.com ([10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B39o9EA002710;
        Thu, 3 Dec 2020 04:50:10 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: dummy: convert all simple allocation devm_ variants
Date:   Thu, 3 Dec 2020 11:50:03 +0200
Message-ID: <20201203095005.72252-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=2 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030058
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since a main requirement for an IIO device is to have a parent device
object, it makes sense to attach more of the IIO device's objects to the
lifetime of the parent object, to clean up the code.
The idea is to also provide a base example that is more up-to-date with
what's going on lately with most IIO drivers.

This change tackles the simple allocations, to convert them to
device-managed calls, and tie them to the parent device.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 29 ++++++++--------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index c0b7ef900735..2a2e62f780a1 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -574,11 +574,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 * parent = &client->dev;
 	 */
 
-	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
-	if (!swd) {
-		ret = -ENOMEM;
-		goto error_kzalloc;
-	}
+	swd = devm_kzalloc(parent, sizeof(*swd), GFP_KERNEL);
+	if (!swd)
+		return ERR_PTR(-ENOMEM);
 	/*
 	 * Allocate an IIO device.
 	 *
@@ -587,11 +585,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 * It also has a region (accessed by iio_priv()
 	 * for chip specific state information.
 	 */
-	indio_dev = iio_device_alloc(parent, sizeof(*st));
-	if (!indio_dev) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(parent, sizeof(*st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
 
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
@@ -615,7 +611,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 *    indio_dev->name = id->name;
 	 *    indio_dev->name = spi_get_device_id(spi)->name;
 	 */
-	indio_dev->name = kstrdup(name, GFP_KERNEL);
+	indio_dev->name = devm_kstrdup(parent, name, GFP_KERNEL);
 
 	/* Provide description of available channels */
 	indio_dev->channels = iio_dummy_channels;
@@ -632,7 +628,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 
 	ret = iio_simple_dummy_events_register(indio_dev);
 	if (ret < 0)
-		goto error_free_device;
+		return ERR_PTR(ret);
 
 	ret = iio_simple_dummy_configure_buffer(indio_dev);
 	if (ret < 0)
@@ -649,11 +645,6 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	iio_simple_dummy_unconfigure_buffer(indio_dev);
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
-error_free_device:
-	iio_device_free(indio_dev);
-error_ret:
-	kfree(swd);
-error_kzalloc:
 	return ERR_PTR(ret);
 }
 
@@ -683,10 +674,6 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
 
 	iio_simple_dummy_events_unregister(indio_dev);
 
-	/* Free all structures */
-	kfree(indio_dev->name);
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
2.27.0

