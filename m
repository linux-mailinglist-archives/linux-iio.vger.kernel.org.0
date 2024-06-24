Return-Path: <linux-iio+bounces-6827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62975915564
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24251F24573
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4919F477;
	Mon, 24 Jun 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CtCqyibD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21319CD0B
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250277; cv=none; b=HBfAaWAoF8NEnb40nFb4zAQ/nzp7PAUoHElw4Q6QDzdbdIE7DZM02MBlp5bJV0iZ8vfmHvjSteJF2oy7xGjuRVlalHD4hGfv3Gc24dDyOAVaaz/EY15RAalP+X4Vy4AAhhEbUCpGHdGZDOwatfVmPJPaQWWQ5EXhDAYN2BgqnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250277; c=relaxed/simple;
	bh=xOPNZnnN4l9IiDBBQWaVQUddXzvIyX6IwLvRqPfBopQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFYDHhfdfHTQHQqXbo6Bk0vcpe8OGklODhvxk0cPNwZkE57f5/Yefr2uyehQvI538BlWOyaKiaATusmELnztzUJ1HtMn+OVHS+CDHFCr5IedEAn4sPWRg/gxlOpRZKIbNbY5jP+i2l4ml6LqqATNAmYe6bDtkJX7ULYJYkzKsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CtCqyibD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso38409015e9.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719250274; x=1719855074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyUzSKKBWAIU7D+W6BU/HhAkpHoZpwJrNeeENeOr2zc=;
        b=CtCqyibDuRUIHJBHFsDxaWqNh7rxuIU7rQo5fXgKEhPQ1nhK/2Wf6DzDXfBLfDn7tK
         zSwM0B+Mu3Z2uMdvcgfpUwL95QDkAaoXbSVGLkH9UjuqU/WPrGJv81rUXtNedUVLMjXT
         rtASs6Ex06nhyqoECYm6gbX6aXDGtSpRE984ZwPKne0W33kFGtRgGzsIMo331B22JnrC
         xubASwOWKUJV2PSof2qhZJEB/jfhaO89uo4seosQjR3mi9yAXm7s4Ya5dUbiPosD+no5
         0hMRQHR72yDa0oKogbNuYYSS2XyZN6wXJ289+4Rvts/UmpMdYB4GNQrotN+T9d00dRD9
         vyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250274; x=1719855074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyUzSKKBWAIU7D+W6BU/HhAkpHoZpwJrNeeENeOr2zc=;
        b=Dv8aV5dAfKhZVVvPlK/Ym6HEMaAypmDKqsbNVORb3q1IOyMFVByHASNPO1b2Gnps9y
         gxhuqFhhcSmeqKc/+INKJaT6Mv2Yh0H+mME/gCY4yqsK9xqxfXmKQyPvOj5IF25ck6Eu
         tLDQqxAZ70edFStIb3dqDKUQ14BCK0wkXs8WuWRgK5tbUZZOViKK106zGiQwLSBIWm2o
         tCLyl64BE4vSDMDqpzuzwqLfP0UksErIuCY6xdsl9ur1o2aw2DrjFHn0MQzGpenY7BD1
         GCktVOsf+V1JE+ezs7GtVcIpE8s116CMimXZPM8qnJOi8gHwFVzexvDqQLDIg0MNP8Ke
         KWRg==
X-Forwarded-Encrypted: i=1; AJvYcCXANeHTP6P8V6GYpSE54j+xBMM0a45G9z+TpE1lTX5J9v9UHTjiQtVE1pVzKNbmsxh7HEEyJWDeOjfqAI2+mSCNSaSW2SShBT3H
X-Gm-Message-State: AOJu0YzsrXMwKZtcls5KxqkywVOJdZZy5xJz14c7sWXRP0TNknw3aYgY
	F88/TSqfTVf1fC7kxPt2FKDalRv0Kue16aNid/JfuUqYy4iOhtGUAlXPXQC/JRg=
X-Google-Smtp-Source: AGHT+IH9Le2Z83zzr03nxEAjY/rvbBfj6K+lspfdVSmGSmUqqLI6jwX/aUNW7OOKMxoc4Nmgu0ezRQ==
X-Received: by 2002:a05:600c:1c1e:b0:424:7e1e:9080 with SMTP id 5b1f17b1804b1-4248cc2b868mr38774005e9.13.1719250273696;
        Mon, 24 Jun 2024 10:31:13 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e4ee:e6f8:8fcc:a63b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d210ff9sm183742385e9.39.2024.06.24.10.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:31:13 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 2/2] iio: frequency: add amlogic clock measure support
