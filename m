Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49407312599
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBGPux (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBGPuw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC0AE64E61;
        Sun,  7 Feb 2021 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712956;
        bh=QxN68hL0r4dralFNejSlqzW5AefIyMLW6iP4TOtvLOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA0CDmrnAyVUboSeZeM0y7pIr7q7jyyw99pVmutdZO3rndvX/auHZMDKqYBHNb7g/
         QAtj838FQ/ItWBu7BogBA5K/DxM7+kO4x1cHi6ggG3cYfJiUbXCumc1Z4Cr25gr+fO
         lKgSrpYEFYf/Lruj2gMGvYJTV2Uw9j/cfYP45AFcRleRC+15FmpromyxV7AY+O+kUm
         styNbUsy2X9bDKcIcJYdMYO7sLzzXLMLGQupfW/fKk/++4Wyj3mJ9OAN40cjv8AdnN
         I93vzH8wYIRWJtPznXEixkOzBDv7hO35AFEbBN/+1ty+qY7ROipf/F5AXxVgoKiqk6
         RGc9ax4CbZh9g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 22/24] iio:Documentation:ABI Add missing elements as used by the adi,ad7150
Date:   Sun,  7 Feb 2021 15:46:21 +0000
Message-Id: <20210207154623.433442-23-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Main additions are around thresh_adaptive.  This has been supported
by the core of IIO for a long time, but no driver that uses it has
previously graduated from staging, hence we are missing Docs.

Otherwise, just new entries in existing lists.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 35289d47d6cb..e3b9878ea7f9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -324,6 +324,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -655,6 +656,8 @@ What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_either_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -732,6 +735,32 @@ Description:
 		a given event type is enabled a future point (and not those for
 		whatever event was previously enabled).
 
+What:		/sys/.../events/in_capacitanceY_adaptive_thresh_rising_en
+What:		/sys/.../events/in_capacitanceY_adaptive_thresh_falling_en
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Descrption:
+		Adaptive thresholds are similar to normal fixed thresholds
+		but the value is expressed as an offset from a value which
+		provides a low frequency approximation of the channel itself.
+		Thus these detect if a rapid change occurs in the specified
+		direction which crosses tracking value + offset.
+		Tracking value calculation is devices specific.
+
+What:		/sys/.../in_capacitanceY_adaptive_thresh_rising_timeout
+What:		/sys/.../in_capacitanceY_adaptive_thresh_falling_timeout
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Descrption:
+		When adaptive thresholds are used, the tracking signal
+		may adjust too slowly to step changes in the raw signal.
+		*_timeout (in seconds) specifies a time for which the
+		difference between the slow tracking signal and the raw
+		signal is allowed to remain out-of-range before a reset
+		event occurs in which the tracking signal is made equal
+		to the raw signal, allowing slow tracking to resume and the
+		adaptive threshold event detection to function as expected.
+
 What:		/sys/.../events/in_accel_thresh_rising_value
 What:		/sys/.../events/in_accel_thresh_falling_value
 What:		/sys/.../events/in_accel_x_raw_thresh_rising_value
@@ -772,6 +801,10 @@ What:		/sys/.../events/in_proximity0_thresh_falling_value
 What:		/sys/.../events/in_proximity0_thresh_rising_value
 What:		/sys/.../events/in_illuminance_thresh_rising_value
 What:		/sys/.../events/in_illuminance_thresh_falling_value
+What:		/sys/.../events/in_capacitanceY_thresh_rising_value
+What:		/sys/.../events/in_capacitanceY_thresh_falling_value
+What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
+What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.30.0

