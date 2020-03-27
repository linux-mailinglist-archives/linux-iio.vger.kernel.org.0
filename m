Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03504196149
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgC0Wey (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:34:54 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40625 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgC0Wey (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:54 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so4333633pjb.5
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iqOeE9hw+dt5WyFHwckotB6IKe97XhX2NxCFAFYvoc=;
        b=Wgo5kynmVEJO0Fi3vCm2iDRi/6sAdIvsWlCvqtErMwD7nyP9oOEflnmF7VEPViuJG4
         AS7TiuTrvs+xPRBlVC6SkERYHPD2hQA2MqWI5Eb3kBDAjd80QSAkHnNeRw1eiL9fsVZU
         Unp4/kuWa9yhcyGv0ds2jS8+ZVRZ9LOQysfUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iqOeE9hw+dt5WyFHwckotB6IKe97XhX2NxCFAFYvoc=;
        b=NQdwQJdsHOhzmLXbd1K0OqDYOqXl6mJHAhZalc6b9OWaA7X39x+cKpHXZERrhWn9IW
         QnyjjDyhqYGvSfGqNttv/c+JaQWWw5fgWMKk3udCNeGYPE/wsB5+oMZSv5gvXamA1lNq
         0uvmqFR78HvzsmotfI9a1qmwNDMe0DHvmxLYzgTLw1qPPuQUDfp0RK3Cusq56ztF1ZJK
         jXaFGpV3id7kqn54tZpbewCEU/3ik7jMzCpnUfP8Mn5NflPhYv2xb6jinGbe7DilSiZT
         6PQKNYaqAK6DaM751uSzk6OIMupt4FbftEQ0W3ONWZeYZM5F5LM4m3xnF2KXUT2tqP+N
         bz5A==
X-Gm-Message-State: ANhLgQ3HtowWTtBh/nyk/CrgNo80UKvGMWxpmBIwZ1jg73RQtDFBVWCX
        sNn336Xla7Qi/3oQvx+PSpn0eA==
X-Google-Smtp-Source: ADFU+vt+NjuxeiSU8AgDNZGLlTEHzEwumWDKaD1dteg5MymQpJaWs8FtwP4J+GiWOEMkWtapQGKDkw==
X-Received: by 2002:a17:90a:bd0c:: with SMTP id y12mr1788038pjr.82.1585348492672;
        Fri, 27 Mar 2020 15:34:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id h11sm4916537pfn.125.2020.03.27.15.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:52 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 05/12] iio: cros_ec: Move function description to .c file
Date:   Fri, 27 Mar 2020 15:34:36 -0700
Message-Id: <20200327223443.6006-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To prevent comment rot, move function description to
cros_ec_sensors_core.c.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v6 and v7.
Changes in v5:
  Added ack.
No changes in v4.
Changes in v3:
  fix spelling.
New in v2.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 69 ++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   | 80 -------------------
 2 files changed, 69 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index d3a3626c7cd83..f3c000448b90e 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -82,6 +82,14 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 	}
 }
 
+/**
+ * cros_ec_sensors_core_init() - basic initialization of the core structure
+ * @pdev:		platform device created for the sensors
+ * @indio_dev:		iio device structure of the device
+ * @physical_device:	true if the device refers to a physical device
+ *
+ * Return: 0 on success, -errno on failure.
+ */
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device)
@@ -159,6 +167,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
 
+/**
+ * cros_ec_motion_send_host_cmd() - send motion sense host command
+ * @state:		pointer to state information for device
+ * @opt_length:	optional length to reduce the response size, useful on the data
+ *		path. Otherwise, the maximal allowed response size is used
+ *
+ * When called, the sub-command is assumed to be set in param->cmd.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
 int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 				 u16 opt_length)
 {
@@ -421,6 +439,14 @@ int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_read_lpc);
 
+/**
+ * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
+ * @indio_dev:	pointer to IIO device
+ * @scan_mask:	bitmap of the sensor indices to scan
+ * @data:	location to store data
+ *
+ * Return: 0 on success, -errno on failure.
+ */
 int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
 			     unsigned long scan_mask, s16 *data)
 {
@@ -445,6 +471,18 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_read_cmd);
 
