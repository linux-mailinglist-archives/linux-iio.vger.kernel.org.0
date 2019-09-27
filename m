Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B841BFD42
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2019 04:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfI0Clv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 22:41:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38155 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfI0Clv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 22:41:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so2619584pgi.5
        for <linux-iio@vger.kernel.org>; Thu, 26 Sep 2019 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LM9q5Xx6Mzt9yNbUm921CBJVXXmEo2RSkhi8vTWfwXU=;
        b=FEoOSXSXSqQp6XKLpQiCMZx8ATRg0h8grRkbHWwInMqhiYcwMAItrMzi+ghR2GUzYj
         3tSCThNuGE2JgrilKGSBaIFFGvi9TwRLiltCvSuSemuIARRNxqQl9f+Jg2RYFm1+2jH9
         xaxzZwYO3LJCKMazz+B/esndrthuEYZxrkbRu5ujttXWPwrm0jgWOt8+pcWR2sTbmBXa
         g/TXEcFOtYo6MA0DICHkpeXYu1ygfjhXYF+BKGcrX+QZPjSF40mbCz2P7WcbmkaPrxVC
         YXKiAhQNMAgrXHdH/tLl6xfmPdvRLesQnJ9zxuCa1Iv0iOlMn8/ObGC4AdlzniNeHD4F
         0JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LM9q5Xx6Mzt9yNbUm921CBJVXXmEo2RSkhi8vTWfwXU=;
        b=BS7EBuWq9OPvZE/SwfASi8yCW0WpQ11gXsipyFQ4AbIg0iQzAsBx+xXIf+UBq44lh6
         SAJgpNNDIkznoedddEFIwirzOLNfsi4hzjeIqvDNAGUDZobiMEVghwDqUPOWUFobMV40
         3Oadfw2ud1V01yKE0eEPLA9fi+Zk10FBmk5kpijsDW+l2bglsjvqGUaEcDHCE7J0TswR
         aakO/YWQgnMe3tzW56Kr0WA5KTdORtn5xAA2eU55NVKQRHU4OXxoAG0uPeCkUxltHrV8
         m0SyHAkAA9/q0/sdSaJ26HWwhsE95Hog6DVTs8eTUZYkT0Qey7RWkOgMigvjNJMZRcux
         yDMA==
X-Gm-Message-State: APjAAAXUlnzp8Z2+SONTqj+bMW7YBDiGDBlqG2n1+y9jSlq0QldXRSzu
        pXYcPvjXzJlTKvSwDE1iWbVLsw==
X-Google-Smtp-Source: APXvYqwOOUwjmPwThJPsYd1/C2/373tC8gWUSVmdLIJPmZF2YA06UcB1XryMc12KjMbVSv4dUfl5Lw==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr3945944pjq.28.1569552109806;
        Thu, 26 Sep 2019 19:41:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k95sm3955461pje.10.2019.09.26.19.41.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 19:41:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@unisoc.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH] iio: adc: sc27xx: Use devm_hwspin_lock_request_specific() to simplify code
Date:   Fri, 27 Sep 2019 10:41:19 +0800
Message-Id: <dabc353394772cd27dc64b48278e2366a763269f.1569551672.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change to use devm_hwspin_lock_request_specific() to help to simplify the
cleanup code for drivers requesting one hwlock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/iio/adc/sc27xx_adc.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index a6c0465..66b387f 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -477,13 +477,6 @@ static void sc27xx_adc_disable(void *_data)
 			   SC27XX_MODULE_ADC_EN, 0);
 }
 
-static void sc27xx_adc_free_hwlock(void *_data)
-{
-	struct hwspinlock *hwlock = _data;
-
-	hwspin_lock_free(hwlock);
-}
-
 static int sc27xx_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -520,19 +513,12 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	sc27xx_data->hwlock = hwspin_lock_request_specific(ret);
+	sc27xx_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
 	if (!sc27xx_data->hwlock) {
 		dev_err(dev, "failed to request hwspinlock\n");
 		return -ENXIO;
 	}
 
-	ret = devm_add_action_or_reset(dev, sc27xx_adc_free_hwlock,
-			      sc27xx_data->hwlock);
-	if (ret) {
-		dev_err(dev, "failed to add hwspinlock action\n");
-		return ret;
-	}
-
 	sc27xx_data->dev = dev;
 
 	ret = sc27xx_adc_enable(sc27xx_data);
-- 
1.7.9.5

