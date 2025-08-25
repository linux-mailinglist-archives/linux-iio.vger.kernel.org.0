Return-Path: <linux-iio+bounces-23229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5C3B34272
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1250E5E201C
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C892ED141;
	Mon, 25 Aug 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGsJmsUj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA71235055;
	Mon, 25 Aug 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130055; cv=none; b=kZQzdL4VPAyN+4HXMLcclRPQ96kku/4a6aJHznkiet7KMjmrNJXuJn2hEaQqUhYedxdoUfD1lPRyOVeXDudAnZvrMYq+uWdnNE9mSxeXvRMuInaCr9VMJ5nATisuLb3iYzP62K51V1xj/E9G/dU9+F1AhgH02uWthj676nZQevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130055; c=relaxed/simple;
	bh=WPJkKfMwVuXEVBnLHkO4qLYMFRXDiPVnU8VJknYRFM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGcfdj0PLiqlyeL2nQfBhPLpW9toMe34J+0U+JZLrUqhsceBoXV5UtgOuy+aK19LpVCMJYpAkRafIJPCrBdTlLYpykWP/XvwrNGs28/Q6GeqkGtx32Gc9G+A6OkYnRv+q3e0CcoJrBQGUNEwK6mTIdzaFTatpOFI+BoXMl2fXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGsJmsUj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756130053; x=1787666053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WPJkKfMwVuXEVBnLHkO4qLYMFRXDiPVnU8VJknYRFM8=;
  b=YGsJmsUj5gRwV0sGZEyFttKQT78NcsweayoPCy6vpfYOfGMxjatmpmkj
   UV6oGca3EXQgV7WpHr0qGK2FjbSe+0V2C4FX9IhWkakycyHicVzyr3QrN
   X/Pdnb9jomE3Nbctfs6MZVTaOeVR1qlkKiLAIcTZ3d9x6yQb4k6mSTzYX
   Z6+xkc22O8odPmkk4i87H810cOjLZMBuaa6FjQezwam0C4GEngRUtGLFs
   UtxLl5hEcE3xTDMiOjU+8uuV9gKVOBiNugsg1oQBrD83nNJtjwEdUdIh8
   I3hVgYDobVEaV1tGSPNUfw9C/bZhDbRedhUDCmm9DkdJBaDE41BalBH3v
   g==;
X-CSE-ConnectionGUID: ZarnJ9rRSPyshLnSnJUCzg==
X-CSE-MsgGUID: 7IMkfVLzQa2MlbnRfeM/PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68936396"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="68936396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:09 -0700
X-CSE-ConnectionGUID: v7eTl4s/SneKxm20Rii4+w==
X-CSE-MsgGUID: TI6nA+7iRVeIMfgZTVi34Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="174583453"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:04 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id BA272121F6C;
	Mon, 25 Aug 2025 16:54:01 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uqXe5-00000007POA-31io;
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
Subject: [PATCH v3 03/12] iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 25 Aug 2025 16:53:52 +0300
Message-ID: <20250825135401.1765847-4-sakari.ailus@linux.intel.com>
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
---
 drivers/iio/chemical/atlas-sensor.c | 2 --
 drivers/iio/chemical/bme680_core.c  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 1daaa36f87a9..8bbba85af699 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -425,7 +425,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	pm_runtime_mark_last_busy(&data->client->dev);
 	ret = pm_runtime_put_autosuspend(&data->client->dev);
 	if (ret)
 		return ret;
@@ -491,7 +490,6 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
 
 	ret = regmap_bulk_read(data->regmap, reg, val, sizeof(*val));
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 61d446fd456c..70f81c4a96ba 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -950,7 +950,6 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 		return ret;
 
 	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -1021,7 +1020,6 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 		return ret;
 
 	ret = __bme680_write_raw(indio_dev, chan, val, val2, mask);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -1140,7 +1138,6 @@ static int bme680_buffer_postdisable(struct iio_dev *indio_dev)
 	struct bme680_data *data = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(data->regmap);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return 0;
 }
-- 
2.47.2


