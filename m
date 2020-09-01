Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49C2585EC
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 05:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIADAa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 23:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgIADA2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 23:00:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD2C06136D
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so4238935plt.3
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xA7zMgvbSPSI1M8jGUrZE1dR1JTsw20qn5fUvvb1NXA=;
        b=NJz55JOGstyiWrMUMrrQfF/fjZWC5FWn9g7auoKAiYH6BBpytDkT7piiVSmM4h1jMW
         XDRbZrKgM0dAhZq9hoqYr9g4JtEP/zCPd+Xyh8tmIMVrqMhFl+SnHhfvGujWw6TWuaRu
         SErIPHQBZxmtX9Gd6NdKm3boBvz1lxSy3c6YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xA7zMgvbSPSI1M8jGUrZE1dR1JTsw20qn5fUvvb1NXA=;
        b=gDAr0Y9fXH/BN3rRfBei2n/RI6NA+B1sfZjEwY8XSEzubMtA1ZEohD88npWBXVxSWp
         HvLBY9Rs3ZuThV+v8TbQgQsV6fb6QOZ41FwbU14j3M9z9ROA6MirvTF5a6bMleOAe1iA
         AutY+lg0nEU0TEAR+6zhkM2r9fFHvGgpFfYRAClBwPJ1J76kMg7BD2yhj9VRQJkC6rjr
         pw3S2JfvRa3E/XeQqW50XQ19fpifJGV5R+alAfp2jyLeigQpHPgjkWszS44fnbCsiUkD
         onNJ/1Woxac9u3nrUWvRCMDutvVfEGV1l0fVJCB4365GA31CcMqK42uBsd3uSP+ctQOG
         ozSg==
X-Gm-Message-State: AOAM530D5y7yafuupJaXOai18pb8aaJZhxUUmQ63Nx4nwrgAc2uFHth7
        KSQH9rk4LyYFuFg5cBoCH9TT4g==
X-Google-Smtp-Source: ABdhPJz4np7lcYjsVCX1jrsUIAkBQ+GzcvITuaQeulCHnblqnLyjRPIv+WtKyPVjIkxVFszgP/oqNg==
X-Received: by 2002:a17:902:b18e:: with SMTP id s14mr3467925plr.160.1598929227712;
        Mon, 31 Aug 2020 20:00:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id v18sm9248235pfu.15.2020.08.31.20.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 20:00:27 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, peress@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/3] Documentation: ABI: iio: Add offsets for some sensors
Date:   Mon, 31 Aug 2020 20:00:16 -0700
Message-Id: <20200901030017.3221295-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901030017.3221295-1-gwendal@chromium.org>
References: <20200901030017.3221295-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add offsets for magnetometer and gyroscope.
They can be use to represent online calibration to offset
hard iron or drift.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- New, split from 3/3 patch.
 Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 47df16c87862d..f77aee8886c66 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1716,3 +1716,22 @@ Description:
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
-- 
2.28.0.402.g5ffc5be6b7-goog

