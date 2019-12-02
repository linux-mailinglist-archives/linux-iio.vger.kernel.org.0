Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1786C10E6E5
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLBIY7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:24:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41103 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLBIY7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:24:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so2526132ljc.8
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqmnz/BXP1dFx/Nn0rGXc1aWiB6qIJ6ZjvViCve4bxw=;
        b=AaXGfCgGPPXs8c72gj62wwi/O56a0DbZ2/N+w9fFI+pN7i6mespRVhDogSThnZfeF8
         HxXd+pBUAM/otwfiEyUNMMc9SL1CP6rW3niqfZtRenCoDQi3ERx0L7TCqFGqtxBRaxgP
         Ej9QwKMD0PW2G4UKFKeiGQJ6i4mg7Y3SSGeuVeqzknIdFa2x0v+odv8narsuLfvmS9+l
         ShOe+qSFZCns0RgDxHv29lvcOEjm2ReHvO+6sfeL6vjLLQf0mrgFFZtvvHuLvq4wPLDG
         MeznFYMJ9ljO6xlQpUwGT5kJIsTZSakJ6JmRe1zlShl5sV1Gpxt1w0YLOnOBMZyOW1Ov
         F74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqmnz/BXP1dFx/Nn0rGXc1aWiB6qIJ6ZjvViCve4bxw=;
        b=eQwn5Iq94jUnycp1pUHEShTjp0qFr62W/PIzGHQCp/d0c3Eoj+rlPCqfWKH+i9YNSq
         pHDONG1e0+5vf0DGbvyXOZdgSv+q4o259DecHkMJQ1g7gQLtMRMRd0xj9KbjCR/TPD7q
         TkrwHGP4KSQA9QokJqneUMZcB9s3JKR5DxbxDdtdTosipMIg/+PfEwFaLad58/e0CC2O
         neB9KdOSlyDXalrakFvqkK2rkS7mwBlz8qxT9g4N1z9QaISUH5ZM9hA9z/cDr5e/60Dz
         shP8+Mmrmdu2hKOhhye3VncIfCaUQrqjigl7gNZPy+th6VULTTFlMh0SrpvizHzpQJUI
         yAhw==
X-Gm-Message-State: APjAAAXlN5/svHPJHlRmjTVTrgEgQxtQ4Ryl6kRLqGQC2mnRa5GjgWn3
        P+M1sw0zqUXnJXtMiitfzK0YsQ==
X-Google-Smtp-Source: APXvYqzmzBe++Ot/kZejOZP6i8jCnCfkRRi1bKQW5gdXxLhqHAmHb5Jt/g67BV6gVQBheBkIA2d6Xg==
X-Received: by 2002:a2e:b52a:: with SMTP id z10mr5314364ljm.178.1575275097009;
        Mon, 02 Dec 2019 00:24:57 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t143sm9614428lff.2.2019.12.02.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:24:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: apds9960: Drop GPIO includes
Date:   Mon,  2 Dec 2019 09:24:52 +0100
Message-Id: <20191202082452.62989-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver includes <linux/gpio.h> and <linux/of_gpio.h> yet
fails to use symbols from any of the include files, so drop
these includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/apds9960.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index c5dfb9a6b5a1..52f86bc777dd 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -15,7 +15,6 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -24,7 +23,6 @@
 #include <linux/iio/events.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
-#include <linux/of_gpio.h>
 
 #define APDS9960_REGMAP_NAME	"apds9960_regmap"
 #define APDS9960_DRV_NAME	"apds9960"
-- 
2.23.0

