Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400C331259A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBGPux (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhBGPuw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F8564E65;
        Sun,  7 Feb 2021 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712960;
        bh=scFiQPxMn0cCNmI3U1ZLThe6T0Bz7rFe6CjK29e9cPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvTGEhphardT7gVKkZkiMQgON2PLQ2dZ/nlRx4UZAF7gKnR9/K/grPtTIxOaQQoBg
         k5zWwKIOkW6bLOsmLdguP5dYfekITbaiyz6P0o6EHyJM+Zz5v5Bp+gvziVHxtyhg04
         cbsiBnJDviJFnh3MQoL7AQ7AXuJGqzqWhbV8HM75oZBfTk+QIeA2k0yHOpvXRKQmc+
         9myPihn3QGu+zQbUyJj21KCZQ5buRFErT5G0V90JPuJs2h8FCIq9+wQyN7XrVz7FYf
         dFC1sSQ8yYP15KY7K73pOUJi0sDq7xSJxpfWFoxJMSMywqyd8DKsQRNYcG5bQftTLS
         HJcFXmYVV+j8A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 24/24] iio:cdc:ad7150: Move driver out of staging.
Date:   Sun,  7 Feb 2021 15:46:23 +0000
Message-Id: <20210207154623.433442-25-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This capacitance to digital converter (CDC) driver is compliant with
the IIO ABI.  Note, not all features supported (e.g. window event modes)
but the driver should be in a useful functional state.

The cleanup was done against QEMU emulation of the device rather than
actual hardware.   Whilst this was a bit of an experiment, it made it
easy to confirm that the driver remained in a consistent working state
through the various refactors.  If it worked in the first place, it
should still be working after this cleanup.

Given some IIO drivers require expensive hardware setups, (not particularly
true with this one) the use of QEMU may provide a viable way forward
for providing testing during code changes where previously we'd had
to rely on sharp eyes and crossed fingers.

Note, no explicit MAINTAINERS entry as it will be covered by the
generic catch-alls for ADI and IIO drivers which are sufficient.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/Kconfig                    |  1 +
 drivers/iio/Makefile                   |  1 +
 drivers/iio/cdc/Kconfig                | 17 +++++++++++++++++
 drivers/iio/cdc/Makefile               |  6 ++++++
 drivers/{staging => }/iio/cdc/ad7150.c |  0
 drivers/staging/iio/cdc/Kconfig        | 10 ----------
 drivers/staging/iio/cdc/Makefile       |  3 +--
 7 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 267553386c71..a5c47300e5a0 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -72,6 +72,7 @@ source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
+source "drivers/iio/cdc/Kconfig"
 source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
 source "drivers/iio/dac/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 1712011c0f4a..1cb1434b86b2 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -18,6 +18,7 @@ obj-y += adc/
 obj-y += afe/
 obj-y += amplifiers/
 obj-y += buffer/
+obj-y += cdc/
 obj-y += chemical/
 obj-y += common/
 obj-y += dac/
diff --git a/drivers/iio/cdc/Kconfig b/drivers/iio/cdc/Kconfig
new file mode 100644
index 000000000000..5e3319a3ff48
--- /dev/null
+++ b/drivers/iio/cdc/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# CDC drivers
+#
+menu "Capacitance to digital converters"
+
+config AD7150
+	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (ad7150, ad7151, ad7156) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7150.
+
+endmenu
diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
new file mode 100644
index 000000000000..ee490637b032
--- /dev/null
+++ b/drivers/iio/cdc/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O capacitance to digital converter (CDC) drivers
+#
+
+obj-$(CONFIG_AD7150) += ad7150.o
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
similarity index 100%
rename from drivers/staging/iio/cdc/ad7150.c
rename to drivers/iio/cdc/ad7150.c
diff --git a/drivers/staging/iio/cdc/Kconfig b/drivers/staging/iio/cdc/Kconfig
index e0a5ce66a984..a7386bbbcb79 100644
--- a/drivers/staging/iio/cdc/Kconfig
+++ b/drivers/staging/iio/cdc/Kconfig
@@ -4,16 +4,6 @@
 #
 menu "Capacitance to digital converters"
 
-config AD7150
-	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (ad7150, ad7151, ad7156) Provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7150.
-
 config AD7746
 	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
 	depends on I2C
diff --git a/drivers/staging/iio/cdc/Makefile b/drivers/staging/iio/cdc/Makefile
index ab8222579e7e..afb7499a7090 100644
--- a/drivers/staging/iio/cdc/Makefile
+++ b/drivers/staging/iio/cdc/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for industrial I/O DAC drivers
+# Makefile for industrial I/O CDC drivers
 #
 
-obj-$(CONFIG_AD7150) += ad7150.o
 obj-$(CONFIG_AD7746) += ad7746.o
-- 
2.30.0

