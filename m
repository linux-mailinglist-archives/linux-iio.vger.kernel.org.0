Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF05343A9B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 08:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVHcg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhCVHc3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 03:32:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE3C061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:32:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h3so10347103pfr.12
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMkrsilVOP6QO4ZQoQXToyrw7eFBMVVM3IKhGI2Wm9o=;
        b=KL10rpvGhTzGqP8JE/pdoHQifN5KnvKuSrq4memsSO3GqPJ9xinpwl75VLdpV+O2zd
         qBrFay5lhgf5Qt3qO8FFSeGM2Qj9yPK5HqnF3JbY/LljAw/XsSxKDHcna0Wli/X40ttN
         kSYkijc+uXWN20yZucic0lqxhI77Lq+VlYCOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMkrsilVOP6QO4ZQoQXToyrw7eFBMVVM3IKhGI2Wm9o=;
        b=WoFSaGr3OgfzgxtC63FziIF5LasSK8FgK0wP81WeRHmaSDkzW5fcIqGkmoyo/DX7ds
         Cp+8vvc6VBhHZPLDkDDnr5CEnF2AH5S7Jc0xDkdYxxm61d3avucJ4jelVjiYrdB3UrKw
         Ry09TKiynX5ATuSf94PD5304dpkxp0nWaYm/J/44dJNqx2i8MbZSVLuP9a+5CHhCyzlf
         4BBb4LF3ryaiX+Tlzr+brGnM0geda6DHcmePXWjO2OfapFT+2vKqNGr4utQa0QeE/7qL
         8tmXtwuM39Hw6JWlNQPc9sYOfH06rjTKGIOq3YrHaEHYfX0gaUh6pspZZZ1G11H0MPBX
         WwtA==
X-Gm-Message-State: AOAM531rgqoYkFwxU+jJxNB23MGFP50TJE6aUDZpi09Ry1BacvGF7zoN
        dSa+96oM/1LC1cXy/JxfGqnMlw==
X-Google-Smtp-Source: ABdhPJxA4xSEtvCz5aoZ+Oy80CSTdWRHX4AsJ62WvQGwor7HQD67N/km0/yXhRkiUQ1v2FClpESqog==
X-Received: by 2002:a63:8c0b:: with SMTP id m11mr21362768pgd.306.1616398348519;
        Mon, 22 Mar 2021 00:32:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:90ec:f36d:f115:8c9e])
        by smtp.gmail.com with UTF8SMTPSA id q17sm3070696pfq.171.2021.03.22.00.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 00:32:28 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 1/2] iio: sx9310: Fix access to variable DT array
Date:   Mon, 22 Mar 2021 00:32:19 -0700
Message-Id: <20210322073220.1637117-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210322073220.1637117-1-gwendal@chromium.org>
References: <20210322073220.1637117-1-gwendal@chromium.org>
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
---
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

