Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2F16C05F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgBYMJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:09:33 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8762 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730639AbgBYMJc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:09:32 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PC4u5Q013025;
        Tue, 25 Feb 2020 07:09:31 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yay1brsvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:09:30 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01PC9Tq6058804
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:09:29 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 25 Feb
 2020 07:09:28 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 07:09:28 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PC9N1G003238;
        Tue, 25 Feb 2020 07:09:28 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 4/6] iio: accel: adxl372: add iio events
Date:   Tue, 25 Feb 2020 14:09:07 +0200
Message-ID: <20200225120909.12629-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225120909.12629-1-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set INT1 interrupts to fire when activity/inactivity
is detected by the device. On irq, push event code by calling
iio_push_event().

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 775dc4f0aaf4..e669eaaaa07e 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -114,6 +114,11 @@
 #define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
 #define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
 
+/* ADXL372_STATUS_2 */
+#define ADXL372_STATUS_2_INACT(x)		(((x) >> 4) & 0x1)
+#define ADXL372_STATUS_2_ACT(x)			(((x) >> 5) & 0x1)
+#define ADXL372_STATUS_2_AC2(x)			(((x) >> 6) & 0x1)
+
 /* ADXL372_INT1_MAP */
 #define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
 #define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
@@ -585,6 +590,27 @@ static int adxl372_get_status(struct adxl372_state *st,
 	return ret;
 }
 
+static void adxl372_push_event(struct iio_dev *indio_dev, s64 timestamp,
+			       u8 status2)
+{
+	unsigned int ev_dir;
+
+	if (ADXL372_STATUS_2_ACT(status2))
+		ev_dir = IIO_EV_DIR_RISING;
+
+	if (ADXL372_STATUS_2_INACT(status2))
+		ev_dir = IIO_EV_DIR_FALLING;
+
+	if (ev_dir != IIO_EV_DIR_NONE)
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  ev_dir),
+						  timestamp);
+}
+
 static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
@@ -598,6 +624,8 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 	if (ret < 0)
 		goto err;
 
+	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
+
 	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
 	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
 		/*
@@ -989,7 +1017,10 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
+	mask = ADXL372_INT1_MAP_FIFO_FULL_MSK |
+	       ADXL372_INT1_MAP_ACT_MSK	 |
+	       ADXL372_INT1_MAP_INACT_MSK;
+	ret = adxl372_set_interrupts(st, mask, 0);
 	if (ret < 0)
 		goto err;
 
@@ -1067,7 +1098,9 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
 	unsigned long int mask = 0;
 
 	if (state)
-		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
+		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK |
+		       ADXL372_INT1_MAP_ACT_MSK	 |
+		       ADXL372_INT1_MAP_INACT_MSK;
 
 	return adxl372_set_interrupts(st, mask, 0);
 }
-- 
2.20.1

