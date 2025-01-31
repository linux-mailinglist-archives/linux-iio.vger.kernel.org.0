Return-Path: <linux-iio+bounces-14757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DCA23EB7
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F581885760
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0101CAA89;
	Fri, 31 Jan 2025 13:54:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFF1C75F2
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738331644; cv=none; b=LumOaO9Vln1aorM6OtYoWEIL3O08LLzVkqWQceq4ZqD59qVmZU5UBN768My1O9+1YSGH/zVfFw/sieDjGm1EJ+HyP3BI3jXzVnakzYvQy4cKQpIL7a6c8agAEiI1RBiadQozyzknGqIa6yUrpDjMj3cTEmMeMN/Vg6FZ1cS5UoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738331644; c=relaxed/simple;
	bh=ZyIeyj8p150WqvNw9FQz8qSzdIzpboqEjOszWkDs8aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL145paXn1OoxCvjJ/yq4m36/5bcfPVTZyxqWgP3O4x010Ul8OHMawHPnd6Dd5yGn1JaGDXlSJKY0Iakjgj/H6IBx3WDk2gV3AQK9ZBeA35RSIRr0nVRKzU5st7uAO3JGDO41mIXwurOJqabuze80cxFbl5r0BiL7uQ/ak6gVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4Ykxz06xvfz4x0ns
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 14:47:24 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a916:3147:9f19:c260])
	by baptiste.telenet-ops.be with cmsmtp
	id 7pmw2E00X0naHe801pmwxJ; Fri, 31 Jan 2025 14:47:24 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tdrM6-0000000FHxs-1tvt;
	Fri, 31 Jan 2025 14:46:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tdrMG-0000000DFVQ-1qJR;
	Fri, 31 Jan 2025 14:46:56 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
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
	Alex Elder <elder@ieee.org>
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
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH treewide v2 1/3] bitfield: Add non-constant field_{prep,get}() helpers
Date: Fri, 31 Jan 2025 14:46:51 +0100
Message-ID: <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738329458.git.geert+renesas@glider.be>
References: <cover.1738329458.git.geert+renesas@glider.be>
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

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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
 include/linux/bitfield.h                      | 34 +++++++++++++++++++
 sound/usb/mixer_quirks.c                      |  4 ---
 9 files changed, 39 insertions(+), 28 deletions(-)

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
index 63928f1732230700..c62324a9fcc81241 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -203,4 +203,38 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+/**
+ * field_prep() - prepare a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @_mask is not limited to a compile-time constant.
+ */
+#define field_prep(_mask, _val)						\
+	({								\
+		typeof(_mask) __mask = (_mask);				\
+		unsigned int __shift = sizeof(_mask) <= 4 ?		\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(((typeof(_mask))(_val) << __shift) & (__mask));	\
+	})
+
+/**
+ * field_get() - extract a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg:  value of entire bitfield
+ *
+ * field_get() extracts the field specified by @_mask from the
+ * bitfield passed in as @_reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @_mask is not limited to a compile-time constant.
+ */
+#define field_get(_mask, _reg)						\
+	({								\
+		typeof(_mask) __mask = _mask;				\
+		unsigned int __shift = sizeof(_mask) <= 4 ?		\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(typeof(_mask))(((_reg) & (__mask)) >> __shift);	\
+	})
+
 #endif
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 23fcd680167d0298..00ab811e4b11a573 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3109,10 +3109,6 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
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


