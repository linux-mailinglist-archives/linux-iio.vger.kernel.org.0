Return-Path: <linux-iio+bounces-15539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056EA35FA5
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C114C188DB88
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F2266598;
	Fri, 14 Feb 2025 13:56:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F0265626
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541393; cv=none; b=o4G+dElP7M6DGETvyyT9oJSmfwK7U+kT8vkucwpfphCJjVWVQnr5qp8PzY74pJPjPBI+2LnY8O2gsBvJcOge4CAhSZH/UPKA1AB9tNR0E5lOc4edWQonGl+BXAVvGzFLjQY+OvaFSy27sw/qWR1nyS2CInFkdkZpLp0FVBeZX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541393; c=relaxed/simple;
	bh=csO0hWDF6gLcCPWxaYzwdawo2cOkmqlJK1LSGZJquzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng4k36FOHdBv1ROQtGHTNfcTxgRlIQvGM18LzrRZv0nFCJpMjJYjT+vCcXRh3MX9JCVT7oA0gy+fIv2iGoN0FirgfzM9UQ3oTFFua+1uw2pr4lkRN0Cgtz+wn7YnPuwiCEwLAn2crKynB9miYKwchnlSIPo+1TrLEsM2ew4X+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:6395:73cc:7fc4:4cab])
	by albert.telenet-ops.be with cmsmtp
	id DRvu2E00L1MuxXz06RvuVQ; Fri, 14 Feb 2025 14:56:27 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAL-00000006p2f-11yq;
	Fri, 14 Feb 2025 14:55:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAc-00000000qEk-1tKI;
	Fri, 14 Feb 2025 14:55:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH treewide v3 2/4] bitfield: Add non-constant field_{prep,get}() helpers
Date: Fri, 14 Feb 2025 14:55:51 +0100
Message-ID: <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739540679.git.geert+renesas@glider.be>
References: <cover.1739540679.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by consolidating them in
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
  - Add Acked-by,
  - Drop underscores from macro parameters,
  - Use __auto_type where possible,
  - Correctly cast reg to the mask type,
  - Introduces __val and __reg intermediates to simplify the actual
    operation,
  - Drop unneeded parentheses,
  - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),

v2:
  - Cast val resp. reg to the mask type,
  - Fix 64-bit use on 32-bit architectures,
  - Convert new upstream users:
      - drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
      - drivers/gpio/gpio-aspeed.c
      - drivers/iio/temperature/mlx90614.c
      - drivers/pinctrl/nuvoton/pinctrl-ma35.c
      - sound/usb/mixer_quirks.c
  - Convert new user queued in renesas-devel for v6.15:
      - drivers/soc/renesas/rz-sysc.c
---
 drivers/clk/at91/clk-peripheral.c             |  1 +
 drivers/clk/at91/pmc.h                        |  3 --
 .../qat/qat_common/adf_gen4_pm_debugfs.c      |  8 +----
 drivers/gpio/gpio-aspeed.c                    |  5 +--
 drivers/iio/temperature/mlx90614.c            |  5 +--
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        |  4 ---
 drivers/soc/renesas/rz-sysc.c                 |  3 +-
 include/linux/bitfield.h                      | 36 +++++++++++++++++++
 sound/usb/mixer_quirks.c                      |  4 ---
 9 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index c173a44c800aa8cc..60208bdc3fe4797e 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4fb29ca111f7d427..3838e4f7df2d4a70 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -116,9 +116,6 @@ struct at91_clk_pms {
 	unsigned int parent;
 };
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define ndck(a, s) (a[s - 1].id + 1)
 #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
index 2e4095c4c12c94f9..ebaa59e934178309 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation */
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/string_helpers.h>
@@ -11,13 +12,6 @@
 #include "adf_gen4_pm.h"
 #include "icp_qat_fw_init_admin.h"
 
-/*
- * This is needed because a variable is used to index the mask at
- * pm_scnprint_table(), making it not compile time constant, so the compile
- * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
- */
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 #define PM_INFO_MEMBER_OFF(member)	\
 	(offsetof(struct icp_qat_fw_init_admin_pm_info, member) / sizeof(u32))
 
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 40c1bd80f8b0434d..b45e4dd8d8e4f00a 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -5,6 +5,7 @@
  * Joel Stanley <joel@jms.id.au>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/aspeed.h>
 #include <linux/gpio/driver.h>
@@ -30,10 +31,6 @@
 #include <linux/gpio/consumer.h>
 #include "gpiolib.h"
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define GPIO_G7_IRQ_STS_BASE 0x100
 #define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
 #define GPIO_G7_CTRL_REG_BASE 0x180
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 740018d4b3dfb35e..c58dc59d4f570831 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -22,6 +22,7 @@
  * the "wakeup" GPIO is not given, power management will be disabled.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
@@ -68,10 +69,6 @@
 #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
 #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
-
 struct mlx_chip_info {
 	/* EEPROM offsets with 16-bit data, MSB first */
 	/* emissivity correction coefficient */
diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 59c4e7c6cddea127..3ba28faa8e1418a9 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -81,10 +81,6 @@
 #define MVOLT_1800			0
 #define MVOLT_3300			1
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
-
 static const char * const gpio_group_name[] = {
 	"gpioa", "gpiob", "gpioc", "gpiod", "gpioe", "gpiof", "gpiog",
 	"gpioh", "gpioi", "gpioj", "gpiok", "gpiol", "gpiom", "gpion",
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 1c98da37b7d18745..917a029d849585cd 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -12,8 +13,6 @@
 
 #include "rz-sysc.h"
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 /**
  * struct rz_sysc - RZ SYSC private data structure
  * @base: SYSC base address
diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index e8269f23b824c4a9..4f43b00cc93d2f4f 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -203,4 +203,40 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ */
+#define field_prep(mask, val)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(mask) __val = (val);				\
+		unsigned int __shift = sizeof(mask) <= 4 ?		\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;	\
+	})
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position
+ * @reg:  value of entire bitfield
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ */
+#define field_get(mask, reg)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(mask) __reg =  (reg);				\
+		unsigned int __shift = sizeof(mask) <= 4 ?		\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;	\
+	})
+
 #endif
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ed6127b0389fff39..5899576c915b0a7e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3110,10 +3110,6 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
 #define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
 #define RME_DIGIFACE_INVERT BIT(31)
 
-/* Nonconst helpers */
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
-- 
2.43.0


