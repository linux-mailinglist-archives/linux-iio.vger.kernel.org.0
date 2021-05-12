Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFF37BD2B
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 14:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhELMxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 08:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbhELMxB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 08:53:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB04A61442;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=Kk11vvdpqmF0cZ2tgc4BefQKiqLRAn74Q/I4wTEDIYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3TG62LaQojTzevTAiDOyoFReZbHD6UONh/GiH3E43mdHseOmujLbCoMVdjJWbsjg
         7kLOic67pSaUlHXnca7EozRVRvV2eiqKuYRwqYR1AjetOE+IKP5so8u1r/djbv2UCH
         +O8NbLRDJv64UHUlJcZBRGEPIGWOMdN1AKQzVZ6lpQzx+0bCplMJGB8yMY47bhwv0R
         wBjNoEkf+W8mNmAU6W0IPMPXa+vvU1bSyJ/124ZwU8bORrzfr1He5o/k6idLgIzjnW
         2ijqrpfBX9Pi6wI1RI7+DfQoA2zZomDBcckMCP8zyBUabchA5os0cEyL32bHpXvTO8
         uPNYI7fvDhWcQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018iA-VR; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mark O'Donovan" <shiftee@posteo.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/40] docs: hid: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:25 +0200
Message-Id: <c9241635fbc24fb8aeb205b2af05cfb710410226.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hid/hid-sensor.rst    |  70 ++++----
 Documentation/hid/intel-ish-hid.rst | 246 ++++++++++++++--------------
 2 files changed, 158 insertions(+), 158 deletions(-)

diff --git a/Documentation/hid/hid-sensor.rst b/Documentation/hid/hid-sensor.rst
index c1c9b8d8dca6..b98d7a415cda 100644
--- a/Documentation/hid/hid-sensor.rst
+++ b/Documentation/hid/hid-sensor.rst
@@ -173,39 +173,39 @@ An example of this representation on sysfs::
 
   /sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09FA.0001/HID-SENSOR-2000e1.6.auto$ tree -R
   .
-  │   ├──  enable_sensor
-  │   │   ├── feature-0-200316
-  │   │   │   ├── feature-0-200316-maximum
-  │   │   │   ├── feature-0-200316-minimum
-  │   │   │   ├── feature-0-200316-name
-  │   │   │   ├── feature-0-200316-size
-  │   │   │   ├── feature-0-200316-unit-expo
-  │   │   │   ├── feature-0-200316-units
-  │   │   │   ├── feature-0-200316-value
-  │   │   ├── feature-1-200201
-  │   │   │   ├── feature-1-200201-maximum
-  │   │   │   ├── feature-1-200201-minimum
-  │   │   │   ├── feature-1-200201-name
-  │   │   │   ├── feature-1-200201-size
-  │   │   │   ├── feature-1-200201-unit-expo
-  │   │   │   ├── feature-1-200201-units
-  │   │   │   ├── feature-1-200201-value
-  │   │   ├── input-0-200201
-  │   │   │   ├── input-0-200201-maximum
-  │   │   │   ├── input-0-200201-minimum
-  │   │   │   ├── input-0-200201-name
-  │   │   │   ├── input-0-200201-size
-  │   │   │   ├── input-0-200201-unit-expo
-  │   │   │   ├── input-0-200201-units
-  │   │   │   ├── input-0-200201-value
-  │   │   ├── input-1-200202
-  │   │   │   ├── input-1-200202-maximum
-  │   │   │   ├── input-1-200202-minimum
-  │   │   │   ├── input-1-200202-name
-  │   │   │   ├── input-1-200202-size
-  │   │   │   ├── input-1-200202-unit-expo
-  │   │   │   ├── input-1-200202-units
-  │   │   │   ├── input-1-200202-value
+  │   ├──  enable_sensor
+  │   │   ├── feature-0-200316
+  │   │   │   ├── feature-0-200316-maximum
+  │   │   │   ├── feature-0-200316-minimum
+  │   │   │   ├── feature-0-200316-name
+  │   │   │   ├── feature-0-200316-size
+  │   │   │   ├── feature-0-200316-unit-expo
+  │   │   │   ├── feature-0-200316-units
+  │   │   │   ├── feature-0-200316-value
+  │   │   ├── feature-1-200201
+  │   │   │   ├── feature-1-200201-maximum
+  │   │   │   ├── feature-1-200201-minimum
+  │   │   │   ├── feature-1-200201-name
+  │   │   │   ├── feature-1-200201-size
+  │   │   │   ├── feature-1-200201-unit-expo
+  │   │   │   ├── feature-1-200201-units
+  │   │   │   ├── feature-1-200201-value
+  │   │   ├── input-0-200201
+  │   │   │   ├── input-0-200201-maximum
+  │   │   │   ├── input-0-200201-minimum
+  │   │   │   ├── input-0-200201-name
+  │   │   │   ├── input-0-200201-size
+  │   │   │   ├── input-0-200201-unit-expo
+  │   │   │   ├── input-0-200201-units
+  │   │   │   ├── input-0-200201-value
+  │   │   ├── input-1-200202
+  │   │   │   ├── input-1-200202-maximum
+  │   │   │   ├── input-1-200202-minimum
+  │   │   │   ├── input-1-200202-name
+  │   │   │   ├── input-1-200202-size
+  │   │   │   ├── input-1-200202-unit-expo
+  │   │   │   ├── input-1-200202-units
+  │   │   │   ├── input-1-200202-value
 
 Here there is a custom sensor with four fields: two feature and two inputs.
 Each field is represented by a set of attributes. All fields except the "value"
