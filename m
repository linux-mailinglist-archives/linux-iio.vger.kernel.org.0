Return-Path: <linux-iio+bounces-497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413D7FDDE9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672361C209E0
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CEB3C6AB;
	Wed, 29 Nov 2023 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Pimi2j8r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC43B6;
	Wed, 29 Nov 2023 09:04:37 -0800 (PST)
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 39A1A28F040;
	Wed, 29 Nov 2023 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701277476;
	bh=mNl0R8sUlYHgeQCJtRI4DeETQ6B494w2vyu4bpO6UzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pimi2j8ruAV51RYJcMEJ3vfQSFYN9gdEC1+bFa2P6+pOxNVAC/umAShwZroXSu0ca
	 5uCP6lgYdX4wGxzVdMhCTSRPTmZp8m83IzMjAzj0WvFSfAnCk6luGuV3k+SxKCrer0
	 g7vpLt2+NoRkbUWeGRTcq4+yBm3ue8NFqW1idwRQ=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Date: Wed, 29 Nov 2023 19:04:12 +0200
Message-ID: <20231129170425.3562-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129170425.3562-1-petre.rodan@subdimension.ro>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds driver for digital Honeywell TruStability HSC and SSC series
pressure and temperature sensors.
Communication is one way. The sensor only requires 4 bytes worth of
clock pulses on both i2c and spi in order to push the data out.
The i2c address is hardcoded and depends on the part number.
There is no additional GPIO control.

Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2: - No change
v3: huge cleanup based on Andy's review. Thanks!
    - fixed pressure offset calculation for differential sensors
    - rename driver from honeywell,hsc to honeywell,hsc030pa
v4: modifications based on Jonathan Cameron's review. Thanks!
    - rename hsc_*_xfer() to hsc_*_recv()
    - struct style changes
    - bus driver only contains bus specific bits and bobs
    - add alignment for SPI buffer
v5: modifications based on Andy's review
    - fix indentation
    - use function pointer typedef instead of explicit declaration
v6: modifications based on Andy's review
    - use str_has_prefix(), match_string() instead of strncmp()
---
 MAINTAINERS                         |   7 +
 drivers/iio/pressure/Kconfig        |  22 ++
 drivers/iio/pressure/Makefile       |   3 +
 drivers/iio/pressure/hsc030pa.c     | 497 ++++++++++++++++++++++++++++
 drivers/iio/pressure/hsc030pa.h     |  78 +++++
 drivers/iio/pressure/hsc030pa_i2c.c |  71 ++++
 drivers/iio/pressure/hsc030pa_spi.c |  62 ++++
 7 files changed, 740 insertions(+)
 create mode 100644 drivers/iio/pressure/hsc030pa.c
 create mode 100644 drivers/iio/pressure/hsc030pa.h
 create mode 100644 drivers/iio/pressure/hsc030pa_i2c.c
 create mode 100644 drivers/iio/pressure/hsc030pa_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 012df8ccf34e..6f993ee69d1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9702,6 +9702,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
+M:	Petre Rodan <petre.rodan@subdimension.ro>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
+F:	drivers/iio/pressure/hsc030pa*
+
 HONEYWELL MPRLS0025PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 95efa32e4289..79adfd059c3a 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -109,6 +109,28 @@ config HP03
 	  To compile this driver as a module, choose M here: the module
 	  will be called hp03.
 
+config HSC030PA
+	tristate "Honeywell HSC/SSC TruStability pressure sensor series"
+	depends on (I2C || SPI_MASTER)
+	select HSC030PA_I2C if I2C
+	select HSC030PA_SPI if SPI_MASTER
+	help
+	  Say Y here to build support for the Honeywell TruStability
+	  HSC and SSC pressure and temperature sensor series.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hsc030pa.
+
+config HSC030PA_I2C
+	tristate
+	depends on HSC030PA
+	depends on I2C
+
+config HSC030PA_SPI
+	tristate
+	depends on HSC030PA
+	depends on SPI_MASTER
+
 config ICP10100
 	tristate "InvenSense ICP-101xx pressure and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 436aec7e65f3..b0f8b94662f2 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -15,6 +15,9 @@ obj-$(CONFIG_DPS310) += dps310.o
 obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
+obj-$(CONFIG_HSC030PA) += hsc030pa.o
+obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
+obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
 obj-$(CONFIG_ICP10100) += icp10100.o
 obj-$(CONFIG_MPL115) += mpl115.o
 obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
