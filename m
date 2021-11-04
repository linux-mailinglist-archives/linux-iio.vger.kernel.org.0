Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C920445028
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhKDI1D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDI1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A61C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f8so5944615plo.12
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdZv0B1+U+lvfR+/5ZB+jRAodarD3Qdo87VQjmtnu2Y=;
        b=kJXE7VOjLjc+5XaGt4iJG/udNSxsKr9xq1tbBobyntqFVqjrq9tS/rJ/kkHx8T+ovG
         V1W9PYLybi+3VGz4KNhYSO+9SQttW6qGaoZNmeRJyjAEbt2dadUpqVr9M1iLpXQa/EQR
         YPfPClMryiSNEujRRkbnVAKUCg5SyVO7m8PDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdZv0B1+U+lvfR+/5ZB+jRAodarD3Qdo87VQjmtnu2Y=;
        b=wuoIcRZpqYLKUnMI2l9EoSOs4uKuGPjGfomi/Ebiik7THj+WRI6BTxrdin5TAIOzyB
         VTTHK2dGK9e9PkZpEq7Jk0a5i/85Kj7FVURhjSJnqXCCeG0TyvdygoX1WFhR1alyjiGj
         CbyyKdXF0CX/UWq95fzS8Gq6jzfmU+1eoNPhQxln8fZXqkVARKQF0BiZyBe1PItFopxJ
         ZlWwLoXsIbaeRq8v191zMwjcqgWGR9WKwiqlE9HxKDRnaxKsVffVUDtgEZLYPfAySgOw
         3fN/dHjEiFvJJn1ZMpN5DeSyZT8ocU3SosAzWVWYU9zBIMNKCUuRGVV6g9cKh9tM0ayx
         +zPg==
X-Gm-Message-State: AOAM530M1XSwo45kIUXoutShJeyCZHzgG0+Ihic8KNlHO7YSXUDqADJd
        OSKAq1sF3AHbHC8fl1+0yrts8A==
X-Google-Smtp-Source: ABdhPJxc9LwqmSpXRDHwWTh5FETrABV6STr1qei6dOLHQxAlDpk9PBWm6LPmiej/fEqrMFTjKFq0sQ==
X-Received: by 2002:a17:90b:3848:: with SMTP id nl8mr717047pjb.221.1636014264720;
        Thu, 04 Nov 2021 01:24:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id e8sm4597895pfn.45.2021.11.04.01.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:24 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 03/13] iio: mma7455: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:03 -0700
Message-Id: <20211104082413.3681212-4-gwendal@chromium.org>
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
 drivers/iio/accel/mma7455_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 777c6c384b09e..e6739ba74edfa 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -134,7 +134,8 @@ static int mma7455_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		*val = sign_extend32(le16_to_cpu(data), 9);
+		*val = sign_extend32(le16_to_cpu(data),
+				     chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 
-- 
2.33.1.1089.g2158813163f-goog

