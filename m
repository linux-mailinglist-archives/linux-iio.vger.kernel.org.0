Return-Path: <linux-iio+bounces-21334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B3AF8A89
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC597BB146
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A312E11DC;
	Fri,  4 Jul 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJdLiCke"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B72E03E3;
	Fri,  4 Jul 2025 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615679; cv=none; b=KleaiI1dOXHjbjrZ9N2U6OmxaumxljLh7sHaZJYuIVMOTIkfEw9eZGLNa39D0Rt/FIuxYzKJMxmRPsvT2yEItArA/NJAkxVKIG5NRP/4++AqvGlV6SGXpHm8X5iq8+XEXH2AOMzzAbaHoDifwrOgipsdRIuoYDHIG2IizcCkjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615679; c=relaxed/simple;
	bh=QbMjMby8Pwl0MnNO9PpYJpQ3wUGLrg04vUF7Y6hQgD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hYYps50V1uNB962ggbIy4NT68+BlXp/GxlfiyO3vHQ9uFwlcm5EUXXH8cZq1nr+WrGYnutvSSkJBxTRx1Ci2zkr9pf3h25pQEp662xvFlRDWeI5MNDu5pp3UX6LIkrcVTMCt/6aPEaZ6fHqeSkY5+T1vyR3QdDCqag2hQbO0YP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJdLiCke; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615677; x=1783151677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QbMjMby8Pwl0MnNO9PpYJpQ3wUGLrg04vUF7Y6hQgD4=;
  b=QJdLiCke6KraIdaC6v/gWaxWgtXzz36uGWHLMHjhAbDlk/+vIBUTw8z+
   uEeD51hwjf724gD/rfZMBGN3TfEFxfmfop6bmHXzhezsRgsK62y3APN2M
   GpS3+Ygqnx8orzn68tl8z2uoivW1gzkEwmJHARv3jJw/SMwMGQ3pMyzRi
   NPQUauTzIeEdjVWRzwfAVU7LrwNZahvZAGpzJX/FaRE+kEdk8CsI2jJTB
   vKfxWXaeOwW9P6O7jAb/BTp+eP8RVaWHGsj1yjecVAonqo107P+wzkfDC
   SMsf28EpUIVA/+KXs19cLm91BJBDeLakCCfcAecUYUKEc/4u8k2r3bV6q
   Q==;
X-CSE-ConnectionGUID: Bl2I5HL+Rv6hMVmPNAGgyw==
X-CSE-MsgGUID: yxMwr1QIT8yxSBq/ckIajA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494763"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494763"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:32 -0700
X-CSE-ConnectionGUID: +yFu4+TsSMKsGHSqPDp44g==
X-CSE-MsgGUID: FEA+89GqRpalH70hPrQ1Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924258"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:22 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 3391B4488D;
	Fri,  4 Jul 2025 10:54:20 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Julien Stephan <jstephan@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 28/80] iio: adc: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:19 +0300
Message-Id: <20250704075420.3219092-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/iio/adc/ab8500-gpadc.c     |  1 -
 drivers/iio/adc/at91-sama5d2_adc.c | 10 ----------
 drivers/iio/adc/imx8qxp-adc.c      |  2 --
 drivers/iio/adc/imx93_adc.c        |  1 -
 drivers/iio/adc/rcar-gyroadc.c     |  1 -
 drivers/iio/adc/rzg2l_adc.c        |  3 ---
 drivers/iio/adc/stm32-adc-core.c   |  1 -
 drivers/iio/adc/stm32-adc.c        |  7 -------
 drivers/iio/adc/sun4i-gpadc-iio.c  |  2 --
 drivers/iio/adc/ti-ads1015.c       |  1 -
 drivers/iio/adc/ti-ads1100.c       |  1 -
 drivers/iio/adc/ti-ads1119.c       |  2 --
 12 files changed, 32 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index f3b057f92310..8eaa1dd6a89b 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -607,7 +607,6 @@ static int ab8500_gpadc_read(struct ab8500_gpadc *gpadc,
 	}
 
 	/* This eventually drops the regulator */
-	pm_runtime_mark_last_busy(gpadc->dev);
 	pm_runtime_put_autosuspend(gpadc->dev);
 
 	return (high_data << 8) | low_data;
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index c3450246730e..67846fefe21a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -896,7 +896,6 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 	emr |= osr | AT91_SAMA5D2_TRACKX(trackx);
 	at91_adc_writel(st, EMR, emr);
 
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	st->oversampling_ratio = oversampling_ratio;
@@ -971,7 +970,6 @@ static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
 				AT91_SAMA5D2_IER_PEN | AT91_SAMA5D2_IER_NOPEN);
 		at91_adc_writel(st, TSMR, 0);
 
-		pm_runtime_mark_last_busy(st->dev);
 		pm_runtime_put_autosuspend(st->dev);
 		return 0;
 	}
@@ -1143,7 +1141,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 	at91_adc_configure_trigger_registers(st, state);
 
 	if (!state) {
-		pm_runtime_mark_last_busy(st->dev);
 		pm_runtime_put_autosuspend(st->dev);
 	}
 
