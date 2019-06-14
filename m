Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD520451A7
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 04:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfFNCEe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Jun 2019 22:04:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFNCEe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jun 2019 22:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wwChL0u57V80b+m7BE36iMznKoitGRMJZ/DZcAfmpu8=; b=n1dOiiRYTKBC8miVo4iGTtP4/t
        fjuZXzejC4NdtTXRdw82kQtq236azGihN+krIAJjRpN6NAhFSG+sWeBJh0Se+GyhfBjtrxZ2PX3Fj
        c1HXu8MO0H7Vur5034RLNbaawfW/ij882bdVxOD7pMqoS933Kc1VZ7Quub6/Jz0LqMcg18vF8k6tg
        pcmQokSCx4bmrh13z6GYuAzYeCY+mircghNgct+aUvRp2OGddueDzHgESTLwyinaoXE4OydBsdCEH
        zD7Od4UukDt9gg10Hmektnx0ngVw97MvHOntBQbSJApf9R7ZodTuHKE1NOQEGKuTg8vYBAQ8raEJ+
        5jHawqww==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZv-0000EI-1X; Fri, 14 Jun 2019 02:04:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002nY-My; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-iio@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 01/14] ABI: fix some syntax issues at the ABI database
Date:   Thu, 13 Jun 2019 23:04:07 -0300
Message-Id: <b908fc6555df8cae3e4c734b2d5f6284c46a5f14.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

On those three files, the ABI representation described at
README are violated.

- at sysfs-bus-iio-proximity-as3935:
	a ':' character is missing after "What"

- at sysfs-class-devfreq:
	there's a typo at Description

- at sysfs-class-cxl, it is using the ":" character at a
	file preamble, causing it to be misinterpreted as a
	tag.

- On the other files, instead of "What", they use "Where".

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/testing/pstore              |  2 +-
 .../sysfs-bus-event_source-devices-format     |  2 +-
 .../ABI/testing/sysfs-bus-i2c-devices-hm6352  |  6 ++---
 .../ABI/testing/sysfs-bus-iio-distance-srf08  |  4 ++--
 .../testing/sysfs-bus-iio-proximity-as3935    |  4 ++--
 .../ABI/testing/sysfs-bus-pci-devices-cciss   | 22 +++++++++----------
 .../testing/sysfs-bus-usb-devices-usbsevseg   | 12 +++++-----
 Documentation/ABI/testing/sysfs-class-cxl     |  6 ++---
 Documentation/ABI/testing/sysfs-class-devfreq |  2 +-
 .../ABI/testing/sysfs-class-powercap          |  2 +-
 Documentation/ABI/testing/sysfs-kernel-fscaps |  2 +-
 .../ABI/testing/sysfs-kernel-vmcoreinfo       |  2 +-
 12 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
index 5fca9f5e10a3..8d6e48f4e8ef 100644
--- a/Documentation/ABI/testing/pstore
+++ b/Documentation/ABI/testing/pstore
@@ -1,4 +1,4 @@
-Where:		/sys/fs/pstore/... (or /dev/pstore/...)
+What:		/sys/fs/pstore/... (or /dev/pstore/...)
 Date:		March 2011
 Kernel Version: 2.6.39
 Contact:	tony.luck@intel.com
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
index 77f47ff5ee02..b6f8748e0200 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
@@ -1,4 +1,4 @@
-Where:		/sys/bus/event_source/devices/<dev>/format
+What:		/sys/bus/event_source/devices/<dev>/format
 Date:		January 2012
 Kernel Version: 3.3
 Contact:	Jiri Olsa <jolsa@redhat.com>
diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352 b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
index feb2e4a87075..29bd447e50a0 100644
--- a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
@@ -1,18 +1,18 @@
-Where:		/sys/bus/i2c/devices/.../heading0_input
+What:		/sys/bus/i2c/devices/.../heading0_input
 Date:		April 2010
 Kernel Version: 2.6.36?
 Contact:	alan.cox@intel.com
 Description:	Reports the current heading from the compass as a floating
 		point value in degrees.
 
-Where:		/sys/bus/i2c/devices/.../power_state
+What:		/sys/bus/i2c/devices/.../power_state
 Date:		April 2010
 Kernel Version: 2.6.36?
 Contact:	alan.cox@intel.com
 Description:	Sets the power state of the device. 0 sets the device into
 		sleep mode, 1 wakes it up.
 
-Where:		/sys/bus/i2c/devices/.../calibration
+What:		/sys/bus/i2c/devices/.../calibration
 Date:		April 2010
 Kernel Version: 2.6.36?
 Contact:	alan.cox@intel.com
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
index 0a1ca1487fa9..a133fd8d081a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
+++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
@@ -1,4 +1,4 @@
-What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
+What:		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
 Date:		January 2017
 KernelVersion:	4.11
 Contact:	linux-iio@vger.kernel.org
@@ -6,7 +6,7 @@ Description:
 		Show or set the gain boost of the amp, from 0-31 range.
 		default 31
 
-What		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
+What:		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
 Date:		January 2017
 KernelVersion:	4.11
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
index 9a17ab5036a4..c59d95346341 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
@@ -1,4 +1,4 @@
-What		/sys/bus/iio/devices/iio:deviceX/in_proximity_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_input
 Date:		March 2014
 KernelVersion:	3.15
 Contact:	Matt Ranostay <matt.ranostay@konsulko.com>
@@ -6,7 +6,7 @@ Description:
 		Get the current distance in meters of storm (1km steps)
 		1000-40000 = distance in meters
 
-What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
+What:		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
 Date:		March 2014
 KernelVersion:	3.15
 Contact:	Matt Ranostay <matt.ranostay@konsulko.com>
diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
index 53d99edd1d75..eb449169c30b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
@@ -1,66 +1,66 @@
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/model
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/model
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 model for logical drive
 		Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 revision for logical
 		drive Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 83 serial number for logical
 		drive Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 vendor for logical drive
 		Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
 Date:		March 2009
 Kernel Version: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	A symbolic link to /sys/block/cciss!cXdY
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/rescan
+What:		/sys/bus/pci/devices/<dev>/ccissX/rescan
 Date:		August 2009
 Kernel Version:	2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Kicks of a rescan of the controller to discover logical
 		drive topology changes.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
 Date:		August 2009
 Kernel Version: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the 8-byte LUN ID used to address logical
 		drive Y of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
 Date:		August 2009
 Kernel Version: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the RAID level of logical drive Y of
 		controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
+What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
 Date:		August 2009
 Kernel Version: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the usage count (number of opens) of logical drive Y
 		of controller X.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/resettable
+What:		/sys/bus/pci/devices/<dev>/ccissX/resettable
 Date:		February 2011
 Kernel Version:	2.6.38
 Contact:	iss_storagedev@hp.com
@@ -71,7 +71,7 @@ Description:	Value of 1 indicates the controller can honor the reset_devices
 		a dump device, as kdump requires resetting the device in order
 		to work reliably.
 
-Where:		/sys/bus/pci/devices/<dev>/ccissX/transport_mode
+What:		/sys/bus/pci/devices/<dev>/ccissX/transport_mode
 Date:		July 2011
 Kernel Version:	3.0
 Contact:	iss_storagedev@hp.com
diff --git a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
index 70d00dfa443d..f6199b314196 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
+++ b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
@@ -1,12 +1,12 @@
-Where:		/sys/bus/usb/.../powered
+What:		/sys/bus/usb/.../powered
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	Controls whether the device's display will powered.
 		A value of 0 is off and a non-zero value is on.
 
-Where:		/sys/bus/usb/.../mode_msb
-Where:		/sys/bus/usb/.../mode_lsb
+What:		/sys/bus/usb/.../mode_msb
+What:		/sys/bus/usb/.../mode_lsb
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
@@ -16,7 +16,7 @@ Description:	Controls the devices display mode.
 		for an 8 character display the values are
 			MSB 0x08; LSB 0xFF.
 
-Where:		/sys/bus/usb/.../textmode
+What:		/sys/bus/usb/.../textmode
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
@@ -25,13 +25,13 @@ Description:	Controls the way the device interprets its text buffer.
 		hex:	each character is between 0-15
 		ascii:	each character is between '0'-'9' and 'A'-'F'.
 
-Where:		/sys/bus/usb/.../text
+What:		/sys/bus/usb/.../text
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	The text (or data) for the device to display
 
-Where:		/sys/bus/usb/.../decimals
+What:		/sys/bus/usb/.../decimals
 Date:		August 2008
 Kernel Version:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index bbbabffc682a..fc7c6f7c21b3 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -1,6 +1,6 @@
-Note: Attributes that are shared between devices are stored in the directory
-pointed to by the symlink device/.
-Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
+Please notice that attributes that are shared between devices are stored in
+the directory pointed to by the symlink device/.
+For example, the real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
 /sys/class/cxl/afu0.0s/device/irqs_max, i.e. /sys/class/cxl/afu0.0/irqs_max.
 
 
diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index ee39acacf6f8..01196e19afca 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -47,7 +47,7 @@ Description:
 What:		/sys/class/devfreq/.../trans_stat
 Date:		October 2012
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
-Descrtiption:
+Description:
 		This ABI shows the statistics of devfreq behavior on a
 		specific device. It shows the time spent in each state and
 		the number of transitions between states.
diff --git a/Documentation/ABI/testing/sysfs-class-powercap b/Documentation/ABI/testing/sysfs-class-powercap
index db3b3ff70d84..f333a0ccc29b 100644
--- a/Documentation/ABI/testing/sysfs-class-powercap
+++ b/Documentation/ABI/testing/sysfs-class-powercap
@@ -147,6 +147,6 @@ What:		/sys/class/powercap/.../<power zone>/enabled
 Date:		September 2013
 KernelVersion:	3.13
 Contact:	linux-pm@vger.kernel.org
-Description
+Description:
 		This allows to enable/disable power capping at power zone level.
 		This applies to current power zone and its children.
diff --git a/Documentation/ABI/testing/sysfs-kernel-fscaps b/Documentation/ABI/testing/sysfs-kernel-fscaps
index 50a3033b5e15..bcff34665192 100644
--- a/Documentation/ABI/testing/sysfs-kernel-fscaps
+++ b/Documentation/ABI/testing/sysfs-kernel-fscaps
@@ -2,7 +2,7 @@ What:		/sys/kernel/fscaps
 Date:		February 2011
 KernelVersion:	2.6.38
 Contact:	Ludwig Nussel <ludwig.nussel@suse.de>
-Description
+Description:
 		Shows whether file system capabilities are honored
 		when executing a binary
 
diff --git a/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo b/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
index 7bd81168e063..1f1087a5f075 100644
--- a/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
+++ b/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
@@ -4,7 +4,7 @@ KernelVersion:	2.6.24
 Contact:	Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
 		Kexec Mailing List <kexec@lists.infradead.org>
 		Vivek Goyal <vgoyal@redhat.com>
-Description
+Description:
 		Shows physical address and size of vmcoreinfo ELF note.
 		First value contains physical address of note in hex and
 		second value contains the size of note in hex. This ELF
-- 
2.21.0

