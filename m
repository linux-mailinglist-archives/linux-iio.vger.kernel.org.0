Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D06B18E496
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCUVCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:39 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36289 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgCUVCi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:38 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so4116864pjb.1;
        Sat, 21 Mar 2020 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPLDUPQN9PY4WCwahZp4kxTJsPYR6KiPIaERqbHD00o=;
        b=ZnVsVaRerzlZE1QhvvBhBl4M2q+7eAKkzdUaMiuWa5ZeJfWrpX+27Wy+yc/IGmqbmh
         qcr8PWZDRI7nO7tC9fLbbE8oUK1Nm/MIoOa5O0uGqX+yTeN/Ue959IKIbQWZYcdw/TIJ
         NgvocFdhCg//fuUbxc2Kxr3F+OW4/0iMLmOzyxfavwAPDMTXZmqToapfFT8tOcfK6NCw
         zuep2cB3V9B8GrNScPHGKbwceackbEtg8l6D2BAq00TdK/J//zRPHCwSpQrUpqnLSXjD
         lv65yILrpqzm9UxJddosvJLWE5dcx13yswssxQz+blD30ndiwry7qri0/GJhxDNjZE3X
         blVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPLDUPQN9PY4WCwahZp4kxTJsPYR6KiPIaERqbHD00o=;
        b=g8SnD/hDn9VJD8D2shcWgprnv/1hR94O5NYrhueGM/2UxgJT0uw+FCM1pWNH9LK3Qi
         KcTpdtmQJb+b5uVyjz+Q/tFN9gesH7+F6mQAifpf0rSZfqdVnUpOCWECXb2RsSnCfV6B
         aU4uF68pAthRUGPnFzTcLeSsfjowe2OMJJce7PO5am7tLBAzva3FL9d3CFyzdXNIZ+HS
         NKS+FdPmv/Ik65f0QUKJcTzBtzNf1Hdm5m2Dqoe72TvE8aKpXdjORCz2LyKMljtPoJSy
         eWmZlt9N4W8yzKpF5JhDfBcn7ttTJ+c2JiBz7KeyjCNxVTuVEzVCtxiRB3Ma5zDQM8Ut
         L8tg==
X-Gm-Message-State: ANhLgQ0sYU99AF3v2H61kG30RfNfPNi1mVNmkB1kacS4D+VGuP8K8yWV
        1DTueMIPjLlyuNlNsTALSMWvnzEQ4wY=
X-Google-Smtp-Source: ADFU+vt3iRrh6lkZ3cc6Bq2C5qHbDXbLWYxO+GDgvQulx/+hY2u0WGEGK/AugR33qKHA1C4B3vlbtA==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr14987534plo.83.1584824557584;
        Sat, 21 Mar 2020 14:02:37 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id z37sm2167242pgl.68.2020.03.21.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:36 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] iio: gyro: mpu3050: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:55 +0530
Message-Id: <20200321210204.18106-5-nish.malpani25@gmail.com>
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
 drivers/iio/gyro/mpu3050-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index afa8018b9238..fbac6972f77b 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -51,8 +51,8 @@ static int mpu3050_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &mpu3050_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