Date: Mon, 24 Jun 2024 19:31:03 +0200
Message-ID: <20240624173105.909554-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624173105.909554-1-jbrunet@baylibre.com>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add support for the HW found in most Amlogic SoC dedicated to measure
system clocks.

This drivers aims to replace the one found in
drivers/soc/amlogic/meson-clk-measure.c with following improvements:

* Access to the measurements through the IIO API:
  Easier re-use of the results in userspace and other drivers
* Controllable scale with raw measurements
* Higher precision with processed measurements

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/iio/frequency/Kconfig              |  15 +
 drivers/iio/frequency/Makefile             |   1 +
 drivers/iio/frequency/amlogic-clk-msr-io.c | 802 +++++++++++++++++++++
 3 files changed, 818 insertions(+)
 create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index c455be7d4a1c..1682cbec0edf 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -7,6 +7,21 @@
 #
 # When adding new entries keep the list in alphabetical order
 
+menu "Frequency Measurements"
+
+config AMLOGIC_CLK_MSR_IO
+	tristate "Amlogic IO Clock Measure"
+	default ARCH_MESON
+	depends on REGMAP_MMIO && COMMON_CLK
+	help
+	  Say yes here to build support for Amlogic Clock Measure
+	  HW found in Amlogic SoC, with IIO support
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called amlogic-clk-msr-io.
+
+endmenu
+
 menu "Frequency Synthesizers DDS/PLL"
 
 menu "Clock Generator/Distribution"
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index 70d0e0b70e80..3939970cccf3 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_ADMV1013) += admv1013.o
 obj-$(CONFIG_ADMV1014) += admv1014.o
 obj-$(CONFIG_ADMV4420) += admv4420.o
 obj-$(CONFIG_ADRF6780) += adrf6780.o
