Return-Path: <linux-iio+bounces-23238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEE4B3428F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B863A915E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F62F7475;
	Mon, 25 Aug 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvHsN92y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D32F6186;
	Mon, 25 Aug 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130076; cv=none; b=Y7m6KdL1jsJ+jai7ELm5iAdMlYTsbSa8HFiCCsUmKCIZBT00yrhhQqZ+0MOWEmD1nmDmqa2LWK3J1VbQOZwnZBT0bsPfHfdDs7gTqCmRO/H/eOlRf/W10eFfYolS71YQH1ibfs+P2YwWga+XY9NbBGnvW2ChhOBju/Q2SBwooqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130076; c=relaxed/simple;
	bh=QuDzdgEbhe01RGcDa58j/iJHR5TXAvIxXXDXJUBmrxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9BoHVBewW+5j2mL3t8G96TakPHVm8VOb+fQe1yiZZTNlANuu0UJmDDp1uH2yLFnXQuIhw1axn5m1FtZNVdQ47w2H5RFHEtekpGF7xcuPJ03CtVQUrv7v8r3tb3b/daTMKREj+zvxGYf+kAtRMBoJfpHYHrhjpIloY1lnISUwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvHsN92y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756130073; x=1787666073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QuDzdgEbhe01RGcDa58j/iJHR5TXAvIxXXDXJUBmrxo=;
  b=BvHsN92yQgRlFW7j/NFJoGx4rRTGmkL2psqx/0w4fzn4yhTuST9smqM/
   c981uKUTILl4r8EjxODFzX7MEuY+kI8jLXT4No4YJNwW/Uw0T+g6+1tLM
   R8FR1U3oYs4F3j0ljQXWAVV+hFGu7GMlJlOB3TsFWYujhcoJC7NAu58Pi
   W8EUBG4o4ZRZ8bXEKCDgZQTamcvmKpkXftzb5VN2o4kffrf9zKnmkv7he
   1/g+A3aaTOE5GraWhpigNrT8LKo8vxo9Tjq8v7Cnv0jvglIcLGfSHindq
   pvfcCAy81NZqXc+/EC/HMf58zTNWlsRHax46E8DCAOgs4Uwnl7vfMjB22
   A==;
X-CSE-ConnectionGUID: yGn/9kMeT3e5kb0PJ+lKFA==
X-CSE-MsgGUID: Go6ANczpT1C67CKABfmIRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68936878"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="68936878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:29 -0700
X-CSE-ConnectionGUID: GuTPFhU6QaK22cPQ2eEZXA==
X-CSE-MsgGUID: 6lwKuP7jR/KEs0KwCNno2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="168547699"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.7])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:25 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E44C5121F83;
	Mon, 25 Aug 2025 16:54:01 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uqXe5-00000007POs-3m4x;
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
Subject: [PATCH v3 12/12] iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 25 Aug 2025 16:54:01 +0300
Message-ID: <20250825135401.1765847-13-sakari.ailus@linux.intel.com>
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
Acked-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90614.c | 1 -
 drivers/iio/temperature/mlx90632.c | 1 -
 drivers/iio/temperature/mlx90635.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 740018d4b3df..8a44a00bfd5e 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -225,7 +225,6 @@ static void mlx90614_power_put(struct mlx90614_data *data)
 	if (!data->wakeup_gpio)
 		return;
 
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 }
 #else
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index ae4ea587e7f9..bf689f6143f3 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1043,7 +1043,6 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 	}
 
 mlx90632_read_raw_pm:
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 	return ret;
 }
diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index 1175c7887ae1..d7d16a56f90b 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -749,7 +749,6 @@ static int mlx90635_read_raw(struct iio_dev *indio_dev,
 	}
 
 mlx90635_read_raw_pm:
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 	return ret;
 }
-- 
2.47.2


