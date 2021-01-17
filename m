Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CA32F93A0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 16:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbhAQPmK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 10:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbhAQPmH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 10:42:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C22D2256F;
        Sun, 17 Jan 2021 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610898044;
        bh=nLroq6lXD74xciguW29RFGRm/iC3bKK63GvLxq4IASM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMqcjRx+PcdrqFLlZ2lI4M+hLwA4uoGUY1GzNPbt0X4yB7dHWToyl4l6cYloZzjiK
         nfZLvPqHE47wGP6cQbitFb+qiEjYLcyO7WuMhlcJuUtY+cdRPrzHGZTNsiKUwx9eNT
         t8Ex5weQrO02SVkOvbUkB1PYeNQMfTeMT5cCjdwwOnwCkbhrrpZfSvKktge3MZDGik
         eHC8eQJCflp89lmBTNVSf+FgIjAWl/dZ0uJGmEHXqOseiMT6wRwxyvx47inw+E4pJE
         fQ+Iv8rQ3vrxc6BJnjgXtaoaChoQN2NPEYP2GY3M3K1TQuOo4YulLG/H214xF1cfQS
         UkiIA14kqZ3Ow==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [RFC PATCH 6/7] iio:ABI docs: Combine the two instances of docs for sensor_sensitivity
Date:   Sun, 17 Jan 2021 15:38:15 +0000
Message-Id: <20210117153816.696693-7-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117153816.696693-1-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This control on the gain of a measurement used for time of flight sensing
is standard but the expected values for different enviroments may not be.
As we cannot have the same ABI element documented in two files, add a
generic version to sysfs-bus-iio-proximity and a note on the expected
value vs measuring environment for the as3935.

Fixes:
$ scripts/get_abi.pl validate
Warning: /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-distance-srf08:0  ./Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935:8

Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../ABI/testing/sysfs-bus-iio-distance-srf08       |  8 --------
 Documentation/ABI/testing/sysfs-bus-iio-proximity  | 14 ++++++++++++++
 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |  9 ---------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
index 40df5c9fef99..9dae94aa880b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
+++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
@@ -1,11 +1,3 @@
-What:		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
-Date:		January 2017
-KernelVersion:	4.11
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Show or set the gain boost of the amp, from 0-31 range.
-		default 31
-
 What:		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
 Date:		January 2017
 KernelVersion:	4.11
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity b/Documentation/ABI/testing/sysfs-bus-iio-proximity
index 2172f3bb9c64..3aac6dab8775 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-proximity
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity
@@ -8,3 +8,17 @@ Description:
 		considered close to the device. If the value read from the
 		sensor is above or equal to the value in this file an object
 		should typically be considered near.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
+Date:		March 2014
+KernelVersion:	3.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Proximity sensors sometimes have a controllable amplifier
+		on the signal from which time of flight measurements are
+		taken.
+		The appropriate values to take is dependent on both the
+		sensor and it's operating environment:
+		* as3935 (0-31 range)
+		18 = indoors (default)
+		14 = outdoors
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
index c59d95346341..1e5c40775a6c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
@@ -6,15 +6,6 @@ Description:
 		Get the current distance in meters of storm (1km steps)
 		1000-40000 = distance in meters
 
-What:		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
-Date:		March 2014
-KernelVersion:	3.15
-Contact:	Matt Ranostay <matt.ranostay@konsulko.com>
-Description:
-		Show or set the gain boost of the amp, from 0-31 range.
-		18 = indoors (default)
-		14 = outdoors
-
 What		/sys/bus/iio/devices/iio:deviceX/noise_level_tripped
 Date:		May 2017
 KernelVersion:	4.13
-- 
2.30.0

