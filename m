Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6051E0DE3
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390414AbgEYLyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 07:54:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7030 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390196AbgEYLyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 07:54:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04PBj9nm006915;
        Mon, 25 May 2020 07:53:37 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp7xhwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 07:53:37 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04PBrZTE039922
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 May 2020 07:53:36 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 04:53:34 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 04:53:23 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 25 May 2020 04:53:33 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04PBrUvG018765;
        Mon, 25 May 2020 07:53:30 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <jic23@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <lorenzo.bianconi83@gmail.com>, <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/3] iio: Move attach/detach of the poll func to the core
Date:   Mon, 25 May 2020 14:38:53 +0300
Message-ID: <20200525113855.178821-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_06:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

All devices using a triggered buffer need to attach and detach the trigger
to the device in order to properly work. Instead of doing this in each and
every driver by hand move this into the core.

At this point in time, all drivers should have been resolved to
attach/detach the poll-function in the same order.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
- drivers/iio/accel/st_accel_buffer.c - remove err2 var and return directly
- drivers/iio/gyro/st_gyro_buffer.c - return earlier if
  st_sensors_set_enable() failed
- drivers/iio/light/vcnl4000.c - return directly on error in
  vcnl4010_buffer_postenable() & vcnl4010_buffer_predisable()
- drivers/iio/pressure/zpa2326.c - print error message on error paths only

 .../buffer/industrialio-triggered-buffer.c    | 10 +--------
 drivers/iio/iio_core_trigger.h                | 17 ++++++++++++++
 drivers/iio/industrialio-buffer.c             | 13 +++++++++++
 drivers/iio/industrialio-trigger.c            | 22 ++++---------------
 include/linux/iio/trigger_consumer.h          |  7 ------
 5 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index e8046c1ecd6b..6c20a83f887e 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -13,11 +13,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
-static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 /**
  * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
  * @indio_dev:		IIO device structure
@@ -67,10 +62,7 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	if (setup_ops)
-		indio_dev->setup_ops = setup_ops;
-	else
-		indio_dev->setup_ops = &iio_triggered_buffer_setup_ops;
+	indio_dev->setup_ops = setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index e59fe2f36bbb..9d1a92cc6480 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -18,6 +18,12 @@ void iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
  **/
 void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
 
+
+int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf);
+int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf);
+
 #else
 
 /**
@@ -37,4 +43,15 @@ static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 }
 
+static inline int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+					       struct iio_poll_func *pf)
+{
+	return 0;
+}
+static inline int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+					       struct iio_poll_func *pf)
+{
+	return 0;
+}
+
 #endif /* CONFIG_TRIGGER_CONSUMER */
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 9fa238c0a7d4..329dd4d6757a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -20,6 +20,7 @@
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
+#include "iio_core_trigger.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
@@ -972,6 +973,13 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		}
 	}
 
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		ret = iio_trigger_attach_poll_func(indio_dev->trig,
+						   indio_dev->pollfunc);
+		if (ret)
+			goto err_disable_buffers;
+	}
+
 	return 0;
 
 err_disable_buffers:
@@ -998,6 +1006,11 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 	if (list_empty(&indio_dev->buffer_list))
 		return 0;
 
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		iio_trigger_detach_poll_func(indio_dev->trig,
+					     indio_dev->pollfunc);
+	}
+
 	/*
 	 * If things go wrong at some step in disable we still need to continue
 	 * to perform the other steps, otherwise we leave the device in a
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 53d1931f6be8..6f16357fd732 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -239,8 +239,8 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
  * the relevant function is in there may be the best option.
  */
 /* Worth protecting against double additions? */
-static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
-					struct iio_poll_func *pf)
+int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool notinuse
@@ -290,8 +290,8 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	return ret;
 }
 
-static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
-					 struct iio_poll_func *pf)
+int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool no_other_users
@@ -705,17 +705,3 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 	if (indio_dev->trig)
 		iio_trigger_put(indio_dev->trig);
 }
-
-int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
-{
-	return iio_trigger_attach_poll_func(indio_dev->trig,
-					    indio_dev->pollfunc);
-}
-EXPORT_SYMBOL(iio_triggered_buffer_postenable);
-
-int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
-{
-	return iio_trigger_detach_poll_func(indio_dev->trig,
-					     indio_dev->pollfunc);
-}
-EXPORT_SYMBOL(iio_triggered_buffer_predisable);
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index c3c6ba5ec423..3aa2f132dd67 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -50,11 +50,4 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
 
 void iio_trigger_notify_done(struct iio_trigger *trig);
 
-/*
- * Two functions for common case where all that happens is a pollfunc
- * is attached and detached from a trigger
- */
-int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
-int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
-
 #endif
-- 
2.25.1

