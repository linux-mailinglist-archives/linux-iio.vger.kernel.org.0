Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4DE4A7287
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiBBOCR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiBBOCQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:16 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EED9C061714
        for <linux-iio@vger.kernel.org>; Wed,  2 Feb 2022 06:02:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 721FF200019;
        Wed,  2 Feb 2022 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUQPK60QKKdxj/JuXXedNGdN9AoMIZdtcjz0BSTqr/w=;
        b=h9ZdsdkDy4kNGPITFoQGHsmaEY5fSoTACJSF5pOKfD4lV3nHabq5kln1R3Q4QhPV+KiTt6
        d7iV99DDIekkeDoEFvC18gSPMUZqLZS+Ovd/re1j6RPgH9qWWdfhZNij2Jbd1/kIvP16f/
        4/deWkX5RVuUn/1K13i8xul71Tq9UkZv+lwRqwYHYEyIAwokjgVhZxosJjXugxxDtgL6Kh
        m2P/qcvxR9mD4ltjYx4jATedpE2EYXdtfTws+V2hj+s/5MfQvxTw49li1CS6KTagYsHLYd
        qkyrD8CDXG1HvSNKhK63AW1G2v0sbHQyrOE0xomxSCbxfufcupA+IWdyKDMzOQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 05/12] iio: st_sensors: Add a local lock for protecting odr
Date:   Wed,  2 Feb 2022 15:02:01 +0100
Message-Id: <20220202140208.391394-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Right now the (framework) mlock lock is (ab)used for multiple purposes:
1- protecting concurrent accesses over the odr local cache
2- avoid changing samplig frequency whilst buffer is running

Let's start by handling situation #1 with a local lock.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++++++++------
 include/linux/iio/common/st_sensors.h         |  3 ++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 6c027150a5a4..d0419234a747 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -71,16 +71,18 @@ static int st_sensors_match_odr(struct st_sensor_settings *sensor_settings,
 
 int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 {
-	int err;
+	int err = 0;
 	struct st_sensor_odr_avl odr_out = {0, 0};
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
+	mutex_lock(&sdata->odr_lock);
+
 	if (!sdata->sensor_settings->odr.mask)
-		return 0;
+		goto unlock_mutex;
 
 	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);
 	if (err < 0)
-		goto st_sensors_match_odr_error;
+		goto unlock_mutex;
 
 	if ((sdata->sensor_settings->odr.addr ==
 					sdata->sensor_settings->pw.addr) &&
@@ -103,7 +105,9 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 	if (err >= 0)
 		sdata->odr = odr_out.hz;
 
-st_sensors_match_odr_error:
+unlock_mutex:
+	mutex_unlock(&sdata->odr_lock);
+
 	return err;
 }
 EXPORT_SYMBOL(st_sensors_set_odr);
@@ -162,6 +166,8 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 	struct st_sensor_odr_avl odr_out = {0, 0};
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
+	mutex_lock(&sdata->odr_lock);
+
 	if (enable) {
 		tmp_value = sdata->sensor_settings->pw.value_on;
 		if ((sdata->sensor_settings->odr.addr ==
@@ -171,7 +177,7 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 			err = st_sensors_match_odr(sdata->sensor_settings,
 							sdata->odr, &odr_out);
 			if (err < 0)
-				goto set_enable_error;
+				goto unlock_mutex;
 			tmp_value = odr_out.value;
 			found = true;
 		}
@@ -179,7 +185,7 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 				sdata->sensor_settings->pw.addr,
 				sdata->sensor_settings->pw.mask, tmp_value);
 		if (err < 0)
-			goto set_enable_error;
+			goto unlock_mutex;
 
 		sdata->enabled = true;
 
@@ -191,12 +197,14 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 				sdata->sensor_settings->pw.mask,
 				sdata->sensor_settings->pw.value_off);
 		if (err < 0)
-			goto set_enable_error;
+			goto unlock_mutex;
 
 		sdata->enabled = false;
 	}
 
-set_enable_error:
+unlock_mutex:
+	mutex_unlock(&sdata->odr_lock);
+
 	return err;
 }
 EXPORT_SYMBOL(st_sensors_set_enable);
@@ -361,6 +369,8 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	struct st_sensors_platform_data *of_pdata;
 	int err = 0;
 
+	mutex_init(&sdata->odr_lock);
+
 	/* If OF/DT pdata exists, it will take precedence of anything else */
 	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
 	if (IS_ERR(of_pdata))
@@ -558,8 +568,10 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 		if (err < 0)
 			goto out;
 
+		mutex_lock(&sdata->odr_lock);
 		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
+		mutex_unlock(&sdata->odr_lock);
 		if (err < 0)
 			goto out;
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 22f67845cdd3..db4a1b260348 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -237,6 +237,7 @@ struct st_sensor_settings {
  * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
  * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
  * @buffer_data: Data used by buffer part.
+ * @odr_lock: Local lock for preventing concurrent ODR accesses/changes
  */
 struct st_sensor_data {
 	struct iio_trigger *trig;
@@ -261,6 +262,8 @@ struct st_sensor_data {
 	s64 hw_timestamp;
 
 	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
+
+	struct mutex odr_lock;
 };
 
 #ifdef CONFIG_IIO_BUFFER
-- 
2.27.0

