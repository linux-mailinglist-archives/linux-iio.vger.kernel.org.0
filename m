Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7758616C116
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgBYMlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:41:25 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36644 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgBYMlZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:41:25 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PCX0Of021912;
        Tue, 25 Feb 2020 07:41:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23aghvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:41:05 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01PCf30O016738
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:41:04 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 04:41:02 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 04:41:02 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 04:41:02 -0800
Received: from nsa.sphairon.box ([10.44.3.59])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PCev8a005013;
        Tue, 25 Feb 2020 07:41:00 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 1/5] iio: imu: adis: Add Managed device functions
Date:   Tue, 25 Feb 2020 13:41:48 +0100
Message-ID: <20200225124152.270914-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225124152.270914-1-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=789 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=2 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support for a managed device version of
adis_setup_buffer_and_trigger. It works exactly as the original
one but it calls all the devm_iio_* functions to setup an iio
buffer and trigger. Hence we do not need to care about cleaning those
and we do not need to support a remove() callback for every driver using
the adis library.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c  | 34 +++++++++++++++++++++++++++++
 drivers/iio/imu/adis_trigger.c | 39 +++++++++++++++++++++++++++++++---
 include/linux/iio/imu/adis.h   | 17 +++++++++++++++
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 3f4dd5c00b03..296036a01d39 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -196,7 +196,41 @@ int adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
+/**
+ * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
+ *					  the managed adis device
+ * @adis: The adis device
+ * @indio_dev: The IIO device
+ * @trigger_handler: Optional trigger handler, may be NULL.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function perfoms exactly the same as adis_setup_buffer_and_trigger()
+ */
+int
+devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
+				   irqreturn_t (*trigger_handler)(int, void *))
+{
+	int ret;
+
+	if (!trigger_handler)
+		trigger_handler = adis_trigger_handler;
+
+	ret = devm_iio_triggered_buffer_setup(&adis->spi->dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	if (adis->spi->irq) {
+		ret = devm_adis_probe_trigger(adis, indio_dev);
+		if (ret)
+			return ret;
+	}
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_adis_setup_buffer_and_trigger);
 /**
  * adis_cleanup_buffer_and_trigger() - Free buffer and trigger resources
  * @adis: The adis device.
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 8b9cd02c0f9f..a07dcc365c18 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -27,6 +27,13 @@ static const struct iio_trigger_ops adis_trigger_ops = {
 	.set_trigger_state = &adis_data_rdy_trigger_set_state,
 };
 
+static inline void adis_trigger_setup(struct adis *adis)
+{
+	adis->trig->dev.parent = &adis->spi->dev;
+	adis->trig->ops = &adis_trigger_ops;
+	iio_trigger_set_drvdata(adis->trig, adis);
+}
+
 /**
  * adis_probe_trigger() - Sets up trigger for a adis device
  * @adis: The adis device
@@ -45,9 +52,7 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	if (adis->trig == NULL)
 		return -ENOMEM;
 
-	adis->trig->dev.parent = &adis->spi->dev;
-	adis->trig->ops = &adis_trigger_ops;
-	iio_trigger_set_drvdata(adis->trig, adis);
+	adis_trigger_setup(adis);
 
 	ret = request_irq(adis->spi->irq,
 			  &iio_trigger_generic_data_rdy_poll,
@@ -72,7 +77,35 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adis_probe_trigger);
+/**
+ * devm_adis_probe_trigger() - Sets up trigger for a managed adis device
+ * @adis: The adis device
+ * @indio_dev: The IIO device
+ *
+ * Returns 0 on success or a negative error code
+ */
+int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
+{
+	int ret;
 
+	adis->trig = devm_iio_trigger_alloc(&adis->spi->dev, "%s-dev%d",
+					    indio_dev->name, indio_dev->id);
+	if (!adis->trig)
+		return -ENOMEM;
+
+	adis_trigger_setup(adis);
+
+	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       IRQF_TRIGGER_RISING,
+			       indio_dev->name,
+			       adis->trig);
+	if (ret)
+		return ret;
+
+	return devm_iio_trigger_register(&adis->spi->dev, adis->trig);
+}
+EXPORT_SYMBOL_GPL(devm_adis_probe_trigger);
 /**
  * adis_remove_trigger() - Remove trigger for a adis devices
  * @adis: The adis device
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index ac7cfd073804..741512b28aaa 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -419,11 +419,15 @@ struct adis_burst {
 	unsigned int	extra_len;
 };
 
+int
+devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
+				   irqreturn_t (*trigger_handler)(int, void *));
 int adis_setup_buffer_and_trigger(struct adis *adis,
 	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *));
 void adis_cleanup_buffer_and_trigger(struct adis *adis,
 	struct iio_dev *indio_dev);
 
+int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
 int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
 void adis_remove_trigger(struct adis *adis);
 
@@ -432,6 +436,13 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 
 #else /* CONFIG_IIO_BUFFER */
 
+static inline int
+devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
+				   irqreturn_t (*trigger_handler)(int, void *))
+{
+	return 0;
+}
+
 static inline int adis_setup_buffer_and_trigger(struct adis *adis,
 	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *))
 {
@@ -443,6 +454,12 @@ static inline void adis_cleanup_buffer_and_trigger(struct adis *adis,
 {
 }
 
+static inline int devm_adis_probe_trigger(struct adis *adis,
+					  struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
 static inline int adis_probe_trigger(struct adis *adis,
 	struct iio_dev *indio_dev)
 {
-- 
2.25.1