@@ -234,8 +234,8 @@ Once enabled and powered on, sensor can report value using HID reports.
 These reports are pushed using misc device interface in a FIFO order::
 
 	/dev$ tree | grep HID-SENSOR-2000e1.6.auto
-	│   │   │   ├── 10:53 -> ../HID-SENSOR-2000e1.6.auto
-	│   ├──  HID-SENSOR-2000e1.6.auto
+	│   │   │   ├── 10:53 -> ../HID-SENSOR-2000e1.6.auto
+	│   ├──  HID-SENSOR-2000e1.6.auto
 
 Each report can be of variable length preceded by a header. This header
 consists of a 32-bit usage id, 64-bit time stamp and 32-bit length field of raw
diff --git a/Documentation/hid/intel-ish-hid.rst b/Documentation/hid/intel-ish-hid.rst
index 7a851252267a..a525cdefc937 100644
--- a/Documentation/hid/intel-ish-hid.rst
+++ b/Documentation/hid/intel-ish-hid.rst
@@ -355,133 +355,133 @@ To debug ISH, event tracing mechanism is used. To enable debug logs::
   root@otcpl-ThinkPad-Yoga-260:~# tree -l /sys/bus/iio/devices/
   /sys/bus/iio/devices/
   ├── iio:device0 -> ../../../devices/0044:8086:22D8.0001/HID-SENSOR-200073.9.auto/iio:device0
-  │   ├── buffer
-  │   │   ├── enable
-  │   │   ├── length
-  │   │   └── watermark
+  │   ├── buffer
+  │   │   ├── enable
+  │   │   ├── length
+  │   │   └── watermark
   ...
-  │   ├── in_accel_hysteresis
-  │   ├── in_accel_offset
-  │   ├── in_accel_sampling_frequency
-  │   ├── in_accel_scale
-  │   ├── in_accel_x_raw
-  │   ├── in_accel_y_raw
-  │   ├── in_accel_z_raw
-  │   ├── name
-  │   ├── scan_elements
-  │   │   ├── in_accel_x_en
-  │   │   ├── in_accel_x_index
-  │   │   ├── in_accel_x_type
-  │   │   ├── in_accel_y_en
-  │   │   ├── in_accel_y_index
-  │   │   ├── in_accel_y_type
-  │   │   ├── in_accel_z_en
-  │   │   ├── in_accel_z_index
-  │   │   └── in_accel_z_type
+  │   ├── in_accel_hysteresis
+  │   ├── in_accel_offset
+  │   ├── in_accel_sampling_frequency
+  │   ├── in_accel_scale
+  │   ├── in_accel_x_raw
+  │   ├── in_accel_y_raw
+  │   ├── in_accel_z_raw
+  │   ├── name
+  │   ├── scan_elements
+  │   │   ├── in_accel_x_en
+  │   │   ├── in_accel_x_index
+  │   │   ├── in_accel_x_type
+  │   │   ├── in_accel_y_en
+  │   │   ├── in_accel_y_index
+  │   │   ├── in_accel_y_type
+  │   │   ├── in_accel_z_en
+  │   │   ├── in_accel_z_index
+  │   │   └── in_accel_z_type
   ...
