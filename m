Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D009761E69
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2019 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfGHMcv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jul 2019 08:32:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40860 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMcu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jul 2019 08:32:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so7612524pgj.7;
        Mon, 08 Jul 2019 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o/qshDkq0LPuA8wc3+fLsn0La9XV1Cl2eJ3HWiEdi04=;
        b=qwgAVI8slDM+OaLoeE7XQ4ewYGrdgxMMLLXpMXIagbnnEXc3KVYnFuEUavNWgipsVf
         iFX+EinH+YAXcqok65pe2AUkkPh6gGhImwz6wnJsxNU9sAmqM5aFQ/yjl9meqsFw8BYy
         2JdlvZNZjlPGpJdnIvOJkA/5qSnWBXuI9ZKAJyVJNoz4DI7Q7O+Bxloqe3BaLFdBsFgF
         nV9SUDsppvfgzGuHvrbMzxv3ZxOAWSbnStH54KMG1sFF65TgbIX62ys/Fuq0xBjBZbNn
         go3qnHsN7sMifpJS3hFqMDe3ncyJZPMxG+tAtj2bkez4zyD7hn+/UJ+ZxU8Yc9y+bN8G
         Zrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o/qshDkq0LPuA8wc3+fLsn0La9XV1Cl2eJ3HWiEdi04=;
        b=kTMzP9pGZtlt5my8+5HptAe/hC5C+65WSAwhPDCdr3t7w+BQMWwOri79wA0P1n2DwG
         qIKS+SMTCF1cjaVHNzxRtCIrcUITxLeVYwsHshkQdNeL4BoV+VMnhr0eK+4RwTwBBuxD
         GLzXHxGpQRlCUKBDb/ECb05hIB31lcXxxyeae5BOj4z6DWvbN+OVAzgMdKtVMoq9bVWw
         5DHsirek6EciMl4La4YmTI82XUr1jpGYXA2/bCq5Zs2Al5S3N0kwCTvjNyM4wqi3usoZ
         nWVuHVlqmjKQsQbSYNEJD7QJL6bfRzCrarscHtGPR/7uOc1PLj0p5iylawucMqWL/iSP
         DNLg==
X-Gm-Message-State: APjAAAWXUtHrjaEzr/iVCo5GZmTLd05Lfghel2yPg/2OtNCNBWtNDEVm
        jLa01owc4e+84dQrkIGM5P+Cjvu8U30=
X-Google-Smtp-Source: APXvYqz3PdSTYRnsXlR72SL1iHWeX/pa4kqZzNHDIMQzI6MJ55XLW1bdEIncdL6STwV/+YNadNlk8Q==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr25557738pjp.27.1562589169983;
        Mon, 08 Jul 2019 05:32:49 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t11sm15084327pgp.1.2019.07.08.05.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:32:49 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 02/14] iio: adc: sc27xx: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date:   Mon,  8 Jul 2019 20:32:43 +0800
Message-Id: <20190708123243.11713-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

devm_add_action_or_reset() is introduced as a helper function which 
internally calls devm_add_action(). If devm_add_action() fails 
then it will execute the action mentioned and return the error code.
This reduce source code size (avoid writing the action twice) 
and reduce the likelyhood of bugs.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/iio/adc/sc27xx_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index ec86f640e963..d7ca002cbb17 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -546,10 +546,9 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = devm_add_action(dev, sc27xx_adc_free_hwlock,
+	ret = devm_add_action_or_reset(dev, sc27xx_adc_free_hwlock,
 			      sc27xx_data->hwlock);
 	if (ret) {
-		sc27xx_adc_free_hwlock(sc27xx_data->hwlock);
 		dev_err(dev, "failed to add hwspinlock action\n");
 		return ret;
 	}
@@ -563,9 +562,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action(dev, sc27xx_adc_disable, sc27xx_data);
+	ret = devm_add_action_or_reset(dev, sc27xx_adc_disable, sc27xx_data);
 	if (ret) {
-		sc27xx_adc_disable(sc27xx_data);
 		dev_err(dev, "failed to add ADC disable action\n");
 		return ret;
 	}
-- 
2.11.0

