Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C3BC613
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395114AbfIXK6O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 06:58:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43987 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbfIXK6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 06:58:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id v27so1103677pgk.10;
        Tue, 24 Sep 2019 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0d4AYNtRkLfpkDim1W4lc4CifwLMiEr/+iKYtJT4Oxw=;
        b=SNogPM1q0Frg3ofEOIbzuKjAsn9fM85Ga0XT+07KBQBIsm3ODaiWzScBEJuJSJiUxq
         pcflkTkN5Km1oZPWwCChI9r3ekxI9KTs+3TxKI3i5UzqGZEBDMkltcAV5V3q5k45aJY3
         tHnu3U5gNw/K2FpT2lkkz6S06LZ0JUx6sXHyKy7XTIr/M4sVKL1dXq12J55shoWdN23z
         ESGi6ngX00V9SvtrmdVRL107HJ/0UMCo0//hacU0g+YW1JfP4ZeTSnNsG2h/Cud2RPun
         oc8JJfE1rf/Qu7XtViNGWvLm6dseO9D/uf3gQ977Jc7ZfBLtbMPqzsZ/VJfU5ayyKe7u
         22/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0d4AYNtRkLfpkDim1W4lc4CifwLMiEr/+iKYtJT4Oxw=;
        b=nD6Lin5kbo4bGc4g76vO4YOmx0Faec7QTY1/UJFBA35WswDsAJhyDWSR1wxjHa7PHZ
         1PsqKPkwjy9Lcv7qqdxsRJR2IT/0m29PpS7lI1ZCalyp56k5AhVCGuAGyfbbP4kD6vPz
         nQ38H0xK04PcS/mtEHcqZUwnLfGm9B9eYKQeFcr5QHUi+fhFOVmszNynYEYxudZ0SdBM
         UJShdkOe/UHbQ/fP8DdPoDNPL5CpVql3PVk2kActs9gljNCW/htvjJqFgEUVnie9c2hz
         1I73MAUARC6WQuxbO6NFd3Xb1yrJQt9+xulerRHlAkCDqAtz5TjyPFnSIWxntHtW6qJS
         ciJQ==
X-Gm-Message-State: APjAAAULp+j+8X77Eb/g2F1QqpjbCJrq996wwEPnrd8ymf25yAkgd8mB
        U2MhNDWDViFXRuKol/oWZmw=
X-Google-Smtp-Source: APXvYqyKHPXFXmai4Q0lnCtL4IQ7IiJNAn+Qr9TTek57cEzbVIRxJFJWcgkNCrBy5aZETYHGsbSYrA==
X-Received: by 2002:a62:4e0f:: with SMTP id c15mr2689062pfb.42.1569322693271;
        Tue, 24 Sep 2019 03:58:13 -0700 (PDT)
Received: from localhost.localdomain ([106.51.110.135])
        by smtp.gmail.com with ESMTPSA id c125sm1953886pfa.107.2019.09.24.03.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 03:58:12 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com,
        Rishi Gupta <gupt21@gmail.com>
Subject: [RESEND PATCH v2 3/3] iio: documentation: light: Add veml6030 sysfs documentation
Date:   Tue, 24 Sep 2019 16:21:58 +0530
Message-Id: <35614391cf5e79765a6151ce998a213544562a37.1569321085.git.gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
In-Reply-To: <cover.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
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
Changes in v2:
* Nothing has changed in this file

 .../ABI/testing/sysfs-bus-iio-light-veml6030       | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-veml6030

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030 b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
new file mode 100644
index 0000000..13589c9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
@@ -0,0 +1,49 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm_available
+Date:		September 2019
+KernelVersion:	5.3.1
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Provides list of valid values that can be used to activate a
+		particular power saving mode in sensor. For ex; 1 means psm
+		mode 1 and 2 means psm mode 2.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm
+Date:		September 2019
+KernelVersion:	5.3.1
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Writing '1' will activate power saving mode 1 in sensor.
+		Similarly, 2 is to activate psm mode 2 and so on.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_period_available
+Date:		September 2019
+KernelVersion:	5.3.1
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		List of valid values available in multiples of integration time
+		for which the light intensity must be above the cutoff level
+		before interrupt is asserted. This refers to persistence values.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_either_period
+Date:		September 2019
+KernelVersion:	5.3.1
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Value in multiple of integration time for which the light intensity must
+		be above the cutoff level before interrupt is asserted.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_rising_value
+Date:		September 2019
+KernelVersion:	5.3.1
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
+		light intensity is above this value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_falling_value
+Date:		September 2019
+KernelVersion:	5.3.1
+Contact:	Rishi Gupta <gupt21@gmail.com>
+Description:
+		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
+		light intensity is below this value.
-- 
2.7.4

