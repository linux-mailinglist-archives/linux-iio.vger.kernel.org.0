Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6550A44B3C5
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 21:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbhKIUMJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 15:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244179AbhKIUMJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 15:12:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E6C061764;
        Tue,  9 Nov 2021 12:09:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r5so652383pls.1;
        Tue, 09 Nov 2021 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooLHi3igkmOkETX9ufe/Sc1q7diODee5fs6WDbYGPs4=;
        b=hLyUj2k4Wc9Gf/mm4uACBBqxG/iZzSnaVaXPeQdz7eXd5cCY5bTVWHyAomHwfcrCzp
         tMHu8dNnCLZHJRPlvY6uXuCTW0h+C2FkT2wdccT/e5UjDjV4UU1qN28tBElkfnymYvJk
         HUqkZGDI8bde07Zp9jLcbW6im1ZC6rWZ8B5kjNGZjNvtJbZpVd4UKZMh8n9ckTojU80M
         ISnY9HM2pkxZI6gWrlL1AG6u+LSn0HOw29DIoz48ffYlYG9yY28VovZdXiMkI1OScll+
         BKyJZCA9eSaZxQoHNgnVF8xj0DkCKlpBus+VUwJTKQNiK8QigGLXHhTWsjzQOwWCec6Z
         4ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooLHi3igkmOkETX9ufe/Sc1q7diODee5fs6WDbYGPs4=;
        b=KnmOJNSEncrP24TZKN1GUV1xtdaDhGO8lg4EU9VbV6ZfdPMiXyuoGRVJV1WxWA5SOl
         e26sDw8NMxa8IxXOnNl30+j/ICWEmY8Surd9e0+yFbgyRVzMVagShH3oDsBo1cl9Tmco
         E7RK5pDQRsF1AN8gCLF5m95+MP9wTjCMThH2i9RfsZfjxOKaZWiSbHyl3oc2NUUsPuKg
         fna1lJLG+dcQ5v+KxDv1W/iIlZtEx/ECVYwG3NRk8wwZK/wz4QlwFrv8fuQ5wCOpTq5s
         m+TKPccP7jzDpjKMAR1qmE/0Ns9lXxpbHNpoU2G0l/SLkE9I329x3f6LiE9BCHNrHkoP
         xSaw==
X-Gm-Message-State: AOAM532TnGNlj0b8DbQP0RwxqQcUC/SWuvT39CTe+aWBfUNmfDrknnsh
        vtLfPBi0zPzbnaKXPVFEuio=
X-Google-Smtp-Source: ABdhPJyiyr/j2xSgPNtenJ7F9XX+fg88ZtCb8oIOgM2AToc5sixgDr0McnffcRC9rsg1ZhPm8+p0xA==
X-Received: by 2002:a17:902:e749:b0:141:edaa:fde1 with SMTP id p9-20020a170902e74900b00141edaafde1mr9701744plf.72.1636488562273;
        Tue, 09 Nov 2021 12:09:22 -0800 (PST)
Received: from localhost.localdomain ([27.255.248.134])
        by smtp.googlemail.com with ESMTPSA id q10sm3103095pjd.0.2021.11.09.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:09:21 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        kuba@kernel.org, saravanak@google.com,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 2/2] iio: accel: adxl355: use fwnode_irq_get_byname()
Date:   Wed, 10 Nov 2021 01:38:40 +0530
Message-Id: <20211109200840.135019-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211109200840.135019-1-puranjay12@gmail.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the generic fwnode_irq_get_byname() in place of of_irq_get_byname()
to get the IRQ number from the interrupt pin.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 4f485909f459..7babb139bb92 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -18,7 +18,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <asm/unaligned.h>
 
@@ -746,10 +746,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
-	/*
-	 * TODO: Would be good to move it to the generic version.
-	 */
-	irq = of_irq_get_byname(dev->of_node, "DRDY");
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "DRDY");
 	if (irq > 0) {
 		ret = adxl355_probe_trigger(indio_dev, irq);
 		if (ret)
-- 
2.30.1

