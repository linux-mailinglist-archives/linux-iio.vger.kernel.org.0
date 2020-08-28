Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58087256384
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 01:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgH1XcW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgH1XcP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 19:32:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A751C061232
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 16:32:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so368723plr.5
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6beHee0w3/XIk3d7z2ZbFXD768rRlzXR8rEgKWWEzAM=;
        b=BTeJPiuO31ZdggJziUvD/w04aZ+GClaDj/8zTBjCn9CM5+s9nQigd0BsrdhXXgNx1s
         lbFbW4pP1i8mSI86sTdkomkQhJNztpDO2kAH5DTbFjfGUsyB7YKpAM7S7Hb4Nb5+A3AZ
         CX/D9bxOli6PfvcVgB0Z2JoTSeSUrfVHK2bPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6beHee0w3/XIk3d7z2ZbFXD768rRlzXR8rEgKWWEzAM=;
        b=djMpkKE3ECpmcHylaA0pEi8oGAMbDK1C5OOHJxNgb327H1wN4u1FBZSS8d05ba8kFx
         Z82c6txivbbMgpySygIpUICfuK3RKNZy/KgU6LlzDaE2m6WcjbTvn9pee5BlyEKjS3RN
         mTEwsesQo21YHHkFf3WmeblY2kW4N/s1hpaU0G+L5eYjWlFCf4rgQr/IyJpDwg8m+P/4
         UQHPbFiBhyLEU42U/EN6jnbJDMn+gEtEdPu3RtzvkCw7J/VL1PXcbu4U14d8lRMREwcW
         euyEIfppMretd+EmQmSF0EdWlobgnK7ZrefOdUm2InXPdtEtQ2KbxAQfX/VwHP/EWhKf
         ZZ/g==
X-Gm-Message-State: AOAM533oVdBKmGkJK/coP5ZVPDdkw3tkP7D2/ZbrxPn4BJTb3aogcwrM
        e1mZ9bkGfCsO3VxuQ1UzTwkyddrU/fwrTg==
X-Google-Smtp-Source: ABdhPJx5ibsOiUjGZPXzeFyMzRej9b6rEyBXJUQniwBAJx+cQ7FXwIrWUESvNnJk+x553otxQIFJ+g==
X-Received: by 2002:a17:90a:8904:: with SMTP id u4mr1110067pjn.87.1598657534970;
        Fri, 28 Aug 2020 16:32:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id y13sm491326pfn.214.2020.08.28.16.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 16:32:14 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, peress@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/2] docs: abi: iio: Add event when offset changes
Date:   Fri, 28 Aug 2020 16:31:56 -0700
Message-Id: <20200828233156.2264689-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200828233156.2264689-1-gwendal@chromium.org>
References: <20200828233156.2264689-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some sensors/sensorhubs can calculate drift or hard iron offsets to
apply to raw data to get the true measure data.
These offsets are applied by the user space application.
When these offsets change, events are raised to tell the application
to update the cached offset values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 47df16c87862d..40da602e7a555 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1716,3 +1716,36 @@ Description:
 		Mass concentration reading of particulate matter in ug / m3.
 		pmX consists of particles with aerodynamic diameter less or
 		equal to X micrometers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_offset
+KernelVersion:	x.y
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Gyroscope drift calculated by the sensor. In addition to factory
+		calibration, sensor or sensorhub can
+		detect gyroscope drift and report it to userspace.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_offset
+KernelVersion:	x.y
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Hard Iron bias calculated by the sensor or sensorhub. To be applied by
+		user space application to the raw data to obtain the geomagnetic field.
+
+What:		/sys/.../iio:deviceX/events/in_accel_offset_change_en
+What:		/sys/.../iio:deviceX/events/in_magn_offset_change_en
+What:		/sys/.../iio:deviceX/events/in_magn_scale_change_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_offset_change_en
+KernelVersion:	x.y
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Some sensors internally calculate offset to apply to remove bias (for
+		instance, hard/soft-iron bias for magnetometer, online calibration bias for
+		gyroscope or accelerometer).
+		When the sensor computes a new set of offset values, it generates an
+		event for the userspace application to refresh the offsets to apply to raw
+		data.
-- 
2.28.0.402.g5ffc5be6b7-goog