-  │   │   ├── devices
-  │   │   │   │   ├── buffer
-  │   │   │   │   │   ├── enable
-  │   │   │   │   │   ├── length
-  │   │   │   │   │   └── watermark
-  │   │   │   │   ├── dev
-  │   │   │   │   ├── in_intensity_both_raw
-  │   │   │   │   ├── in_intensity_hysteresis
-  │   │   │   │   ├── in_intensity_offset
-  │   │   │   │   ├── in_intensity_sampling_frequency
-  │   │   │   │   ├── in_intensity_scale
-  │   │   │   │   ├── name
-  │   │   │   │   ├── scan_elements
-  │   │   │   │   │   ├── in_intensity_both_en
-  │   │   │   │   │   ├── in_intensity_both_index
-  │   │   │   │   │   └── in_intensity_both_type
-  │   │   │   │   ├── trigger
-  │   │   │   │   │   └── current_trigger
+  │   │   ├── devices
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_intensity_both_raw
+  │   │   │   │   ├── in_intensity_hysteresis
+  │   │   │   │   ├── in_intensity_offset
+  │   │   │   │   ├── in_intensity_sampling_frequency
+  │   │   │   │   ├── in_intensity_scale
+  │   │   │   │   ├── name
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_intensity_both_en
+  │   │   │   │   │   ├── in_intensity_both_index
+  │   │   │   │   │   └── in_intensity_both_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
   ...
-  │   │   │   │   ├── buffer
-  │   │   │   │   │   ├── enable
-  │   │   │   │   │   ├── length
-  │   │   │   │   │   └── watermark
-  │   │   │   │   ├── dev
-  │   │   │   │   ├── in_magn_hysteresis
-  │   │   │   │   ├── in_magn_offset
-  │   │   │   │   ├── in_magn_sampling_frequency
-  │   │   │   │   ├── in_magn_scale
-  │   │   │   │   ├── in_magn_x_raw
-  │   │   │   │   ├── in_magn_y_raw
-  │   │   │   │   ├── in_magn_z_raw
-  │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_raw
-  │   │   │   │   ├── in_rot_hysteresis
-  │   │   │   │   ├── in_rot_offset
-  │   │   │   │   ├── in_rot_sampling_frequency
-  │   │   │   │   ├── in_rot_scale
-  │   │   │   │   ├── name
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_magn_hysteresis
+  │   │   │   │   ├── in_magn_offset
+  │   │   │   │   ├── in_magn_sampling_frequency
+  │   │   │   │   ├── in_magn_scale
+  │   │   │   │   ├── in_magn_x_raw
+  │   │   │   │   ├── in_magn_y_raw
+  │   │   │   │   ├── in_magn_z_raw
+  │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_raw
+  │   │   │   │   ├── in_rot_hysteresis
+  │   │   │   │   ├── in_rot_offset
+  │   │   │   │   ├── in_rot_sampling_frequency
+  │   │   │   │   ├── in_rot_scale
+  │   │   │   │   ├── name
   ...
-  │   │   │   │   ├── scan_elements
-  │   │   │   │   │   ├── in_magn_x_en
-  │   │   │   │   │   ├── in_magn_x_index
-  │   │   │   │   │   ├── in_magn_x_type
-  │   │   │   │   │   ├── in_magn_y_en
-  │   │   │   │   │   ├── in_magn_y_index
-  │   │   │   │   │   ├── in_magn_y_type
-  │   │   │   │   │   ├── in_magn_z_en
-  │   │   │   │   │   ├── in_magn_z_index
-  │   │   │   │   │   ├── in_magn_z_type
-  │   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_en
-  │   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_index
-  │   │   │   │   │   └── in_rot_from_north_magnetic_tilt_comp_type
-  │   │   │   │   ├── trigger
-  │   │   │   │   │   └── current_trigger
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_magn_x_en
+  │   │   │   │   │   ├── in_magn_x_index
+  │   │   │   │   │   ├── in_magn_x_type
+  │   │   │   │   │   ├── in_magn_y_en
+  │   │   │   │   │   ├── in_magn_y_index
+  │   │   │   │   │   ├── in_magn_y_type
+  │   │   │   │   │   ├── in_magn_z_en
+  │   │   │   │   │   ├── in_magn_z_index
+  │   │   │   │   │   ├── in_magn_z_type
+  │   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_en
+  │   │   │   │   │   ├── in_rot_from_north_magnetic_tilt_comp_index
+  │   │   │   │   │   └── in_rot_from_north_magnetic_tilt_comp_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
   ...
