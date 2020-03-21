Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E897118E49E
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgCUVC6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40946 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgCUVC6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so4069822plk.7;
        Sat, 21 Mar 2020 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7GKDF50XnkZ+DrwxrjAqJqC7VsUaW4M1DlGKJ84ra8=;
        b=Y6K1mkGAMsOub4j68QY3+sa/ZN/+N0aZrTS9gO4K2e1DETgGhuLRkao9DjNs63raLI
         TXVwrSdOqkOCim8QAi8Q9YZ4PZug3orRYmqIf1XAsQ6L3dWFCgv2aBKHbzgnobJbSKw8
         T+5taZ4dbuU8Qb7Jl67j1sF0WmWNAu74o7cwzYzo9lGXiaFI6LlBfd1JATx2al18bIR/
         Kdzor+OR8LWw+VFs7iisbrmcBRPzhsVUp/jb4+sX3Rj7uF6gIWy/X5yVzJ8ydBWjKSxH
         +wu6bTbeBbo0n9M+f/po3uZHkcp7ditvd3+cmpoxntgxuFH+CEVgz+bRWhoEuVdmma0d
         IyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7GKDF50XnkZ+DrwxrjAqJqC7VsUaW4M1DlGKJ84ra8=;
        b=YkfLr7Hp86dT19v9+/FzMb1SpwJHO6GJfgb9KOk896QaOA8QC0oX17ag9FBxGZPA+D
         qUMJBJcBhrHX9x8aAqjfat82V7zQXxYtdR5UNBbVHqxJ8Bl+A/4YK/iiKf7LwxqA+A+G
         avFmGL8Veyk2HWaKc/0tZMLurMPyRz3IlsxyUI4MvXbqM8rjIKd4bzNk9cWRodLftw7D
         1xX5ko+CgA2zH1RdILzlbJ/kFGU9iFKSHEaIJ7s2p8b8r7WkdC5FLuxHqrsr4v6rCdj0
         8v91+1dvEBgSGflGY8RbkOtbqc/kYnrKwCFGbm9DswhaI+e9x6Yzjwgu9vUU4SUAP/3d
         afaw==
X-Gm-Message-State: ANhLgQ1gY8yDauzixaRnbn5CVi7/wYLr5QCmrIZaWrA/DU3WOKIVoNlV
        qg2Cc5RnAgkJEWy5pYlZmBzgwqkK/5M=
X-Google-Smtp-Source: ADFU+vszA/WWf8CSo2FHjddz7c5XEg/XRI/tXEJoAgHWGiYcgMwLlVsLUGzbOvPdu/d1DXqevEzS4A==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr15170011plr.106.1584824577792;
        Sat, 21 Mar 2020 14:02:57 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id f15sm7078472pfq.100.2020.03.21.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:57 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] iio: imu: inv_mpu6050_spi: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:59 +0530
Message-Id: <20200321210204.18106-9-nish.malpani25@gmail.com>
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
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 673b198e6368..fa1d571cb4b8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -53,8 +53,8 @@ static int inv_mpu_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

