Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4519D31BC9F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 16:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhBOPc1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 10:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhBOPbR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 10:31:17 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413C6C061786
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 07:30:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id c8so6008901ljd.12
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUzqONXw9UKNankFH42rC2qDQ/ZrQAInJYtzyvpkDqU=;
        b=fb+ExkF0hTzt7m75Msh0DjbiQCaurNGiZQ+BKts0XftbMjIGgqnt5No+eCyfbnt4Sv
         4kVo5IWiUkP58o3AiqI201yYwq/xQBgLFj+eRL4XP7TTo6c1rOGiI8QY3qCDBQGG3MKU
         YLcu5ntqoPPMRi0FXr64q6w1w/7f+IvcXt1nRj6QnnOsJYTpjGRAV4wcBD61u0zxWXc8
         VwuuNxtZEOR0hrfaojBCv9KbuGWQeQAVGNaT57DoWb/wNNpFoRuAkoKMPXgQh4XjO+97
         ApaJ2ODQiebYYB4NI/ixMzOUKnZAUL3YwFg1qlMlopWhoEwHgV1+FPXOi7oRMysvvS1V
         uN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUzqONXw9UKNankFH42rC2qDQ/ZrQAInJYtzyvpkDqU=;
        b=MZTqm9Du6nNEorHjC264miwPSvaUNuoD3rkOJ1nuRyRl1u1/sVs/t1C4k3oIEHW4oD
         JZIV+g1ukVDDx4e/i6tEWMS4dfSjcReki4xdPM5qMaQjXh+EQm80iKWmClk32y6JzGdA
         1fP80r5xb0kPN4CRoqd00BaP1cnntsKDeX6OC2Un5AHd5iPstxJZOZWv6zSW9guAzU7x
         5EiboCwlVOl98hPS5RX76Z+6wnwB5oexG8+FrTMqpzdDamCveh4tPg4f53V31pIG5c2U
         gjZeBWLh+Jp0QVhP2SlvA6YDYsExsL1WdEIwF1xK4O7VkMQgkt+uXxKqGh5u0jwgMArd
         IOKQ==
X-Gm-Message-State: AOAM530UMwJYEPkDPdYuDkgeIVSlsFOkfcd2poItQsXiHRkdESaa4Lak
        R0WlQR3ZgtrjOllv35vVOoDxQg==
X-Google-Smtp-Source: ABdhPJwSA14vxp9wUH305uO/ZS/uLbTz0gV5syvPctLzya7sUFPjBdzP6im7BbtL9CzSfcjijMu6Eg==
X-Received: by 2002:a05:651c:1343:: with SMTP id j3mr8775204ljb.81.1613403034814;
        Mon, 15 Feb 2021 07:30:34 -0800 (PST)
Received: from genomnajs.publikt.skane.se (host-78-76-89-148.homerun.telia.com. [78.76.89.148])
        by smtp.gmail.com with ESMTPSA id d24sm2800609lfc.225.2021.02.15.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:30:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 2/2] iio: magnetometer: yas530: Inlucde right header
Date:   Mon, 15 Feb 2021 16:30:32 +0100
Message-Id: <20210215153032.47962-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To get access to the big endian byte order parsing helpers
drivers need to include <asm/unaligned.h> and nothing else.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index cee6207d8847..2f2f8cb3c26c 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -32,13 +32,14 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/random.h>
-#include <linux/unaligned/be_byteshift.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include <asm/unaligned.h>
+
 /* This register map covers YAS530 and YAS532 but differs in YAS 537 and YAS539 */
 #define YAS5XX_DEVICE_ID		0x80
 #define YAS5XX_ACTUATE_INIT_COIL	0x81
-- 
2.29.2

