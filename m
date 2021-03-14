Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918CA33A77A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhCNSSV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234033AbhCNSSF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:18:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBCA964EC6;
        Sun, 14 Mar 2021 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745884;
        bh=3PT22OLX3s76KG/CyNotJU5m2kHns0IWrKbE2893HgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6bA6WpR4CBukupf9VcADOP+y6VcLG5NjLfuc6xOdmzvJQhy1Vr2fa9iQxcDuuuef
         RkDD3P80f5bEDDTDHH8Azaty6msACuhH3wWxsHRoD5n1LLHdD7VV74gwe1AOKhvjZb
         TMZiIcHKsqYf4mP3ruX9xNXMQELf6Y/GJw/kKa3USHG7FVMa+YgEcZHzsmCNVa1iSZ
         DHRK2ovjhs+vgfNBFBvOOYY9c6BIIZaGSUe2PW+BRG6Weyror7G+UCqGkgxITHImvr
         5YJptVQy9/R0QEOWKUbLtnLZqnmqYURqPX/HC5cUZVDV7w7FtJAHNR6UTUC10ehKhz
         PeP44cIRfZ/qA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 21/24] iio:Documentation:ABI Add missing elements as used by the adi,ad7150
Date:   Sun, 14 Mar 2021 18:15:08 +0000
Message-Id: <20210314181511.531414-22-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
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
Link: https://lore.kernel.org/r/20210207154623.433442-23-jic23@kernel.org
---
 Documentation/ABI/testing/sysfs-bus-iio | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index affd4ce871d7..32d26c118141 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -371,6 +371,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -702,6 +703,8 @@ What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_either_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -779,6 +782,32 @@ Description:
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
@@ -819,6 +848,10 @@ What:		/sys/.../events/in_proximity0_thresh_falling_value
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
2.30.2

