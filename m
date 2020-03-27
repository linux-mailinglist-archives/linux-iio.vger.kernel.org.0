Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3C196144
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0WfV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:35:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33233 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC0WfC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:35:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id j1so5198681pfe.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+1xmr1a9eg3AmnjLomjOPKSe+onX/qqluNCv1dv8I0=;
        b=CnPBKlywSOzMLnPL2jTSRxHG2ElBI7BnPECo8RQl/yi5yG38NJr86kKApXZ1+Dt/lN
         C4OVdG0T0UngFQM7gI8byJaTjJZGMRWfLB7jrTyrlD3XrPZDsbmuQZVGcP9F5PSZccUe
         OjLYATwVq5Q9BtbteK+guA18WiPtI3oRfVTTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+1xmr1a9eg3AmnjLomjOPKSe+onX/qqluNCv1dv8I0=;
        b=F2L9y2VBm8WF+2uCuZtT91ZODE7Q730grZgP8Ckbb8xXqfeucDxx+1/FihYMT0l3OV
         0loucyKpmeR1utz5AHEa4wxAJdS4fYyKcv0NfD5wCJyKsF/Ai873b7JMxAUkf8RP+C0t
         SbyCztUkYXgQrRyj0EFngkJkd/+dmjoOB6z+yikddgsANxncECd0vJjfCA5Qq33vnlze
         ZRlASYTGJiO5wyIUCtfrWRg324tORTuBD2iDFRLYbeg7ffzt6wio/Pj0gEZaKalLdOfx
         kJIo3R24+J7dF7AWHs9gOWzeE1ROOuPxEWxcJe4nFsh2+0+bw5D8tSVfcy8g8Hn8ez+F
         am3Q==
X-Gm-Message-State: ANhLgQ2fbqGeVgwWyV9NX0fd4ak5bFvf8KVsAaahtCTfwSevLf8YQLSL
        BwGAd/II6MMtfBKb0fyj64GNEQ==
X-Google-Smtp-Source: ADFU+vsD97GkxfZVdvTRqrAFA5EqUkKPIHRm7Zw+f1cdlx7onYBRpR49+dsNQdauolRMFSp/iCv48w==
X-Received: by 2002:a63:5847:: with SMTP id i7mr1534992pgm.127.1585348501236;
        Fri, 27 Mar 2020 15:35:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id f22sm4588981pgl.20.2020.03.27.15.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:35:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 12/12] iio: cros_ec: flush as hwfifo attribute
Date:   Fri, 27 Mar 2020 15:34:43 -0700
Message-Id: <20200327223443.6006-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add buffer/hwfifo_flush. It is not part of the ABI, but it follows ST
and HID lead: Tells the sensor hub to send to the host all pending
sensor events.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v7.
New in v6.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c831915ca7e56..aaf124a82e0e4 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -113,6 +113,33 @@ static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
 	return ret;
 }
 
+static ssize_t cros_ec_sensors_flush(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret = 0;
+	bool flush;
+
+	ret = strtobool(buf, &flush);
+	if (ret < 0)
+		return ret;
+	if (!flush)
+		return -EINVAL;
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	if (ret != 0)
+		dev_warn(&indio_dev->dev, "Unable to flush sensor\n");
+	mutex_unlock(&st->cmd_lock);
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(hwfifo_flush, 0644, NULL,
+		       cros_ec_sensors_flush, 0);
+
 static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 						 struct device_attribute *attr,
 						 const char *buf, size_t len)
@@ -175,6 +202,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
 static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
 
 const struct attribute *cros_ec_sensor_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_flush.dev_attr.attr,
 	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
 	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	NULL,
-- 
2.26.0.rc2.310.g2932bb562d-goog

