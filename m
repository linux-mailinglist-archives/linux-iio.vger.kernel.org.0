Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3DF0958
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 23:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfKEW1T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 17:27:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40941 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbfKEW1S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 17:27:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so17088854pfl.7
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2019 14:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raXUNtoCObqNhz8yQ8Z0W+tORolNPEAtHqFYzcRFFPY=;
        b=ABYTyIgupckx0tZjexIOhJvD/wpS+GHXkp2VLo+6Th5KCwyP+WYDl3kzvfvUhzHghe
         UL6xDyKLMFYz/wV67jgWWslICfvjMcb5lGjINHQOnlLV/0XlrdvvmuBmt8cAoH0Wc4MG
         YMpKVl0NHSvIu5Uweo9fyXjHsguKoU+/yE9ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raXUNtoCObqNhz8yQ8Z0W+tORolNPEAtHqFYzcRFFPY=;
        b=ddh8JaGLblLoS/D2BIsmHE0mqn8bJi882/Xj9s5LpU9ccuYfyLndEAKthbLQHXXy0v
         lznsXk2H38Wqt6p15B5/BrhS1Lmq6eS7r68chkQ917AoGLVaQuQ/tE6f603k29gejn57
         l4q18ZK2iNWH/1f4NEK+rqxy7XWkb+imovw8M+jrk2kzHM8ofTmvfwY8TfNjg0hzrhtm
         joJtcsJpKNXmsXY4I1lFqiNuuUiKI8qbBmhFUd0EFjhMZuXzsddcsWaXU+Bf5bQfPj+G
         FjlsEyh7KBfoH8fCN5owqASXkl8GQFvs2gvoVJmMoqtD64PPULqC6KIxL38rdAc7PgyR
         f2QA==
X-Gm-Message-State: APjAAAX9IYcD5IFHSfabfNgOdMJdgF6SFApgcpGz1Ax5uWjAB47s2fAb
        nFx6mmfA62anicpnYcz4YFZ7zg==
X-Google-Smtp-Source: APXvYqyzGP6vsJxJsbqsfpR2P5vsyFTttbcc/OVfo+P5VvvwbF5zPVGEmQNeIS/dL51dJbOja/QgfQ==
X-Received: by 2002:a63:7514:: with SMTP id q20mr21742706pgc.6.1572992837728;
        Tue, 05 Nov 2019 14:27:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 184sm22370455pfu.58.2019.11.05.14.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:16 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 12/17] iio: cros_ec: Move function description to .c file
Date:   Tue,  5 Nov 2019 14:26:47 -0800
Message-Id: <20191105222652.70226-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To prevent comment rot, move function description to
cros_ec_sensors_core.c.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v4.
Changes in v3:
  fix spelling.
New in v2.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 69 ++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   | 80 -------------------
 2 files changed, 69 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 81a7f692de2f..b47da497a3c3 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -83,6 +83,14 @@ static void get_default_min_max_freq(enum motionsensor_type type,
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
@@ -160,6 +168,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
@@ -422,6 +440,14 @@ int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
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
@@ -446,6 +472,18 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
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
@@ -481,6 +519,16 @@ irqreturn_t cros_ec_sensors_capture(int irq, void *p)
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
@@ -521,6 +569,17 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
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
@@ -542,6 +601,16 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
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
index bb331e6356a9..0af918978f97 100644
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
2.24.0.rc1.363.gb1bccd3e3d-goog

