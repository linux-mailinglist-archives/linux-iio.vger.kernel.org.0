Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942F911ADAD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfLKOi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:38:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33854 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKOi4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:38:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id l127so635229pfl.1;
        Wed, 11 Dec 2019 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0g2yitOap2PZ563u5lrVGdcbHo44KhhJk/TqjJ9Bls=;
        b=n/zyW7zeFhMU5gj3nvHALhoD0Cni+mTg66+JciqG64jKfxuDYWCuHFshRuKw9PzcVR
         UPAhcWK8PMXQJvYTKwWVJxtE93sBSkxt97rrtEQIGwWkoZ1GYIbhP1dc6cBA47HAr7fq
         7HZyBS8L+8zimgtYc0u2Qxogpoe9wos3NUr+I8uQNBQ2QVMH43qaylcRH6Fy7GLt4cV7
         Q3DztC7PRqjIfQG8uHRpfhPlvaIVfJ23nQyyG/nE6Xu/em+ek7hvnX2atXSHwTL/ryKg
         m776Nu2T7ruyegOFT76AFo2uyLAC2UWE0ZgYTo6SUra3dBBLtNc3N/WoplLyovVh9w/h
         MbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l0g2yitOap2PZ563u5lrVGdcbHo44KhhJk/TqjJ9Bls=;
        b=X3z3ZBLIMFZxvR4ua9ijL0Nml+3XlF/t+QpYloNcNtRU4fp22cgMFkjrR4j+Y2jW3U
         K8Spg/rH7JkoEdr6uZXnXhhroU20v3zUiprz0d4qVGYAaJeXumk+JaOUC5E/l33q/ZBN
         N39Lc/q8FEHL/AJQK6PqE3DRLUTHkvhzo3421F7NwFRjw/8mqfzv9xQ+eiOflfpNGMTq
         xPNM6iWd9gAT2Pp8zwx/u909isjg+C0ZShuMZ2Xgyp4ioMwLwwjqf4fFEDRfZC9KYGCH
         02SGUMcKu/6lqVkZjYHBYp7z2vSluodzm09pQec5bP1Bq1T6hawE9nQblYzaPtDWawvi
         eQ8w==
X-Gm-Message-State: APjAAAUnnEpjOmMkiuTrXoKEnG+wOxwh5TssAVSgCbnlVPV2gWe3nwTp
        gosv68uxkzcqr+5o1U/nakzDyMLIfSepCQ==
X-Google-Smtp-Source: APXvYqy05/Tn9Tceh/n1VRnGu0o9MXcVLllz85EXFJwN51RkIZCmg7WXWcX4MikbeZCoqWs2pOFXqQ==
X-Received: by 2002:a63:ea17:: with SMTP id c23mr4526029pgi.85.1576075135462;
        Wed, 11 Dec 2019 06:38:55 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 06:38:54 -0800 (PST)
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
        Sagi Grimberg <sagi@grimberg.me>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 01/12] add helpers for kelvin to/from Celsius conversion
Date:   Wed, 11 Dec 2019 23:38:08 +0900
Message-Id: <1576075099-3441-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are several helper macros to convert kelvin to/from Celsius in
<linux/thermal.h> for thermal drivers.  These are useful for any other
drivers or subsystems, but it's odd to include <linux/thermal.h> just for
the helpers.

This adds a new <linux/units.h> that provides the equivalent inline
functions for any drivers or subsystems.  It is intended to replace the
helpers in <linux/thermal.h>.

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
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>
- add milli_kelvin_to_millicelsius() and millicelsius_to_milli_kelvin() and
  use them for implementing other helpers
- add MILLIDEGREE_PER_DEGREE and MILLIDEGREE_PER_DECIDEGREE and replace
  the hardcoded constants
- add kelvin_to_celsius() and celsius_to_kelvin() in <linux/units.h>

 include/linux/units.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/linux/units.h

diff --git a/include/linux/units.h b/include/linux/units.h
new file mode 100644
index 0000000..aaf7163
--- /dev/null
+++ b/include/linux/units.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNITS_H
+#define _LINUX_UNITS_H
+
+#include <linux/kernel.h>
+
+#define ABSOLUTE_ZERO_MILLICELSIUS -273150
+
+static inline long milli_kelvin_to_millicelsius(long t)
+{
+	return t + ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+static inline long millicelsius_to_milli_kelvin(long t)
+{
+	return t - ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+#define MILLIDEGREE_PER_DEGREE 1000
+#define MILLIDEGREE_PER_DECIDEGREE 100
+
+static inline long kelvin_to_millicelsius(long t)
+{
+	return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long millicelsius_to_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long deci_kelvin_to_celsius(long t)
+{
+	t = milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long celsius_to_deci_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t * MILLIDEGREE_PER_DEGREE);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
+}
+
+/**
+ * deci_kelvin_to_millicelsius_with_offset - convert Kelvin to Celsius
+ * @t: temperature value in decidegrees Kelvin
+ * @offset: difference between Kelvin and Celsius in millidegrees
+ *
+ * Return: temperature value in millidegrees Celsius
+ */
+static inline long deci_kelvin_to_millicelsius_with_offset(long t, long offset)
+{
+	return t * MILLIDEGREE_PER_DECIDEGREE - offset;
+}
+
+static inline long deci_kelvin_to_millicelsius(long t)
+{
+	return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE);
+}
+
+static inline long millicelsius_to_deci_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
+}
+
+static inline long kelvin_to_celsius(long t)
+{
+	return t + DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
+				     MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long celsius_to_kelvin(long t)
+{
+	return t - DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
+				     MILLIDEGREE_PER_DEGREE);
+}
+
+#endif /* _LINUX_UNITS_H */
-- 
2.7.4

