Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44DC2CD2E5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgLCJu5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 04:50:57 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10458 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728789AbgLCJu5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 04:50:57 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B39VANg022500;
        Thu, 3 Dec 2020 04:50:16 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vj5n7f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 04:50:15 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0B39oES2007858
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 04:50:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 3 Dec 2020
 04:50:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 04:50:13 -0500
Received: from saturn.ad.analog.com ([10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B39o9EB002710;
        Thu, 3 Dec 2020 04:50:11 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: dummy: convert events to device-managed handlers
Date:   Thu, 3 Dec 2020 11:50:04 +0200
Message-ID: <20201203095005.72252-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201203095005.72252-1-alexandru.ardelean@analog.com>
References: <20201203095005.72252-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=2 mlxscore=0 bulkscore=0
 mlxlogscore=851 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030058
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the iio_simple_dummy_events_register() function to use
device-managed functions/equivalents.
The iio_dummy_evgen_release_irq() function needs to be carried over a
devm_add_action_or_reset() handler.

With this the iio_simple_dummy_events_unregister() function can be removed,
and so can it's usage/call.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dummy/iio_simple_dummy.c        |  8 +---
 drivers/iio/dummy/iio_simple_dummy.h        |  9 +---
 drivers/iio/dummy/iio_simple_dummy_events.c | 53 +++++++++------------
 3 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 2a2e62f780a1..a746b34ae7a3 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -626,13 +626,13 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	/* Specify that device provides sysfs type interfaces */
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_simple_dummy_events_register(indio_dev);
+	ret = iio_simple_dummy_events_register(parent, indio_dev);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
 	ret = iio_simple_dummy_configure_buffer(indio_dev);
 	if (ret < 0)
-		goto error_unregister_events;
+		return ERR_PTR(ret);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -643,8 +643,6 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	return swd;
 error_unconfigure_buffer:
 	iio_simple_dummy_unconfigure_buffer(indio_dev);
-error_unregister_events:
-	iio_simple_dummy_events_unregister(indio_dev);
 	return ERR_PTR(ret);
 }
 
@@ -672,8 +670,6 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
 	/* Buffered capture related cleanup */
 	iio_simple_dummy_unconfigure_buffer(indio_dev);
 
-	iio_simple_dummy_events_unregister(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
index a91622ac54e0..b1ca6e97ed3f 100644
--- a/drivers/iio/dummy/iio_simple_dummy.h
+++ b/drivers/iio/dummy/iio_simple_dummy.h
@@ -76,21 +76,16 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 				       enum iio_event_info info, int val,
 				       int val2);
 
-int iio_simple_dummy_events_register(struct iio_dev *indio_dev);
-void iio_simple_dummy_events_unregister(struct iio_dev *indio_dev);
+int iio_simple_dummy_events_register(struct device *parent, struct iio_dev *indio_dev);
 
 #else /* Stubs for when events are disabled at compile time */
 
 static inline int
-iio_simple_dummy_events_register(struct iio_dev *indio_dev)
+iio_simple_dummy_events_register(struct device *parent, struct iio_dev *indio_dev)
 {
 	return 0;
 }
 
-static inline void
-iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
-{}
-
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
 
 /**
diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
index 63a2b844be50..8f51fe5cbdfc 100644
--- a/drivers/iio/dummy/iio_simple_dummy_events.c
+++ b/drivers/iio/dummy/iio_simple_dummy_events.c
@@ -222,6 +222,13 @@ static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void iio_simple_dummy_events_release_irq(void *data)
+{
+	struct iio_dummy_state *st = data;
+
+	iio_dummy_evgen_release_irq(st->event_irq);
+}
+
 /**
  * iio_simple_dummy_events_register() - setup interrupt handling for events
  * @indio_dev: device instance data
@@ -233,44 +240,28 @@ static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
  * no way forms part of this example. Just assume that events magically
  * appear via the provided interrupt.
  */
-int iio_simple_dummy_events_register(struct iio_dev *indio_dev)
+int iio_simple_dummy_events_register(struct device *parent,
+				     struct iio_dev *indio_dev)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 	int ret;
 
 	/* Fire up event source - normally not present */
 	st->event_irq = iio_dummy_evgen_get_irq();
-	if (st->event_irq < 0) {
-		ret = st->event_irq;
-		goto error_ret;
-	}
-	st->regs = iio_dummy_evgen_get_regs(st->event_irq);
-
-	ret = request_threaded_irq(st->event_irq,
-				   &iio_simple_dummy_get_timestamp,
-				   &iio_simple_dummy_event_handler,
-				   IRQF_ONESHOT,
-				   "iio_simple_event",
-				   indio_dev);
-	if (ret < 0)
-		goto error_free_evgen;
-	return 0;
+	if (st->event_irq < 0)
+		return st->event_irq;
 
-error_free_evgen:
-	iio_dummy_evgen_release_irq(st->event_irq);
-error_ret:
-	return ret;
-}
+	ret = devm_add_action_or_reset(parent,
+				       iio_simple_dummy_events_release_irq, st);
+	if (ret)
+		return ret;
 
-/**
- * iio_simple_dummy_events_unregister() - tidy up interrupt handling on remove
- * @indio_dev: device instance data
- */
-void iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
-{
-	struct iio_dummy_state *st = iio_priv(indio_dev);
+	st->regs = iio_dummy_evgen_get_regs(st->event_irq);
 
-	free_irq(st->event_irq, indio_dev);
-	/* Not part of normal driver */
-	iio_dummy_evgen_release_irq(st->event_irq);
+	return devm_request_threaded_irq(parent, st->event_irq,
+					 &iio_simple_dummy_get_timestamp,
+					 &iio_simple_dummy_event_handler,
+					 IRQF_ONESHOT,
+					 "iio_simple_event",
+					 indio_dev);
 }
-- 
2.27.0

