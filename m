Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F66D1897A2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgCRJKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 05:10:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgCRJKE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:10:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so433161wrm.4;
        Wed, 18 Mar 2020 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ld4erb9oJVZGRzDLHfUzNBJ8XB/21Y+k8y5pdjhuegA=;
        b=UmSjnosXBMRMEVNUiV+w47Fn+TtFcgbfVg6gGB2e4xP0vstZIuu4zLALa0KrO5Oa/J
         0y6cwX2d6HZMOIYdjw5BjxDZ4Fl0Ha8HCbcVw++bde+lPFYdpC96roMAL4/cubo6mZGN
         jpSlf30hJQGZo//UBpscqa4ZCPZlLFdX/ooBtOXVoU2W3m30p3G3zwbPUQYe8iuahwT0
         YCKru+arf2zpmrdyd7Z2azofqDuXmGwMfcwjoC2t5PoNnW7arvKQj8XrAx2Ih2YJCr90
         9KV81D5jerUMwPwy8F44wiPN7gYhX44HMffRfk147nzV3gkXe8QN5rdv9G93itjJde/w
         gtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ld4erb9oJVZGRzDLHfUzNBJ8XB/21Y+k8y5pdjhuegA=;
        b=WSlYkyhE7/fQMTv462GgixGfQedf+1uMPLNtXzZuM0Bt3gDmHSijkKyX4Yw9gAg8mD
         eDdiRwl2Hv5iQaE6IBu6cqDRfhHf32zra7EifHlAOsxOig11kCiS2h9tvHMR5PLTbrbi
         FTUb5n/pqdgZeWwkVsLOljen0k+cYxKaXMsoUDYCgCT1jyfQPWWPC4OKTzryQvRShm/A
         8bgGYi9QfqlbM3ox5PL9EMPfmXYWn3kmFfp0sQuB0u/EHd0fVQjXLmGNFjGgiVv7l+26
         8GKoX9o+/ty08AkLLN7gYR7UF4wo09O1fNgGLLtih6sIzkaZXITQUJkA8AkBUH557IgY
         ZJgg==
X-Gm-Message-State: ANhLgQ1c7I2vLPSE+KPmQYOE2Ltl8Wq4K1qBIh3r7HW7qQfyAUB/qi3t
        MNOxeR6zB0RvMtVL8dcOGcDKuqBQyaE=
X-Google-Smtp-Source: ADFU+vugHCq2eOE3QDWWy2QPYfJkW8SmQieTaibLPcHUC/ZZmOjy65ef/y2kbJSvRvdp7prZT31pBQ==
X-Received: by 2002:adf:9796:: with SMTP id s22mr4278161wrb.31.1584522601365;
        Wed, 18 Mar 2020 02:10:01 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id w1sm2823986wmc.11.2020.03.18.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:10:00 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH v3 1/4] iio: accel: adxl372: Add support for FIFO peak mode
Date:   Wed, 18 Mar 2020 13:09:55 +0200
Message-Id: <20200318110958.8621-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318110958.8621-1-alexandru.tachici@analog.com>
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

By default, if all three channels (x, y, z) are enabled, sample sets of
concurrent 3-axis data is stored in the FIFO. This patch adds the option
to configure the FIFO to store peak acceleration (x, y and z) of every
over-threshold event. When pushing to iio buffer we push only enabled
axis data.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 67b8817995c0..90c37d6f10d3 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -133,6 +133,9 @@
 
 /* The ADXL372 includes a deep, 512 sample FIFO buffer */
 #define ADXL372_FIFO_SIZE			512
+#define ADXL372_X_AXIS_EN(x)			(((x) >> 0) & 0x1)
+#define ADXL372_Y_AXIS_EN(x)			(((x) >> 1) & 0x1)
+#define ADXL372_Z_AXIS_EN(x)			(((x) >> 2) & 0x1)
 
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
@@ -253,6 +256,7 @@ struct adxl372_state {
 	struct iio_trigger		*dready_trig;
 	enum adxl372_fifo_mode		fifo_mode;
 	enum adxl372_fifo_format	fifo_format;
+	unsigned int			fifo_axis_mask;
 	enum adxl372_op_mode		op_mode;
 	enum adxl372_act_proc_mode	act_proc_mode;
 	enum adxl372_odr		odr;
@@ -264,6 +268,7 @@ struct adxl372_state {
 	u8				int2_bitmask;
 	u16				watermark;
 	__be16				fifo_buf[ADXL372_FIFO_SIZE];
+	bool				peak_fifo_mode_en;
 };
 
 static const unsigned long adxl372_channel_masks[] = {
@@ -522,6 +527,22 @@ static int adxl372_get_status(struct adxl372_state *st,
 	return ret;
 }
 
+static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
+{
+	__be16	axis_sample[3];
+	int i = 0;
+
+	memset(axis_sample, 0, 3 * sizeof(__be16));
+	if (ADXL372_X_AXIS_EN(st->fifo_axis_mask))
+		axis_sample[i++] = sample[0];
+	if (ADXL372_Y_AXIS_EN(st->fifo_axis_mask))
+		axis_sample[i++] = sample[1];
+	if (ADXL372_Z_AXIS_EN(st->fifo_axis_mask))
+		axis_sample[i++] = sample[2];
+
+	memcpy(sample, axis_sample, 3 * sizeof(__be16));
+}
+
 static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
@@ -553,8 +574,12 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 			goto err;
 
 		/* Each sample is 2 bytes */
-		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
+		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
+			/* filter peak detection data */
+			if (st->peak_fifo_mode_en)
+				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
 			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+		}
 	}
 err:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -722,6 +747,43 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", st->peak_fifo_mode_en);
+}
+
+static ssize_t adxl372_peak_fifo_en_set(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	bool val;
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	st->peak_fifo_mode_en = val;
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(hwfifo_peak_mode_enable, 0644,
+		       adxl372_peak_fifo_en_get,
+		       adxl372_peak_fifo_en_set, 0);
+
 static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
@@ -815,13 +877,22 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
+	st->fifo_axis_mask = adxl372_axis_lookup_table[i].bits;
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
 					  indio_dev->masklength);
+
+	/* Configure the FIFO to store sets of impact event peak. */
+	if (st->peak_fifo_mode_en) {
+		st->fifo_set_size = 3;
+		st->fifo_format = ADXL372_XYZ_PEAK_FIFO;
+	}
+
 	/*
 	 * The 512 FIFO samples can be allotted in several ways, such as:
 	 * 170 sample sets of concurrent 3-axis data
 	 * 256 sample sets of concurrent 2-axis data (user selectable)
 	 * 512 sample sets of single-axis data
+	 * 170 sets of impact event peak (x, y, z)
 	 */
 	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
 		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
@@ -894,6 +965,7 @@ static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
 static struct attribute *adxl372_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
+	&iio_dev_attr_hwfifo_peak_mode_enable.dev_attr.attr,
 	NULL,
 };
 
-- 
2.20.1

