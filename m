Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74FF11BF5A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 22:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLKVid (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 16:38:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35211 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKVid (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 16:38:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so16181lfr.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2019 13:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtLeUHFiL+dOJNhxDIzcPZjSfJUnp/C7Q8G/2C52MTY=;
        b=C8EKacdlQMun5gl0woeKwdUKcpeiCJQ7wlzWPhen+8moSV6lXopcDAwWFiRN9AtZ/v
         bUkHJqo0Xvh4cy58+doNMFnJSxr4X81fobmdSqBDQD99Fz297/mVUwK/vWaIeyPvCqk7
         wp2KBPUnwhFEgglmcr2IHcAwI1CPp2xFD0o73UWWNL4ynbNfnwwf1vN+OuhUn2tVAyLN
         15VbgVVno0Yl96RP/ef8bm7U9N7sc0w+K7EQJ1RJMoc/VJGdfOZskrkkm8J/xKEFfCKi
         m9NjP06YUSTEv3ewUyiSRyUpwilZw9QrUbrg4qV4R4WrgQ6vGJQUrAP18JYLa4WIC18d
         VMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtLeUHFiL+dOJNhxDIzcPZjSfJUnp/C7Q8G/2C52MTY=;
        b=Z54wIgHPZOErfK5aMOVBLxQx/Od764oWoxv97diMZWpOXu4qC3mZfWPTsIbUCy1QPn
         y1fJIA6zgTHig8VCdOQfNocapmPXXRmV3kkws8pJnHkGhAIuYj2CqfzETeZc99Oy1wTQ
         1w4ViN5TCgaMYmCS7eL6RbYRUWprFIuPIQqfe6xe3DtlXvnVYHtrnw1L6JlmoZlWPQrb
         h0XFXaUwNJB0QEhSBxcL8VYchYFiKRqpixfgjSeT7zhdo2By418lZchbAUHy3/VTh7lS
         jU8W/Gt7GEehVFA1o3cSh0Qgm4y6QdyFekUATz3wLfV+giEuJZV2uuyr6fqCUGGXu/au
         Y27A==
X-Gm-Message-State: APjAAAVLs+P5JMPfhMgFSwW2EmRYkSyQCpIpHDDFzpLoExE6YTFKC3JE
        7QrGqJBdozALwmJCOIhXuMMTUA==
X-Google-Smtp-Source: APXvYqzaxegeLPBWr+pJHMguc3Ya6LVucqY915A6wj1Nr5hzm0XrtWNyVqgDLObVKohW7UZfbp9uAw==
X-Received: by 2002:ac2:5a09:: with SMTP id q9mr3626549lfn.71.1576100310984;
        Wed, 11 Dec 2019 13:38:30 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id e8sm2074199ljb.45.2019.12.11.13.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:38:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 3/4] iio: accel: bma180: Use explicit member assignment
Date:   Wed, 11 Dec 2019 22:38:18 +0100
Message-Id: <20191211213819.14024-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191211213819.14024-1-linus.walleij@linaro.org>
References: <20191211213819.14024-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This uses the C99 explicit .member assignment for the
variant data in struct bma180_part_info. This makes it
easier to understand and add new variants.

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bma180.c | 68 ++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 4a619b5a544a..f583f10ccbb9 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -632,32 +632,52 @@ static const struct iio_chan_spec bma250_channels[] = {
 
 static const struct bma180_part_info bma180_part_info[] = {
 	[BMA180] = {
-		bma180_channels, ARRAY_SIZE(bma180_channels),
-		bma180_scale_table, ARRAY_SIZE(bma180_scale_table),
-		bma180_bw_table, ARRAY_SIZE(bma180_bw_table),
-		BMA180_CTRL_REG0, BMA180_RESET_INT,
-		BMA180_CTRL_REG0, BMA180_SLEEP,
-		BMA180_BW_TCS, BMA180_BW,
-		BMA180_OFFSET_LSB1, BMA180_RANGE,
-		BMA180_TCO_Z, BMA180_MODE_CONFIG, BMA180_LOW_POWER,
-		BMA180_CTRL_REG3, BMA180_NEW_DATA_INT,
-		BMA180_RESET,
-		bma180_chip_config,
-		bma180_chip_disable,
+		.channels = bma180_channels,
+		.num_channels = ARRAY_SIZE(bma180_channels),
+		.scale_table = bma180_scale_table,
+		.num_scales = ARRAY_SIZE(bma180_scale_table),
+		.bw_table = bma180_bw_table,
+		.num_bw = ARRAY_SIZE(bma180_bw_table),
+		.int_reset_reg = BMA180_CTRL_REG0,
+		.int_reset_mask = BMA180_RESET_INT,
+		.sleep_reg = BMA180_CTRL_REG0,
+		.sleep_mask = BMA180_SLEEP,
+		.bw_reg = BMA180_BW_TCS,
+		.bw_mask = BMA180_BW,
+		.scale_reg = BMA180_OFFSET_LSB1,
+		.scale_mask = BMA180_RANGE,
+		.power_reg = BMA180_TCO_Z,
+		.power_mask = BMA180_MODE_CONFIG,
+		.lowpower_val = BMA180_LOW_POWER,
+		.int_enable_reg = BMA180_CTRL_REG3,
+		.int_enable_mask = BMA180_NEW_DATA_INT,
+		.softreset_reg = BMA180_RESET,
+		.chip_config = bma180_chip_config,
+		.chip_disable = bma180_chip_disable,
 	},
 	[BMA250] = {
-		bma250_channels, ARRAY_SIZE(bma250_channels),
-		bma250_scale_table, ARRAY_SIZE(bma250_scale_table),
-		bma250_bw_table, ARRAY_SIZE(bma250_bw_table),
-		BMA250_INT_RESET_REG, BMA250_INT_RESET_MASK,
-		BMA250_POWER_REG, BMA250_SUSPEND_MASK,
-		BMA250_BW_REG, BMA250_BW_MASK,
-		BMA250_RANGE_REG, BMA250_RANGE_MASK,
-		BMA250_POWER_REG, BMA250_LOWPOWER_MASK, 1,
-		BMA250_INT_ENABLE_REG, BMA250_DATA_INTEN_MASK,
-		BMA250_RESET_REG,
-		bma250_chip_config,
-		bma250_chip_disable,
+		.channels = bma250_channels,
+		.num_channels = ARRAY_SIZE(bma250_channels),
+		.scale_table = bma250_scale_table,
+		.num_scales = ARRAY_SIZE(bma250_scale_table),
+		.bw_table = bma250_bw_table,
+		.num_bw = ARRAY_SIZE(bma250_bw_table),
+		.int_reset_reg = BMA250_INT_RESET_REG,
+		.int_reset_mask = BMA250_INT_RESET_MASK,
+		.sleep_reg = BMA250_POWER_REG,
+		.sleep_mask = BMA250_SUSPEND_MASK,
+		.bw_reg = BMA250_BW_REG,
+		.bw_mask = BMA250_BW_MASK,
+		.scale_reg = BMA250_RANGE_REG,
+		.scale_mask = BMA250_RANGE_MASK,
+		.power_reg = BMA250_POWER_REG,
+		.power_mask = BMA250_LOWPOWER_MASK,
+		.lowpower_val = 1,
+		.int_enable_reg = BMA250_INT_ENABLE_REG,
+		.int_enable_mask = BMA250_DATA_INTEN_MASK,
+		.softreset_reg = BMA250_RESET_REG,
+		.chip_config = bma250_chip_config,
+		.chip_disable = bma250_chip_disable,
 	},
 };
 
-- 
2.21.0

