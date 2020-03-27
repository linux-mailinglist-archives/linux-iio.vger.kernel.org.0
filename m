Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4B196137
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgC0Wez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:34:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40814 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgC0Wez (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so5263426pgj.7
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cygiXMhl15qCUoQzSdzcfGNuz13l6qpvDscRygVf1ic=;
        b=nZqt3IRQGdYufnzoOrJmLIYTAQccDO7n2b+z4Mc2wXhA3x9URxfnGcXPxklgM6vLQ8
         hXm8L3SwAqa19ww7KqvSxtlcRQH0BpIIzWOLQVnm+rTrHygWf0kFHEhR4h8DUi4JlfsN
         434HiMvvup6htLiPt73RyIC294WFvPSr9AV5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cygiXMhl15qCUoQzSdzcfGNuz13l6qpvDscRygVf1ic=;
        b=X784F+UQZH+pjNswOMUAfEgvhBocbIqFDXkyRavynW6dPb1J5XZvqX7GCeNQQ/htYW
         Dy2gI0IhWUUx8k0EUM1ti4+IxiFzRxbdSrTTiWHXU3uBmbXo3gnzp4xBCtTx1sjqFSbs
         vGzkD6DL5/ZfD92tTZfbDGZO8/aa07vO7RN+joCQ4BHGlptMBw/S+FZpVBkUE1seOVxU
         RzLmEWEAeTr2CzAlrbJ2rkEEcwrszYgrqfqYNmXHUoBXFKjVlVqKcEJKBUD5665hDx2R
         1+tOIehRooYDiBHorGspVndGvoFCnO4lm7LBH/GzOKQRKW4vNveEGSYnZEDWUrmdGyqR
         uayw==
X-Gm-Message-State: ANhLgQ0HKzyTjCAjP8RETA0WLLtO+s4UFeJSGCKal4rZtZCyayqNUV0h
        4M2rYNt9K5WsSC/rmVT6Iqttfg==
X-Google-Smtp-Source: ADFU+vvcX6J9Ugh2o4X81n4+wBMCWFJmedzRhDkNd7oVayTVBqJ4mAlMn+oBovbNwOQC+ASgcgJJtQ==
X-Received: by 2002:a62:cdcc:: with SMTP id o195mr1447680pfg.323.1585348493927;
        Fri, 27 Mar 2020 15:34:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id a15sm4869187pfg.77.2020.03.27.15.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:53 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 06/12] iio: expose iio_device_set_clock
Date:   Fri, 27 Mar 2020 15:34:37 -0700
Message-Id: <20200327223443.6006-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some IIO devices may want to override the default (realtime) to another
clock source by default.
It can beneficial when timestamps coming from the hardware or underlying
drivers are already in that format.
It can always be overridden by attribute current_timestamp_clock.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v6 and v7.
Changes in v5:
- New in v5.

 drivers/iio/industrialio-core.c | 8 +++++++-
 include/linux/iio/iio.h         | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 65ff0d0670188..26e963483bab0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -189,7 +189,12 @@ ssize_t iio_read_const_attr(struct device *dev,
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
-static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
+/**
+ * iio_device_set_clock() - Set current timestamping clock for the device
+ * @indio_dev: IIO device structure containing the device
+ * @clock_id: timestamping clock posix identifier to set.
+ */
+int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 {
 	int ret;
 	const struct iio_event_interface *ev_int = indio_dev->event_interface;
@@ -207,6 +212,7 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 
 	return 0;
 }
+EXPORT_SYMBOL(iio_device_set_clock);
 
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 862ce0019eba5..b18f34a8901f3 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -627,6 +627,8 @@ static inline clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
 	return indio_dev->clock_id;
 }
 
+int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id);
+
 /**
  * dev_to_iio_dev() - Get IIO device struct from a device struct
  * @dev: 		The device embedded in the IIO device
-- 
2.26.0.rc2.310.g2932bb562d-goog

