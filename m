Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD4FD9CA
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfKOJum (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:50:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfKOJuk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so4292660plt.13
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EH3/rE12JHx6Schyye7LNMnilco+Fu8o6GMXdyK4YA=;
        b=m6M/4rTxXvWWde2XfD9f79AUiuMlhyLUByo1EytWTsdj1qXfh7Y+G1GYTOTQFQMEk9
         IGqoEabjZq/1VBfX2f0/qc0yUm3t50NZFYYMuX1ltV6DSxhH09MuVyfhMOFoXCIAnlzj
         RhNPilBWuZRQ2tpuSktJRxOoXINQoKbrJRW2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EH3/rE12JHx6Schyye7LNMnilco+Fu8o6GMXdyK4YA=;
        b=PkJDfMEteV0k9uRtfu6JWVhE8p5GZqs/sd/1SnhaXIGAELtmmBbns8eFVj6kp05UKU
         BX+aSvbLfZ/SJI/3IRXyFPP4wMWCb+F+AUvC+bvwnLL8vAykAn1NhtkhcbLwfJSl/crl
         ozacgm18v44uhcIj0t3SOi+xSbvn5vmXavtOV2an3ZuA1wndMpvTou4EwoQ8x7a8jOSs
         NEENlBueC1H1X2C5Dq05lrbGmY34dJ7aKyNmfK3sFf625s297UzSkZ3nKqk1DW2WyH6E
         8LN82yOIoui9Osof/JMmE6N1fw+rsZZCAWyFtOl/czPjJtRxpcrz1iXnAAuQoSDBOate
         mD3A==
X-Gm-Message-State: APjAAAX7MtzaGor/XvWCCQoOtYjop4xdMZnVXTgopqCMhNV/CY57KUDm
        bzaX2Wzg6AJcRZgxByAFXiuCOw==
X-Google-Smtp-Source: APXvYqxHj8FG2nGVH/ERl/QGBLmOFQGuinzi6G3lxXITvgjcF8Qdcm9wl4M8PaZ94nAb23Rqhr3H/w==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr13962662plt.329.1573811439555;
        Fri, 15 Nov 2019 01:50:39 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j20sm9310587pff.182.2019.11.15.01.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:39 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 13/18] iio: expose iio_device_set_clock
Date:   Fri, 15 Nov 2019 01:34:07 -0800
Message-Id: <20191115093412.144922-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
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

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/industrialio-core.c | 8 +++++++-
 include/linux/iio/iio.h         | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a46cdf2d8833..92815bdc14ee 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -188,7 +188,12 @@ ssize_t iio_read_const_attr(struct device *dev,
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
@@ -206,6 +211,7 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 
 	return 0;
 }
+EXPORT_SYMBOL(iio_device_set_clock);
 
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 862ce0019eba..b18f34a8901f 100644
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
2.24.0.432.g9d3f5f5b63-goog

