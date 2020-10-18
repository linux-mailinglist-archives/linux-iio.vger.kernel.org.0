Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE329188E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgJRRPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgJRRPv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 13:15:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A452C061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 10:15:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so8830640wrl.3
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+RWq//obkFsbQkf0frorg8nADONbMbmIRghejO+t54=;
        b=OWNhjTRSyDd9oXlWWD/2w8WrkivJIuxojfj0590PSh5jabXJAdOmR9+6YP2AxW43tC
         tWWr2yMYXCmDlFaQTBSzjkvxVlzzkpY4DZsqFNrtwWzassbwFHgfFrwN2xtrWMEqSp1m
         LNhD09fuVCMfYUz8Z8/mNAXIFLmM4oQzQLFkJ7MUKByzptDAovCoSo+SCawKJX+LXcep
         Iy9eqEr/S4aUHk8ZuCsri9MJ/lUoFz+HlifTvkw8TD4kPPz7+yj0h/WXDHUZ0O2xqVds
         Ojuw+uTtUft2ziHX2qewu/JcwlMwUK8TXqgm6ouPlMjPhPGHTsF9dEPPRBlRVS9zMOyU
         fl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+RWq//obkFsbQkf0frorg8nADONbMbmIRghejO+t54=;
        b=fHU47TS6ANMNHNiE08O+gwUidcReVEgxqCxu05VUqDtubkF69MaLn22oMIvne2PoxH
         xVBIcIvQ5EGBy+JYmMQ48vORSp9y5F0JQ/IeCRLSLI6GfQzLm4PJaM3IWcDOjS7j9C9Y
         jXROK9CPdpjHvfZBAEWJX75+v5d2DyScqlV1NXmci5c0hNbsxm31T3UElJ6UBVymv5P/
         J6qaREkG/cub/VjK93+AV8R4hqinR37NPAqq4uWcCq7OCpukyx9Y9PnPQvWxuEF7aBEV
         xsPbQXkfXfOzFIa3WgrFB9j+yE8SHOSk9zu4StsOmPjpm5Rz8vFpnAqtcen5gOxQs4l5
         vzoA==
X-Gm-Message-State: AOAM533NozKM85NDIQjKU4IQZC95vTL1JWBs+OC3PDUKPIBNrTFbYb52
        rVxC7K7VpIie84a4dRiqzuXU5Q==
X-Google-Smtp-Source: ABdhPJwrLsEQG5u2+3sJluFInmC+o3UDfLKxPtnMSYaPxJJL+OPjcGL9AzT9Yzt8tJP8+LiwH6kBlg==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr16752792wrw.229.1603041349031;
        Sun, 18 Oct 2020 10:15:49 -0700 (PDT)
Received: from localhost.localdomain (124.171.185.81.rev.sfr.net. [81.185.171.124])
        by smtp.gmail.com with ESMTPSA id b25sm12013701wmj.21.2020.10.18.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 10:15:48 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        matthias.bgg@gmail.com, jic23@kernel.org
Cc:     chun-hung.wu@mediatek.com, alexandru.ardelean@analog.com,
        pmeerw@pmeerw.net, lars@metafoo.de,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2] iio: adc: mediatek: fix unset field
Date:   Sun, 18 Oct 2020 19:15:45 +0200
Message-Id: <20201018171545.3190476-1-fparent@baylibre.com>
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
---

Changelog:
V2:
	* s/of_device_get_match_data/device_get_match_data
	* include mod_devicetable.h and property.h instead of of_*.h headers

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

