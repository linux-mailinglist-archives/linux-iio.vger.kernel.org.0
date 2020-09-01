Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4682585ED
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 05:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIADAc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 23:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIADA3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 23:00:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574FC061379
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so961471pjd.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/zE6qh9ak4MHpyIajYfiuqVPANSyom2jAVJbqWmifc=;
        b=iD9simpUIyBXM8wi3JpTa7LDb2XdViklaq4BNCqnrKSepBWpOzBpJ9DOaJFfwBfiGg
         WePhgNXjDW8G0AioV008RaMHP6pVWGf16eUb95ktUtUOyyy4EowIV48iHS0cn8bCE0Wy
         0EB0G2qlGPv1DE+EEPPyJHN+Cr1C3ox0tuqoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/zE6qh9ak4MHpyIajYfiuqVPANSyom2jAVJbqWmifc=;
        b=Wal9D+ZEeEAhIBbh3B5OvbAw9pD1cfmZYI7exjWpy/psN3pe5qB26dnHEwEWPI+MM7
         hzxqQBYx/2y7mcZIj7fOv/XyGUGnLEgszwjJkiR2SoHYFc1Q5qGAJia+JTnfoYRtVt1X
         Z8DgNdrOKfUKQq81Abd8Rxte+Lz2PtajsnA13WGgf2UceZnTeub0LTTfvWTUzC6Et1p6
         LxwDmbZ1d8cLFg2x6gnuuw5NfeXRTGlWlI8ss45x3WTZkbVcDJafU7Zltli1rMEBPBnn
         PZL2O9P7zw01bTEFlbZnY0XR4s21c3CRPomowM2zIY2Se8eA3NakVIjtaqtWrlLUmqeJ
         EAqA==
X-Gm-Message-State: AOAM531iWbFo2HyeJDVXitFhNNYEvBI23TJhUmcXWF6wso5oKL+hnQ5F
        ieJEpNdxdjbD6t/Pr/GdwhFlkw==
X-Google-Smtp-Source: ABdhPJzpVlGMxI115SoCuztCnSuy97OYHHyZtXbKPC+fksbSEUGekHMZEkN7iqxPEtc86nPEwCNZbg==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr2204192pjb.174.1598929228834;
        Mon, 31 Aug 2020 20:00:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id b23sm9376306pfo.12.2020.08.31.20.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 20:00:28 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, peress@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 3/3] Documentation: ABI: iio: Add event when offset/scale changes
Date:   Mon, 31 Aug 2020 20:00:17 -0700
Message-Id: <20200901030017.3221295-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901030017.3221295-1-gwendal@chromium.org>
References: <20200901030017.3221295-1-gwendal@chromium.org>
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
Changes since v1:
- Define metadata_en instead of offset/scale_en to limit race
  conditions.
 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f77aee8886c66..45f456de1621a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1735,3 +1735,16 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Hard Iron bias calculated by the sensor or sensorhub. To be applied by
 		user space application to the raw data to obtain the geomagnetic field.
+
+What:		/sys/.../iio:deviceX/events/in_accel_metadata_change_en
+What:		/sys/.../iio:deviceX/events/in_magn_metadata_change_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_metadata_change_en
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

