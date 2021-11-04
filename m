Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA144502B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKDI1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhKDI1H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:07 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EAC061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k4so5980209plx.8
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfOVCvVYnXf5Qn6Otdy07nqhnP7h5NZHYQtwyvdfb7A=;
        b=Rd5gMOrl7v4l2SaqlB65B6t+vB65mfcJyr0jERqpPJgliRwbBMHxERTdz7f6cocwtE
         +xNpzQ10Pe60QjRVi+cc1zeN5ZHKMnZmBSHmYSUcXNA66bfFftZUajcDJ1N50NqCnxm0
         xVsITl/OGcctT1rie4S4inUOAa7fbmmjfbT74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfOVCvVYnXf5Qn6Otdy07nqhnP7h5NZHYQtwyvdfb7A=;
        b=AWgySpWEgOz/0/fHpO8G5RLIyLYEnM+/7UYOjtCoGp6ceXApq4VO0JV/XUbYw1Qzs+
         TOxPSxWmDKopBrsdDR9MIs+TzwfKsyspf0dxH8snxmLatutCZ4zkY5ovpURtZ1hl5GIY
         tCnXQMyCSPuHFwSns9fJ2UtWC/LOac82oQh6reh1gKAJgR1C2CEPXbVFvpOQ6On5SEDH
         wo9lxWOc0BOHe3gqs+YOsszo2UQrfEoYqop5Udl7V3H3Mp0vqmE2QciIfyYpj5v5TWZF
         pXL9oqZJR7e3ZN+1Piv4/4mM0U4/baRKgKQHPAb4QayDkNT5IClYKGERNhwgC+D13Xef
         6UEg==
X-Gm-Message-State: AOAM5330/LFmJbAFLKKDC8iMIL8ZQT2NL6FhxEopd1XuckxjRsUBZAAk
        e+12FoeuA7QlpwcF2T+t307OKj5nhLFy2A==
X-Google-Smtp-Source: ABdhPJzbG5tE9QT0nAp7EYcXSqpIlUlK5fRIj1udr6ZmuKH0oSDRggqWLVlSMOMVT7sXYKU1fCl/oA==
X-Received: by 2002:a17:902:d711:b0:141:efff:9f3 with SMTP id w17-20020a170902d71100b00141efff09f3mr22711064ply.48.1636014269493;
        Thu, 04 Nov 2021 01:24:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id w13sm6897039pjc.29.2021.11.04.01.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:29 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 06/13] iio: stk8ba50: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:06 -0700
Message-Id: <20211104082413.3681212-7-gwendal@chromium.org>
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
 drivers/iio/accel/stk8ba50.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index e137a34b5c9a9..517c57ed9e949 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -227,7 +227,8 @@ static int stk8ba50_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			return -EINVAL;
 		}
-		*val = sign_extend32(ret >> STK8BA50_DATA_SHIFT, 9);
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
 		stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
 		mutex_unlock(&data->lock);
 		return IIO_VAL_INT;
-- 
2.33.1.1089.g2158813163f-goog

