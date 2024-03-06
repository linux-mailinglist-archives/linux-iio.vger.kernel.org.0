Return-Path: <linux-iio+bounces-3360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBA873DCD
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 18:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9F71C22C4D
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C613BAF9;
	Wed,  6 Mar 2024 17:51:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252813BAF1
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747473; cv=none; b=aMMwpAjWuM2S+MDQmTIWFJOvNaibfLuwK38FHp7zt/L4bg0wA1stYAHwudZM2Dmh3JaTDDPnmVjZqKeWet1CwkKK4GMSCDD0voWaW9D+Z06pABFyeEd2cQTArqvDpPPlrJEM8MZ3iGHsszQLe7FqKK2kcnAvzRTzBxAqW2QVRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747473; c=relaxed/simple;
	bh=eK4NW9Rk4JvCfGAlFvUDp7R7qIYr4GqYENwx7iHN+QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poTvBESthxDBFXKDiu8JQqFge6VeoHcRMW3swTHmIF1KVnvNVfxzGeuBusYi5+kAEvNjJ4B6Ff9+gZ/3mdiK/iwydHWI5iD49GOTkd7RcNo5hO2smv6EPx5NEbN3v/35wkwpi5YTb2f+XGTY4wh43A2R/adhQjR9dHF1L5v9JcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvPw-0002OA-Ls; Wed, 06 Mar 2024 18:51:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvPw-004n6g-4N; Wed, 06 Mar 2024 18:51:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvPw-000ny5-09;
	Wed, 06 Mar 2024 18:51:00 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/3] HID: hid-sensor-custom: Convert to platform remove callback returning void
Date: Wed,  6 Mar 2024 18:50:49 +0100
Message-ID:  <f4c8334ea1548d911862ede881ab0d90a408c156.1709747164.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709747164.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709747164.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=eK4NW9Rk4JvCfGAlFvUDp7R7qIYr4GqYENwx7iHN+QA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6Kz6u4elbe732bZ1momXG+oG1DpXHlk/tdD/Z 6Re+1mS/peJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeis+gAKCRCPgPtYfRL+ TmU7B/0eaFD339wXp3yiNszZyWj0Szdjw2jZdUB8ijcWtke+65zdHwczl7MoPf7Y5ynEyBVFjK9 o7Xxa1DlDTTV57pHtZzVLFDrf8q5ByxSp3ZzLXE8CwPHIdlmqfpnaQAE3z0IB2hfAVMeOuNYNAq rd1AYbhRcDMJtXwKlv79cps8OyOeM8WjQFlfKvD80dlMBDCQHMPO8jnTio89KvWTKPj1eqXTq7r CtYD/dhQD7i18T+n71+Cp72y8v8bNEpKax8Ax+lUVnzwYfKLAFYlxoOTvktFqxqRI7jw8d81vy/ OeM3hCNlc7uyh9J7lJiabWrVfckmyOwfiufuNPNKLM9gfpDa
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
 drivers/hid/hid-sensor-custom.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index d85398721659..de7287f3af61 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1032,14 +1032,14 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hid_sensor_custom_remove(struct platform_device *pdev)
+static void hid_sensor_custom_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
 	if (sensor_inst->custom_pdev) {
 		platform_device_unregister(sensor_inst->custom_pdev);
-		return 0;
+		return;
 	}
 
 	hid_sensor_custom_dev_if_remove(sensor_inst);
@@ -1047,8 +1047,6 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
-
-	return 0;
 }
 
 static const struct platform_device_id hid_sensor_custom_ids[] = {
@@ -1068,7 +1066,7 @@ static struct platform_driver hid_sensor_custom_platform_driver = {
 		.name	= KBUILD_MODNAME,
 	},
 	.probe		= hid_sensor_custom_probe,
-	.remove		= hid_sensor_custom_remove,
+	.remove_new	= hid_sensor_custom_remove,
 };
 module_platform_driver(hid_sensor_custom_platform_driver);
 
-- 
2.43.0


