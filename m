Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1CDFC6A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 05:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfJVD6q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 23:58:46 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:39407 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfJVD6q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 23:58:46 -0400
Received: by mail-pg1-f172.google.com with SMTP id p12so9104132pgn.6;
        Mon, 21 Oct 2019 20:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCq9N4zqYiTC10C8x4uRvjS1Qh/qeG2lIGWH8M8Vfbc=;
        b=kdpRFsaZWzeZZVGxYXEsh5pibkCYXuqBge66WYt4GYsZuHOHb+5GgQZkKtDRsLNeX0
         uDAGrR8a/3khlLgCasC96NrKvdPRILnrDMR9o0QrEPER7s0D6soMhs6Eh3Orlppalp6b
         YgfxoZv1yN0t0azR/CdEPnkPnbbGxQnFANlpapfGlK1g3bLSzFOlikO7Ncz3R6ZUyQ5s
         MmFGTRJg0tk0tqPj0OIg4jhOZhJacu7lu97W18E2AhJqKQ8LQQsZJMkMQbTQzZaYp03L
         RmR3tQKTuB0uaH6+YgoPbXL8au7U6AbAIr8RY62ZyESQdcVQFdC7SVGZuTBlvnwNjmCl
         0YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCq9N4zqYiTC10C8x4uRvjS1Qh/qeG2lIGWH8M8Vfbc=;
        b=lXJ8frFGbEp/Y6IwQxYWInmcxnCwGMPUfgl2yBI/jgmAZ7UWmzIQkrqUZ8gJG07hz+
         IvcZJQSJr1r1EsIhgKmDZtSzteuwxZl8HelvzU58askpkFYsSv+86+8SeLV2C/LTA8O9
         lEWKaBBZGu+sWsLdkJ14JaPCKGgRaR+GjUTkSwVNflChG3AuHvJrOaSV8iLOUfq24mZa
         RfjXll/LeGH9zlyNBMrxJtu+fe+ERQScBh4vs+OlOdKHGhhfFm982L0v0IbT4Ym2NtiJ
         TrDFRsQ0b87kCrEdAVJx/mgMxeL4dBQ1iYfrLZnD3m0lCdpqnOM9eH+QscWm4q/db558
         JzgA==
X-Gm-Message-State: APjAAAVucNcuYBXirFhF4Ew6GoxeHoK2v7DI3TDcfuUD6hznUd6t6K6P
        pz7lDAVPkBxKl9m7QGIuKAc=
X-Google-Smtp-Source: APXvYqzL0PZ5Q/MLV/68/KdfD1duwBWsRuBT00k+RGZvYVdysxStQSL9Z/qKGeqecHeooHU9HbTdfw==
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr1767335pfd.151.1571716725720;
        Mon, 21 Oct 2019 20:58:45 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.0])
        by smtp.gmail.com with ESMTPSA id e4sm17580570pff.22.2019.10.21.20.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 20:58:45 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v4 3/3] iio: documentation: light: Add veml6030 sysfs documentation
Date:   Tue, 22 Oct 2019 09:28:25 +0530
Message-Id: <1571716705-23113-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571664705-7123-1-git-send-email-gupt21@gmail.com>
References: <1571664705-7123-1-git-send-email-gupt21@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver for veml6030 light sensor provides custom sysfs entries
used to know parameters supported by the driver and to configure
sensor like setting power saving mode and persistence etc. This
commit document them.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v4:
* None

Changes in v3:
* Updated Date from September to October
* Updated KernelVersion from 5.3.1 to 5.4
* in_illuminance_period_available is now in events directory

Changes in v2:
* None

 .../ABI/testing/sysfs-bus-iio-light-veml6030       | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-veml6030

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030 b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
new file mode 100644
index 0000000..13cd321
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
@@ -0,0 +1,49 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm_available
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Provides list of valid values that can be used to activate a
+		particular power saving mode in sensor. For ex; 1 means psm
+		mode 1 and 2 means psm mode 2 and so on.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Writing '1' will activate power saving mode 1 in sensor.
+		Similarly, 2 is to activate psm mode 2 and so on.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		List of valid values available in multiples of integration time
+		for which the light intensity must be above the cutoff level
+		before interrupt is asserted. This refers to persistence values.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_either_period
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Value in multiple of integration time for which the light intensity must
+		be above the cutoff level before interrupt is asserted.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_rising_value
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
+		light intensity is above this value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_falling_value
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
+		light intensity is below this value.
-- 
2.7.4

