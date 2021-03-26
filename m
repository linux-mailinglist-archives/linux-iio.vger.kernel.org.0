Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFFF34AEBA
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 19:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZSqa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZSqK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 14:46:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92EC0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 11:46:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e33so5191773pgm.13
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fw6G3h2wngly3T1GhuM3nxPZaInfJBTBEOVNMXObu28=;
        b=MhZrl8884pYRT7HIR63wW5dJU2RxVA/SGQmSdaQWY5oTclcxU/6mR0aFAnaMUtOhW6
         LYAPUBSEvX63g9lo87WykHwR0TIS9QVRmWLG8SWiJti9d1F6UEMzZNDOU5kXsWs06/8N
         BOc9S2Jy1P6/HM2/cFIHsCDogRX9pYWgAvE40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fw6G3h2wngly3T1GhuM3nxPZaInfJBTBEOVNMXObu28=;
        b=B/BanhlAUzDZXIHNh77tJKPeioaABn4ZUqggZwOpOsIOROXUelAGu+9Vx0/GkZCaId
         TKxZSINtmRnAs7zYMCF6yBz6zNIS4G7NKMT8XskXTku9ZqUH92zbCgymHYqfeXwE23dG
         IxIL/UeY6ZiOfIfautwxVwxLnFt90e7jah6VxXOTouy0PcpDkWxpcI2dlaKwZL0XPCov
         ye5gP1JFiv+JcdMVmZO+FqQrbhrArFXs/Pah51kBW+SKd/zJGDdfcyrM1jsZUd6RyaUP
         x7huLv1BihGIPOl7RMLSHxBQsN0uA+AXVqz0RXWo+rRTUM6uPG6MBTdEVCAAgtCEjluL
         qmAQ==
X-Gm-Message-State: AOAM53038JFS/uacxIEQZyO6tdovK9wMfuoDC92M8Zb48E6fO2sLX4Ju
        lv4JhDRUqUqi+Pr9R9QQQYVFEw==
X-Google-Smtp-Source: ABdhPJwUNjXBnDZ1hgCIozwWvZLYJbtNjv1MeC7XsUxpuOq6jXpPDqVbfdB4q/ApDOlv10qKv1pVwA==
X-Received: by 2002:a63:fc26:: with SMTP id j38mr13400546pgi.433.1616784370216;
        Fri, 26 Mar 2021 11:46:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e071:1f4b:7e7:f3c7])
        by smtp.gmail.com with UTF8SMTPSA id n5sm10261727pfq.44.2021.03.26.11.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 11:46:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 1/2] iio: sx9310: Fix access to variable DT array
Date:   Fri, 26 Mar 2021 11:46:02 -0700
Message-Id: <20210326184603.251683-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326184603.251683-1-gwendal@chromium.org>
References: <20210326184603.251683-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the current code, we want to read 4 entries from DT array
"semtech,combined-sensors". If there are less, we silently fail as
of_property_read_u32_array() returns -EOVERFLOW.

First count the number of entries and if between 1 and 4, collect the
content of the array.

Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 No changes in v7.

 Changes in v6:
 Fix error in of_property_count_elems_of_size() argumnent:
 Used ARRAY_SIZE(combined) [4] instead of sizeof(u32).

 Changes in v5:
 new, split fixes from changes needed for ACPI support.

 drivers/iio/proximity/sx9310.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 394c2afe0f233..289c76bb3b024 100644
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
+							sizeof(u32));
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

