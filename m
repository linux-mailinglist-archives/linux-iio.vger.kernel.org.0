Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8311F60B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfLOFRs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45563 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLOFRr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1707582pgk.12;
        Sat, 14 Dec 2019 21:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rs+ph61PgowUB2wxJYFFkBstw61v/JyioJPVFcT1dTo=;
        b=PrmuGguMd8I2icLDPcfOnUjhxgAkYI89eucLm58rL6pWLvQL2jZxJTUV6iNRcYSoQ2
         sKk2OHbbVJPQZZq8MT2heyABgtzLtkONYwt26Zk+TkTkAYRNziB7w4K8Q5suhmYOXkR3
         POykAo/0yD/76gVPmRSp7biObXx0ma7YjYqyoVxlPQ1JTyhH6KpJ6H6Jnz94BeV/15du
         cwtfk9+BTmygl5heycnwix988ik+j1JV7n6H5L4OTWXP+GKoFXjVCQy4x2NB/4vNQaOA
         eoYdoyMlUaHLlo+pSFsk56d5j/vVEZ5cSa73TgiJO85GCfq+XhKbVxnbyPrRf8JLKn9b
         /OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rs+ph61PgowUB2wxJYFFkBstw61v/JyioJPVFcT1dTo=;
        b=qWb+Y6dN2mIreYPFr1ecn8zetJA+4a/dEgeET+hVxH00DoEhfYknGvlobLI8J2un67
         YQsS2GEJiUMXYJ53PM7MoWZ3l/GhkvboKRapq/EJbsAWqhGC7+EAet4QlChOEogBpcpt
         3LvPeOOsOjwRiCWwLkzpcpfDWQEJKHyRtk5UtHt/D/HJTd8P8WrQV4GCHD0UaDVXrUo5
         d+ubOxA+y0WO/Ap9ytxmj+2hjPiLr0rdvGzeTLRJdaIjW7IkWQbYg6Qbbln472ZiAFtQ
         CIXkh4b5RvuPMSPyx7VprSmgjPuHN6FEssjOPtId4CZj8aTcyrcXMaGFRINlqjWlZnAG
         lCWg==
X-Gm-Message-State: APjAAAXgeEUMGY930CoFBQuhhPkZfL4PPPS8vw5m0qc9Zx/GYzZ8LBq0
        mT6xAF5YGJNa7M8ScB9tWU4=
X-Google-Smtp-Source: APXvYqyz2b9p5as0HpR/8ZvYU3LMjgqtKZ/4OlUPaESNc9g0DwHCBTVHwRTYyxlafrFwiY2Ib4eY4g==
X-Received: by 2002:a63:3104:: with SMTP id x4mr9984060pgx.369.1576387066555;
        Sat, 14 Dec 2019 21:17:46 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:45 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v4 12/12] iio: adc: qcom-vadc-common: use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:15 +0900
Message-Id: <1576386975-7941-13-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the qcom-vadc-common to use milli_kelvin_to_millicelsius()
in <linux/units.h>.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by tag

 drivers/iio/adc/qcom-vadc-common.c | 6 +++---
 drivers/iio/adc/qcom-vadc-common.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index dcd7fb5..2bb78d1 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -6,6 +6,7 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/units.h>
 
 #include "qcom-vadc-common.h"
 
@@ -236,8 +237,7 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
 		voltage = 0;
 	}
 
-	voltage -= KELVINMIL_CELSIUSMIL;
-	*result_mdec = voltage;
+	*result_mdec = milli_kelvin_to_millicelsius(voltage);
 
 	return 0;
 }
@@ -325,7 +325,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 {
 	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code,
 				prescale, data, 2);
-	*result_mdec -= KELVINMIL_CELSIUSMIL;
+	*result_mdec = milli_kelvin_to_millicelsius(*result_mdec);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index bbb1fa0..e074902a 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -38,7 +38,6 @@
 #define VADC_AVG_SAMPLES_MAX			512
 #define ADC5_AVG_SAMPLES_MAX			16
 
-#define KELVINMIL_CELSIUSMIL			273150
 #define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
 #define PMIC5_SMB_TEMP_CONSTANT			419400
 #define PMIC5_SMB_TEMP_SCALE_FACTOR		356
-- 
2.7.4

