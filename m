Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64018E49A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgCUVCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39790 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgCUVCr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id m1so4073283pll.6;
        Sat, 21 Mar 2020 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2aho2z1FyUdK2dZzDAU5ewsvt7HCb+Birg8KAiBXYY=;
        b=omXL3G5zUt2ezV5XVEGhq/1h7u2YEZbw1RvuKUvYK27w7izcowU+mwLtArGr9Pmnmp
         UnglIki/NTtZNnK5j+xeB/lifUS+gNZROTRRrpV0VqRTy5koh1nVVzopO/GLoDi8flcj
         D81H9IMtdg97dgBWjJUFmGRUO4dO6nLsCqUW662WhiQLSVZtnKLXuGzv4LWs2nHiTkzQ
         jERBnTd4CV43LCQUYd89JocxXFmBIQMhK9Z26/d5bSGvfSoDj2khnWwzsnHybk5qKVnL
         27TVU8y7sjE+2EyIL0bG2eamnrgNpwH2iNqu1FRJNtjmPPvbQ9XcPtj7gdNKjYRf0s+H
         LXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2aho2z1FyUdK2dZzDAU5ewsvt7HCb+Birg8KAiBXYY=;
        b=qdYXwQ5w8PI2UHqhmEL9i6K7JyJHJwPbbP/tZYmzTrfpPtS4daJVD7JoAbLTjsOLB4
         tsij8dIe6z3vgTSg1jhsJ5fUptGAxG4jhfQUwT5B5Rx+qKpRbyIkNTASSrUyMeMm18bg
         fysUP8mWeEt3j1OQzP7FNOFsq9ZqwgHVqDOKDo6Axzh8TFjrTWUZfJhcr6txn7JJwjoO
         taMJS/i2e1vhqAIifpU8oLlifKEOTad7G0WU9mmS5IEAb93dxBfkDS4rkAD0nPUbXzha
         Hr9p5q+FhCz4J0Ki5d0epJFgHYVcWavnN0synSxUBGJ7vLw8H/0ZL0wadqEytfoSySu5
         jb4Q==
X-Gm-Message-State: ANhLgQ2AiX+oNIokVjA/5mdoc7iSjbbHw5enh3yrr6II4TKZ4B/y82y3
        yfqkHyzuAs470H3lDfS01+CB4YlERIk=
X-Google-Smtp-Source: ADFU+vt/Gt0ROamUB3tI7Bl6vcpW9oSr8BP61YRewdEP+lNirgByg9kHbnhTQHHoDFobpxT/ZPbIfg==
X-Received: by 2002:a17:90b:11d5:: with SMTP id gv21mr17512752pjb.191.1584824566817;
        Sat, 21 Mar 2020 14:02:46 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id 184sm8236778pgb.52.2020.03.21.14.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:46 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] iio: imu: bmi160_spi: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:57 +0530
Message-Id: <20200321210204.18106-7-nish.malpani25@gmail.com>
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
 drivers/iio/imu/bmi160/bmi160_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index c19e3df35559..b52085937fb9 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -20,8 +20,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
-- 
2.20.1

