Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4018E49C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCUVCx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34931 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgCUVCw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so5292917pfb.2;
        Sat, 21 Mar 2020 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hmgJGWzVkKtIDfK7DCr04tH78rbXV1H1joYwA10/tU=;
        b=MiZQhIThLfh4XVRHc8IBfzzuiRv8TlTbh8grovFpxGZa7U8xuFk7DbFToQe5bY4zFx
         8OVfbc6D3EPoA2bozUlKyKYzPiiYmXVsZuKenGslsaaLGHQTwiLg5K2FrNKncsThaFoW
         +1WX9QX99Nena0M7phmGkgl/EiVolxdUQxjrcw+PWrzzg0acXJU7gMBbtP4C9x6A0pGH
         n6Dc9zfV+5XMwM5e3UJpaWJTHdWWWVe1nIK01L5WGLkyFhyiHFCihUA4k+msokkqHkuT
         Wh9PXcspAd8lI2waRO0gf/SXCvlB4bodqRqef5HLWkQm69hhbED1rSvf1o9+0eINAeCu
         qfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hmgJGWzVkKtIDfK7DCr04tH78rbXV1H1joYwA10/tU=;
        b=N/E2vEK4MbV3FU0tMU3V1DNKDgLZQGBSZDl0TOKM9uJm/zxgHp7hTrwNbYG0PHcsxx
         Pf3NmDGuUAPehPbgp9/uFq0W94xr/U/BkMkRfDPLakKIftukTXXfN9+DwpPirdqSWmUo
         sgiDeQb2YLKAl6ZaqLkCUdL9EtLjttQwgJf7ukFwYIEg5YdJN5cdG8O8CvV+FDEZ/XRU
         cEE32J5nm6vXGXv24dtCH43BZdFNZsUcbW36UP7akn1YuQSJGAUVXYjt3bLl4lt63wKA
         hwJzNRK8TOVADZHJG27/RpV5Z/DzPX1HUzWfcuP0s61GETuoSz2lA80+7y643JfngqAI
         J+5g==
X-Gm-Message-State: ANhLgQ0+B1LC7/MgogOiEwkbNfZ5ipNluIk8WD1ZRVg0Y7wsHwNMi19E
        D4hcS2hR8/y/alK4HwvUaS4EmiCLbnc=
X-Google-Smtp-Source: ADFU+vsuHgHA1RyuqhAoQFgN8y5rXzAikx4GnsZJ/SIZ+B6w2q/qkOPftFI2WKN7xoNK1S7P9eDI5g==
X-Received: by 2002:a62:820e:: with SMTP id w14mr17043681pfd.59.1584824571541;
        Sat, 21 Mar 2020 14:02:51 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id m9sm5550818pff.93.2020.03.21.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:51 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] iio: imu: inv_mpu6050_i2c: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:58 +0530
Message-Id: <20200321210204.18106-8-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321210204.18106-1-nish.malpani25@gmail.com>
References: <20200321210204.18106-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide more suitable format specifiers while printing error logs.
Discards the use of unnecessary explicit casting and prints symbolic
error name which might prove to be convenient during debugging.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Based on conversations in [1] & [2].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
[2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 6993d3b87bb0..5588946dd60d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -122,8 +122,8 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

