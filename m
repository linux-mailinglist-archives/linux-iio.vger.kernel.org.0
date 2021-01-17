Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3260C2F939B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 16:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbhAQPlc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 10:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbhAQPl0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 10:41:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDCAE22525;
        Sun, 17 Jan 2021 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610898036;
        bh=O7hLJi627+dzEbV8hGXUM+os9GMieFVg4UvUCiSkhps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuSTqxMlqV3R9ilHgJQNKRAaGJcwbPk1EdvgMBfEi0uMBMKLDed2ivbOjLmDqX63n
         WJvwJxfGsj93HlkylCpdeiapPdzXIORhsWkeQF3zeHv5b9FsDyTWG0wJMh5y0XXdK3
         Gk4L4m04Cb1Lf6cAujHKzVtsLiJZ18ven9GuRtyy9fBND4Z9X8eSqCKlbrwOrHeOGE
         CbrCkx+N2VY8fPh9yUuZG0R3vdPY0nWcZh4VUyLudJKtL74TUpn0yQLKPsTtQ3Ifnq
         kFZSWxBHBgjAHT1jw0zHAybVzGp9zY3N7aqt0o0hzFbDejbvBACsAfHs46KXHWPHwj
         qnA38ePSyoLTQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [RFC PATCH 1/7] iio:ABI docs: Fix up duplicate *_calibbias_* documentation for icm42600
Date:   Sun, 17 Jan 2021 15:38:10 +0000
Message-Id: <20210117153816.696693-2-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117153816.696693-1-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This device has the unusual characteristic that the calibbias values
have well defined units (more commonly they are tweaks to a DAC)
Unfortunately the previous approach of having more specific documentation
in sysfs-bus-iio-icm42600 results in warnings during the documentation
build and random ordering in the resulting documentation.

To avoid this, add a note to the main documentation on this special
characteristic for the icm42600.   The _available for calibbias was
missing from the main sysfs-bus-iio docs so also add that, allowing
us to drop the icm42600 specific file.

Fixes
$ scripts/get_abi.pl validate warning:
Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  ./Documentation/ABI/testing/sysfs-bus-iio:394
Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  ./Documentation/ABI/testing/sysfs-bus-iio:395
Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  ./Documentation/ABI/testing/sysfs-bus-iio:396
Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  ./Documentation/ABI/testing/sysfs-bus-iio:397
Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  ./Documentation/ABI/testing/sysfs-bus-iio:398
Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  ./Documentation/ABI/testing/sysfs-bus-iio:399

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio       | 13 ++++++++++++
 .../ABI/testing/sysfs-bus-iio-icm42600        | 20 -------------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d957f5da5c04..d2dd9cc280f9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -408,6 +408,19 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Hardware applied calibration offset (assumed to fix production
 		inaccuracies).
+		icm42600: For this device values are real physical offsets
+		expressed in SI units (m/s^2 for accelerometers and rad/s
+		for gyroscope)/
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
+KernelVersion:  5.8
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Available values of calibbias. Maybe expressed as either of:
+
+		- a small discrete set of values like "0 2 4 6 8"
+		- a range specified as "[min step max]"
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-icm42600 b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
deleted file mode 100644
index 0bf1fd4f5bf1..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-icm42600
+++ /dev/null
@@ -1,20 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
-KernelVersion:  5.8
-Contact:        linux-iio@vger.kernel.org
-Description:
-		Hardware applied calibration offset (assumed to fix production
-		inaccuracies). Values represent a real physical offset expressed
-		in SI units (m/s^2 for accelerometer and rad/s for gyroscope).
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
-What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
-KernelVersion:  5.8
-Contact:        linux-iio@vger.kernel.org
-Description:
-		Range of available values for hardware offset. Values in SI
-		units (m/s^2 for accelerometer and rad/s for gyroscope).
-- 
2.30.0

