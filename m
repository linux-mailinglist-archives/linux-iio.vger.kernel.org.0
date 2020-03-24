Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB82D191AEC
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgCXU1z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 16:27:55 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51040 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgCXU1x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 16:27:53 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so45237pjb.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 13:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpnS/j1XfTEAxa697JfCqGh5bEfIShtd5fhuG2l93l8=;
        b=ijO5I9xYJrPv9CaECBq+rp2MoCRZ6HJH87CVQD9pH86IYXdVtpQivHTYyHrnoLld/3
         TKUEe9UuDwZ1fVvAIu4nZXlGJu2l/Z/tiJl00A6VBgPDugHEeqPvtzvGKsCBwxK4ATP+
         RpHN9MYEcmMQDWAXLKJ3WrJDVJFOy932tV8GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpnS/j1XfTEAxa697JfCqGh5bEfIShtd5fhuG2l93l8=;
        b=uI/c2b9G16Ei1L2notHXZcLHiSiovXUmIWVvUmLMC7bqwAhxKlwy7TKHTpMoNNvc5Q
         A5RCGHvv67m0LhgOs8LbqO1oQNUmk3GpkuH/TTpgC1Hcx6wcjrzjvjXU9V1eJiBTY95t
         dUYMpACo0UEqjzXAu1uPdmiR7qOEcQjwgh238m84ZR7SRxueG6H2+3cE36bg+w6iOgUV
         ObqAZsxk0u4lKT7iC2hKcMrBSZMyFp9JdGhA5A/kPEUdAmYPk3DIhuiKn6Y5p+m5311f
         lzelGygBAJ4+u6v/3F77PEMazkDKFKYuXib3YrCbkxCqifmIJlT1DrqKC3ZCkp1Bdaeh
         E46g==
X-Gm-Message-State: ANhLgQ2EMt6GgNMlw0Xv62bqCNu5KrMezn2n9acYwzM41qqGPVm4eUsL
        n3uKFCwoMTT1ijt/xK4n43+UGA==
X-Google-Smtp-Source: ADFU+vteWSjntoj8aZ+Nx0AIgMc07uFZI7ZIcP0H9/Q7LWpXp1fHUENvhsVnOSCkEv+TAQt64R8dYg==
X-Received: by 2002:a17:90a:a102:: with SMTP id s2mr7671363pjp.44.1585081671127;
        Tue, 24 Mar 2020 13:27:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id j19sm16613872pfe.102.2020.03.24.13.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:27:50 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 04/11] iio: cros_ec: Move function description to .c file
Date:   Tue, 24 Mar 2020 13:27:29 -0700
Message-Id: <20200324202736.243314-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200324202736.243314-1-gwendal@chromium.org>
References: <20200324202736.243314-1-gwendal@chromium.org>
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
Changes in v6:
- No changes.
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
2.25.1.696.g5e7596f4ac-goog

