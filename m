Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452D411F5F0
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 06:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLOFRU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 00:17:20 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46345 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOFRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 00:17:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id z21so1511001pjq.13;
        Sat, 14 Dec 2019 21:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dFlnRv0hadsugtVajyHRe0JC+tPOCVnj6GsrCbBgD3o=;
        b=NC5Q3xlhCVYDD/m31UtBzIc7GqULlCKQs5ldsS8eMSO7ocTrRah48V7JueoBaZjRfF
         dFYazkMieceVvYDQVsuOkcDgcQgV+R2s3QkTvDH852AG/HAOg/6bmXHwqA+hQrAtvcTY
         B/45nLwULGUuOdCwfUMpOuU0WmNIRaRqaEEXgijAWVFt0CCjv1PAXYcA+jkp2IDrAGBN
         zKWV0O1HL9cnFQ8NQnCN/BvouZMcLq7yOazxwoBEjJMZ//2o82FHAP0v2bFXLdAqt0Lk
         34CbQTdrvH938tKYyDddbbw1RfXz1UJTkIppwnsQSEyG1kyk26wdD9HbuxJJgfkJsY5Y
         3Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dFlnRv0hadsugtVajyHRe0JC+tPOCVnj6GsrCbBgD3o=;
        b=CU+rFoo41a+wA4K+gdeayZxE5Mni+TQjqPs7PkgYVDEgcVIvjDysrOz2sP6PEJd7Pc
         ZLCceEUFFgKW6Nl6hLiT0xc3OtcqPJ/Tnv/BNfk2h87tdWobcLfpgRpUKcY9NEFEwJA6
         y6kmIlWl/kxsOczeo60qMYAR6osYvLOYBFU5FxCQVpF4lX6y0k5LS6okORior8danCBs
         LMNeg+ChTJYxOqwRnUWLUqf1r+kEHFXBkKhm5h1TYKd3Sb7eE6elM2tVPX0yMaVwtxyM
         eifJifzMskA7GUiwXWWaOUWIT1hcM51fiQzSTZh4i1WGoL6WjdCFEED3esvjGALqQq/5
         cuKQ==
X-Gm-Message-State: APjAAAUA+NY9saGTgTFAh/rMXdqUw4D6ftqxcAdAyb4L7ROGQK7j3aJO
        P2B355O+EHnHV9jxX8WtXqs=
X-Google-Smtp-Source: APXvYqwbGw831TCHknZkFd89BpDoeV5W4jcrJR7PjtyCCgpjaIW4I9/0mOvOtFg2s6Cbv4FQ3LiZFQ==
X-Received: by 2002:a17:90a:f84:: with SMTP id 4mr10440876pjz.74.1576387038837;
        Sat, 14 Dec 2019 21:17:18 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Dec 2019 21:17:18 -0800 (PST)
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
Subject: [PATCH v4 06/12] thermal: intel_pch: switch to use <linux/units.h> helpers
Date:   Sun, 15 Dec 2019 14:16:09 +0900
Message-Id: <1576386975-7941-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the intel pch thermal driver to use
deci_kelvin_to_millicelsius() in <linux/units.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/units.h>.

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

 drivers/thermal/intel/intel_pch_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f..b118611 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
@@ -92,7 +93,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 		if (ACPI_SUCCESS(status)) {
 			unsigned long trip_temp;
 
-			trip_temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+			trip_temp = deci_kelvin_to_millicelsius(r);
 			if (trip_temp) {
 				ptd->psv_temp = trip_temp;
 				ptd->psv_trip_id = *nr_trips;
-- 
2.7.4

