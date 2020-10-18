Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928B4291DA7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgJRTqw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732770AbgJRTqu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 15:46:50 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B425C061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:46:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq12so8113048edb.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldXak5SnxnljogjS5BR4bzLQ/cs7o2P5Z7xi0J4e2zs=;
        b=B4ezs0jnZXe0OoPEHTaO2JK643odWH4jcP7VGXoLrgJtEmJqs5BvZhLnBxMIWt+CT5
         1EWAqMem9TADkZ65DuSA50Wy/qjZA3RLPgSKDHv3+nOg9DVXsUnQ1DdgKr31mrz9Gxga
         xVrX6vtzxaOj/9PT6tYsrqUIwHom3lkoIel0j236GdPrfCjfwpPzIoFokkZgit0joRIj
         DnWuK4Arv4Jqv+aQ6olPyI7cLEKVnNDjdvcnTNjlj3K2ovuLtZdOewVvl/2i1+0J5Edm
         hqOXWZeM1BBlxpcUl2RpKARhqurr7BBshgHZjGNJ6TkyRK5C8R6HYgmJJJKV8XL23rdC
         R4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldXak5SnxnljogjS5BR4bzLQ/cs7o2P5Z7xi0J4e2zs=;
        b=GRfSlztDwzlec8tQX9ijbCAj1FBaMGQkd6UVOjuVLsHXcn7apOX9b10n67tcArEUZs
         D6dxsEcFsAg1/I8EEvqLZcSPTonhg+aaTD2lJJAKsry6ze4yPS6zHCE2g+StwYY1+ud6
         UNY7h/bOZkcPFhE9BWJWJmL3weFcPoeFjbpLN+X2dLxAk0/EKV2Phz6vB4Do29gmzRN4
         2O7tkPr6dExQdERGzvORwZwoMjSW2C9Y4ZSaCvdCfSVUfOJYnJh4VbNuUSW/zX+1m0R0
         I6q5SoQcVNJF0RIxPGc7T8cHgv3MnRmoUT+M40coaNpFRYke7vl7FOK/4Wwj2WnSMEwe
         RE8A==
X-Gm-Message-State: AOAM5336GH1j+sIWixf1VgfuC7ckcczc+TwtHXVvKO1LCu5ydkL0edTO
        21k7aPSOgRIvyyBEoXDkxWJyKA==
X-Google-Smtp-Source: ABdhPJwY6G8XBmaYMPV8hFHddmJ/OHEgz7gA3xdGXbTrVFj3gqbUp+8slxRYnn6QASjh7AGhTznBEQ==
X-Received: by 2002:aa7:c659:: with SMTP id z25mr14681221edr.219.1603050408832;
        Sun, 18 Oct 2020 12:46:48 -0700 (PDT)
Received: from localhost.localdomain (124.171.185.81.rev.sfr.net. [81.185.171.124])
        by smtp.gmail.com with ESMTPSA id c5sm8009574edx.58.2020.10.18.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 12:46:48 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        matthias.bgg@gmail.com, jic23@kernel.org
Cc:     chun-hung.wu@mediatek.com, alexandru.ardelean@analog.com,
        pmeerw@pmeerw.net, lars@metafoo.de,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v3] iio: adc: mediatek: fix unset field
Date:   Sun, 18 Oct 2020 21:46:44 +0200
Message-Id: <20201018194644.3366846-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

dev_comp field is used in a couple of places but it is never set. This
results in kernel oops when dereferencing a NULL pointer. Set the
`dev_comp` field correctly in the probe function.

Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---

Changelog:
V2:
	* s/of_device_get_match_data/device_get_match_data
	* include mod_devicetable.h and property.h instead of of_*.h headers
V3:
	* Remove extra space between Fixes tag and Signed-off-by tag
	* Add missing Reviewed-by tag from Matthias Brugger

 drivers/iio/adc/mt6577_auxadc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index ac415cb089cd..79c1dd68b909 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -9,9 +9,9 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/iopoll.h>
 #include <linux/io.h>
 #include <linux/iio/iio.h>
@@ -276,6 +276,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	adc_dev->dev_comp = device_get_match_data(&pdev->dev);
+
 	mutex_init(&adc_dev->lock);
 
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
-- 
2.28.0

