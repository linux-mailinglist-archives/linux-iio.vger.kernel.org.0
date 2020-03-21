Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3118E498
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgCUVCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37740 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgCUVCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id x1so51602plm.4;
        Sat, 21 Mar 2020 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1A9apg+b4EyJs+2ycxMl5PacpRpliWrxG1kc1+BpvWQ=;
        b=Zok/kDa3Wt7kWm3AIMB3b1QGIXG6TOyyB7qTaKGhVjOCt+m91W7zb6Rjoz4U6u3Fw3
         mCf2WV04ht2Mel/uBy47693fjgsXh1eRPzbivXT6OAeFc89XAMV1YtS2EQCMTCCFPt+n
         xOZkbK24guPga2EL//rbUMGUn9df892EMSARcJfFEMdqIM00McIcXxb1vEsmLaepv0ud
         DdrIULTxb8/9NrcgojXXFmVvzdiHevQCqA6j9eBnCyfQdliEZvpvN1iJiMp5DYfOFzIX
         9LHwp0f7/kDvDRu7zcHf58ga22+aGmpxxNdrNZiRUMe2kz9rCA4HxFYilAZw06nguwhb
         Xktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1A9apg+b4EyJs+2ycxMl5PacpRpliWrxG1kc1+BpvWQ=;
        b=B88DomO6Z4oRWuUV8xYYQIsspmYAowvp67WyfCxPBNbKvm9VkF0xWRh4Cj3QiyBLPl
         j8Git7Qsn9JDk7r4ozr1BuqqA0FfGuGzuZGBsGhduuFOWtStoluwc6di/Wi4ds2wqHqy
         jnU7JUf8cJg+OrBblNZvauCxZ7ZQlFC8tzXjmWD5ULp5TGJq7Y4TCfz+3JC2K6TW2o8n
         1YHX3MBCQQgCmxkEjIn0ajUv6m+W4M4gh9tzA4nizvZj+kU/nJPKksmiy2FmqGFlEevp
         zg7iOwylTC+ssJc8PVzEvW6yTU13QgdsTdhuNxPAVa1AD4R/gXpNGavYin0U3SADMN+q
         BGcQ==
X-Gm-Message-State: ANhLgQ3UKBRTLDtQeZTnseTzU1is14lIP4aa+T4qPmASgU/1RJGeVUzc
        IDO2ZCeR4XKL78WQ7iVigM+U8k5JT68=
X-Google-Smtp-Source: ADFU+vt6yciclt8T8U3VHueQk+CoFcYnP+IMgsBORICJNBOosvGQ6KqHH998dgI2yEiAxnQf7EF6Og==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr4358262pjq.52.1584824562772;
        Sat, 21 Mar 2020 14:02:42 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id w6sm9085155pfw.55.2020.03.21.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:42 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] iio: imu: bmi160_i2c: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:56 +0530
Message-Id: <20200321210204.18106-6-nish.malpani25@gmail.com>
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
 drivers/iio/imu/bmi160/bmi160_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index e36f5e82d400..97d7a39c03df 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -24,8 +24,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

