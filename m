Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBD18979F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgCRJKJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 05:10:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgCRJKI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:10:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so29219175wrl.1;
        Wed, 18 Mar 2020 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SHhQHnZIi/4h72keeEYbIQCzJGcDZElFf3IKhgnUxo=;
        b=TkrZVAhTpmSLvxXG8PNb1s/QVm9yH0NxI8vT+wlsjjnZsErMbQ1Lc1jUtX+FmZZ2bs
         gyE9oFnewvEX9sshYdB5Y6lo19QDH87gIA0Y9sqwmMIQNumCXE9v80NSXBYtSusU/5dt
         MT6WlmCkhb40oTLqg7OtH5npaWpQTDD/spi6fR2w60b8YfbVoUPgSSWqSKLXeiB4pyp+
         +7ox0YTj0qVjHTn889ZpHeZvVcr1g0wxJ59NHC4cO1H5QQoa6tSrtnkFkY15fNr/hEXs
         WjAklpTNdC+WKqjO/gSH9dl6pzEWXxVRKxleybvuKDCbo+LiU2LgH0gBHToaKtDZtBnQ
         QJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SHhQHnZIi/4h72keeEYbIQCzJGcDZElFf3IKhgnUxo=;
        b=OTDKq1fEecs+hSb5rnxQh0KNDLcePi9dpZjNlvLCTBcR/8shqAe9vE07lnohtYlPM1
         hIDnDkvk+V05GHWnBBvja7ACdLH2uOL597jJaw+X6YT+Sg1+BwIcXsTPU0pzdJ/ODn4i
         3Dv05JdHXQn8BCkG7kGuiGO7aa3s7odpwY4wsmzBitZ1/UA1bxfTz8IWK8DrX1eIdb2t
         HnYI466HJBwhVU1P/KHFdca1LrT8f3doyUfzSHijbj0YKMFit1BLJIXCjTWflkIYAm/X
         ve5d7gy3xnx+ceGnWnxm9oagXgXS/V/nFz1zhFnIz3O5/SYhTw/n4/GMg+jbcYSTpcZE
         M8vQ==
X-Gm-Message-State: ANhLgQ3tmHygEA1dPl3jcMZ+YlnLxApR+DPYxDLXECLC2Icld4XmLjpQ
        jb32nIicviaPO7lCapAUaVhHDXmP
X-Google-Smtp-Source: ADFU+vvvNSCJU5tc7gOt2zbuF5QA+mySFbKRI3UHthp1OTZhSsyojL0Ly6/YWVissb/GdhcDb7wBPQ==
X-Received: by 2002:adf:ab1d:: with SMTP id q29mr4191474wrc.233.1584522604847;
        Wed, 18 Mar 2020 02:10:04 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id w1sm2823986wmc.11.2020.03.18.02.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:10:04 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH v3 4/4] iio: accel: adxl372: Update sysfs docs
Date:   Wed, 18 Mar 2020 13:09:58 +0200
Message-Id: <20200318110958.8621-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318110958.8621-1-alexandru.tachici@analog.com>
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds entries in the syfs docs of ADXL372.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-accel-adxl372   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372 b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
new file mode 100644
index 000000000000..6be4f57f9520
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
@@ -0,0 +1,30 @@
+What:		/sys/bus/iio/devices/iio:deviceX/hwfifo_peak_mode_enable
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows to configure the FIFO to store sample
+		sets of impact event peak (x, y, z). As a precondition, all
+		three channels (x, y, z) need to be enabled.
+		Writing 1, peak fifo mode will be enabled, if cleared and
+		all three channels are enabled, sample sets of concurrent
+		3-axis data will be stored in the FIFO.
+
+What:		/sys/bus/iio/devices/iio:deviceX/activity_detect_event
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		adxl372 works in loop mode. It will loop  between activity
+		and inactivity detection mode. The thresh_rising sysfs files
+		found in events/ need to be configured in order to define when
+		the device will mark a sensed acceleration over a period of
+		time as activity. Reads "in_accel_thresh_x_rising".
+
+What:		/sys/bus/iio/devices/iio:deviceX/inactivity_detect_event
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		adxl372 works in loop mode. It will loop  between activity
+		and inactivity detection mode. The thresh_falling sysfs files
+		found in events/ need to be configured in order to define when
+		the device will mark a sensed acceleration over a period of
+		time as inactivity. Reads "in_accel_thresh_x_falling".
-- 
2.20.1