new file mode 100644
index 000000000000..d25dafa137d0
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/unaligned.h>
+
+#include "hsc030pa.h"
+
+/*
+ * HSC_PRESSURE_TRIPLET_LEN - length for the string that defines the
+ * pressure range, measurement unit and type as per the part nomenclature.
+ * Consult honeywell,pressure-triplet in the bindings file for details.
+ */
+#define HSC_PRESSURE_TRIPLET_LEN 6
+#define HSC_STATUS_MASK          GENMASK(7, 6)
+#define HSC_TEMPERATURE_MASK     GENMASK(15, 5)
+#define HSC_PRESSURE_MASK        GENMASK(29, 16)
+
+struct hsc_func_spec {
+	u32 output_min;
+	u32 output_max;
+};
+
+/*
+ * function A: 10% - 90% of 2^14
+ * function B:  5% - 95% of 2^14
+ * function C:  5% - 85% of 2^14
+ * function F:  4% - 94% of 2^14
+ */
+static const struct hsc_func_spec hsc_func_spec[] = {
+	[HSC_FUNCTION_A] = { .output_min = 1638, .output_max = 14746 },
+	[HSC_FUNCTION_B] = { .output_min =  819, .output_max = 15565 },
+	[HSC_FUNCTION_C] = { .output_min =  819, .output_max = 13926 },
+	[HSC_FUNCTION_F] = { .output_min =  655, .output_max = 15401 },
+};
+
+enum hsc_variants {
+	HSC001BA = 0x0, HSC1_6BA = 0x1, HSC2_5BA = 0x2, HSC004BA = 0x3,
+	HSC006BA = 0x4, HSC010BA = 0x5, HSC1_6MD = 0x6, HSC2_5MD = 0x7,
+	HSC004MD = 0x8, HSC006MD = 0x9, HSC010MD = 0xa, HSC016MD = 0xb,
+	HSC025MD = 0xc, HSC040MD = 0xd, HSC060MD = 0xe, HSC100MD = 0xf,
+	HSC160MD = 0x10, HSC250MD = 0x11, HSC400MD = 0x12, HSC600MD = 0x13,
+	HSC001BD = 0x14, HSC1_6BD = 0x15, HSC2_5BD = 0x16, HSC004BD = 0x17,
+	HSC2_5MG = 0x18, HSC004MG = 0x19, HSC006MG = 0x1a, HSC010MG = 0x1b,
+	HSC016MG = 0x1c, HSC025MG = 0x1d, HSC040MG = 0x1e, HSC060MG = 0x1f,
+	HSC100MG = 0x20, HSC160MG = 0x21, HSC250MG = 0x22, HSC400MG = 0x23,
+	HSC600MG = 0x24, HSC001BG = 0x25, HSC1_6BG = 0x26, HSC2_5BG = 0x27,
+	HSC004BG = 0x28, HSC006BG = 0x29, HSC010BG = 0x2a, HSC100KA = 0x2b,
+	HSC160KA = 0x2c, HSC250KA = 0x2d, HSC400KA = 0x2e, HSC600KA = 0x2f,
+	HSC001GA = 0x30, HSC160LD = 0x31, HSC250LD = 0x32, HSC400LD = 0x33,
+	HSC600LD = 0x34, HSC001KD = 0x35, HSC1_6KD = 0x36, HSC2_5KD = 0x37,
+	HSC004KD = 0x38, HSC006KD = 0x39, HSC010KD = 0x3a, HSC016KD = 0x3b,
+	HSC025KD = 0x3c, HSC040KD = 0x3d, HSC060KD = 0x3e, HSC100KD = 0x3f,
+	HSC160KD = 0x40, HSC250KD = 0x41, HSC400KD = 0x42, HSC250LG = 0x43,
+	HSC400LG = 0x44, HSC600LG = 0x45, HSC001KG = 0x46, HSC1_6KG = 0x47,
+	HSC2_5KG = 0x48, HSC004KG = 0x49, HSC006KG = 0x4a, HSC010KG = 0x4b,
+	HSC016KG = 0x4c, HSC025KG = 0x4d, HSC040KG = 0x4e, HSC060KG = 0x4f,
+	HSC100KG = 0x50, HSC160KG = 0x51, HSC250KG = 0x52, HSC400KG = 0x53,
+	HSC600KG = 0x54, HSC001GG = 0x55, HSC015PA = 0x56, HSC030PA = 0x57,
+	HSC060PA = 0x58, HSC100PA = 0x59, HSC150PA = 0x5a, HSC0_5ND = 0x5b,
+	HSC001ND = 0x5c, HSC002ND = 0x5d, HSC004ND = 0x5e, HSC005ND = 0x5f,
+	HSC010ND = 0x60, HSC020ND = 0x61, HSC030ND = 0x62, HSC001PD = 0x63,
+	HSC005PD = 0x64, HSC015PD = 0x65, HSC030PD = 0x66, HSC060PD = 0x67,
+	HSC001NG = 0x68, HSC002NG = 0x69, HSC004NG = 0x6a, HSC005NG = 0x6b,
+	HSC010NG = 0x6c, HSC020NG = 0x6d, HSC030NG = 0x6e, HSC001PG = 0x6f,
+	HSC005PG = 0x70, HSC015PG = 0x71, HSC030PG = 0x72, HSC060PG = 0x73,
+	HSC100PG = 0x74, HSC150PG = 0x75, HSC_VARIANTS_MAX
+};
+
+static const char * const hsc_triplet_variants[HSC_VARIANTS_MAX] = {
+	[HSC001BA] = "001BA", [HSC1_6BA] = "1.6BA", [HSC2_5BA] = "2.5BA",
+	[HSC004BA] = "004BA", [HSC006BA] = "006BA", [HSC010BA] = "010BA",
+	[HSC1_6MD] = "1.6MD", [HSC2_5MD] = "2.5MD", [HSC004MD] = "004MD",
+	[HSC006MD] = "006MD", [HSC010MD] = "010MD", [HSC016MD] = "016MD",
+	[HSC025MD] = "025MD", [HSC040MD] = "040MD", [HSC060MD] = "060MD",
+	[HSC100MD] = "100MD", [HSC160MD] = "160MD", [HSC250MD] = "250MD",
+	[HSC400MD] = "400MD", [HSC600MD] = "600MD", [HSC001BD] = "001BD",
+	[HSC1_6BD] = "1.6BD", [HSC2_5BD] = "2.5BD", [HSC004BD] = "004BD",
+	[HSC2_5MG] = "2.5MG", [HSC004MG] = "004MG", [HSC006MG] = "006MG",
+	[HSC010MG] = "010MG", [HSC016MG] = "016MG", [HSC025MG] = "025MG",
+	[HSC040MG] = "040MG", [HSC060MG] = "060MG", [HSC100MG] = "100MG",
+	[HSC160MG] = "160MG", [HSC250MG] = "250MG", [HSC400MG] = "400MG",
+	[HSC600MG] = "600MG", [HSC001BG] = "001BG", [HSC1_6BG] = "1.6BG",
+	[HSC2_5BG] = "2.5BG", [HSC004BG] = "004BG", [HSC006BG] = "006BG",
+	[HSC010BG] = "010BG", [HSC100KA] = "100KA", [HSC160KA] = "160KA",
+	[HSC250KA] = "250KA", [HSC400KA] = "400KA", [HSC600KA] = "600KA",
+	[HSC001GA] = "001GA", [HSC160LD] = "160LD", [HSC250LD] = "250LD",
+	[HSC400LD] = "400LD", [HSC600LD] = "600LD", [HSC001KD] = "001KD",
+	[HSC1_6KD] = "1.6KD", [HSC2_5KD] = "2.5KD", [HSC004KD] = "004KD",
+	[HSC006KD] = "006KD", [HSC010KD] = "010KD", [HSC016KD] = "016KD",
+	[HSC025KD] = "025KD", [HSC040KD] = "040KD", [HSC060KD] = "060KD",
+	[HSC100KD] = "100KD", [HSC160KD] = "160KD", [HSC250KD] = "250KD",
+	[HSC400KD] = "400KD", [HSC250LG] = "250LG", [HSC400LG] = "400LG",
+	[HSC600LG] = "600LG", [HSC001KG] = "001KG", [HSC1_6KG] = "1.6KG",
+	[HSC2_5KG] = "2.5KG", [HSC004KG] = "004KG", [HSC006KG] = "006KG",
+	[HSC010KG] = "010KG", [HSC016KG] = "016KG", [HSC025KG] = "025KG",
+	[HSC040KG] = "040KG", [HSC060KG] = "060KG", [HSC100KG] = "100KG",
+	[HSC160KG] = "160KG", [HSC250KG] = "250KG", [HSC400KG] = "400KG",
+	[HSC600KG] = "600KG", [HSC001GG] = "001GG", [HSC015PA] = "015PA",
+	[HSC030PA] = "030PA", [HSC060PA] = "060PA", [HSC100PA] = "100PA",
+	[HSC150PA] = "150PA", [HSC0_5ND] = "0.5ND", [HSC001ND] = "001ND",
+	[HSC002ND] = "002ND", [HSC004ND] = "004ND", [HSC005ND] = "005ND",
+	[HSC010ND] = "010ND", [HSC020ND] = "020ND", [HSC030ND] = "030ND",
+	[HSC001PD] = "001PD", [HSC005PD] = "005PD", [HSC015PD] = "015PD",
+	[HSC030PD] = "030PD", [HSC060PD] = "060PD", [HSC001NG] = "001NG",
+	[HSC002NG] = "002NG", [HSC004NG] = "004NG", [HSC005NG] = "005NG",
+	[HSC010NG] = "010NG", [HSC020NG] = "020NG", [HSC030NG] = "030NG",
+	[HSC001PG] = "001PG", [HSC005PG] = "005PG", [HSC015PG] = "015PG",
+	[HSC030PG] = "030PG", [HSC060PG] = "060PG", [HSC100PG] = "100PG",
+	[HSC150PG] = "150PG",
+};
+
+/**
+ * struct hsc_range_config - list of pressure ranges based on nomenclature
+ * @pmin: lowest pressure that can be measured
+ * @pmax: highest pressure that can be measured
+ */
+struct hsc_range_config {
+	const s32 pmin;
+	const s32 pmax;
+};
+
+/* All min max limits have been converted to pascals */
+static const struct hsc_range_config hsc_range_config[HSC_VARIANTS_MAX] = {
+	[HSC001BA] = { .pmin =       0, .pmax =  100000 },
+	[HSC1_6BA] = { .pmin =       0, .pmax =  160000 },
+	[HSC2_5BA] = { .pmin =       0, .pmax =  250000 },
+	[HSC004BA] = { .pmin =       0, .pmax =  400000 },
+	[HSC006BA] = { .pmin =       0, .pmax =  600000 },
+	[HSC010BA] = { .pmin =       0, .pmax = 1000000 },
+	[HSC1_6MD] = { .pmin =    -160, .pmax =     160 },
+	[HSC2_5MD] = { .pmin =    -250, .pmax =     250 },
+	[HSC004MD] = { .pmin =    -400, .pmax =     400 },
+	[HSC006MD] = { .pmin =    -600, .pmax =     600 },
+	[HSC010MD] = { .pmin =   -1000, .pmax =    1000 },
+	[HSC016MD] = { .pmin =   -1600, .pmax =    1600 },
+	[HSC025MD] = { .pmin =   -2500, .pmax =    2500 },
+	[HSC040MD] = { .pmin =   -4000, .pmax =    4000 },
+	[HSC060MD] = { .pmin =   -6000, .pmax =    6000 },
+	[HSC100MD] = { .pmin =  -10000, .pmax =   10000 },
+	[HSC160MD] = { .pmin =  -16000, .pmax =   16000 },
+	[HSC250MD] = { .pmin =  -25000, .pmax =   25000 },
+	[HSC400MD] = { .pmin =  -40000, .pmax =   40000 },
+	[HSC600MD] = { .pmin =  -60000, .pmax =   60000 },
+	[HSC001BD] = { .pmin = -100000, .pmax =  100000 },
+	[HSC1_6BD] = { .pmin = -160000, .pmax =  160000 },
+	[HSC2_5BD] = { .pmin = -250000, .pmax =  250000 },
+	[HSC004BD] = { .pmin = -400000, .pmax =  400000 },
+	[HSC2_5MG] = { .pmin =       0, .pmax =     250 },
+	[HSC004MG] = { .pmin =       0, .pmax =     400 },
+	[HSC006MG] = { .pmin =       0, .pmax =     600 },
+	[HSC010MG] = { .pmin =       0, .pmax =    1000 },
+	[HSC016MG] = { .pmin =       0, .pmax =    1600 },
+	[HSC025MG] = { .pmin =       0, .pmax =    2500 },
+	[HSC040MG] = { .pmin =       0, .pmax =    4000 },
+	[HSC060MG] = { .pmin =       0, .pmax =    6000 },
+	[HSC100MG] = { .pmin =       0, .pmax =   10000 },
+	[HSC160MG] = { .pmin =       0, .pmax =   16000 },
+	[HSC250MG] = { .pmin =       0, .pmax =   25000 },
+	[HSC400MG] = { .pmin =       0, .pmax =   40000 },
+	[HSC600MG] = { .pmin =       0, .pmax =   60000 },
+	[HSC001BG] = { .pmin =       0, .pmax =  100000 },
+	[HSC1_6BG] = { .pmin =       0, .pmax =  160000 },
+	[HSC2_5BG] = { .pmin =       0, .pmax =  250000 },
+	[HSC004BG] = { .pmin =       0, .pmax =  400000 },
+	[HSC006BG] = { .pmin =       0, .pmax =  600000 },
+	[HSC010BG] = { .pmin =       0, .pmax = 1000000 },
+	[HSC100KA] = { .pmin =       0, .pmax =  100000 },
+	[HSC160KA] = { .pmin =       0, .pmax =  160000 },
+	[HSC250KA] = { .pmin =       0, .pmax =  250000 },
+	[HSC400KA] = { .pmin =       0, .pmax =  400000 },
+	[HSC600KA] = { .pmin =       0, .pmax =  600000 },
+	[HSC001GA] = { .pmin =       0, .pmax = 1000000 },
+	[HSC160LD] = { .pmin =    -160, .pmax =     160 },
+	[HSC250LD] = { .pmin =    -250, .pmax =     250 },
+	[HSC400LD] = { .pmin =    -400, .pmax =     400 },
+	[HSC600LD] = { .pmin =    -600, .pmax =     600 },
+	[HSC001KD] = { .pmin =   -1000, .pmax =    1000 },
+	[HSC1_6KD] = { .pmin =   -1600, .pmax =    1600 },
+	[HSC2_5KD] = { .pmin =   -2500, .pmax =    2500 },
+	[HSC004KD] = { .pmin =   -4000, .pmax =    4000 },
+	[HSC006KD] = { .pmin =   -6000, .pmax =    6000 },
+	[HSC010KD] = { .pmin =  -10000, .pmax =   10000 },
+	[HSC016KD] = { .pmin =  -16000, .pmax =   16000 },
+	[HSC025KD] = { .pmin =  -25000, .pmax =   25000 },
+	[HSC040KD] = { .pmin =  -40000, .pmax =   40000 },
+	[HSC060KD] = { .pmin =  -60000, .pmax =   60000 },
+	[HSC100KD] = { .pmin = -100000, .pmax =  100000 },
+	[HSC160KD] = { .pmin = -160000, .pmax =  160000 },
+	[HSC250KD] = { .pmin = -250000, .pmax =  250000 },
+	[HSC400KD] = { .pmin = -400000, .pmax =  400000 },
+	[HSC250LG] = { .pmin =       0, .pmax =     250 },
+	[HSC400LG] = { .pmin =       0, .pmax =     400 },
+	[HSC600LG] = { .pmin =       0, .pmax =     600 },
+	[HSC001KG] = { .pmin =       0, .pmax =    1000 },
+	[HSC1_6KG] = { .pmin =       0, .pmax =    1600 },
+	[HSC2_5KG] = { .pmin =       0, .pmax =    2500 },
+	[HSC004KG] = { .pmin =       0, .pmax =    4000 },
+	[HSC006KG] = { .pmin =       0, .pmax =    6000 },
+	[HSC010KG] = { .pmin =       0, .pmax =   10000 },
+	[HSC016KG] = { .pmin =       0, .pmax =   16000 },
+	[HSC025KG] = { .pmin =       0, .pmax =   25000 },
+	[HSC040KG] = { .pmin =       0, .pmax =   40000 },
+	[HSC060KG] = { .pmin =       0, .pmax =   60000 },
+	[HSC100KG] = { .pmin =       0, .pmax =  100000 },
+	[HSC160KG] = { .pmin =       0, .pmax =  160000 },
+	[HSC250KG] = { .pmin =       0, .pmax =  250000 },
+	[HSC400KG] = { .pmin =       0, .pmax =  400000 },
+	[HSC600KG] = { .pmin =       0, .pmax =  600000 },
+	[HSC001GG] = { .pmin =       0, .pmax = 1000000 },
+	[HSC015PA] = { .pmin =       0, .pmax =  103421 },
+	[HSC030PA] = { .pmin =       0, .pmax =  206843 },
+	[HSC060PA] = { .pmin =       0, .pmax =  413685 },
+	[HSC100PA] = { .pmin =       0, .pmax =  689476 },
+	[HSC150PA] = { .pmin =       0, .pmax = 1034214 },
+	[HSC0_5ND] = { .pmin =    -125, .pmax =     125 },
+	[HSC001ND] = { .pmin =    -249, .pmax =     249 },
+	[HSC002ND] = { .pmin =    -498, .pmax =     498 },
+	[HSC004ND] = { .pmin =    -996, .pmax =     996 },
+	[HSC005ND] = { .pmin =   -1245, .pmax =    1245 },
+	[HSC010ND] = { .pmin =   -2491, .pmax =    2491 },
+	[HSC020ND] = { .pmin =   -4982, .pmax =    4982 },
+	[HSC030ND] = { .pmin =   -7473, .pmax =    7473 },
+	[HSC001PD] = { .pmin =   -6895, .pmax =    6895 },
+	[HSC005PD] = { .pmin =  -34474, .pmax =   34474 },
+	[HSC015PD] = { .pmin = -103421, .pmax =  103421 },
+	[HSC030PD] = { .pmin = -206843, .pmax =  206843 },
+	[HSC060PD] = { .pmin = -413685, .pmax =  413685 },
+	[HSC001NG] = { .pmin =       0, .pmax =     249 },
+	[HSC002NG] = { .pmin =       0, .pmax =     498 },
+	[HSC004NG] = { .pmin =       0, .pmax =     996 },
+	[HSC005NG] = { .pmin =       0, .pmax =    1245 },
+	[HSC010NG] = { .pmin =       0, .pmax =    2491 },
+	[HSC020NG] = { .pmin =       0, .pmax =    4982 },
+	[HSC030NG] = { .pmin =       0, .pmax =    7473 },
+	[HSC001PG] = { .pmin =       0, .pmax =    6895 },
+	[HSC005PG] = { .pmin =       0, .pmax =   34474 },
+	[HSC015PG] = { .pmin =       0, .pmax =  103421 },
+	[HSC030PG] = { .pmin =       0, .pmax =  206843 },
+	[HSC060PG] = { .pmin =       0, .pmax =  413685 },
+	[HSC100PG] = { .pmin =       0, .pmax =  689476 },
+	[HSC150PG] = { .pmin =       0, .pmax = 1034214 },
+};
+
+/*
+ * hsc_measurement_is_valid() - validate last conversion via status bits
+ * @data: structure containing instantiated sensor data
+ * Return: true only if both status bits are zero
+ *
+ * the two MSB from the first transfered byte contain a status code
+ *   00 - normal operation, valid data
+ *   01 - device in factory programming mode
+ *   10 - stale data
+ *   11 - diagnostic condition
+ */
+static bool hsc_measurement_is_valid(struct hsc_data *data)
+{
+	return !(data->buffer[0] & HSC_STATUS_MASK);
+}
+
+static int hsc_get_measurement(struct hsc_data *data)
+{
+	const struct hsc_chip_data *chip = data->chip;
+	int ret;
+
+	guard(mutex)(&data->lock);
+	ret = data->recv_cb(data);
+	if (ret < 0)
+		return ret;
+
+	data->is_valid = chip->valid(data);
+	if (!data->is_valid)
+		return -EAGAIN;
+
+	return 0;
+}
+
+/*
+ * IIO ABI expects
+ * value = (conv + offset) * scale
+ *
+ * datasheet provides the following formula for determining the temperature
+ * temp[C] = conv * a + b
+ *   where a = 200/2047; b = -50
+ *
+ *  temp[C] = (conv + (b/a)) * a * (1000)
+ *  =>
+ *  scale = a * 1000 = .097703957 * 1000 = 97.703957
+ *  offset = b/a = -50 / .097703957 = -50000000 / 97704
+ *
+ *  based on the datasheet
+ *  pressure = (conv - Omin) * Q + Pmin =
+ *          ((conv - Omin) + Pmin/Q) * Q
+ *  =>
+ *  scale = Q = (Pmax - Pmin) / (Omax - Omin)
+ *  offset = Pmin/Q - Omin = Pmin * (Omax - Omin) / (Pmax - Pmin) - Omin
+ */
+static int hsc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *channel, int *val,
+			int *val2, long mask)
+{
+	struct hsc_data *data = iio_priv(indio_dev);
+	int ret;
+	u32 recvd;
+	int raw;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = hsc_get_measurement(data);
+		if (ret)
+			return ret;
+
+		recvd = get_unaligned_be32(data->buffer);
+		switch (channel->type) {
+		case IIO_PRESSURE:
+			raw = FIELD_GET(HSC_PRESSURE_MASK, recvd);
+			*val = raw;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			raw = FIELD_GET(HSC_TEMPERATURE_MASK, recvd);
+			*val = raw;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (channel->type) {
+		case IIO_TEMP:
+			*val = 97;
+			*val2 = 703957;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_PRESSURE:
+			*val = data->p_scale;
+			*val2 = data->p_scale_dec;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_OFFSET:
+		switch (channel->type) {
+		case IIO_TEMP:
+			*val = -50000000;
+			*val2 = 97704;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_PRESSURE:
+			*val = data->p_offset;
+			*val2 = data->p_offset_dec;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec hsc_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+};
+
+static const struct iio_info hsc_info = {
+	.read_raw = hsc_read_raw,
+};
+
+static const struct hsc_chip_data hsc_chip = {
+	.valid = hsc_measurement_is_valid,
+	.channels = hsc_channels,
+	.num_channels = ARRAY_SIZE(hsc_channels),
+};
+
+int hsc_common_probe(struct device *dev, void *client, hsc_recv_fn recv,
+			const char *name)
+{
+	struct hsc_data *hsc;
+	struct iio_dev *indio_dev;
+	const char *triplet;
+	u64 tmp;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	hsc = iio_priv(indio_dev);
+
+	hsc->chip = &hsc_chip;
+	hsc->recv_cb = recv;
+	hsc->client = client;
+
+	ret = device_property_read_u32(dev, "honeywell,transfer-function",
+				     &hsc->function);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"honeywell,transfer-function could not be read\n");
+	if (hsc->function > HSC_FUNCTION_F)
+		return dev_err_probe(dev, -EINVAL,
+				     "honeywell,transfer-function %d invalid\n",
+				     hsc->function);
+
+	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
+					&triplet);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"honeywell,pressure-triplet could not be read\n");
+
+	if (str_has_prefix(triplet, "NA")) {
+		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
+					       &hsc->pmin);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"honeywell,pmin-pascal could not be read\n");
+		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
+					       &hsc->pmax);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"honeywell,pmax-pascal could not be read\n");
+	} else {
+		ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
+						triplet);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL,
+				"honeywell,pressure-triplet is invalid\n");
+
+		hsc->pmin = hsc_range_config[ret].pmin;
+		hsc->pmax = hsc_range_config[ret].pmax;
+	}
+
+	if (hsc->pmin >= hsc->pmax)
+		return dev_err_probe(dev, -EINVAL,
+			"pressure limits are invalid\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "can't get vdd supply\n");
+
+	hsc->outmin = hsc_func_spec[hsc->function].output_min;
+	hsc->outmax = hsc_func_spec[hsc->function].output_max;
+
+	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
+		      hsc->outmax - hsc->outmin);
+	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_dec);
+	tmp = div_s64(((s64)hsc->pmin * (s64)(hsc->outmax - hsc->outmin)) *
+		      MICRO, hsc->pmax - hsc->pmin);
+	tmp -= (s64)hsc->outmin * MICRO;
+	hsc->p_offset = div_s64_rem(tmp, MICRO, &hsc->p_offset_dec);
+
+	mutex_init(&hsc->lock);
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &hsc_info;
+	indio_dev->channels = hsc->chip->channels;
+	indio_dev->num_channels = hsc->chip->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS(hsc_common_probe, IIO_HONEYWELL_HSC030PA);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
new file mode 100644
index 000000000000..169921da759f
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ */
+
+#ifndef _HSC030PA_H
+#define _HSC030PA_H
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define HSC_REG_MEASUREMENT_RD_SIZE 4
+
+struct device;
+
+struct iio_chan_spec;
+struct iio_dev;
+
+struct hsc_data;
+struct hsc_chip_data;
+
+typedef int (*hsc_recv_fn)(struct hsc_data *);
+
+/**
+ * struct hsc_data
+ * @client: either i2c or spi kernel interface struct for current dev
+ * @chip: structure containing chip's channel properties
+ * @lock: lock protecting chip reads
+ * @recv: function that implements the chip reads
+ * @is_valid: false if last transfer has failed
+ * @buffer: raw conversion data
+ * @pmin: minimum measurable pressure limit
+ * @pmax: maximum measurable pressure limit
+ * @outmin: minimum raw pressure in counts (based on transfer function)
+ * @outmax: maximum raw pressure in counts (based on transfer function)
+ * @function: transfer function
+ * @p_scale: pressure scale
+ * @p_scale_dec: pressure scale, decimal places
+ * @p_offset: pressure offset
+ * @p_offset_dec: pressure offset, decimal places
+ */
+struct hsc_data {
+	void *client;
+	const struct hsc_chip_data *chip;
+	struct mutex lock;
+	hsc_recv_fn recv_cb;
+	bool is_valid;
+	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+	s32 pmin;
+	s32 pmax;
+	u32 outmin;
+	u32 outmax;
+	u32 function;
+	s64 p_scale;
+	s32 p_scale_dec;
+	s64 p_offset;
+	s32 p_offset_dec;
+};
+
+struct hsc_chip_data {
+	bool (*valid)(struct hsc_data *data);
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+};
+
+enum hsc_func_id {
+	HSC_FUNCTION_A,
+	HSC_FUNCTION_B,
+	HSC_FUNCTION_C,
+	HSC_FUNCTION_F,
+};
+
+int hsc_common_probe(struct device *dev, void *client,
+	hsc_recv_fn recv, const char *name);
+
+#endif
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
new file mode 100644
index 000000000000..17f335e5631f
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [hsc]
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf [i2c related]
+ */
+
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+
+#include "hsc030pa.h"
+
+static int hsc_i2c_recv(struct hsc_data *data)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg;
+	int ret;
+
+	msg.addr = client->addr;
+	msg.flags = client->flags | I2C_M_RD;
+	msg.len = HSC_REG_MEASUREMENT_RD_SIZE;
+	msg.buf = data->buffer;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+
+	return (ret == 2) ? 0 : ret;
+}
+
+static int hsc_i2c_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	return hsc_common_probe(&client->dev, client, hsc_i2c_recv, id->name);
+}
+
+static const struct of_device_id hsc_i2c_match[] = {
+	{ .compatible = "honeywell,hsc030pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, hsc_i2c_match);
+
+static const struct i2c_device_id hsc_i2c_id[] = {
+	{ "hsc030pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, hsc_i2c_id);
+
+static struct i2c_driver hsc_i2c_driver = {
+	.driver = {
+		.name = "hsc030pa",
+		.of_match_table = hsc_i2c_match,
+	},
+	.probe = hsc_i2c_probe,
+	.id_table = hsc_i2c_id,
+};
+module_i2c_driver(hsc_i2c_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor i2c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_HSC030PA);
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
new file mode 100644
index 000000000000..846b0922c4d4
--- /dev/null
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell TruStability HSC Series pressure/temperature sensor
+ *
+ * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/stddef.h>
+
+#include <linux/iio/iio.h>
+
+#include "hsc030pa.h"
+
+static int hsc_spi_recv(struct hsc_data *data)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = NULL,
+		.rx_buf = data->buffer,
+		.len = HSC_REG_MEASUREMENT_RD_SIZE,
+	};
+
+	return spi_sync_transfer(data->client, &xfer, 1);
+}
+
+static int hsc_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	return hsc_common_probe(&spi->dev, spi, hsc_spi_recv, id->name);
+}
+
+static const struct of_device_id hsc_spi_match[] = {
+	{ .compatible = "honeywell,hsc030pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, hsc_spi_match);
+
+static const struct spi_device_id hsc_spi_id[] = {
+	{ "hsc030pa" },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, hsc_spi_id);
+
+static struct spi_driver hsc_spi_driver = {
+	.driver = {
+		.name = "hsc030pa",
+		.of_match_table = hsc_spi_match,
+	},
+	.probe = hsc_spi_probe,
+	.id_table = hsc_spi_id,
+};
+module_spi_driver(hsc_spi_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell HSC and SSC pressure sensor spi driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HONEYWELL_HSC030PA);
-- 
2.41.0


