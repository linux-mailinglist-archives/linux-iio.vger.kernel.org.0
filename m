Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC911F5DF
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfLOFRD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42630 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOFRC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so1716349pgb.9;
        Sat, 14 Dec 2019 21:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9X4iPd0KnMa5KIyBgavR+hocptaY6HIdK2blzLDzaA=;
        b=FPmAVeP2mdUVq6DwLRYvd9CvKLYcTHemjyCqjRrlXZl9WEmrF1z0xAHiQoxS9gc67/
         zhyEge0e40HIR579wURSSHamNti6CIEe7Gosq5ThBuDc4iSqL+Bqd0yPAIjDCq9rnlI6
         8PwmLVKxAwFVNQtYO4DHbtwS8NuO/oTO8cTsrj17hfr0YVizOwfT7bcMGxj581fLb4fF
         Q+EBHdUwJJKg5IUx05aEP4gRRpMp/8AI+/qxNIwj/N2wI5FJzbeULUdGFDd3Js5WUsL0
         hgFLna4w1PwiOvokEp3QJXp1owK24s/6XM+zZMa90nP8X+GQhl06fAkKxNhLc4Orehyf
         TpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9X4iPd0KnMa5KIyBgavR+hocptaY6HIdK2blzLDzaA=;
        b=AWkURdWa+/hZh9c/V16kdCB9kZ/6Dleysgm2WlwMzP6V1BLrGBDyY1iYK7Ywm9RDcJ
         9tvnZjk0MNuGyPAQ0xEl/LDz4E6BmmdeyNRcfJsdu2zy3BQ6Wv5ByndIW89rK2Uy7BxG
         eclfDyjdP+1kXPv3orxggionoXUoiFVDE/zW+ZYWNlkHoNHVOvSRnM7G+VQ5GtaLaG47
         WxZytEFM3d3urgkxd1VljO9qVWN5wk2ky/1//Il31MWHuZ7nre75s+Ujjj8HKZDVvqo+
         WnXyAdqd5XMfETZdapEFDyjF0i3TAjxS0GYdFXqE9nouIosPhR/SBwLiZX3FrsMlgJg/
         j0Ig==
X-Gm-Message-State: APjAAAX51IUX5fVA+a5rg3/9BfgFedcF7a4SU916FD5LD42fZcXVKLQ1
        d2gvI5/S2lw88UUBFN7nbps=
X-Google-Smtp-Source: APXvYqwaYLWaptacVXVwa4TActC1oLxGg8wUZKowyGri7WYpGP5PtlqW2c8tyhGBSdvFWauo1nBjCw==
X-Received: by 2002:a63:a53:: with SMTP id z19mr10191253pgk.267.1576387021783;
        Sat, 14 Dec 2019 21:17:01 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:01 -0800 (PST)
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
Subject: [PATCH v4 03/12] platform/x86: asus-wmi: switch to use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:06 +0900
Message-Id: <1576386975-7941-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The asus-wmi driver doesn't implement the thermal device functionality
directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
is a bit odd.

This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
<linux/units.h>.

The format string is changed from %d to %ld due to function returned type.

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
* v4
- change include order

 drivers/platform/x86/asus-wmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..b254f9f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -33,9 +33,9 @@
 #include <linux/seq_file.h>
 #include <linux/platform_data/x86/asus-wmi.h>
 #include <linux/platform_device.h>
-#include <linux/thermal.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/units.h>
 
 #include <acpi/battery.h>
 #include <acpi/video.h>
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

