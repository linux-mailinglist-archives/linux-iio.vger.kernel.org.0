Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7DDED9A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfJUNb7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 09:31:59 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:46803 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUNb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 09:31:59 -0400
Received: by mail-pf1-f179.google.com with SMTP id q5so8435165pfg.13;
        Mon, 21 Oct 2019 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6TBjAovqEnEPL9uVV/+gWkAn7AsiTJRh7RaEnv55usQ=;
        b=tx2/aG5V8m4d9lpW+zACp1mkWbb7GUKFwHhv2mscZpInr4DKgYWZCH73CR1/dALmJJ
         cx0A6QTfYIs6HfVMX7kPU1rTxDfFUraZSwFa8mjIxy61xVfm/vVczjBOaHB7xtd9qsvC
         bBpF6417d434ACzjbIrei2bZXoDWdnF9JQor9Us4XmtIu/PSE/OI687tsWpqdWx2/TJ2
         LjOayZfTeOewZmgYjB76+7ScqEIMlNhYWqigt4GybI84XnqlcVMpqWPAsqiJvnkxX293
         b8ejUiZ0ZjbUd2H9d/hWxgd9RlOC7I0K7rPGSDpUMMachrWqOgPhefZqAqwO/TgvD3Fd
         FWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6TBjAovqEnEPL9uVV/+gWkAn7AsiTJRh7RaEnv55usQ=;
        b=t9/A18qsTkRQ3+T0jb9liNv+V1OShG2lyHtz06RSPz0r6tW2+JX57rp0XWVW0jBABw
         tMhZoXz7dMmc1MM7EuafvK9jrs/R3VVS/WMCJWKKHs5TnXd+qPNNI9bgy85wX5HSjyZv
         g919ohL1AyoUv8bLyqpIhoOoQhra8kOTZQLTlaHGvx3JvaGvpn5739vNkWQ2IeypZKeY
         bFfDWsDM+yOwRy4uU8Z/eLdhROB9y1LWbw4/NfYsAHZwPxFD5JXGoD54Dc7IfatJgBYW
         8Aj5gH3DRds/d/ZhMgJXmjjCkVNKqmq/F0JZGhlgM5DuDUbz4x1ptWSZlS5pCUyUPJhj
         e5cQ==
X-Gm-Message-State: APjAAAWBq20OAWFtL7+bcirKV8tYVDZPpysmUiPdIC+RB/3l0a2QAjPl
        Mylk69nxa0hTuwOmn5cH3viURgOXemU=
X-Google-Smtp-Source: APXvYqwwqf2izADYTak1ztpyH4iez4HFp6zIBOKlLmb9r4aJ5PIADOFq9Hd2YG5eC6eRra68aNfeHg==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr23200495pfm.178.1571664716898;
        Mon, 21 Oct 2019 06:31:56 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.0])
        by smtp.gmail.com with ESMTPSA id e184sm17082252pfa.87.2019.10.21.06.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 06:31:56 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v3 3/3] iio: documentation: light: Add veml6030 sysfs documentation
Date:   Mon, 21 Oct 2019 19:01:45 +0530
Message-Id: <1571664705-7123-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20191005151119.56c65d71@archlinux>
References: <20191005151119.56c65d71@archlinux>
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