+/**
+ * cros_ec_sensors_capture() - the trigger handler function
+ * @irq:	the interrupt number.
+ * @p:		a pointer to the poll function.
+ *
+ * On a trigger event occurring, if the pollfunc is attached then this
+ * handler is called as a threaded interrupt (and hence may sleep). It
+ * is responsible for grabbing data from the device and pushing it into
+ * the associated buffer.
+ *
+ * Return: IRQ_HANDLED
+ */
 irqreturn_t cros_ec_sensors_capture(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -480,6 +518,16 @@ irqreturn_t cros_ec_sensors_capture(int irq, void *p)
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
 
+/**
+ * cros_ec_sensors_core_read() - function to request a value from the sensor
+ * @st:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @val:	will contain one element making up the returned value
+ * @val2:	will contain another element making up the returned value
+ * @mask:	specifies which values to be requested
+ *
+ * Return:	the type of value returned by the device
+ */
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
@@ -520,6 +568,17 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read);
 
+/**
+ * cros_ec_sensors_core_read_avail() - get available values
+ * @indio_dev:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @vals:	list of available values
+ * @type:	type of data returned
+ * @length:	number of data returned in the array
+ * @mask:	specifies which values to be requested
+ *
+ * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
+ */
 int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 				    struct iio_chan_spec const *chan,
 				    const int **vals,
@@ -541,6 +600,16 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
 
+/**
+ * cros_ec_sensors_core_write() - function to write a value to the sensor
+ * @st:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @val:	first part of value to write
+ * @val2:	second part of value to write
+ * @mask:	specifies which values to write
+ *
+ * Return:	the type of value returned by the device
+ */
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask)
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index bb331e6356a9c..0af918978f975 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -79,95 +79,25 @@ struct cros_ec_sensors_core_state {
 	int frequencies[3];
 };
 
-/**
- * cros_ec_sensors_read_lpc() - retrieve data from EC shared memory
- * @indio_dev:	pointer to IIO device
- * @scan_mask:	bitmap of the sensor indices to scan
- * @data:	location to store data
- *
- * This is the safe function for reading the EC data. It guarantees that the
- * data sampled was not modified by the EC while being read.
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,
 			     s16 *data);
 
-/**
- * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
- * @indio_dev:	pointer to IIO device
- * @scan_mask:	bitmap of the sensor indices to scan
- * @data:	location to store data
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev, unsigned long scan_mask,
 			     s16 *data);
 
 struct platform_device;
-/**
- * cros_ec_sensors_core_init() - basic initialization of the core structure
- * @pdev:		platform device created for the sensors
- * @indio_dev:		iio device structure of the device
- * @physical_device:	true if the device refers to a physical device
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev, bool physical_device);
 
-/**
- * cros_ec_sensors_capture() - the trigger handler function
- * @irq:	the interrupt number.
- * @p:		a pointer to the poll function.
- *
- * On a trigger event occurring, if the pollfunc is attached then this
- * handler is called as a threaded interrupt (and hence may sleep). It
- * is responsible for grabbing data from the device and pushing it into
- * the associated buffer.
- *
- * Return: IRQ_HANDLED
- */
 irqreturn_t cros_ec_sensors_capture(int irq, void *p);
 
-/**
- * cros_ec_motion_send_host_cmd() - send motion sense host command
- * @st:		pointer to state information for device
- * @opt_length:	optional length to reduce the response size, useful on the data
- *		path. Otherwise, the maximal allowed response size is used
- *
- * When called, the sub-command is assumed to be set in param->cmd.
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *st,
 				 u16 opt_length);
 
-/**
- * cros_ec_sensors_core_read() - function to request a value from the sensor
- * @st:		pointer to state information for device
- * @chan:	channel specification structure table
- * @val:	will contain one element making up the returned value
- * @val2:	will contain another element making up the returned value
- * @mask:	specifies which values to be requested
- *
- * Return:	the type of value returned by the device
- */
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask);
 
-/**
- * cros_ec_sensors_core_read_avail() - get available values
- * @indio_dev:		pointer to state information for device
- * @chan:	channel specification structure table
- * @vals:	list of available values
- * @type:	type of data returned
- * @length:	number of data returned in the array
- * @mask:	specifies which values to be requested
- *
- * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
- */
 int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 				    struct iio_chan_spec const *chan,
 				    const int **vals,
@@ -175,16 +105,6 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 				    int *length,
 				    long mask);
 
-/**
- * cros_ec_sensors_core_write() - function to write a value to the sensor
- * @st:		pointer to state information for device
- * @chan:	channel specification structure table
- * @val:	first part of value to write
- * @val2:	second part of value to write
- * @mask:	specifies which values to write
- *
- * Return:	the type of value returned by the device
- */
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask);
-- 
2.26.0.rc2.310.g2932bb562d-goog

