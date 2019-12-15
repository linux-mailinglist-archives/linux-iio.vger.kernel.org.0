Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFD11F5E4
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfLOFRJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:09 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43506 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfLOFRI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so1515536pjs.10;
        Sat, 14 Dec 2019 21:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3my8RP+3u7n3veq9PtxCL/LXumnZQKbolrNqeQogkFY=;
        b=raWQVX5OuOc2bkMiheKyKPwiClD8x0+EfjKFf0qMGEo02vguYoQC8ljPwoMX+4CxO4
         vciGC7KJx8rxr6LPTal0qb/QPClRVMM1DzL436GYGp7hk17/XWGuH+bFCvc6dslVRPvU
         Nm1JdWz2Dn7wwGVYEFRWyFZ/BnALUs8vorqsQzt1kkAxHtVuACbCxT51IiLUXbTig2sy
         Oy4242wsqTyNwxEioMiTl82h607aQcWJ2H9jyGm4msb+IK5FjYiGaOvzRPMqGXuv+08Z
         2oB76QVhTlJU8vJtOdFjrQkUhBNR/DNhkv8dy0dyxNZvqhjKtCRkcVLyaXaFboKOZi7n
         MRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3my8RP+3u7n3veq9PtxCL/LXumnZQKbolrNqeQogkFY=;
        b=fRkflNfQx2SM83ynqi2XjQdqDvIFljMwysM/RA8CnyXDyVVNC+gkMw0acLbyt2VEGk
         QB6MoHHWGsCHfnzUx1aQyGhGjraSRISzyzioCdWzu94BSk58deZV4gp+Pg4ASWeLK5h2
         Vkr+rgcXC1CBkWH6IIN4tRaW1e9BlyRSdf/TXf5BRfG5toCUk6wR/N/r3F89ei6Acv/i
         zYZaWXF1ZnciciFeuqqo8stkMwWRl+h1SMOkxoVVFUwnX8l7m+NswUs5ZaWY2lAAwa58
         xxAb3BZCGIz5BFEDoGLaZcoiHcMDpF1l/7qnFgQg1RreLGMLMFX18Nm+bX8gOmOYL53b
         LySA==
X-Gm-Message-State: APjAAAXMJphEGGPolW24MqD+Lg1x0/pRJXDXhf89cZNm8hNbL/zF0/LQ
        D3wme86MGXGs1oex99hgIkE=
X-Google-Smtp-Source: APXvYqwQKHV1f9EJqmr0sZGc75iS/LgVRptZfafPMXcin6IZi+sZoqSA1EcyfrXp8opQVtB8978ijw==
X-Received: by 2002:a17:90a:b94b:: with SMTP id f11mr10518148pjw.5.1576387027338;
        Sat, 14 Dec 2019 21:17:07 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:06 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v4 04/12] platform/x86: intel_menlow: switch to use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:07 +0900
Message-Id: <1576386975-7941-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
celsius_to_deci_kelvin() in <linux/units.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/units.h>.

This also removes a trailing space, while we're at it.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* No changes from v3

 drivers/platform/x86/intel_menlow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index b102f6d..101d7e7 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 MODULE_AUTHOR("Thomas Sujith");
 MODULE_AUTHOR("Zhang Rui");
@@ -302,8 +303,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, idx, &value);
+	if (result)
+		return result;
 
-	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
+	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
 }
 
 static ssize_t aux0_show(struct device *dev,
@@ -332,8 +335,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
 	if (value < 0)
 		return -EINVAL;
 
-	result = sensor_set_auxtrip(attr->handle, idx, 
-				    CELSIUS_TO_DECI_KELVIN(value));
+	result = sensor_set_auxtrip(attr->handle, idx,
+				    celsius_to_deci_kelvin(value));
 	return result ? result : count;
 }
 
-- 
2.7.4

