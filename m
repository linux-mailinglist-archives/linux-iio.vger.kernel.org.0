Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C884143DE9E
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJ1KVd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJ1KVW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA59C0613B9;
        Thu, 28 Oct 2021 03:18:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h7so23101227ede.8;
        Thu, 28 Oct 2021 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L2JMKpGP10zaKzlWr+YPAz+Tmj11kCytPQMo8tQzF78=;
        b=LnxD7A4Lpm2UQsB1e5xhp2b0TA2gTdNEGC8ZFgLX5itA9oUnFGmuxyS4DCgABCn01D
         eu5rIzt0pBuoT+ZN8HJlbVWWuG5yiEJVadsgYQoy0jim7vOPf4sIz+lMc1t/torM0ZH3
         8OGDdlj5N7ncDsfUsb0IPV3p6aQ5lrY+IWv6926m4l4O3yhmWlRS8W6PdPMZaFq6h7FG
         VMeIVUlpUaLF8Z/nah/DUcxHQIKeMxLCrJtkY00mqYnQxIRxVuEdh4cmk28mi+q8XPqt
         +e41UmAarpiLTJy59Zn3r4KJKNBuhWVZa3MCdAFBLGiNZKttKdCy+LpkKwFzs5Zm8BEQ
         U9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L2JMKpGP10zaKzlWr+YPAz+Tmj11kCytPQMo8tQzF78=;
        b=GYeCOJjRCvFoVYL9vnW8pHpASLDZN8ZpXlIwxDgWTzUl+tlB2AlxbeB1uzRouJN9qB
         ZaakTrBk+Z5e02v8iKhHC0r3q60bbmSoVAS1c2pXPsHzHApYb8LFy622I3fSCJWPjBao
         CHYkp6IorGj4eBX5w9ZMphfucfmnfbAg1zSmERkKKYHUX6B/Cij+bwEHBUa79CFgb1Lx
         LPhR17dzk24eT6rCJVSKFzU+HlArlWcxbRlBYaJqWjPZvBSe+sVIEP9FLTED81l8k3UF
         66XUfosirJ8GykRH8rhyEtwbdunFEVUKohmHQuB4NnkxCHaexVAOs6acunny7W4MTM/g
         t9zA==
X-Gm-Message-State: AOAM531mDD1bJqR9tGZsklA/+rvU7X/nCoEyFhqZlGQodKPfNFoj7Wc2
        j8yEgDTT/0gx9qtXx4so3Vg=
X-Google-Smtp-Source: ABdhPJzAZM+WJTe83dDsq2IpH+EjpxCvgHpUKq0Wvch/VsHbabkzyUPixpcDZbhsWjUGd7Lskd7iUg==
X-Received: by 2002:a17:907:9614:: with SMTP id gb20mr4481318ejc.564.1635416334721;
        Thu, 28 Oct 2021 03:18:54 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:54 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 06/10] iio: document bno055 private sysfs attributes
Date:   Thu, 28 Oct 2021 12:18:36 +0200
Message-Id: <20211028101840.24632-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds ABI documentation for bno055 driver private sysfs
attributes.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 .../ABI/testing/sysfs-bus-iio-bno055          | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-bno055 b/Documentation/ABI/testing/sysfs-bus-iio-bno055
new file mode 100644
index 000000000000..930a70c5a858
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
@@ -0,0 +1,84 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_range
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for acceleration readings in G. Note that this does not
+		affects the scale (which should be used when changing the
+		maximum and minimum readable value affects also the reading
+		scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_range
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for angular velocity readings in dps. Note that this does
+		not affects the scale (which should be used when changing the
+		maximum	and minimum readable value affects also the reading
+		scaling	factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_range_available
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_accel_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_range_available
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_anglvel_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/fast_magnetometer_calibration_enable
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "Fast Magnetometer
+		Calibration" HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
+		NDOF) HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_calibration_data
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the binary calibration data blob for the IMU sensors.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_accel
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
+		Report the autocalibration status for the accelerometer sensor.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_gyro
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
+		Reports the autocalibration status for the gyroscope sensor.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_magn
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
+		Reports the autocalibration status for the magnetometer sensor.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_autocalibration_status_sys
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be "Idle", "Bad", "Barely enough", "Fair", or "Good".
+		Reports the status for the IMU overall autocalibration.
+
+What:		/sys/bus/iio/devices/iio:deviceX/unique_id
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		16-bytes, 2-digits-per-byte, HEX-string representing the sensor
+		unique ID number.
-- 
2.17.1

