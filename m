Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440CA34BA8E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 05:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhC1DhZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Mar 2021 23:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhC1Dgu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Mar 2021 23:36:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7FC0613B1
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 20:36:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r17so7263381pgi.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 20:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9qFxmM7PC3HjqXfTJfN+OFOhIINqBJVEYzQMAqXcGA=;
        b=M8EhQfC4W6FHV3cDWap/DkH8n5aAmlpmNhyYhEzvvYfkdO5nEhZclvVTKiuveLvw9I
         cbL9bK0zAvsuu//aTsisUri1xAMSr3pVO1hWTbzeHjZNYlKM0ZpJ08/h5DeFepnZbmfs
         Of6huu2I/NV+k0Cczzp5vdOXqpejA65rq+T/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9qFxmM7PC3HjqXfTJfN+OFOhIINqBJVEYzQMAqXcGA=;
        b=VuWnGAUEm638Hcl2pz8QCgBPO0Cfkj6FjGtza/6dV1AEPZkAZLT8J4jpxCJa1Ur3U2
         FmAkIfcdZvZoD0D9+AWGNf3CxlZIdwxDEEEZgReWxNICuIzNIF1yGfWHADcoJvFKQ3tr
         u2ys7rJsG5GVu6fN1yPr5hETmJFCHTWQJyYeYc8R8+mWZJzfhbBEJmNGAGlwTI+ol7ad
         xmCINItft7alXWHVlu+DtfOiYS7MhFsn4v8o2ko1t/I2KiDgEJ6ggDS8+7hZKHFfecqP
         QKSVbYx1yDHTYQxxaIHhw86NlaULUb9BzYPTpkG4kY12CpP9Wf6buLyXY/LabrF2EcAY
         xF4Q==
X-Gm-Message-State: AOAM533RW4Uqvve8Bgnx02nSEG+EzvIrBb5Ezb+yRo+jckVYsoQPxKFC
        TqPn5c4yY6MfSOkJdk9RgYF11Q==
X-Google-Smtp-Source: ABdhPJxIkOWp9AM1cU0EfkTNpxya9df7+547JU6zFQwHIByCqf4G4WHXu0LnEVyuNvOCOHBp2PaAOQ==
X-Received: by 2002:aa7:980a:0:b029:20c:5402:5de9 with SMTP id e10-20020aa7980a0000b029020c54025de9mr19769635pfl.18.1616902609590;
        Sat, 27 Mar 2021 20:36:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5993:d227:a897:4c2a])
        by smtp.gmail.com with UTF8SMTPSA id u9sm13075121pgc.59.2021.03.27.20.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 20:36:49 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/2] iio: sx9310: Add debouncer-depth parameters
Date:   Sat, 27 Mar 2021 20:36:39 -0700
Message-Id: <20210328033639.1021599-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210328033639.1021599-1-gwendal@chromium.org>
References: <20210328033639.1021599-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Semtech SX9310 SAR sensor has a debouncer filter: only when N
measurements are above/below the far/close threshold an event is
sent to the host.
By default the debouncer is set to 2 events for the close to far
transition and 1 event (no debounce) for far to close.
It is a balance speed of detection and false positive avoidance.

On some chromebooks, the debouncer is set to a larger number.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 1ed749190bff9..6f92cf18fac31 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1219,8 +1219,8 @@ static const struct sx9310_reg_default *
 sx9310_get_default_reg(struct device *dev, int idx,
 		       struct sx9310_reg_default *reg_def)
 {
+	u32 start = 0, raw = 0, pos = 0, depth = 0;
 	u32 combined[SX9310_NUM_CHANNELS];
-	u32 start = 0, raw = 0, pos = 0;
 	unsigned long comb_mask = 0;
 	int ret, i, count;
 	const char *res;
@@ -1325,6 +1325,25 @@ sx9310_get_default_reg(struct device *dev, int idx,
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
 					   pos);
 		break;
+	case SX9310_REG_PROX_CTRL10:
+		ret = device_property_read_u32(dev, "semtech,close-debouncer-depth", &depth);
+		if (ret)
+			raw = FIELD_GET(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK,
+					reg_def->def);
+		else
+			raw = ilog2(depth);
+		reg_def->def &= ~SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK;
+		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, raw);
+
+		ret = device_property_read_u32(dev, "semtech,far-debouncer-depth", &depth);
+		if (ret)
+			raw = FIELD_GET(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK,
+					reg_def->def);
+		else
+			raw = ilog2(depth);
+		reg_def->def &= ~SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK;
+		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, raw);
+		break;
 	}
 
 	return reg_def;
-- 
2.31.0.291.g576ba9dcdaf-goog

