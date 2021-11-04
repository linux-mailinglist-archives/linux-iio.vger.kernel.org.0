Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB8445029
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhKDI1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDI1E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952FC061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r28so4825975pga.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2NF2iQiTW0SCiPPmUKQtfO2X1ePHPLUOi6iTgYkNyg=;
        b=eO11pi8A2i4HirN/r4G19fEw8OVgBkWTMf3Na2L5rGzzynwsKdpkNZt+ki08wgW8gd
         KvGbKjipvrGKZdNMNPhvSn6pux4oKYi2/o2GUrZ2MX3g5Wkggc4MvscEpPpVvVy1vM4M
         qSpSn18CdwGFi0P4NiASKfT2lh9uYovq9HBrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2NF2iQiTW0SCiPPmUKQtfO2X1ePHPLUOi6iTgYkNyg=;
        b=Xmb+E1RQ/wsAXhP8Ny8vRWBJYJxSGo/nsRKW6APP2Um52qbBaCdGRsoVgGx9yAS3LT
         R016dXRQiqiWi6fAoCvglxdkTCCaAGtZG2aNCIfkACf4uINHs3vXKxkIn+WON26mjIPn
         nZ1s85EGgL5Ww+ZzLwJIXc4srEB0PcBUiIWJcxd3KGhJaT+UBrmhigAsh7NS15kyZnOh
         sy6M2twvkLeoma1Q+TnRJ+oCoz0+yyw8qALjN430R8gsgGWY4QmMPupkU9NKk8buCcw5
         058CZrLZmU7gPd6apsUyihgU4ixbLoBwl3vb09zxSlWpT/KeW+h5nMHxev2PivkSd7Df
         8m1w==
X-Gm-Message-State: AOAM532zVZoYyFSxUQCNXWcAY7FFFz37qrLLNTW7b4OgaBBtlqxUhFo0
        JsIvwFZU9z7HClahCGfOTU6+ti/T+i1Akg==
X-Google-Smtp-Source: ABdhPJz966mbrlX5Y0szuNRWypFhvtWDmmQYsT67iwta61FhQy6z5gFKGYKcp5/7A0tUwJDkdD8lmg==
X-Received: by 2002:a63:3d8f:: with SMTP id k137mr38062282pga.21.1636014266235;
        Thu, 04 Nov 2021 01:24:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id ng9sm7024811pjb.4.2021.11.04.01.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:25 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 04/13] iio: sca3000: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:04 -0700
Message-Id: <20211104082413.3681212-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use channel definition as root of trust and replace constant
when reading elements directly using the raw sysfs attributes.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/sca3000.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index c6b75308148aa..43ecacbdc95ae 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -534,6 +534,13 @@ static const struct iio_chan_spec sca3000_channels_with_temp[] = {
 			BIT(IIO_CHAN_INFO_OFFSET),
 		/* No buffer support */
 		.scan_index = -1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 9,
+			.storagebits = 16,
+			.shift = 5,
+			.endianness = IIO_BE,
+		},
 	},
 	{
 		.type = IIO_ACCEL,
@@ -730,8 +737,9 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
-			*val = sign_extend32(*val, 12);
+			*val = sign_extend32(be16_to_cpup((__be16 *)st->rx) >>
+					     chan->scan_type.shift,
+					     chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
 			ret = sca3000_read_data_short(st,
@@ -741,8 +749,9 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = ((st->rx[0] & 0x3F) << 3) |
-			       ((st->rx[1] & 0xE0) >> 5);
+			*val = (be16_to_cpup((__be16 *)st->rx) >>
+				chan->scan_type.shift) &
+				GENMASK(chan->scan_type.realbits - 1, 0);
 		}
 		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
-- 
2.33.1.1089.g2158813163f-goog

