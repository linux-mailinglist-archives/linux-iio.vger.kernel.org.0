Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90584191AFD
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 21:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgCXU2X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 16:28:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36670 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgCXU1x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 16:27:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id j29so22063pgl.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZigHEZ9wEtW9T2r5IUfNO5JfwDcLltP6YCkvQNLzMZg=;
        b=EEj5rKgfO0GiydsW11KRCtfxlT6VWJWdckQbFJAHocKf9zxE4sh7bI+ssRJReWY5z+
         NxlCQ7c95xJJJHBpzr4JznrxpF1Ugd+4ZaUHlfueHs3/NwQBCrXZ6lWOrabQWVYc+cB3
         NxO81PWs+9IL3pXbOF6sghze+pvWw45GjQCIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZigHEZ9wEtW9T2r5IUfNO5JfwDcLltP6YCkvQNLzMZg=;
        b=mVDJycaRO1FtW//3zyId3boVNbp6ZPhLm3PezlNeygvKNCCfALZC0czVNfeS1v82nz
         8bunlBh3XDMCypHAqNxGZWZ4QC7ZjcBLv6xfK3R9qbdxmqZvoQmUL4zbQNtnt6MnI3Eo
         EYCGKXd8bhPzgDk/wVi19iPd5wE6oTKfjUKjZrbFbZP/sKgbweA7t8JAdzpQeItGIpzo
         iU4W2PYEogqCZyzm/pI0b4ExbxD26vX5Kw2ttBFDbGFaSeNRaCLWjkbqM7jyI3nRsyFu
         1WllrGxrycPOrFno+neCSF2dryviWe/iySvMJMMelivfZZSyK1buB57f5b9CGzWU1JZz
         l4ig==
X-Gm-Message-State: ANhLgQ1PEuq+TIc3eydaOZZmksAbTCyZvq+pGGqHVp/af9O//FDP6PWF
        8V5JbET2rz8cwHdVMgglRPENpQ==
X-Google-Smtp-Source: ADFU+vtrlDmTwEE9oYXJAOdQ/zBHf+vMnBKpgHdCBI82QuEAs/PG/g2Tsj9vSxggT8MDEeA66ZFpyQ==
X-Received: by 2002:a63:4f0c:: with SMTP id d12mr26233420pgb.199.1585081672376;
        Tue, 24 Mar 2020 13:27:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id o33sm2993992pje.19.2020.03.24.13.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:27:51 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 05/11] iio: expose iio_device_set_clock
Date:   Tue, 24 Mar 2020 13:27:30 -0700
Message-Id: <20200324202736.243314-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200324202736.243314-1-gwendal@chromium.org>
References: <20200324202736.243314-1-gwendal@chromium.org>
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
Changes in v6:
- No changes.
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
2.25.1.696.g5e7596f4ac-goog

