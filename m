Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02573EE839
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhHQIOL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 04:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhHQIOJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 04:14:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B4C061764;
        Tue, 17 Aug 2021 01:13:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so27387021wrs.0;
        Tue, 17 Aug 2021 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNpthpH15DTu8RBKV54iW5xxSqBJuNP9jmT6bY/RyzI=;
        b=SYuRfmkAQID5TSGEej3B7UcoooTqvAkRvJBZtd0w8B59UoFCHCLor1rAj2H9z9rz02
         XfOpgkIqLAx6Tt5MmEkouYU4MDeaOdESwbM58EzsJhu5tDk8J3kBcZQRR4KUIeQRTfvL
         /dIJuoDpCTxZg18Yawlctau9mcWOWscSWhz3OAwnLQ8xsfpapUpu519rZoB4ugcNAhVe
         laYrbTo8LVKT+iRmuK36JCr4iNtzaQI4MhYuyAffI1N61O82Buxuo1jXRNiNh3cBqLXr
         OZ1f2qosqJIJKtYABn/KqgFHrH3yrZZQ3GcPiYflSBkt0bwMsk0Hw0bSge4SLMYJYWAk
         KGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNpthpH15DTu8RBKV54iW5xxSqBJuNP9jmT6bY/RyzI=;
        b=BBGMqEC2WxQ/M5krDxbu++bYWrKB8wBT1dOlHkrQWSgCq21niaHaaGfbLwrFv9N/yk
         TmZSJEdN1rb8huySsxj4UBebd/WvN5GVRFYOd0NUFiR1ssDG671mPRQflh9CoSznwa1n
         PNouqhjmulov9Oy7mugZ+dVBszaxKptnK8uvzQOBFtd4719ENWtZl4ziYiESH6ng+9cz
         l7ZE3JXhheEw36KCuAGTkIsfX0ePV4kQ1gUSNBL6Me3JFejISIRmFn9/VIOIOJ7+YKkP
         1bZXlYXPmwC7G2LefFb+zJ6Xf4f6PghZudHoqAjPM1fWuMD+TEMFN+wwVunuL3RV8yFw
         NhGA==
X-Gm-Message-State: AOAM530tblGZkrZNk3I6Lc5jMYt6P+q/pOgMyy1CllWlrBFVWc0k9qoM
        4Rrxifi6fwW7LeWLhnwnyNU=
X-Google-Smtp-Source: ABdhPJznDK9eFcziNqrHnwEoQ1pvWyUZdNXCVFVd7bPm4KmDsli2JR1yB6astmQBNaCefQmEHUqfdw==
X-Received: by 2002:a5d:6948:: with SMTP id r8mr2365968wrw.136.1629188015292;
        Tue, 17 Aug 2021 01:13:35 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id b12sm1316604wmd.42.2021.08.17.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:13:34 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] iio: gyro: remove dead config dependencies on INPUT_MPU3050
Date:   Tue, 17 Aug 2021 10:13:30 +0200
Message-Id: <20210817081330.9645-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit b1fe0cf06f92 ("Input: delete MPU3050 driver") deletes the superseded
MPU3050 driver and its corresponding config INPUT_MPU3050.

The dependencies on the superseding driver in ./drivers/iio/gyro/Kconfig
to ensure that the two drivers are not built into the same kernel is a dead
dependency and not required anymore.

So, remove those config dependencies on INPUT_MPU3050 for MPU3050_I2C.

This issue was detected with ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/iio/gyro/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 20b5ac7ab66a..a672f7d12bbb 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -126,7 +126,6 @@ config MPU3050
 
 config MPU3050_I2C
 	tristate "Invensense MPU3050 devices on I2C"
-	depends on !(INPUT_MPU3050=y || INPUT_MPU3050=m)
 	depends on I2C
 	select MPU3050
 	select REGMAP_I2C
-- 
2.26.2

