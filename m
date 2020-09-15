Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC36E26A246
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIOJcy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 05:32:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45458 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgIOJct (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 05:32:49 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08F9VaDm016290;
        Tue, 15 Sep 2020 05:32:32 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33gu851uyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 05:32:32 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08F9WVqX017761
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 15 Sep 2020 05:32:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:32:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:32:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 15 Sep 2020 05:32:40 -0400
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08F9W7vp027664;
        Tue, 15 Sep 2020 05:32:27 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean --dry-run <alexandru.ardelean@analog.com>
Subject: [PATCH 10/10] iio: adis: Drop non Managed device functions
Date:   Tue, 15 Sep 2020 11:33:45 +0200
Message-ID: <20200915093345.85614-11-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915093345.85614-1-nuno.sa@analog.com>
References: <20200915093345.85614-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_05:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=800 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop `adis_setup_buffer_and_trigger()`. All users were updated to use
the devm version of this function. This avoids having almost the same
code repeated.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c  | 64 +++-------------------------------
 drivers/iio/imu/adis_trigger.c | 60 -------------------------------
 include/linux/iio/imu/adis.h   | 27 --------------
 3 files changed, 4 insertions(+), 147 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 5b4225ee09b9..df6144285470 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -169,48 +169,6 @@ static void adis_buffer_cleanup(void *arg)
 	kfree(adis->xfer);
 }
 
-/**
- * adis_setup_buffer_and_trigger() - Sets up buffer and trigger for the adis device
- * @adis: The adis device.
- * @indio_dev: The IIO device.
- * @trigger_handler: Optional trigger handler, may be NULL.
- *
- * Returns 0 on success, a negative error code otherwise.
- *
- * This function sets up the buffer and trigger for a adis devices.  If
- * 'trigger_handler' is NULL the default trigger handler will be used. The
- * default trigger handler will simply read the registers assigned to the
- * currently active channels.
- *
- * adis_cleanup_buffer_and_trigger() should be called to free the resources
- * allocated by this function.
- */
-int adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-	irqreturn_t (*trigger_handler)(int, void *))
-{
-	int ret;
-
-	if (!trigger_handler)
-		trigger_handler = adis_trigger_handler;
-
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-		trigger_handler, NULL);
-	if (ret)
-		return ret;
-
-	if (adis->spi->irq) {
-		ret = adis_probe_trigger(adis, indio_dev);
-		if (ret)
-			goto error_buffer_cleanup;
-	}
-	return 0;
-
-error_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
-
 /**
  * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
  *					  the managed adis device
@@ -220,7 +178,10 @@ EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
  *
  * Returns 0 on success, a negative error code otherwise.
  *
- * This function perfoms exactly the same as adis_setup_buffer_and_trigger()
+ * This function sets up the buffer and trigger for a adis devices.  If
+ * 'trigger_handler' is NULL the default trigger handler will be used. The
+ * default trigger handler will simply read the registers assigned to the
+ * currently active channels.
  */
 int
 devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
@@ -248,20 +209,3 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(devm_adis_setup_buffer_and_trigger);
 
-/**
- * adis_cleanup_buffer_and_trigger() - Free buffer and trigger resources
- * @adis: The adis device.
- * @indio_dev: The IIO device.
- *
- * Frees resources allocated by adis_setup_buffer_and_trigger()
- */
-void adis_cleanup_buffer_and_trigger(struct adis *adis,
-	struct iio_dev *indio_dev)
-{
-	if (adis->spi->irq)
-		adis_remove_trigger(adis);
-	kfree(adis->buffer);
-	kfree(adis->xfer);
-	iio_triggered_buffer_cleanup(indio_dev);
-}
-EXPORT_SYMBOL_GPL(adis_cleanup_buffer_and_trigger);
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 8afe71947c00..64e0ba51cb18 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -55,53 +55,6 @@ static int adis_validate_irq_flag(struct adis *adis)
 
 	return 0;
 }
-/**
- * adis_probe_trigger() - Sets up trigger for a adis device
- * @adis: The adis device
- * @indio_dev: The IIO device
- *
- * Returns 0 on success or a negative error code
- *
- * adis_remove_trigger() should be used to free the trigger.
- */
-int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
-{
-	int ret;
-
-	adis->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
-					indio_dev->id);
-	if (adis->trig == NULL)
-		return -ENOMEM;
-
-	adis_trigger_setup(adis);
-
-	ret = adis_validate_irq_flag(adis);
-	if (ret)
-		return ret;
-
-	ret = request_irq(adis->spi->irq,
-			  &iio_trigger_generic_data_rdy_poll,
-			  adis->irq_flag,
-			  indio_dev->name,
-			  adis->trig);
-	if (ret)
-		goto error_free_trig;
-
-	ret = iio_trigger_register(adis->trig);
-
-	indio_dev->trig = iio_trigger_get(adis->trig);
-	if (ret)
-		goto error_free_irq;
-
-	return 0;
-
-error_free_irq:
-	free_irq(adis->spi->irq, adis->trig);
-error_free_trig:
-	iio_trigger_free(adis->trig);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(adis_probe_trigger);
 
 /**
  * devm_adis_probe_trigger() - Sets up trigger for a managed adis device
@@ -137,16 +90,3 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(devm_adis_probe_trigger);
 
-/**
- * adis_remove_trigger() - Remove trigger for a adis devices
- * @adis: The adis device
- *
- * Removes the trigger previously registered with adis_probe_trigger().
- */
-void adis_remove_trigger(struct adis *adis)
-{
-	iio_trigger_unregister(adis->trig);
-	free_irq(adis->spi->irq, adis->trig);
-	iio_trigger_free(adis->trig);
-}
-EXPORT_SYMBOL_GPL(adis_remove_trigger);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 2df67448f0d1..01ba691da2f3 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -517,14 +517,8 @@ struct adis_burst {
 int
 devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 				   irq_handler_t trigger_handler);
-int adis_setup_buffer_and_trigger(struct adis *adis,
-	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *));
-void adis_cleanup_buffer_and_trigger(struct adis *adis,
-	struct iio_dev *indio_dev);
 
 int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
-int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
-void adis_remove_trigger(struct adis *adis);
 
 int adis_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask);
@@ -538,33 +532,12 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 	return 0;
 }
 
-static inline int adis_setup_buffer_and_trigger(struct adis *adis,
-	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *))
-{
-	return 0;
-}
-
-static inline void adis_cleanup_buffer_and_trigger(struct adis *adis,
-	struct iio_dev *indio_dev)
-{
-}
-
 static inline int devm_adis_probe_trigger(struct adis *adis,
 					  struct iio_dev *indio_dev)
 {
 	return 0;
 }
 
-static inline int adis_probe_trigger(struct adis *adis,
-	struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis_remove_trigger(struct adis *adis)
-{
-}
-
 #define adis_update_scan_mode NULL
 
 #endif /* CONFIG_IIO_BUFFER */
-- 
2.28.0