+obj-$(CONFIG_AMLOGIC_CLK_MSR_IO) += amlogic-clk-msr-io.o
diff --git a/drivers/iio/frequency/amlogic-clk-msr-io.c b/drivers/iio/frequency/amlogic-clk-msr-io.c
new file mode 100644
index 000000000000..16a15dd346d8
--- /dev/null
+++ b/drivers/iio/frequency/amlogic-clk-msr-io.c
@@ -0,0 +1,802 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2024 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MSR_CLK_REG0	0x0
+#define  MSR_BUSY	BIT(31)
+#define  MSR_CLK_SRC	GENMASK(26, 20)
+#define  MSR_CLK_EN	BIT(19)
+#define  MSR_CONT	BIT(17)
+#define  MSR_ENABLE	BIT(16)
+#define  MSR_TIME	GENMASK(15, 0)
+#define   MSR_TIME_MAX	(MSR_TIME + 1)
+#define MSR_CLK_REG1	0x4
+#define MSR_CLK_REG2	0x8
+#define  MSR_MEASURED	GENMASK(19, 0)
+
+#define CLK_MIN_TIME 64 /* This allows to measure up to 8GHz */
+#define CLK_MSR_MAX 128
+
+/*
+ * Note this driver aims to replace drivers/soc/amlogic/meson-clk-measure.c
+ * It provides the same functionality and adds support for the IIO API.
+ * The only thing missing is the clock summary which is very handy for
+ * debugging purpose. It is easy to reproduce the summary in userspace,
+ * from the iio device sysfs directory:
+ *
+ * for i in $(seq 0 127); do
+ *   printf "%20s: %11dHz +/- %.0fHz\n" \
+ *           $(cat in_altvoltage${i}_label) \
+ *           $(cat in_altvoltage${i}_input) \
+ *           $(cat in_altvoltage_scale);
+ * done
+ */
+
+struct amlogic_cmsr {
+	struct regmap *reg;
+	struct regmap *duty;
+	struct mutex lock;
+};
+
+static const char *cmsr_m8[CLK_MSR_MAX] = {
+	[0]  = "ring_osc_out_ee0",
+	[1]  = "ring_osc_out_ee1",
+	[2]  = "ring_osc_out_ee2",
+	[3]  = "a9_ring_osck",
+	[6]  = "vid_pll",
+	[7]  = "clk81",
+	[8]  = "encp",
+	[9]  = "encl",
+	[11] = "eth_rmii",
+	[13] = "amclk",
+	[14] = "fec_clk_0",
+	[15] = "fec_clk_1",
+	[16] = "fec_clk_2",
+	[18] = "a9_clk_div16",
+	[19] = "hdmi_sys",
+	[20] = "rtc_osc_clk_out",
+	[21] = "i2s_clk_in_src0",
+	[22] = "clk_rmii_from_pad",
+	[23] = "hdmi_ch0_tmds",
+	[24] = "lvds_fifo",
+	[26] = "sc_clk_int",
+	[28] = "sar_adc",
+	[30] = "mpll_clk_test_out",
+	[31] = "audac_clkpi",
+	[32] = "vdac",
+	[33] = "sdhc_rx",
+	[34] = "sdhc_sd",
+	[35] = "mali",
+	[36] = "hdmi_tx_pixel",
+	[38] = "vdin_meas",
+	[39] = "pcm_sclk",
+	[40] = "pcm_mclk",
+	[41] = "eth_rx_tx",
+	[42] = "pwm_d",
+	[43] = "pwm_c",
+	[44] = "pwm_b",
+	[45] = "pwm_a",
+	[46] = "pcm2_sclk",
+	[47] = "ddr_dpll_pt",
+	[48] = "pwm_f",
+	[49] = "pwm_e",
+	[59] = "hcodec",
+	[60] = "usb_32k_alt",
+	[61] = "gpio",
+	[62] = "vid2_pll",
+	[63] = "mipi_csi_cfg",
+};
+
+static const char *cmsr_gx[CLK_MSR_MAX] = {
+	[0]  = "ring_osc_out_ee_0",
+	[1]  = "ring_osc_out_ee_1",
+	[2]  = "ring_osc_out_ee_2",
+	[3]  = "a53_ring_osc",
+	[4]  = "gp0_pll",
+	[6]  = "enci",
+	[7]  = "clk81",
+	[8]  = "encp",
+	[9]  = "encl",
+	[10] = "vdac",
+	[11] = "rgmii_tx",
+	[12] = "pdm",
+	[13] = "amclk",
+	[14] = "fec_0",
+	[15] = "fec_1",
+	[16] = "fec_2",
+	[17] = "sys_pll_div16",
+	[18] = "sys_cpu_div16",
+	[19] = "hdmitx_sys",
+	[20] = "rtc_osc_out",
+	[21] = "i2s_in_src0",
+	[22] = "eth_phy_ref",
+	[23] = "hdmi_todig",
+	[26] = "sc_int",
+	[28] = "sar_adc",
+	[31] = "mpll_test_out",
+	[32] = "vdec",
+	[35] = "mali",
+	[36] = "hdmi_tx_pixel",
+	[37] = "i958",
+	[38] = "vdin_meas",
+	[39] = "pcm_sclk",
+	[40] = "pcm_mclk",
+	[41] = "eth_rx_or_rmii",
+	[42] = "mp0_out",
+	[43] = "fclk_div5",
+	[44] = "pwm_b",
+	[45] = "pwm_a",
+	[46] = "vpu",
+	[47] = "ddr_dpll_pt",
+	[48] = "mp1_out",
+	[49] = "mp2_out",
+	[50] = "mp3_out",
+	[51] = "nand_core",
+	[52] = "sd_emmc_b",
+	[53] = "sd_emmc_a",
+	[55] = "vid_pll_div_out",
+	[56] = "cci",
+	[57] = "wave420l_c",
+	[58] = "wave420l_b",
+	[59] = "hcodec",
+	[60] = "alt_32k",
+	[61] = "gpio_msr",
+	[62] = "hevc",
+	[66] = "vid_lock",
+	[70] = "pwm_f",
+	[71] = "pwm_e",
+	[72] = "pwm_d",
+	[73] = "pwm_c",
+	[75] = "aoclkx2_int",
+	[76] = "aoclk_int",
+	[77] = "rng_ring_osc_0",
+	[78] = "rng_ring_osc_1",
+	[79] = "rng_ring_osc_2",
+	[80] = "rng_ring_osc_3",
+	[81] = "vapb",
+	[82] = "ge2d",
+};
+
+static const char *cmsr_axg[CLK_MSR_MAX] = {
+	[0]   = "ring_osc_out_ee_0",
+	[1]   = "ring_osc_out_ee_1",
+	[2]   = "ring_osc_out_ee_2",
+	[3]   = "a53_ring_osc",
+	[4]   = "gp0_pll",
+	[5]   = "gp1_pll",
+	[7]   = "clk81",
+	[9]   = "encl",
+	[17]  = "sys_pll_div16",
+	[18]  = "sys_cpu_div16",
+	[20]  = "rtc_osc_out",
+	[23]  = "mmc_clk",
+	[28]  = "sar_adc",
+	[31]  = "mpll_test_out",
+	[40]  = "mod_eth_tx_clk",
+	[41]  = "mod_eth_rx_clk_rmii",
+	[42]  = "mp0_out",
+	[43]  = "fclk_div5",
+	[44]  = "pwm_b",
+	[45]  = "pwm_a",
+	[46]  = "vpu",
+	[47]  = "ddr_dpll_pt",
+	[48]  = "mp1_out",
+	[49]  = "mp2_out",
+	[50]  = "mp3_out",
+	[51]  = "sd_emmm_c",
+	[52]  = "sd_emmc_b",
+	[61]  = "gpio_msr",
+	[66]  = "audio_slv_lrclk_c",
+	[67]  = "audio_slv_lrclk_b",
+	[68]  = "audio_slv_lrclk_a",
+	[69]  = "audio_slv_sclk_c",
+	[70]  = "audio_slv_sclk_b",
+	[71]  = "audio_slv_sclk_a",
+	[72]  = "pwm_d",
+	[73]  = "pwm_c",
+	[74]  = "wifi_beacon",
+	[75]  = "tdmin_lb_lrcl",
+	[76]  = "tdmin_lb_sclk",
+	[77]  = "rng_ring_osc_0",
+	[78]  = "rng_ring_osc_1",
+	[79]  = "rng_ring_osc_2",
+	[80]  = "rng_ring_osc_3",
+	[81]  = "vapb",
+	[82]  = "ge2d",
+	[84]  = "audio_resample",
+	[85]  = "audio_pdm_sys",
+	[86]  = "audio_spdifout",
+	[87]  = "audio_spdifin",
+	[88]  = "audio_lrclk_f",
+	[89]  = "audio_lrclk_e",
+	[90]  = "audio_lrclk_d",
+	[91]  = "audio_lrclk_c",
+	[92]  = "audio_lrclk_b",
+	[93]  = "audio_lrclk_a",
+	[94]  = "audio_sclk_f",
+	[95]  = "audio_sclk_e",
+	[96]  = "audio_sclk_d",
+	[97]  = "audio_sclk_c",
+	[98]  = "audio_sclk_b",
+	[99]  = "audio_sclk_a",
+	[100] = "audio_mclk_f",
+	[101] = "audio_mclk_e",
+	[102] = "audio_mclk_d",
+	[103] = "audio_mclk_c",
+	[104] = "audio_mclk_b",
+	[105] = "audio_mclk_a",
+	[106] = "pcie_refclk_n",
+	[107] = "pcie_refclk_p",
+	[108] = "audio_locker_out",
+	[109] = "audio_locker_in",
+};
+
+static const char *cmsr_g12a[CLK_MSR_MAX] = {
+	[0]   = "ring_osc_out_ee_0",
+	[1]   = "ring_osc_out_ee_1",
+	[2]   = "ring_osc_out_ee_2",
+	[3]   = "sys_cpu_ring_osc",
+	[4]   = "gp0_pll",
+	[6]   = "enci",
+	[7]   = "clk81",
+	[8]   = "encp",
+	[9]   = "encl",
+	[10]  = "vdac",
+	[11]  = "eth_tx",
+	[12]  = "hifi_pll",
+	[13]  = "mod_tcon",
+	[14]  = "fec_0",
+	[15]  = "fec_1",
+	[16]  = "fec_2",
+	[17]  = "sys_pll_div16",
+	[18]  = "sys_cpu_div16",
+	[19]  = "lcd_an_ph2",
+	[20]  = "rtc_osc_out",
+	[21]  = "lcd_an_ph3",
+	[22]  = "eth_phy_ref",
+	[23]  = "mpll_50m",
+	[24]  = "eth_125m",
+	[25]  = "eth_rmii",
+	[26]  = "sc_int",
+	[27]  = "in_mac",
+	[28]  = "sar_adc",
+	[29]  = "pcie_inp",
+	[30]  = "pcie_inn",
+	[31]  = "mpll_test_out",
+	[32]  = "vdec",
+	[33]  = "sys_cpu_ring_osc_1",
+	[34]  = "eth_mpll_50m",
+	[35]  = "mali",
+	[36]  = "hdmi_tx_pixel",
+	[37]  = "cdac",
+	[38]  = "vdin_meas",
+	[39]  = "bt656",
+	[41]  = "eth_rx_or_rmii",
+	[42]  = "mp0_out",
+	[43]  = "fclk_div5",
+	[44]  = "pwm_b",
+	[45]  = "pwm_a",
+	[46]  = "vpu",
+	[47]  = "ddr_dpll_pt",
+	[48]  = "mp1_out",
+	[49]  = "mp2_out",
+	[50]  = "mp3_out",
+	[51]  = "sd_emmc_c",
+	[52]  = "sd_emmc_b",
+	[53]  = "sd_emmc_a",
+	[54]  = "vpu_clkc",
+	[55]  = "vid_pll_div_out",
+	[56]  = "wave420l_a",
+	[57]  = "wave420l_c",
+	[58]  = "wave420l_b",
+	[59]  = "hcodec",
+	[61]  = "gpio_msr",
+	[62]  = "hevcb",
+	[63]  = "dsi_meas",
+	[64]  = "spicc_1",
+	[65]  = "spicc_0",
+	[66]  = "vid_lock",
+	[67]  = "dsi_phy",
+	[68]  = "hdcp22_esm",
+	[69]  = "hdcp22_skp",
+	[70]  = "pwm_f",
+	[71]  = "pwm_e",
+	[72]  = "pwm_d",
+	[73]  = "pwm_c",
+	[75]  = "hevcf",
+	[77]  = "rng_ring_osc_0",
+	[78]  = "rng_ring_osc_1",
+	[79]  = "rng_ring_osc_2",
+	[80]  = "rng_ring_osc_3",
+	[81]  = "vapb",
+	[82]  = "ge2d",
+	[83]  = "co_rx",
+	[84]  = "co_tx",
+	[89]  = "hdmi_todig",
+	[90]  = "hdmitx_sys",
+	[91]  = "sys_cpub_div16",
+	[92]  = "sys_pll_cpub_div16",
+	[94]  = "eth_phy_rx",
+	[95]  = "eth_phy_pll",
+	[96]  = "vpu_b",
+	[97]  = "cpu_b_tmp",
+	[98]  = "ts",
+	[99]  = "ring_osc_out_ee_3",
+	[100] = "ring_osc_out_ee_4",
+	[101] = "ring_osc_out_ee_5",
+	[102] = "ring_osc_out_ee_6",
+	[103] = "ring_osc_out_ee_7",
+	[104] = "ring_osc_out_ee_8",
+	[105] = "ring_osc_out_ee_9",
+	[106] = "ephy_test",
+	[107] = "au_dac_g128x",
+	[108] = "audio_locker_out",
+	[109] = "audio_locker_in",
+	[110] = "audio_tdmout_c_sclk",
+	[111] = "audio_tdmout_b_sclk",
+	[112] = "audio_tdmout_a_sclk",
+	[113] = "audio_tdmin_lb_sclk",
+	[114] = "audio_tdmin_c_sclk",
+	[115] = "audio_tdmin_b_sclk",
+	[116] = "audio_tdmin_a_sclk",
+	[117] = "audio_resample",
+	[118] = "audio_pdm_sys",
+	[119] = "audio_spdifout_b",
+	[120] = "audio_spdifout",
+	[121] = "audio_spdifin",
+	[122] = "audio_pdm_dclk",
+};
+
+static const char *cmsr_sm1[CLK_MSR_MAX] = {
+	[0]   = "ring_osc_out_ee_0",
+	[1]   = "ring_osc_out_ee_1",
+	[2]   = "ring_osc_out_ee_2",
+	[3]   = "ring_osc_out_ee_3",
+	[4]   = "gp0_pll",
+	[5]   = "gp1_pll",
+	[6]   = "enci",
+	[7]   = "clk81",
+	[8]   = "encp",
+	[9]   = "encl",
+	[10]  = "vdac",
+	[11]  = "eth_tx",
+	[12]  = "hifi_pll",
+	[13]  = "mod_tcon",
+	[14]  = "fec_0",
+	[15]  = "fec_1",
+	[16]  = "fec_2",
+	[17]  = "sys_pll_div16",
+	[18]  = "sys_cpu_div16",
+	[19]  = "lcd_an_ph2",
+	[20]  = "rtc_osc_out",
+	[21]  = "lcd_an_ph3",
+	[22]  = "eth_phy_ref",
+	[23]  = "mpll_50m",
+	[24]  = "eth_125m",
+	[25]  = "eth_rmii",
+	[26]  = "sc_int",
+	[27]  = "in_mac",
+	[28]  = "sar_adc",
+	[29]  = "pcie_inp",
+	[30]  = "pcie_inn",
+	[31]  = "mpll_test_out",
+	[32]  = "vdec",
+	[34]  = "eth_mpll_50m",
+	[35]  = "mali",
+	[36]  = "hdmi_tx_pixel",
+	[37]  = "cdac",
+	[38]  = "vdin_meas",
+	[39]  = "bt656",
+	[40]  = "arm_ring_osc_out_4",
+	[41]  = "eth_rx_or_rmii",
+	[42]  = "mp0_out",
+	[43]  = "fclk_div5",
+	[44]  = "pwm_b",
+	[45]  = "pwm_a",
+	[46]  = "vpu",
+	[47]  = "ddr_dpll_pt",
+	[48]  = "mp1_out",
+	[49]  = "mp2_out",
+	[50]  = "mp3_out",
+	[51]  = "sd_emmc_c",
+	[52]  = "sd_emmc_b",
+	[53]  = "sd_emmc_a",
+	[54]  = "vpu_clkc",
+	[55]  = "vid_pll_div_out",
+	[56]  = "wave420l_a",
+	[57]  = "wave420l_c",
+	[58]  = "wave420l_b",
+	[59]  = "hcodec",
+	[60]  = "arm_ring_osc_out_5",
+	[61]  = "gpio_msr",
+	[62]  = "hevcb",
+	[63]  = "dsi_meas",
+	[64]  = "spicc_1",
+	[65]  = "spicc_0",
+	[66]  = "vid_lock",
+	[67]  = "dsi_phy",
+	[68]  = "hdcp22_esm",
+	[69]  = "hdcp22_skp",
+	[70]  = "pwm_f",
+	[71]  = "pwm_e",
+	[72]  = "pwm_d",
+	[73]  = "pwm_c",
+	[74]  = "arm_ring_osc_out_6",
+	[75]  = "hevcf",
+	[76]  = "arm_ring_osc_out_7",
+	[77]  = "rng_ring_osc_0",
+	[78]  = "rng_ring_osc_1",
+	[79]  = "rng_ring_osc_2",
+	[80]  = "rng_ring_osc_3",
+	[81]  = "vapb",
+	[82]  = "ge2d",
+	[83]  = "co_rx",
+	[84]  = "co_tx",
+	[85]  = "arm_ring_osc_out_8",
+	[86]  = "arm_ring_osc_out_9",
+	[87]  = "mipi_dsi_phy",
+	[88]  = "cis2_adapt",
+	[89]  = "hdmi_todig",
+	[90]  = "hdmitx_sys",
+	[91]  = "nna_core",
+	[92]  = "nna_axi",
+	[93]  = "vad",
+	[94]  = "eth_phy_rx",
+	[95]  = "eth_phy_pll",
+	[96]  = "vpu_b",
+	[97]  = "cpu_b_tmp",
+	[98]  = "ts",
+	[99]  = "arm_ring_osc_out_10",
+	[100] = "arm_ring_osc_out_11",
+	[101] = "arm_ring_osc_out_12",
+	[102] = "arm_ring_osc_out_13",
+	[103] = "arm_ring_osc_out_14",
+	[104] = "arm_ring_osc_out_15",
+	[105] = "arm_ring_osc_out_16",
+	[106] = "ephy_test",
+	[107] = "au_dac_g128x",
+	[108] = "audio_locker_out",
+	[109] = "audio_locker_in",
+	[110] = "audio_tdmout_c_sclk",
+	[111] = "audio_tdmout_b_sclk",
+	[112] = "audio_tdmout_a_sclk",
+	[113] = "audio_tdmin_lb_sclk",
+	[114] = "audio_tdmin_c_sclk",
+	[115] = "audio_tdmin_b_sclk",
+	[116] = "audio_tdmin_a_sclk",
+	[117] = "audio_resample",
+	[118] = "audio_pdm_sys",
+	[119] = "audio_spdifout_b",
+	[120] = "audio_spdifout",
+	[121] = "audio_spdifin",
+	[122] = "audio_pdm_dclk",
+	[123] = "audio_resampled",
+	[124] = "earcrx_pll",
+	[125] = "earcrx_pll_test",
+	[126] = "csi_phy0",
+	[127] = "csi2_data",
+};
+
+static struct iio_chan_spec *cmsr_populate_channels(struct device *dev,
+						    const char * const *conf)
+{
+	struct iio_chan_spec *chan;
+	int i;
+
+	chan = devm_kzalloc(dev, sizeof(*chan) * CLK_MSR_MAX, GFP_KERNEL);
+	if (!chan)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < CLK_MSR_MAX; i++) {
+		chan[i].type = IIO_ALTVOLTAGE;
+		chan[i].indexed = 1;
+		chan[i].channel = i;
+		chan[i].info_mask_separate = (BIT(IIO_CHAN_INFO_RAW) |
+					    BIT(IIO_CHAN_INFO_PROCESSED));
+		chan[i].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+		chan[i].datasheet_name = conf[i];
+	}
+
+	return chan;
+}
+
+static int cmsr_get_time_unlocked(struct amlogic_cmsr *cm)
+{
+	unsigned int raw;
+
+	regmap_read(cm->reg, MSR_CLK_REG0, &raw);
+
+	/* Field register value is time = val + 1 */
+	return FIELD_GET(MSR_TIME, raw) + 1;
+}
+
+static int cmsr_set_time_unlocked(struct amlogic_cmsr *cm,
+				  unsigned int time)
+{
+	time -= 1;
+
+	if (time < 0 || time > MSR_TIME)
+		return -EINVAL;
+
+	regmap_update_bits(cm->reg, MSR_CLK_REG0, MSR_TIME,
+			   FIELD_PREP(MSR_TIME, time));
+
+	return 0;
+}
+
+static int cmsr_measure_unlocked(struct amlogic_cmsr *cm,
+				 unsigned int idx)
+{
+	unsigned int raw;
+	int ret;
+
+	regmap_update_bits(cm->reg, MSR_CLK_REG0,
+			   MSR_ENABLE | MSR_CONT | MSR_CLK_EN | MSR_CLK_SRC,
+			   MSR_CLK_EN | FIELD_PREP(MSR_CLK_SRC, idx));
+
+	regmap_set_bits(cm->reg, MSR_CLK_REG0, MSR_ENABLE);
+	ret = regmap_read_poll_timeout(cm->reg, MSR_CLK_REG0, raw,
+				       !(raw & MSR_BUSY), 10, 70000);
+	regmap_clear_bits(cm->reg, MSR_CLK_REG0, MSR_ENABLE | MSR_CLK_EN);
+
+	if (ret)
+		return ret;
+
+	regmap_read(cm->reg, MSR_CLK_REG2, &raw);
+	ret = FIELD_GET(MSR_MEASURED, raw);
+
+	/* Check for overflow */
+	if (ret == MSR_MEASURED)
+		return -EINVAL;
+
+	return ret;
+}
+
+static int cmsr_measure_processed_unlocked(struct amlogic_cmsr *cm,
+					   unsigned int idx,
+					   int *val2)
+{
+	unsigned int time = CLK_MIN_TIME;
+	u64 rate;
+	int ret;
+
+	/*
+	 * The challenge here is to provide the best accuracy
+	 * while not spending to much time doing it.
+	 * - Starting with a short duration risk not detecting
+	 *   slow clocks, but it is fast. All 128 can be done in ~8ms
+	 * - Starting with a long duration risk overflowing the
+	 *   measurement counter and would be way to long, especially
+	 *   considering the number of disabled clocks. ~4s for all
+	 *   128 worst case.
+	 *
+	 * This IP measures system clocks so all clock are expected
+	 * to be 1kHz < f < 8GHz. We can compromise based on this,
+	 * doing it in 3 pass:
+	 * #1 Starting if 64us window: detects 30kHz < f < 8GHz
+	 *    - Go to #2 if no detection, Go to #3 otherwise
+	 * #2 Extend duration to 1024us (f > 1kHz)
+	      - Assume f = 0Hz if no detection, Go to #3 otherwise
+	 * #3 Clock has been detected, adjust window for best accuracy
+	 *
+	 * Doing the range detection takes ~1ms per clock, including disabled
+	   clocks.
+	 * Actual measurement takes at most ~65ms in step #3 for slow clocks,
+	 * when the full range the HW is used.
+	 */
+
+	/* Step #1 - quick measurement */
+	cmsr_set_time_unlocked(cm, time);
+	ret = cmsr_measure_unlocked(cm, idx);
+	if (ret < 0)
+		return ret;
+
+	else if (ret == 0) {
+		/* Step #2 - extend the window if necessary */
+		time *= 16;
+		cmsr_set_time_unlocked(cm, time);
+		ret = cmsr_measure_unlocked(cm, idx);
+		if (ret < 0)
+			return ret;
+
+		else if (ret == 0) {
+			/* Still nothing - assume no clock */
+			*val2 = 0;
+			return 0;
+		}
+	}
+
+	/* Step #3: Adapt scale for better precision */
+	time = time * MSR_MEASURED * 3 / (ret * 4); /* 25% margin */
+	time = min_t(unsigned int, MSR_TIME_MAX, time);
+
+	/* Actually measure rate with an optimized scale */
+	cmsr_set_time_unlocked(cm, time);
+	ret = cmsr_measure_unlocked(cm, idx);
+	if (ret < 0)
+		return ret;
+
+	rate = DIV_ROUND_CLOSEST_ULL(ret * 1000000ULL, time);
+	*val2 = rate >> 32ULL;
+	return (int)rate;
+}
+
+static int cmsr_read_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int *val, int *val2, long mask)
+{
+	struct amlogic_cmsr *cm = iio_priv(indio_dev);
+
+	guard(mutex)(&cm->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = cmsr_measure_unlocked(cm, chan->channel);
+		if (*val < 0)
+			return *val;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */
+		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
+		if (*val < 0)
+			return *val;
+		return IIO_VAL_INT_64;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val2 = cmsr_get_time_unlocked(cm);
+		*val = 1000000;
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cmsr_write_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int val, int val2, long info)
+{
+	struct amlogic_cmsr *cm = iio_priv(indio_dev);
+	unsigned int time;
+
+	guard(mutex)(&cm->lock);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		time = DIV_ROUND_CLOSEST(1000000U, val);
+		return cmsr_set_time_unlocked(cm, time);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cmsr_write_raw_get_fmt(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int cmsr_read_label(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   char *label)
+{
+	return sprintf(label, "%s\n", chan->datasheet_name);
+}
+
+static const struct of_device_id cmsr_of_match[] = {
+	{
+		.compatible = "amlogic,gx-clk-msr-io",
+		.data = cmsr_gx,
+	}, {
+		.compatible = "amlogic,meson8-clk-msr-io",
+		.data = cmsr_m8,
+	}, {
+		.compatible = "amlogic,axg-clk-msr-io",
+		.data = cmsr_axg,
+	}, {
+		.compatible = "amlogic,g12a-clk-msr-io",
+		.data = cmsr_g12a,
+	}, {
+		.compatible = "amlogic,sm1-clk-msr-io",
+		.data = cmsr_sm1,
+	}, {}
+};
+MODULE_DEVICE_TABLE(of, cmsr_of_match);
+
+static const struct iio_info cmsr_info = {
+	.read_raw = cmsr_read_raw,
+	.read_label = cmsr_read_label,
+	.write_raw = cmsr_write_raw,
+	.write_raw_get_fmt = cmsr_write_raw_get_fmt,
+};
+
+static const struct regmap_config cmsr_regmap_cfg = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+static int cmsr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct amlogic_cmsr *cm;
+	const char * const *conf;
+	void __iomem *regs;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*cm));
+	if (!indio_dev)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, indio_dev);
+	cm = iio_priv(indio_dev);
+
+	conf = of_device_get_match_data(dev);
+	if (!conf) {
+		dev_err(dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "reg");
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	cm->reg = devm_regmap_init_mmio(dev, regs, &cmsr_regmap_cfg);
+	if (IS_ERR(cm->reg)) {
+		dev_err(dev, "failed to init main regmap: %ld\n",
+			PTR_ERR(cm->reg));
+		return PTR_ERR(cm->reg);
+	}
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "duty");
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	cm->duty = devm_regmap_init_mmio(dev, regs, &cmsr_regmap_cfg);
+	if (IS_ERR(cm->duty)) {
+		dev_err(dev, "failed to init duty regmap: %ld\n",
+			PTR_ERR(cm->duty));
+		return PTR_ERR(cm->duty);
+	}
+
+	mutex_init(&cm->lock);
+
+	/* Init scale with a sane default */
+	cmsr_set_time_unlocked(cm, CLK_MIN_TIME);
+
+	indio_dev->name = "amlogic-clk-msr";
+	indio_dev->info = &cmsr_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = CLK_MSR_MAX;
+	indio_dev->channels = cmsr_populate_channels(dev, conf);
+	if (IS_ERR(indio_dev->channels))
+		return PTR_ERR(indio_dev->channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct platform_driver amlogic_cmsr_driver = {
+	.probe		= cmsr_probe,
+	.driver		= {
+		.name	= "amlogic-clk-msr-io",
+		.of_match_table = cmsr_of_match,
+	},
+};
+module_platform_driver(amlogic_cmsr_driver);
+
+MODULE_DESCRIPTION("Amlogic Clock Measure IO driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


