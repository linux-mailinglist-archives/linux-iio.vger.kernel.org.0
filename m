Return-Path: <linux-iio+bounces-1697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C682E1A5
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 21:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8231E1C221E8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804091A581;
	Mon, 15 Jan 2024 20:21:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54919BD2
	for <linux-iio@vger.kernel.org>; Mon, 15 Jan 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSE-0004fy-P2; Mon, 15 Jan 2024 21:21:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-0005g5-Bi; Mon, 15 Jan 2024 21:21:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-000N7F-0r;
	Mon, 15 Jan 2024 21:21:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH 03/33] iio: adc: ad_sigma_delta: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:49 +0100
Message-ID:  <34f4c9459aae0915539c69bf02adabce58d51a45.1705348269.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UNWg1cWkWl9ngD6vxLDzpVtm8ne2cP1Z0jV0US+oPSg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHE+lyvTjdPNlT+lqDFZXOYzJe8P2F/x0tgO eIe8XBeIu+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRxAAKCRCPgPtYfRL+ Ts7qB/9b4+aHxeuxvcXG5uKUWriLzDsQc3kQmHmNxuE7gtbI2ktJnCM2/wNfSqvRXZWQ2LdZPLk uz2Pn1p9Xj5dU9QeYYScHODxVF/f5FkIOGZFe/vHiYhq/TSObO9x5AYYTP1I56LOvuvd3kyWjXU xP54rzuFf1F56I9LZWXQhCCmAciWWz8ka4izS7L53JGSIgu0U4tzdmY/wVPWi5rzOOJYpM3DP0s ++gnAPQuo6iwgG+05dMgYu7TzhCGKpQfihdWdlHzrNqmZ/zLhdzmyMikBR894TbOeHJGPyO0RTs q3ZEYHYpjxdDucPHm6OwoVHVb21uzYw5ThpmFWtxHNOZHP6q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/ad_sigma_delta.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7e2192870743..55442eddf57c 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -212,7 +212,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	if (ret)
 		return ret;
 
-	spi_bus_lock(sigma_delta->spi->master);
+	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
@@ -235,7 +235,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	sigma_delta->bus_locked = false;
-	spi_bus_unlock(sigma_delta->spi->master);
+	spi_bus_unlock(sigma_delta->spi->controller);
 
 	return ret;
 }
@@ -287,7 +287,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	ad_sigma_delta_set_channel(sigma_delta, chan->address);
 
-	spi_bus_lock(sigma_delta->spi->master);
+	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
@@ -322,7 +322,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	sigma_delta->bus_locked = false;
-	spi_bus_unlock(sigma_delta->spi->master);
+	spi_bus_unlock(sigma_delta->spi->controller);
 	iio_device_release_direct_mode(indio_dev);
 
 	if (ret)
@@ -387,7 +387,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 	sigma_delta->samples_buf = samples_buf;
 
-	spi_bus_lock(sigma_delta->spi->master);
+	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 
@@ -401,7 +401,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_unlock:
-	spi_bus_unlock(sigma_delta->spi->master);
+	spi_bus_unlock(sigma_delta->spi->controller);
 
 	return ret;
 }
@@ -426,7 +426,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 
 	ad_sigma_delta_disable_all(sigma_delta);
 	sigma_delta->bus_locked = false;
-	return spi_bus_unlock(sigma_delta->spi->master);
+	return spi_bus_unlock(sigma_delta->spi->controller);
 }
 
 static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
-- 
2.43.0


