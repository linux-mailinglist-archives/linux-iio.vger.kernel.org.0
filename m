Return-Path: <linux-iio+bounces-23235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19016B34275
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCFD2A23E9
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A123D7CB;
	Mon, 25 Aug 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjQl/6xT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125A2797AA;
	Mon, 25 Aug 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130071; cv=none; b=LYE9pt0tDm6jGKispzMeaoH87U2hzv8CbvDgf61l3EMUlmPW1+ODtLSCuIrTzJBHQndBFAIeA+8M4QxPI7rtsPe+pGi3yOA1YchX93bLD5je6KDsvjJYB7jKs8oRNiBgrDjbqQb9Rny7rYWsUSsDaxNbOQ9M2qb4BGWWrg8B2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130071; c=relaxed/simple;
	bh=JGUMCbb2jJCc1rUIo+reE75z35JPcdws3MpXvLdGhaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkcNF/gRvbivPhfosljMaY+HlIrPXTW99b0TUGyG0klRRJ26xf8+HKjPGHCQmOaqiblXdJBGbPfHThpnc6N1Som0M8uFuScWJfNfY+T4KjXyF81lDNkrSkV74IkzZ64osdMVaSz+HbcDbPRhKEkHZaXPLwS2oe/jkaJ+Co/TNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjQl/6xT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756130069; x=1787666069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JGUMCbb2jJCc1rUIo+reE75z35JPcdws3MpXvLdGhaY=;
  b=cjQl/6xTItslfoqqc1L5rJCDgXZelwl8Q71YLPQpgv5mZkl75UuKIf7D
   ykcsX5/lJqEI/7KiTJ2CAn0wJ4JABQBILFqHgRuw41fzysGUk8jhcI5sV
   G6LKxOZXtMZsOnVm8BSCuE0pwetaUwC2VV8Qt3fua5hYGQs321wg0qbze
   KdBwE2bXSgUMYYEddXaQSRTZRcLuEyGjpwQBvgJYcut5gqd1G6QlKrIHI
   PpshJXPcqQTpJb/Vo3Bk6ijAPrzO9dDipWo7o/eVA2jVM6HgljMTaFWt4
   f5l0SUHcRJ9796ATMdSUA/Rwlr3/cEOi2/jGmYJOcnQiDNzpyOg4DSI2w
   g==;
X-CSE-ConnectionGUID: 5C4rUb8HQl+stZGohWGiwg==
X-CSE-MsgGUID: AcViXlhjTMupdGi1LdZEcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68936703"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="68936703"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:23 -0700
X-CSE-ConnectionGUID: KwSioaM3Rw2uJuAG6v80pA==
X-CSE-MsgGUID: vS1ZLyJ/RNCoLz0J0eVOgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="168547683"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.7])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:18 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id CC2DE121F72;
	Mon, 25 Aug 2025 16:54:01 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uqXe5-00000007POT-3N1t;
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
Subject: [PATCH v3 07/12] iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 25 Aug 2025 16:53:56 +0300
Message-ID: <20250825135401.1765847-8-sakari.ailus@linux.intel.com>
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   | 1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 6 ------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      | 1 -
 drivers/iio/imu/kmx61.c                            | 6 ++----
 7 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 7a28051330b7..48014b61ced3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -315,7 +315,6 @@ static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 exit:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -567,7 +566,6 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -675,7 +673,6 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -727,7 +724,6 @@ static int inv_icm42600_accel_read_offset(struct inv_icm42600_state *st,
 	memcpy(data, st->buffer, sizeof(data));
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	if (ret)
 		return ret;
@@ -865,7 +861,6 @@ static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index ca744aaee542..36d69a0face6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -430,7 +430,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (sleep)
 		msleep(sleep);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 9ba6f13628e6..8a7cc9127631 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -184,7 +184,6 @@ static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
 		ret = -EINVAL;
 exit:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -283,7 +282,6 @@ static int inv_icm42600_gyro_write_scale(struct iio_dev *indio_dev,
 	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -378,7 +376,6 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -430,7 +427,6 @@ static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
 	memcpy(data, st->buffer, sizeof(data));
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	if (ret)
 		return ret;
@@ -567,7 +563,6 @@ static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 271a4788604a..30f6a9595eea 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -41,7 +41,6 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
 
 exit:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 39eb516acc73..b2fa1f4957a5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -735,7 +735,6 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 		break;
 	}
 
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 
 	return ret;
@@ -938,7 +937,6 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 error_write_raw_unlock:
 	mutex_unlock(&st->lock);
@@ -1146,14 +1144,12 @@ static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)
 			st->chip_config.wom_en = false;
 		}
 
-		pm_runtime_mark_last_busy(pdev);
 		pm_runtime_put_autosuspend(pdev);
 	}
 
 	return result;
 
 error_suspend:
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 	return result;
 }
@@ -1249,7 +1245,6 @@ static int inv_mpu6050_write_event_value(struct iio_dev *indio_dev,
 	value = (u64)val * 1000000ULL + (u64)val2;
 	result = inv_mpu6050_set_wom_threshold(st, value, INV_MPU6050_FREQ_DIVIDER(st));
 
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 
 	return result;
@@ -1357,7 +1352,6 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	if (result)
 		goto fifo_rate_fail_power_off;
 
-	pm_runtime_mark_last_busy(pdev);
 fifo_rate_fail_power_off:
 	pm_runtime_put_autosuspend(pdev);
 fifo_rate_fail_unlock:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 5b1088cc3704..10a473342075 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -194,7 +194,6 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
 			goto error_power_off;
-		pm_runtime_mark_last_busy(pdev);
 		pm_runtime_put_autosuspend(pdev);
 	}
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 55c82891e08c..3cd91d8a89ee 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -747,12 +747,10 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 		data->mag_ps = on;
 	}
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: kmx61_set_power_state for %d, ret %d\n",
-- 
2.47.2