@@ -1336,7 +1333,6 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 		at91_adc_writel(st, IER, AT91_SAMA5D2_IER_DRDY);
 
 pm_runtime_put:
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 	return ret;
 }
@@ -1394,7 +1390,6 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 	if (st->dma_st.dma_chan)
 		dmaengine_terminate_sync(st->dma_st.dma_chan);
 
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return 0;
@@ -1603,7 +1598,6 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq,
 	mr |= AT91_SAMA5D2_MR_TRACKTIM(tracktim);
 	at91_adc_writel(st, MR, mr);
 
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u, tracktim=%u\n",
@@ -1809,7 +1803,6 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 	at91_adc_readl(st, LCDR);
 
 pm_runtime_put:
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 	return ret;
 }
@@ -1890,7 +1883,6 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
 restore_config:
 	/* Revert previous settings. */
 	at91_adc_temp_sensor_configure(st, false);
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 	if (ret < 0)
 		return ret;
@@ -2465,7 +2457,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "version: %x\n",
 		 readl_relaxed(st->base + st->soc_info.platform->layout->VERSION));
 
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return 0;
@@ -2567,7 +2558,6 @@ static int at91_adc_resume(struct device *dev)
 		at91_adc_configure_trigger_registers(st, true);
 	}
 
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return 0;
diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index be13a6ed7e00..d9da24efdcbe 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -229,7 +229,6 @@ static int imx8qxp_adc_read_raw(struct iio_dev *indio_dev,
 		ret = wait_for_completion_interruptible_timeout(&adc->completion,
 								IMX8QXP_ADC_TIMEOUT);
 
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_sync_autosuspend(dev);
 
 		if (ret == 0) {
@@ -295,7 +294,6 @@ static int imx8qxp_adc_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 
 	*readval = readl(adc->regs + reg);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_sync_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 7feaafd2316f..bb5bd22269b9 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -248,7 +248,6 @@ static int imx93_adc_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&adc->lock);
 		ret = imx93_adc_read_channel_conversion(adc, chan->channel, val);
 		mutex_unlock(&adc->lock);
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_sync_autosuspend(dev);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index cc326f21d398..467c6a9213ab 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -166,7 +166,6 @@ static int rcar_gyroadc_set_power(struct rcar_gyroadc *priv, bool on)
 	if (on) {
 		return pm_runtime_resume_and_get(dev);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		return pm_runtime_put_autosuspend(dev);
 	}
 }
diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 9674d48074c9..29264a410def 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -249,7 +249,6 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	rzg2l_adc_start_stop(adc, false);
 
 rpm_put:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -411,7 +410,6 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -591,7 +589,6 @@ static int rzg2l_adc_resume(struct device *dev)
 
 rpm_restore:
 	if (adc->was_rpm_active) {
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
 resets_restore:
diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index dea166c53369..b42fee4a4695 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -795,7 +795,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		goto err_irq_remove;
 	}
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 588c69e175f5..54147d0afc0f 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1528,7 +1528,6 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	stm32_adc_conv_irq_disable(adc);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -1564,7 +1563,6 @@ static int stm32_adc_write_raw(struct iio_dev *indio_dev,
 
 		adc->cfg->set_ovs(indio_dev, idx);
 
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 
 		adc->ovs_idx = idx;
@@ -1759,7 +1757,6 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
 	adc->num_conv = bitmap_weight(scan_mask, iio_get_masklength(indio_dev));
 
 	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -1808,7 +1805,6 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
 	else
 		*readval = stm32_adc_readl(adc, reg);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -1954,7 +1950,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 err_clr_trig:
 	stm32_adc_set_trig(indio_dev, NULL);
 err_pm_put:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -1977,7 +1972,6 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -2614,7 +2608,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		goto err_hw_stop;
 	}
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 6b8d6bee1873..a439f4864111 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -245,7 +245,6 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
 		*val = info->temp_data;
 
 	ret = 0;
-	pm_runtime_mark_last_busy(indio_dev->dev.parent);
 
 err:
 	pm_runtime_put_autosuspend(indio_dev->dev.parent);
@@ -272,7 +271,6 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 
 		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
 
-		pm_runtime_mark_last_busy(indio_dev->dev.parent);
 		pm_runtime_put_autosuspend(indio_dev->dev.parent);
 
 		return 0;
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 48549d617e5f..d3920fcb131b 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -377,7 +377,6 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index b0790e300b18..aa8946063c7d 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -105,7 +105,6 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 
 	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
 
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 
 	if (ret < 0) {
diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index d2f86e1ec656..9f576cfe63f9 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -291,7 +291,6 @@ static int ads1119_single_conversion(struct ads1119_state *st,
 	*val = sign_extend32(sample, chan->scan_type.realbits - 1);
 	ret = IIO_VAL_INT;
 pdown:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -470,7 +469,6 @@ static int ads1119_triggered_buffer_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-- 
2.39.5


