Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68321411618
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhITNzI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 09:55:08 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:59427 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhITNzF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 09:55:05 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7D11C24000F;
        Mon, 20 Sep 2021 13:53:36 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-iio@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v6 2/4] iio: ABI: docs: Document Senseair Sunrise ABI
Date:   Mon, 20 Sep 2021 15:54:11 +0200
Message-Id: <20210920135413.140310-3-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920135413.140310-1-jacopo+renesas@jmondi.org>
References: <20210920135413.140310-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jacopo Mondi <jacopo@jmondi.org>

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

