Return-Path: <linux-iio+bounces-3429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92B8775BB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 09:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE91C20DFB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983319479;
	Sun, 10 Mar 2024 08:06:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC350171A1
	for <linux-iio@vger.kernel.org>; Sun, 10 Mar 2024 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710057987; cv=none; b=rCcb1hk53WELlw9xDII+2DCjkSP26lAaOAZ8j7IDJSZEhOcF9JI1CMA51Qk/1Y5sV/4BDzujZ3HtZW9zy2IchDL6X0xdH0AZzHe1tkSPWgDThsHzTlUPf9AiuKEjSMkdinmMTWQl23td22KY7FmyD/wTcOqoN8PaRpPYbnNlC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710057987; c=relaxed/simple;
	bh=Y3iVEuUnTxadv+2Xsne2ZqFIPCWIinyeZaatYcGXFmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA7tbs3cdrmQ2huK30cZAnN398oly2fjAOwdX66mudisKakGLnf6H1ydaT+eWN+qYLsqh669XI2H2gdpV2ZoNMuqvl4N8wiW6D5HxS5zw4usMAuoy8FaIqvG45qSB02YTeVJEYtN48UfB/6IGpQqCno0E0sQ22YfShqPmYlBxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECC-00073Q-Vw; Sun, 10 Mar 2024 09:06:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECB-005Txt-WB; Sun, 10 Mar 2024 09:06:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjECB-003KQv-2w;
	Sun, 10 Mar 2024 09:06:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: William Breathitt Gray <william.gray@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] counter: ti-ecap-capture: Convert to platform remove callback returning void
Date: Sun, 10 Mar 2024 09:06:06 +0100
Message-ID:  <f70902b2aabecaa9295c28629cd7a8a0e6eb06d0.1710057753.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710057753.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710057753.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Y3iVEuUnTxadv+2Xsne2ZqFIPCWIinyeZaatYcGXFmw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7WnvQ6MhD8ir6vlj0K8bS/UVG6qXp8reE73Xx SkmyEVNDfeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe1p7wAKCRCPgPtYfRL+ Tp04B/9JZ66umIX0fdbWIsAqswZ0vtG8Va9k8cSYwBIwxf8u0roWV9DCJnH+iM5UrbYqGnTbv2j 6nxM40CZZTbasN7E5PPLOw8fuD6hzVh5TcNUx/jkA3Qjn9mlnMV9Dyi01+3N7b0bJiqbNZMTHAJ Epzn/3xD/MozpLPFe0IonGoopq6KEb1I9zyHeELLfT5zVjZyE08oauRtlH3xmNi7j5Sk8AJeMbT RJSEsIS5sxkjKqzn5L7gNPU9AuYjI9jjpPquXTdjHOOV5kHKnm85BvUhSlFuenSHcNPxkhC0Ved yfzcbOzps4yhDQJEhLP+h+5rUnEj4wPjIo2WDTmNlrSmDAkg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-ecap-capture.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index fb1cb1774674..d33d35055b91 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -537,15 +537,13 @@ static int ecap_cnt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ecap_cnt_remove(struct platform_device *pdev)
+static void ecap_cnt_remove(struct platform_device *pdev)
 {
 	struct counter_device *counter_dev = platform_get_drvdata(pdev);
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
 
 	if (ecap_dev->enabled)
 		ecap_cnt_capture_disable(counter_dev);
-
-	return 0;
 }
 
 static int ecap_cnt_suspend(struct device *dev)
@@ -600,7 +598,7 @@ MODULE_DEVICE_TABLE(of, ecap_cnt_of_match);
 
 static struct platform_driver ecap_cnt_driver = {
 	.probe = ecap_cnt_probe,
-	.remove = ecap_cnt_remove,
+	.remove_new = ecap_cnt_remove,
 	.driver = {
 		.name = "ecap-capture",
 		.of_match_table = ecap_cnt_of_match,
-- 
2.43.0


