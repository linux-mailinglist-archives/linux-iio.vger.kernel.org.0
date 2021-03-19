Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7253422A0
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 17:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCSQ6W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCSQ6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 12:58:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF99C06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:58:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so5178421pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4YhaO+/7zQ8eIjr571Ku5UtRnhk6XWOem2z/EOwxdUI=;
        b=mb1gSQp6McWfH7sGoeYlwGUDqNtGmU9C7knT1kii24cilXZ2ebncww/qPisFbnlMma
         n4aiiaUxBZypGhw82mx5TGirFP96B3js1QiOYT3MEWopZPLlmxvmyyno9WSpbsLaTISt
         brNNNZuf/Lm+hs3gUWcZdktVa5UKkQJlM6P28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4YhaO+/7zQ8eIjr571Ku5UtRnhk6XWOem2z/EOwxdUI=;
        b=pxbmP75ko/6LewUcropltoj30DVG6vJW7vWOkKvBH2NhD2Lt4bpqfOGZU4b7BUwYxP
         RtXm5j6zLQkzerDkyQnvwlkcDpBNaldVi5Oe4D4AJYY4Wx6eQLggpkm66PX9BO3masHZ
         BXYcEC+gHcy7SE6SHDOd3Si+09QoGOCy3uRxB5JDHyzKFeRCwAKGy2R5BrhD0mD81vI2
         oM+QpT4jFwGz1Ru+iomO7DdiWmge98uvfs2id4+KlswX/M4ywzSJFqmD6Ci5V1X9vbYA
         oGPOfl7ZuR0FHSlokeQF8jO+Hm6T4w+7XFwkZ8wvgGU7YhMcnfJseNZtF28Jjz2UZBLD
         ubdg==
X-Gm-Message-State: AOAM532XIMSqxGsCemtLXOnmZXnng6EzUIQroKHNW1yM2FHZVKroATaV
        wKU7mescjA0hvMrqRKIT3VPq4Q==
X-Google-Smtp-Source: ABdhPJyN2d1YAXjoTAxYy78cLtSI5+KcT4hZN21UuOpbQxHiZO3ssDcQIN4jpyQ9DndU9KiLn4r6VQ==
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr10447961pjb.156.1616173094873;
        Fri, 19 Mar 2021 09:58:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:a05c:c77f:8a41:973d])
        by smtp.gmail.com with UTF8SMTPSA id k21sm1527018pfi.28.2021.03.19.09.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:58:14 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 1/2] iio: sx9310: Fix access to variable DT array
Date:   Fri, 19 Mar 2021 09:58:06 -0700
Message-Id: <20210319165807.3639636-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210319165807.3639636-1-gwendal@chromium.org>
References: <20210319165807.3639636-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the current cide, we want to read at 4 entries from DT array
"semtech,combined-sensors". If there are less, we silently fail as
of_property_read_u32_array() returns -EOVERFLOW.

First count the number of entries and if between 1 and 4, collect the
content of the array.

Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 394c2afe0f233..cbca965889f14 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1213,17 +1213,17 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 }
 
 static const struct sx9310_reg_default *
-sx9310_get_default_reg(struct sx9310_data *data, int i,
+sx9310_get_default_reg(struct sx9310_data *data, int idx,
 		       struct sx9310_reg_default *reg_def)
 {
-	int ret;
 	const struct device_node *np = data->client->dev.of_node;
-	u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
+	u32 combined[SX9310_NUM_CHANNELS];
+	u32 start = 0, raw = 0, pos = 0;
 	unsigned long comb_mask = 0;
+	int ret, i, count;
 	const char *res;
-	u32 start = 0, raw = 0, pos = 0;
 
-	memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
+	memcpy(reg_def, &sx9310_default_regs[idx], sizeof(*reg_def));
 	if (!np)
 		return reg_def;
 
@@ -1234,15 +1234,31 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 			reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
 		}
 
-		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
-		of_property_read_u32_array(np, "semtech,combined-sensors",
-					   combined, ARRAY_SIZE(combined));
-		for (i = 0; i < ARRAY_SIZE(combined); i++) {
-			if (combined[i] <= SX9310_NUM_CHANNELS)
-				comb_mask |= BIT(combined[i]);
+		count = of_property_count_elems_of_size(np, "semtech,combined-sensors",
+							ARRAY_SIZE(combined));
+		if (count > 0 && count <= ARRAY_SIZE(combined)) {
+			ret = of_property_read_u32_array(np, "semtech,combined-sensors",
+							 combined, count);
+			if (ret)
+				break;
+		} else {
+			/*
+			 * Either the property does not exist in the DT or the
+			 * number of entries is incorrect.
+			 */
+			break;
+		}
+		for (i = 0; i < count; i++) {
+			if (combined[i] >= SX9310_NUM_CHANNELS) {
+				/* Invalid sensor (invalid DT). */
+				break;
+			}
+			comb_mask |= BIT(combined[i]);
 		}
+		if (i < count)
+			break;
 
-		comb_mask &= 0xf;
+		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
 		if (comb_mask == (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
 			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
 		else if (comb_mask == (BIT(1) | BIT(2)))
-- 
2.31.0.291.g576ba9dcdaf-goog

