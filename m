Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74C8172074
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 15:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgB0OnC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 09:43:02 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16936 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731080AbgB0Ntm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 08:49:42 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDj6UU008510;
        Thu, 27 Feb 2020 08:49:41 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrx39wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 08:49:41 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01RDne1Z059125
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 08:49:40 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 08:49:39 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 08:49:39 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 08:49:38 -0500
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RDnVon027892;
        Thu, 27 Feb 2020 08:49:36 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 6/8] iio: inkern: drop devm_iio_channel_release{_all} API calls
Date:   Thu, 27 Feb 2020 15:52:25 +0200
Message-ID: <20200227135227.12433-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227135227.12433-1-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_04:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270109
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's unused so far, so it can't be removed. Also makes sense to remove it
to discourage weird uses of this call during review.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../driver-api/driver-model/devres.rst        |  2 --
 drivers/iio/inkern.c                          | 27 -------------------
 include/linux/iio/consumer.h                  | 18 -------------
 3 files changed, 47 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 6c401c74e480..10ccebe9f7c1 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -291,9 +291,7 @@ IIO
   devm_iio_trigger_alloc()
   devm_iio_trigger_register()
   devm_iio_channel_get()
-  devm_iio_channel_release()
   devm_iio_channel_get_all()
-  devm_iio_channel_release_all()
 
 INPUT
   devm_input_allocate_device()
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 5a8351c9a426..ede99e0d5371 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -360,18 +360,6 @@ static void devm_iio_channel_free(struct device *dev, void *res)
 	iio_channel_release(channel);
 }
 
-static int devm_iio_channel_match(struct device *dev, void *res, void *data)
-{
-	struct iio_channel **r = res;
-
-	if (!r || !*r) {
-		WARN_ON(!r || !*r);
-		return 0;
-	}
-
-	return *r == data;
-}
-
 struct iio_channel *devm_iio_channel_get(struct device *dev,
 					 const char *channel_name)
 {
@@ -394,13 +382,6 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_channel_get);
 
-void devm_iio_channel_release(struct device *dev, struct iio_channel *channel)
-{
-	WARN_ON(devres_release(dev, devm_iio_channel_free,
-			       devm_iio_channel_match, channel));
-}
-EXPORT_SYMBOL_GPL(devm_iio_channel_release);
-
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
 	const char *name;
@@ -514,14 +495,6 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
 
-void devm_iio_channel_release_all(struct device *dev,
-				  struct iio_channel *channels)
-{
-	WARN_ON(devres_release(dev, devm_iio_channel_free_all,
-			       devm_iio_channel_match, channels));
-}
-EXPORT_SYMBOL_GPL(devm_iio_channel_release_all);
-
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	enum iio_chan_info_enum info)
 {
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 2bde8c912d4d..c4118dcb8e05 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -63,15 +63,6 @@ void iio_channel_release(struct iio_channel *chan);
  */
 struct iio_channel *devm_iio_channel_get(struct device *dev,
 					 const char *consumer_channel);
-/**
- * devm_iio_channel_release() - Resource managed version of
- *				iio_channel_release().
- * @dev:		Pointer to consumer device for which resource
- *			is allocared.
- * @chan:		The channel to be released.
- */
-void devm_iio_channel_release(struct device *dev, struct iio_channel *chan);
-
 /**
  * iio_channel_get_all() - get all channels associated with a client
  * @dev:		Pointer to consumer device.
@@ -106,15 +97,6 @@ void iio_channel_release_all(struct iio_channel *chan);
  */
 struct iio_channel *devm_iio_channel_get_all(struct device *dev);
 
-/**
- * devm_iio_channel_release_all() - Resource managed version of
- *				    iio_channel_release_all().
- * @dev:		Pointer to consumer device for which resource
- *			is allocared.
- * @chan:		Array channel to be released.
- */
-void devm_iio_channel_release_all(struct device *dev, struct iio_channel *chan);
-
 struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
-- 
2.20.1