-  │   │   │   │   ├── buffer
-  │   │   │   │   │   ├── enable
-  │   │   │   │   │   ├── length
-  │   │   │   │   │   └── watermark
-  │   │   │   │   ├── dev
-  │   │   │   │   ├── in_anglvel_hysteresis
-  │   │   │   │   ├── in_anglvel_offset
-  │   │   │   │   ├── in_anglvel_sampling_frequency
-  │   │   │   │   ├── in_anglvel_scale
-  │   │   │   │   ├── in_anglvel_x_raw
-  │   │   │   │   ├── in_anglvel_y_raw
-  │   │   │   │   ├── in_anglvel_z_raw
-  │   │   │   │   ├── name
-  │   │   │   │   ├── scan_elements
-  │   │   │   │   │   ├── in_anglvel_x_en
-  │   │   │   │   │   ├── in_anglvel_x_index
-  │   │   │   │   │   ├── in_anglvel_x_type
-  │   │   │   │   │   ├── in_anglvel_y_en
-  │   │   │   │   │   ├── in_anglvel_y_index
-  │   │   │   │   │   ├── in_anglvel_y_type
-  │   │   │   │   │   ├── in_anglvel_z_en
-  │   │   │   │   │   ├── in_anglvel_z_index
-  │   │   │   │   │   └── in_anglvel_z_type
-  │   │   │   │   ├── trigger
-  │   │   │   │   │   └── current_trigger
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_anglvel_hysteresis
+  │   │   │   │   ├── in_anglvel_offset
+  │   │   │   │   ├── in_anglvel_sampling_frequency
+  │   │   │   │   ├── in_anglvel_scale
+  │   │   │   │   ├── in_anglvel_x_raw
+  │   │   │   │   ├── in_anglvel_y_raw
+  │   │   │   │   ├── in_anglvel_z_raw
+  │   │   │   │   ├── name
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_anglvel_x_en
+  │   │   │   │   │   ├── in_anglvel_x_index
+  │   │   │   │   │   ├── in_anglvel_x_type
+  │   │   │   │   │   ├── in_anglvel_y_en
+  │   │   │   │   │   ├── in_anglvel_y_index
+  │   │   │   │   │   ├── in_anglvel_y_type
+  │   │   │   │   │   ├── in_anglvel_z_en
+  │   │   │   │   │   ├── in_anglvel_z_index
+  │   │   │   │   │   └── in_anglvel_z_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
   ...
-  │   │   │   │   ├── buffer
-  │   │   │   │   │   ├── enable
-  │   │   │   │   │   ├── length
-  │   │   │   │   │   └── watermark
-  │   │   │   │   ├── dev
-  │   │   │   │   ├── in_anglvel_hysteresis
-  │   │   │   │   ├── in_anglvel_offset
-  │   │   │   │   ├── in_anglvel_sampling_frequency
-  │   │   │   │   ├── in_anglvel_scale
-  │   │   │   │   ├── in_anglvel_x_raw
-  │   │   │   │   ├── in_anglvel_y_raw
-  │   │   │   │   ├── in_anglvel_z_raw
-  │   │   │   │   ├── name
-  │   │   │   │   ├── scan_elements
-  │   │   │   │   │   ├── in_anglvel_x_en
-  │   │   │   │   │   ├── in_anglvel_x_index
-  │   │   │   │   │   ├── in_anglvel_x_type
-  │   │   │   │   │   ├── in_anglvel_y_en
-  │   │   │   │   │   ├── in_anglvel_y_index
-  │   │   │   │   │   ├── in_anglvel_y_type
-  │   │   │   │   │   ├── in_anglvel_z_en
-  │   │   │   │   │   ├── in_anglvel_z_index
-  │   │   │   │   │   └── in_anglvel_z_type
-  │   │   │   │   ├── trigger
-  │   │   │   │   │   └── current_trigger
+  │   │   │   │   ├── buffer
+  │   │   │   │   │   ├── enable
+  │   │   │   │   │   ├── length
+  │   │   │   │   │   └── watermark
+  │   │   │   │   ├── dev
+  │   │   │   │   ├── in_anglvel_hysteresis
+  │   │   │   │   ├── in_anglvel_offset
+  │   │   │   │   ├── in_anglvel_sampling_frequency
+  │   │   │   │   ├── in_anglvel_scale
+  │   │   │   │   ├── in_anglvel_x_raw
+  │   │   │   │   ├── in_anglvel_y_raw
+  │   │   │   │   ├── in_anglvel_z_raw
+  │   │   │   │   ├── name
+  │   │   │   │   ├── scan_elements
+  │   │   │   │   │   ├── in_anglvel_x_en
+  │   │   │   │   │   ├── in_anglvel_x_index
+  │   │   │   │   │   ├── in_anglvel_x_type
+  │   │   │   │   │   ├── in_anglvel_y_en
+  │   │   │   │   │   ├── in_anglvel_y_index
+  │   │   │   │   │   ├── in_anglvel_y_type
+  │   │   │   │   │   ├── in_anglvel_z_en
+  │   │   │   │   │   ├── in_anglvel_z_index
+  │   │   │   │   │   └── in_anglvel_z_type
+  │   │   │   │   ├── trigger
+  │   │   │   │   │   └── current_trigger
   ...
-- 
2.30.2

