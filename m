Return-Path: <linux-iio+bounces-23234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FE4B34289
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA7E5E4269
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73C2F6170;
	Mon, 25 Aug 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWfoTzo2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D502F60B2;
	Mon, 25 Aug 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130070; cv=none; b=hNuUroRCJhMDmhDNS1Mrs7CLx8Q47DtfTAsCvuXbIcJupecw5KAGi49jfdaBLTOYG+FfrzVcvkc5gkCpK5SIynsUMLNoyouMwI8J+wWPvdL0zreEZ9mUdXYh7NI4e8CLJ+lAlMbusZ9fcEhrn4gOgGGQhLL32W9VzHULdQznGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130070; c=relaxed/simple;
	bh=Y6BmQsoHEXKtoNEql38zgrbM5vjoAf3tiVb+ccRW6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+4ewM4cwPgsEkbqSt0I0hQW+3E/OJlbEFOUL74ifHfySBCY1c2388vrzsZ2wbO2Gzx71/lwQsaEwEI09FX4h1TDlNSv4P5Rnt1S00x/TTjYlZiKBX5YWS9GNyMxI3E/dLp5/weuD5hqwmkKmuKdIUfTn3a6y0RaHBqAu7NjESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWfoTzo2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756130068; x=1787666068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6BmQsoHEXKtoNEql38zgrbM5vjoAf3tiVb+ccRW6lQ=;
  b=JWfoTzo2qGPgPdIhRUeZHcnG4/uNE2B5+3jEFOY3OoX8fRymjVI9eP6I
   F90dkgtESVuruD7mb50oxYkvGoJlm0VupBnMhtnUx2KvcFtWhQo/UXjEi
   TvH97hJ+Z5v+yvXv7wOFbCM7ZiadALhU9M29BoVv3Y2bMBbfkNGxPFxs0
   XxUT4nXoy1BlGG3JeGmf28hCKIvA2RiF1khHHG/7+murYyrV3rdk9J4vg
   6vpLIxVPLZw9lHmXk77JIRtaAZb79MLsVBWpSuZv4eFSVsQG3k0l2oltw
   FeZaCg/b1GKt7VJKfqYOxMlM7UdVjjWwfjtWDsrLHl6lwnuRHVU252aO7
   Q==;
X-CSE-ConnectionGUID: g++ESyYvQBOI5h5DmydInQ==
X-CSE-MsgGUID: gxHiNuEWRgq7rw5PqYFXgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68936694"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="68936694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:23 -0700
X-CSE-ConnectionGUID: iB8M4n4+QkurhYzn8JVT1w==
X-CSE-MsgGUID: NLoPB0QnQCecCSyvVSxz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="168547681"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.7])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:18 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C755E121F6F;
	Mon, 25 Aug 2025 16:54:01 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uqXe5-00000007PON-3Hj0;
	Mon, 25 Aug 2025 16:54:01 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
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
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	Andreas Klinger <ak@it-klinger.de>,
	Crt Mori <cmo@melexis.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Bo Liu <liubo03@inspur.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sean Nyekjaer <sean@geanix.com>,
	Frank Li <Frank.Li@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Gustavo Vaz <gustavo.vaz@usp.br>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Laight <david.laight@aculab.com>,
	Jakob Hauser <jahau@rocketmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 06/12] iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 25 Aug 2025 16:53:55 +0300
Message-ID: <20250825135401.1765847-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825135401.1765847-1-sakari.ailus@linux.intel.com>
References: <20250825135401.1765847-1-sakari.ailus@linux.intel.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/bmg160_core.c     | 4 +---
 drivers/iio/gyro/fxas21002c_core.c | 2 --
 drivers/iio/gyro/mpu3050-core.c    | 3 ---
 drivers/iio/gyro/mpu3050-i2c.c     | 1 -
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 781d3e96645f..38394b5f3275 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -309,10 +309,8 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 
 	if (on)
 		ret = pm_runtime_get_sync(dev);
-	else {
-		pm_runtime_mark_last_busy(dev);
+	else
 		ret = pm_runtime_put_autosuspend(dev);
-	}
 
 	if (ret < 0) {
 		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 754c8a564ba4..a88670207cec 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -373,8 +373,6 @@ static int  fxas21002c_pm_put(struct fxas21002c_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 
-	pm_runtime_mark_last_busy(dev);
-
 	return pm_runtime_put_autosuspend(dev);
 }
 
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 16553948c5c3..67ae7d1012bc 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -370,7 +370,6 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 
 out_read_raw_unlock:
 	mutex_unlock(&mpu3050->lock);
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 
 	return ret;
@@ -662,7 +661,6 @@ static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 
 	return 0;
@@ -976,7 +974,6 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		if (ret)
 			dev_err(mpu3050->dev, "error resetting FIFO\n");
 
-		pm_runtime_mark_last_busy(mpu3050->dev);
 		pm_runtime_put_autosuspend(mpu3050->dev);
 		mpu3050->hw_irq_trigger = false;
 
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index 8e284f47242c..092878f2c886 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -27,7 +27,6 @@ static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)
 {
 	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
 
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 	return 0;
 }
-- 
2.47.2


