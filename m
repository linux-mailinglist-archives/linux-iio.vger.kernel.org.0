Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D65E36C73A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbhD0NtM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 09:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237105AbhD0NtD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 09:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E51613DD;
        Tue, 27 Apr 2021 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619531299;
        bh=arZpyGkKTxsqqfpzWoktMt05ZPIZSfDGxgm4BT8YC+g=;
        h=From:To:Cc:Subject:Date:From;
        b=DoCEW9oMieN8/M9qkDs1P8T/BoyfuegQMozZpouwq6EDsVlOOmvA5bPk4DFPicKPk
         UB+NIp2fHVfIbimeGajXx01f5o8RfST3/Iz5eqs4pyJvqhW/fbIiV/SLOwOYJEcrxv
         +GDneH/6qtF+/ZqlIcf5VwPGqeftwfnbbhsk4vJUoHp5CX6kT49YwJXidt1nFoBEc9
         uYw4TloTdBJ33Qd7Y5lC+6SCalWS9RjmoKlxGDMfWp5G78D0HuSqxk0Mzv50vPLPXq
         zZ9txl3eUMxf/74A8RvCcxjhrCU7osfUjxyP0ZvnvtfdIXXp1DJNjdHnoY5uVSDNW1
         UiYKQ7xJemBLQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lbO4X-000rvv-6C; Tue, 27 Apr 2021 15:48:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] iio: Documentation: move incompatible ABI to obsolete
Date:   Tue, 27 Apr 2021 15:48:15 +0200
Message-Id: <46ba2895ffeae0dc86a8570e1b2c28a8c33cb20a.1619531276.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 63cd35f34d2e ("iio: Documentation: update definitions for bufferY and scan_elements")
updated iio documentation in order to point to the newly
per-buffer API, as it is now possible to support multi buffers.

While the previous ABI will be kept forever, the best is
for applications to use the 5.11+ ABI. So, move the
legacy one ABI/obsolete.

This fixes an issue with scripts/get_abi.pl, that doesn't
accept two different Kernel version support for the same
API set.

Fixes: 63cd35f34d2e ("iio: Documentation: update definitions for bufferY and scan_elements")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/obsolete/sysfs-bus-iio | 98 ++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-iio  | 38 ---------
 2 files changed, 98 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-bus-iio

diff --git a/Documentation/ABI/obsolete/sysfs-bus-iio b/Documentation/ABI/obsolete/sysfs-bus-iio
new file mode 100644
index 000000000000..e1ca7e7b1c4b
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-bus-iio
@@ -0,0 +1,98 @@
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/length
+KernelVersion:	2.6.35
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of scans contained by the buffer.
+
+		Since Kernel 5.11, multiple buffers are supported.
+		so, it is better to use, instead:
+			/sys/bus/iio/devices/iio:deviceX/bufferY/length
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/enable
+KernelVersion:	2.6.35
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Actually start the buffer capture up.  Will start trigger
+		if first device and appropriate.
+
+		Since Kernel 5.11, multiple buffers are supported.
+		so, it is better to use, instead:
+			/sys/bus/iio/devices/iio:deviceX/bufferY/enable
+
+What:		/sys/bus/iio/devices/iio:deviceX/scan_elements
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Directory containing interfaces for elements that will be
+		captured for a single triggered sample set in the buffer.
+
+		Since kernel 5.11 the scan_elements attributes are merged into
+		the bufferY directory, to be configurable per buffer.
+
+What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_en
+What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_en
+What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_en
+What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_x_en
+What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_y_en
+What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_z_en
+What:		/sys/.../iio:deviceX/scan_elements/in_magn_x_en
+What:		/sys/.../iio:deviceX/scan_elements/in_magn_y_en
+What:		/sys/.../iio:deviceX/scan_elements/in_magn_z_en
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_en
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_en
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_tilt_comp_en
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_tilt_comp_en
+What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_en
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_en
+What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_en
+What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_en
+What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
+What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
+What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
+What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
+What:		/sys/.../iio:deviceX/scan_elements/in_proximity_en
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scan element control for triggered data capture.
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/watermark
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A single positive integer specifying the maximum number of scan
+		elements to wait for.
+
+		Poll will block until the watermark is reached.
+
+		Blocking read will wait until the minimum between the requested
+		read amount or the low water mark is available.
+
+		Non-blocking read will retrieve the available samples from the
+		buffer even if there are less samples then watermark level. This
+		allows the application to block on poll with a timeout and read
+		the available samples after the timeout expires and thus have a
+		maximum delay guarantee.
+
+		Since Kernel 5.11, multiple buffers are supported.
+		so, it is better to use, instead:
+			/sys/bus/iio/devices/iio:deviceX/bufferY/watermark
+
+What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
+KernelVersion: 4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A read-only value indicating the bytes of data available in the
+		buffer. In the case of an output buffer, this indicates the
+		amount of empty space available to write data to. In the case of
+		an input buffer, this indicates the amount of data available for
+		reading.
+
+		Since Kernel 5.11, multiple buffers are supported.
+		so, it is better to use, instead:
+			/sys/bus/iio/devices/iio:deviceX/bufferY/data_available
diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 433fe0ab74be..03a09eda896f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1195,16 +1195,12 @@ Description:
 		The name of the trigger source being used, as per string given
 		in /sys/class/iio/triggerY/name.
 
-What:		/sys/bus/iio/devices/iio:deviceX/buffer/length
-KernelVersion:	2.6.35
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/length
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Number of scans contained by the buffer.
 
-What:		/sys/bus/iio/devices/iio:deviceX/buffer/enable
-KernelVersion:	2.6.35
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/enable
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
@@ -1212,8 +1208,6 @@ Description:
 		Actually start the buffer capture up.  Will start trigger
 		if first device and appropriate.
 
-What:		/sys/bus/iio/devices/iio:deviceX/scan_elements
-KernelVersion:	2.6.37
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
@@ -1224,34 +1218,6 @@ Description:
 		Since kernel 5.11 the scan_elements attributes are merged into
 		the bufferY directory, to be configurable per buffer.
 
-What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_en
-What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_en
-What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_en
-What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_x_en
-What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_y_en
-What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_z_en
-What:		/sys/.../iio:deviceX/scan_elements/in_magn_x_en
-What:		/sys/.../iio:deviceX/scan_elements/in_magn_y_en
-What:		/sys/.../iio:deviceX/scan_elements/in_magn_z_en
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_en
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_en
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_tilt_comp_en
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_tilt_comp_en
-What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_en
-What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
-What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
-What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
-What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
-What:		/sys/.../iio:deviceX/scan_elements/in_proximity_en
-KernelVersion:	2.6.37
 What:		/sys/.../iio:deviceX/bufferY/in_accel_x_en
 What:		/sys/.../iio:deviceX/bufferY/in_accel_y_en
 What:		/sys/.../iio:deviceX/bufferY/in_accel_z_en
@@ -1613,8 +1579,6 @@ Description:
 		Specifies number of seconds in which we compute the steps
 		that occur in order to decide if the consumer is making steps.
 
-What:		/sys/bus/iio/devices/iio:deviceX/buffer/watermark
-KernelVersion:	4.2
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/watermark
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
@@ -1633,8 +1597,6 @@ Description:
 		the available samples after the timeout expires and thus have a
 		maximum delay guarantee.
 
-What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
-KernelVersion: 4.16
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/data_available
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
-- 
2.30.2

