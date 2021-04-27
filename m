Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA97D36C776
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhD0ODv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 10:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236306AbhD0ODu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 10:03:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A48FF6101B;
        Tue, 27 Apr 2021 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619532187;
        bh=fXv60qQ44m2dkDb5InkmbbYr24sfm+LfU8VfwqTHfVk=;
        h=From:To:Cc:Subject:Date:From;
        b=OeHiTjzv0BWEkNAHZGQueKYP92qpuDvyuDaJ6addj6LcgeQP+lhcoN0IA9M5PAmwB
         OcXBKOj8/wU840+FQTXna8y34sr72smNXnJdBpDbChmQhAu1wdxd/Su2kfAWr/ov79
         ORvitayZVzCPIKr0vRPj9ufRO0usiFv4l6MNE5WbZmzvoF83pe5ndH6FSTOnVt7mkH
         PgfmHxYaQqn4y9QcZxfMJunUz1NCtPQHwlLOXbadcu6zAFqa9ou+QldA8KsnQPrpBD
         rgUrQpHpRayLg4SLvcwm5MXilp9AQSD3Zkc3kS39uGZr0Xc3cHpsxMWYOm1+d/bNTu
         nd5WjMWlRB6hw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lbOIq-000s9k-Aw; Tue, 27 Apr 2021 16:03:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: Documentation: move incompatible ABI to obsolete
Date:   Tue, 27 Apr 2021 16:03:00 +0200
Message-Id: <a2c802049adee6a5710a58082cfdc1132c5e4c11.1619532170.git.mchehab+huawei@kernel.org>
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
 Documentation/ABI/obsolete/sysfs-bus-iio | 182 +++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-iio  |  82 ----------
 2 files changed, 182 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-bus-iio

diff --git a/Documentation/ABI/obsolete/sysfs-bus-iio b/Documentation/ABI/obsolete/sysfs-bus-iio
new file mode 100644
index 000000000000..c9531bb64816
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-bus-iio
@@ -0,0 +1,182 @@
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
+		Since kernel 5.11 the scan_elements attributes are merged into
+		the bufferY directory, to be configurable per buffer.
+
+What:		/sys/.../iio:deviceX/scan_elements/in_accel_type
+What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_type
+What:		/sys/.../iio:deviceX/scan_elements/in_magn_type
+What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
+What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_type
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_type
+What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_type
+What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_type
+What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
+What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
+What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
+What:		/sys/.../iio:deviceX/scan_elements/in_proximity_type
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Description of the scan element data storage within the buffer
+		and hence the form in which it is read from user-space.
+		Form is [be|le]:[s|u]bits/storagebits[>>shift].
+		be or le specifies big or little endian. s or u specifies if
+		signed (2's complement) or unsigned. bits is the number of bits
+		of data and storagebits is the space (after padding) that it
+		occupies in the buffer. shift if specified, is the shift that
+		needs to be applied prior to masking out unused bits. Some
+		devices put their data in the middle of the transferred elements
+		with additional information on both sides.  Note that some
+		devices will have additional information in the unused bits
+		so to get a clean value, the bits value must be used to mask
+		the buffer output value appropriately.  The storagebits value
+		also specifies the data alignment.  So s48/64>>2 will be a
+		signed 48 bit integer stored in a 64 bit location aligned to
+		a 64 bit boundary. To obtain the clean value, shift right 2
+		and apply a mask to zero the top 16 bits of the result.
+		For other storage combinations this attribute will be extended
+		appropriately.
+
+		Since kernel 5.11 the scan_elements attributes are merged into
+		the bufferY directory, to be configurable per buffer.
+
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_index
+What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_index
+What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_index
+What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_index
+What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
+What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
+What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
+What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_x_index
+What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_y_index
+What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_z_index
+What:		/sys/.../iio:deviceX/scan_elements/in_magn_x_index
+What:		/sys/.../iio:deviceX/scan_elements/in_magn_y_index
+What:		/sys/.../iio:deviceX/scan_elements/in_magn_z_index
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_index
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_index
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_tilt_comp_index
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_tilt_comp_index
+What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_index
+What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_index
+What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_index
+What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_index
+What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
+What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
+What:		/sys/.../iio:deviceX/scan_elements/in_proximity_index
+KernelVersion:	2.6.37
+Description:
+		A single positive integer specifying the position of this
+		scan element in the buffer. Note these are not dependent on
+		what is enabled and may not be contiguous. Thus for user-space
+		to establish the full layout these must be used in conjunction
+		with all _en attributes to establish which channels are present,
+		and the relevant _type attributes to establish the data storage
+		format.
+
+		Since kernel 5.11 the scan_elements attributes are merged into
+		the bufferY directory, to be configurable per buffer.
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
index 433fe0ab74be..1164e3779fd9 100644
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
@@ -1284,23 +1250,6 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Scan element control for triggered data capture.
 
-What:		/sys/.../iio:deviceX/scan_elements/in_accel_type
-What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_type
-What:		/sys/.../iio:deviceX/scan_elements/in_magn_type
-What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_type
-What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
-What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
-What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
-What:		/sys/.../iio:deviceX/scan_elements/in_proximity_type
-KernelVersion:	2.6.37
 What:		/sys/.../iio:deviceX/bufferY/in_accel_type
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_type
 What:		/sys/.../iio:deviceX/bufferY/in_magn_type
@@ -1347,33 +1296,6 @@ Description:
 		If the type parameter can take one of a small set of values,
 		this attribute lists them.
 
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_index
-What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
-What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
-What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
-What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_x_index
-What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_y_index
-What:		/sys/.../iio:deviceX/scan_elements/in_anglvel_z_index
-What:		/sys/.../iio:deviceX/scan_elements/in_magn_x_index
-What:		/sys/.../iio:deviceX/scan_elements/in_magn_y_index
-What:		/sys/.../iio:deviceX/scan_elements/in_magn_z_index
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_index
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_index
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_magnetic_tilt_comp_index
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_from_north_true_tilt_comp_index
-What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_index
-What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_index
-What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_index
-What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_index
-What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
-What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
-What:		/sys/.../iio:deviceX/scan_elements/in_proximity_index
-KernelVersion:	2.6.37
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_index
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_index
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_index
@@ -1613,8 +1535,6 @@ Description:
 		Specifies number of seconds in which we compute the steps
 		that occur in order to decide if the consumer is making steps.
 
-What:		/sys/bus/iio/devices/iio:deviceX/buffer/watermark
-KernelVersion:	4.2
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/watermark
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
@@ -1633,8 +1553,6 @@ Description:
 		the available samples after the timeout expires and thus have a
 		maximum delay guarantee.
 
-What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
-KernelVersion: 4.16
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/data_available
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
-- 
2.30.2

