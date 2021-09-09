Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843CA4047F6
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhIIJqN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 05:46:13 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36729 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIJqM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Sep 2021 05:46:12 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 01C7F40017;
        Thu,  9 Sep 2021 09:45:00 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH v5 2/4] iio: ABI: docs: Document Senseair Sunrise ABI
Date:   Thu,  9 Sep 2021 11:45:35 +0200
Message-Id: <20210909094537.218064-3-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909094537.218064-1-jacopo@jmondi.org>
References: <20210909094537.218064-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the sysfs attributes of the sunrise_co2 driver.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 .../sysfs-bus-iio-chemical-sunrise-co2        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
new file mode 100644
index 000000000000..ee7aeb11709b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
@@ -0,0 +1,38 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_factory
+Date:		August 2021
+KernelVersion:	5.16
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Writing '1' triggers a 'Factory' calibration cycle.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_background
+Date:		August 2021
+KernelVersion:	5.16
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Writing '1' triggers a 'Background' calibration cycle.
+
+What:		/sys/bus/iio/devices/iio:deviceX/error_status_available
+Date:		August 2021
+KernelVersion:	5.16
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
+What:		/sys/bus/iio/devices/iio:deviceX/error_status
+Date:		August 2021
+KernelVersion:	5.16
+Contact:	Jacopo Mondi <jacopo@jmondi.org>
+Description:
+		Reading returns the current chip error status.
-- 
2.32.0

