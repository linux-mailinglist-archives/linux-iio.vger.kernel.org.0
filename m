Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B9516794
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 21:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbiEAT4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 15:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiEAT4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 15:56:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206D64F3
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 12:52:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x17so22267851lfa.10
        for <linux-iio@vger.kernel.org>; Sun, 01 May 2022 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=151X47XYQhKwGh3J2QBehR9nYXYVMCBLEuCCOXanp4Y=;
        b=Og1KDXM+XDmlxmWPptwaKbMvFqjxN7CzHfe8ZhJ/2CHQx5CKJp88mOJOW1wTeMoTRi
         RHLmr/WQDXPrgVdmIUJ2u2w94YpxDdgDyrg0lohmCCyaocBcISsJ0Xzwts/v5PbL3nsn
         sqrrbkOJ2Xy7oRBqag1kE4//RcWWrw2zSqsoB4CUg3vkXpNs9OWHWW0H3F2hzjPUd5hc
         0zraLIKQJWVfK1cWvGDU6E3IDrwDyPdKIKaIsqbFKcLlUCnGxibZhBdSl05cvLz545oy
         x/pFqTNhjaRwG7xJ4W/tRsGfhaMqvo2dCG22NS0DiIsVsOKH8FO7UgqWrnEI0NjJzMDO
         1+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=151X47XYQhKwGh3J2QBehR9nYXYVMCBLEuCCOXanp4Y=;
        b=k55cwvGBLfoO2MEywg9EOHc9PZZnmWSpXqd3e0uoAjkb9d+TfpVX3qtOL0IxGAfvPe
         fSRgtmqL2EZ8zlSFgEvF6GrgzMkFu1jRJ3orkZExbc1fzf7XUvxc9D2UmU3bIH3NFtBp
         PefKnOZmu1PKRblc47atGT8qFQFDmJ9GTwvUPIm5BqS+KIFPC35PcA1VjBpmhVEl0jWm
         GMF9Uf/aJ4YCAPzlYbvh0UcaIPhaYfX8A1sUFzqA7wLlg0BEZEaCE9uqn9vIslWDRPhK
         Q2VGjPPVwDxJo/mSaNCGsoABaffy6EqOnFdYpIPjXW4cxw50qQjyDmQyLlCYxDmP7Vkc
         vsxQ==
X-Gm-Message-State: AOAM533CIhHAhiExW2W03X9p+FZRWqBIjCmtZmb7COXRT9Xxw/1um8CL
        VjLOyh3dUbKDA6bHoZ8qXoccdg==
X-Google-Smtp-Source: ABdhPJymox5hpOa7Qzc30i1JzATO8xb0iWjp/GwNR189YnyMj+OGm//WeNystInpMVBPjAlc6e/PiA==
X-Received: by 2002:ac2:57cf:0:b0:439:94e:7c4a with SMTP id k15-20020ac257cf000000b00439094e7c4amr6976208lfo.23.1651434754631;
        Sun, 01 May 2022 12:52:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25590000000b0047255d211d4sm517446lfg.259.2022.05.01.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:52:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] iio: magnetometer: yas530: Fix memchr_inv() misuse
Date:   Sun,  1 May 2022 21:50:29 +0200
Message-Id: <20220501195029.151852-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The call to check if the calibration is all zeroes is doing
it wrong: memchr_inv() returns NULL if the the calibration
contains all zeroes, but the check is for != NULL.

Fix it up. It's probably not an urgent fix because the inner
check for BIT(7) in data[13] will save us. But fix it.

Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
Reported-by: Jakob Hauser <jahau@rocketmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 9ff7b0e56cf6..b2bc637150bf 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -639,7 +639,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
 
 	/* Sanity check, is this all zeroes? */
-	if (memchr_inv(data, 0x00, 13)) {
+	if (memchr_inv(data, 0x00, 13) == NULL) {
 		if (!(data[13] & BIT(7)))
 			dev_warn(yas5xx->dev, "calibration is blank!\n");
 	}
-- 
2.35.1

