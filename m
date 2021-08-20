Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE43F2D41
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 15:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhHTNi3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 09:38:29 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41833 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhHTNi3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 09:38:29 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 18FB724000B;
        Fri, 20 Aug 2021 13:37:48 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 3/3] iio: ABI: docs: Document Senseair Sunrise ABI
Date:   Fri, 20 Aug 2021 15:38:21 +0200
Message-Id: <20210820133821.159239-4-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820133821.159239-1-jacopo@jmondi.org>
References: <20210820133821.159239-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the sysfs attributes of the sunrise_co2 driver.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 .../sysfs-bus-iio-chemical-sunrise-co2        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
new file mode 100644
index 000000000000..1a252f616652
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
@@ -0,0 +1,51 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_calibration_mode_available
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Reading returns the list of the possible calibration modes.
+		Available options:
+		- 'factory_calibration': Restore factory calibration
+		- 'background_calibration': Calibration using target value
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_mode
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Reading returns the currently selected calibration mode.
+		Writing sets the desired calibration mode to one of the values
+		returned by 'in_concentration_calibration_mode_available'
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Writing '1' triggers a calibration cycle according to the mode
+		set int 'in_concentration_co2_calibration_mode'.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_error_status_available
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Reading returns the list of possible chip error status.
+		Available options are:
+		- 'error_fatal': Analog front-end initialization error
+		- 'error_i2c': Read/write to non-existing register
+		- 'error_algorithm': Corrupted parameters
+		- 'error_calibration': Calibration has failed
+		- 'error_self_diagnostic': Internal interface failure
+		- 'error_out_of_range': Measured concentration out of scale
+		- 'error_memory': Error during memory operations
+		- 'error_no_measurement': Cleared at first measurement
+		- 'error_low_voltage': Sensor regulated voltage too low
+		- 'error_measurement_timeout': Unable to complete measurement
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_error_status
+Date:		August 2021
+KernelVersion:
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Reading returns the current chip error status.
-- 
2.32.0

