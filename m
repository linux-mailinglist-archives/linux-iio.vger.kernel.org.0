Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8911ADB9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfLKOjI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:39:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35421 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKOjH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:39:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so1920814pfo.2;
        Wed, 11 Dec 2019 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5F0PPdfZoQeR4+ehc0BK4J4+yf/kLV8FFWeTQgbLqO4=;
        b=D2AOHOEMCyO3k0hjvFxCCgKEqw3qsFhSE3sCThcc9FU8sN4//6ZWrWkG4W0Gw5n5Ql
         tnp6kAtoTrDnZfAVIlvPnYrYsz7QXKkZDhw44viq5clQ7OOY+SMTFX/cE0NORObwwHJw
         C4CPlUCRgN2zccpdBIat2VJElRlPGOguLM6h2WjaYzB7Hw4VCD8ljH78NdA9JrCOe5bh
         B2+rv7y7IQkBPBmDzviHzyAhk8WOzaLp9nk55/T4PP4tUjiDmDN6zvWs7KXdkfW7+da9
         81bR72bXCAr0IbLnDyZkZcA/Zmg1Qm376KSytapK2fxSgAtL7XjJ/OyTV0lIxAZXC/42
         nRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5F0PPdfZoQeR4+ehc0BK4J4+yf/kLV8FFWeTQgbLqO4=;
        b=uGs7dnc01dah/RsCj9FZahlf6r7C6dXvx8oVKfVNBfwnK/8WXl1xGObk2scplGKLff
         QtL/OvjTqwLq5l8ZbW+bm6EXvmkV1Zvf5YwsK3HUJhzuI3lMSbVKHJowxxNejXoClBiY
         o3Bm98NHGtyQOCxD1BeBHYHfAJqK1bAIzLwuJGlhNSCtevqf1imvY5CZrOkRuJFHujuW
         oJPxMz8XibQVBhs/9p6gTqoBQL4n6tkcSHSsz9jFaNrYy0diVtISq++vnWQE8RizEp37
         +gvBrnlG0z3s/VOqhOYTvl2kE9hAuIq5CY2hTYg1jNMnnTjIIhlI8itz5/fOPkm7d+kq
         KfTQ==
X-Gm-Message-State: APjAAAUJYPH2C750jcAPpEQ4O46INmfdpH6zygHFtMU9W/jMVbEQB4ZV
        xXTe4YTIbEfslmPdjJ/Jc3Y=
X-Google-Smtp-Source: APXvYqy+ULp0BtV8BOiWwljH1aYQKPrE2YUyS2+/jHA9IgLPTQUYtDOyRF2WZHmnIuuz2UODfEYp1Q==
X-Received: by 2002:a63:184d:: with SMTP id 13mr4515647pgy.132.1576075146466;
        Wed, 11 Dec 2019 06:39:06 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:39:05 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH v3 03/12] platform/x86: asus-wmi: switch to use <linux/units.h> helpers
Date:   Wed, 11 Dec 2019 23:38:10 +0900
Message-Id: <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The asus-wmi driver doesn't implement the thermal device functionality
directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
is a bit odd.

This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
<linux/units.h>.

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
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

 drivers/platform/x86/asus-wmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..ed74c0d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -33,7 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/platform_data/x86/asus-wmi.h>
 #include <linux/platform_device.h>
-#include <linux/thermal.h>
+#include <linux/units.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
@@ -1512,9 +1512,8 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 	if (err < 0)
 		return err;
 
-	value = DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
-
-	return sprintf(buf, "%d\n", value);
+	return sprintf(buf, "%ld\n",
+		       deci_kelvin_to_millicelsius(value & 0xFFFF));
 }
 
 /* Fan1 */
-- 
2.7.4

