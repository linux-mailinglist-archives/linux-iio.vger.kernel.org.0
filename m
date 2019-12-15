Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB31611F610
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLOFRb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42653 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOFRb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so1716676pgb.9;
        Sat, 14 Dec 2019 21:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wNtUm+SbN+0a8GrjUSZCRK4zHG4L4L6an0ip7ptF0d0=;
        b=CARqNQEGgXO6NPLDpqfdZ8o0UQ+3RuRnE7NqTCXaWSswkmnp/+HkwkITZstEhn/nmX
         HcevBsy0kEg3sUHjdGc0RqmDxfCBhjAM8THzFd+Xvl67sT7JSUzI73iuR2E/l4+ncAGJ
         HjGYI+FzFACe1DhH/ZzpHu+m/62n2xsZzbLMSt/ANKN1fEsj+jZhvTx/XWi1q6glBfat
         kYon/9k2+Ja8NrZx4yY7DMLTmeFx1SwyhBN/NPot2bJVbU54KE/kdEqad/8zdTZi7F3+
         00KDKKCOxU3RqpVpKwJdp4THa1xZJgS+GTAdj9pFAj13S4HJn1Vb6GsDPNKClSLR7Khe
         yOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wNtUm+SbN+0a8GrjUSZCRK4zHG4L4L6an0ip7ptF0d0=;
        b=eHfuyC11sgqLUNqFNf3fC+9JJdns+302kfnsvtV3rgen9JATYqGhce0ptSDHfqPMaa
         36TQZ1mrZbTNVcurcCcZy0JTslpXSkoyKuD75MqgorvLEb278/HhGPN/w8m9hc4CM9ho
         T35GC+Q30M8tBlO7EhJ3e51RNTKafPrvIFIbWd8TIWg24rCBtnK6eTkpIo6ZqFjpHdwR
         x4ZQq+vH9aouR4GDqaT3BpQIfAXtDEbbKu6PtP1ACXueSlnnQFH1Xfyaxe0RZH3cdii/
         fQsUtqw+bLzAkjs9MrA214Nu21B+JwqoEMbVjHJ/thBtVtCCAe1fKxFqaDLUpU8cOAvj
         zUXA==
X-Gm-Message-State: APjAAAUiKk3y34SCOFXWI23wtAomfV7sXR0LY4k346YEZDi7K6CeYJ46
        XFO5Lwzjs8HpLtJe9VQyfYg=
X-Google-Smtp-Source: APXvYqyRvp6w8dX6QbBOEnKG62KgsdB7W7pSUy/KgK7EVQbEeUeuesZYikCPANPFgyHy/nhytxOxug==
X-Received: by 2002:a65:4106:: with SMTP id w6mr4234387pgp.347.1576387050494;
        Sat, 14 Dec 2019 21:17:30 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:29 -0800 (PST)
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
Subject: [PATCH v4 08/12] thermal: remove kelvin to/from Celsius conversion helpers from <linux/thermal.h>
Date:   Sun, 15 Dec 2019 14:16:11 +0900
Message-Id: <1576386975-7941-9-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This removes the kelvin to/from Celsius conversion helper macros in
<linux/thermal.h> which were switched to the inline helper functions
in <linux/units.h>.

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
* v4
- add Reviewed-by tag

 include/linux/thermal.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d9111ae..126913c6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -32,17 +32,6 @@
 /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
 #define THERMAL_TEMP_INVALID	-274000
 
-/* Unit conversion macros */
-#define DECI_KELVIN_TO_CELSIUS(t)	({			\
-	long _t = (t);						\
-	((_t-2732 >= 0) ? (_t-2732+5)/10 : (_t-2732-5)/10);	\
-})
-#define CELSIUS_TO_DECI_KELVIN(t)	((t)*10+2732)
-#define DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, off) (((t) - (off)) * 100)
-#define DECI_KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, 2732)
-#define MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, off) (((t) / 100) + (off))
-#define MILLICELSIUS_TO_DECI_KELVIN(t) MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, 2732)
-
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
-- 
2.7.4

