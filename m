Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27E2585EE
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 05:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIADAd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 23:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgIADA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 23:00:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A4C061366
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s2so954289pjr.4
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=139M2MKwaZAFODTk1bpLDAYfiuB+nhOuPU+D7YUXrms=;
        b=ioyOcDbcijUw0uR0N/78zCmMqhJHFHRttFf91uFTXJOuVur8u6YPq3hS13sro7q2k3
         kmNWe5kbawXWqwNMFyZ1f2fnpdDa/nitYOxaGJARfGq5XsUEeaQBjn5tIEQWwCY1SkrL
         X2kc/ATbZRE2IompbAJ0fdLuY765rW1rdFNk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=139M2MKwaZAFODTk1bpLDAYfiuB+nhOuPU+D7YUXrms=;
        b=m/eG5MFQHj8fGKlirjqk4YanaP/ZBggwb6wJbvh8g929tl9IJzjrhzycVxaJ5231iL
         x2tce69nqZaEtnAo8l7ThGhDBDNvYAjElpkRIB1fakeVIFQN5xt9BHSQFK8MpFGVUnYb
         fvbcZcxrcJ0yw6pKBqmxMT4bzWTRyo9a9JqS6/iSFpX6WSPsce3KcqPMVXLeNgBf90LR
         AXQeoDzRPcxmJcqxkkaExtlXYJIkqwBRSs6zUPWsyDHjPhEt1FEf6rbFP5LJMD1c/KoO
         D4M049ytW7ZermuD+jlx30bBkSpOpGeI9K29Nkh5VL0s1tmSH/E5/HQou02pZ138HsDj
         1dGA==
X-Gm-Message-State: AOAM530dmYaEgIcjZm4hdv5iCdSybMpbpOz6wd2l+JHiS0+cJDaWa8NK
        iDne1rV++VNIKiQ33npKd7Mr+A==
X-Google-Smtp-Source: ABdhPJwm5hOJXt5JYnj/hCo8XjCqwwxlnqrTOZWrnWoU7l5SmiWiJnbI5DjMd/4Y2X4HwRTvUMRypw==
X-Received: by 2002:a17:902:720a:: with SMTP id ba10mr3500038plb.41.1598929226564;
        Mon, 31 Aug 2020 20:00:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id g9sm5305521pfo.144.2020.08.31.20.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 20:00:26 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, peress@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/3] Documentation: ABI: iio: Use What: consistently
Date:   Mon, 31 Aug 2020 20:00:15 -0700
Message-Id: <20200901030017.3221295-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901030017.3221295-1-gwendal@chromium.org>
References: <20200901030017.3221295-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change "[w|W]hat[:| ]" to What: for consistency.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes since v1
 Documentation/ABI/testing/sysfs-bus-iio | 48 ++++++++++++-------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c3767d4d01a6f..47df16c87862d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -401,21 +401,21 @@ Description:
 		Hardware applied calibration offset (assumed to fix production
 		inaccuracies).
 
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
-what		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
-what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
@@ -483,7 +483,7 @@ Description:
 		If a discrete set of scale values is available, they
 		are listed in this attribute.
 
-What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
@@ -750,9 +750,9 @@ What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
 What:		/sys/.../events/in_tempY_raw_thresh_rising_value
 What:		/sys/.../events/in_tempY_raw_thresh_falling_value
 What:		/sys/.../events/in_illuminance0_thresh_falling_value
-what:		/sys/.../events/in_illuminance0_thresh_rising_value
-what:		/sys/.../events/in_proximity0_thresh_falling_value
-what:		/sys/.../events/in_proximity0_thresh_rising_value
+What:		/sys/.../events/in_illuminance0_thresh_rising_value
+What:		/sys/.../events/in_proximity0_thresh_falling_value
+What:		/sys/.../events/in_proximity0_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -830,11 +830,11 @@ What:		/sys/.../events/in_tempY_thresh_rising_hysteresis
 What:		/sys/.../events/in_tempY_thresh_falling_hysteresis
 What:		/sys/.../events/in_tempY_thresh_either_hysteresis
 What:		/sys/.../events/in_illuminance0_thresh_falling_hysteresis
-what:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
-what:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
-what:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
-what:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
-what:		/sys/.../events/in_proximity0_thresh_either_hysteresis
+What:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
+What:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
+What:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
+What:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
+What:		/sys/.../events/in_proximity0_thresh_either_hysteresis
 KernelVersion:	3.13
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.28.0.402.g5ffc5be6b7-goog

