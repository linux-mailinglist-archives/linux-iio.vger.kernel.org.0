Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB318E492
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCUVC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:02:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37723 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgCUVC2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:02:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id x1so51385plm.4;
        Sat, 21 Mar 2020 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E//bqMfh3++0a3x1eV689Eb4tyW5vXhzuzOkHH+VoWw=;
        b=RRJ83wd9s0+rtemr/K7ZtqReMR0422O8FtKNEYYf+FscQEMu1YFlVxBvXrnb8i+tqc
         +eQi3iq44LXJfwSUxiej3XmMlN3t47w3ZN4yVlrPfKm7V441aoyTy1XqSz0i0lI7ve+v
         EGGnlzltrY798kGJ53COgTiGYOTCd6I7npxFlFTBQCUBE1Q2Psi6CzPisYQjuaCnZ5S1
         D5tp91axCtWYshzqe6Kh9y50COzZ46Jly2KhBK/aNe4gJKGDXjJ5ov2WNTZCH4HVuYli
         CzJglQP5ixMBmjvPjXwxr+FH1qA2xOsDVPiuu09W1hm2exB3789NURyGh7/4x63UEO0c
         5oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E//bqMfh3++0a3x1eV689Eb4tyW5vXhzuzOkHH+VoWw=;
        b=aJjhmy3ph7vZiLGBfTbAGr3ySR9+9Xfpo+Ts3/OJsjkaISh169Mos01RPs+JRjYflF
         UyCMTtN6YSRQC8yf6MFP7NU/b7pFv1K+Ip6wCpUI806C+s6Bzhdj6/mivL9lnc6Fq0FK
         yFCO7+MK78Hzg3IpaT44lviqBl8o27vXbxuCJyx+ghxgoOmqj3diWHrp1zhDnrSbJC+h
         hsIVQAe8Z10Ly55SYY20LC+Mvix73oYRoznzBUO+6f9mI+4hkzL/VrQ3h6rbkFHdMXUE
         z5vpb7YbMcUHIocByu5/DySRN/WBAK43l65i7tqk56uASpKl6Vq4knuCXOFwO2LMpHq7
         jE+g==
X-Gm-Message-State: ANhLgQ1KphD5ROGFe4TkYJiIGbInetE8cXxSbuLLUNMVHtT31OCQn1o4
        TVtN787aXxoQbDzyv/72JwnygZ/b
X-Google-Smtp-Source: ADFU+vtFsH28AQpZNdScVeEvnwT8Phhpe+Hr7IehCcG0HjxZbgnbjQjAf1DVaz9T6ncQuE0MqcBeMg==
X-Received: by 2002:a17:90a:272d:: with SMTP id o42mr14501887pje.194.1584824547369;
        Sat, 21 Mar 2020 14:02:27 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id k5sm8103170pgl.3.2020.03.21.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 14:02:27 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] iio: gyro: bmg160_i2c: Use suitable format specifier
Date:   Sun, 22 Mar 2020 02:31:53 +0530
Message-Id: <20200321210204.18106-3-nish.malpani25@gmail.com>
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
 drivers/iio/gyro/bmg160_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 4fc9c6a3321f..d276e3308b13 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -21,8 +21,8 @@ static int bmg160_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.20.1

