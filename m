Return-Path: <linux-iio+bounces-11972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9569C0496
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 12:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B331F23A88
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FAC20EA28;
	Thu,  7 Nov 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oOwdF9Xh"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBD1E1048;
	Thu,  7 Nov 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980077; cv=none; b=DOPRcisi18WEn90A5sjk9KzsifO2OsDeftdk5IocyuIvQ7qn9u5HPMU8aornUQ2+RlWCPcKemlv+JbuBPTn8dx6GWWTyDIjYJ8bRS7Tpqb+x5yMYarH2lDmvdwyAlr/nDb+fYjqu2miJfV/ShDIRY46/5st0YuCZovyoF8h8yJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980077; c=relaxed/simple;
	bh=/63pllMZ4i5KoE/zuOj7Bb093fiOC5mBGNF+IAAjJ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVzfknk4e9CiGybXtqqGkXBTR5Y5nsbVSY7WfBmB7jzThZoxyl9LBAOKvvbsAisZRTf/qSQc5M+LtsTsd6pkiIaFWR+VBBYtPkjDodVpT9BJxnMsHIAlMwyJI6M/sHmP5HylwG5gbfHLW7a6hFWxcRw/N0tebwOLjXpuNni0Yrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oOwdF9Xh; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rPKia8mc29LBHIBoWFB0OJoeWWo9xwpVLeKPu0E5yTY=; b=oOwdF9XhUQua5TsDyAUqVgld6g
	q1t6fDXZRQJVLg30c7i652Mp6G3/GqiqGB/k82Kyi7YNiXtQxb8kN+sgM5zpd9UG+Xkk3R/H84nbB
	pAvSHCi/uWHzRhJQyXKMNDq+15gxh3IpcAa4l/41wK0jUUQpurl1GVhhkc8PWU/E0t0Enkh/feVuL
	1KhS9DJ6OzyvTqreMGctZQQlLGOUNTAGh5nK0B11pB7jJdqhZZUjR0OtMJxzUydbv47KaN1Z43JHO
	Is7Arus0usp2Gmdufp6kQiJKJ/PCHIYoP9W1qpxDr/N7y3yH2anY4F3xaEYoHFOv569J7qz2BMbuS
	4x9wIXvg==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t90yy-0005lF-Nn; Thu, 07 Nov 2024 12:47:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	jikos@kernel.org,
	jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	pavel@ucw.cz,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	heiko@sntech.de,
	stable@vger.kernel.org
Subject: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale platform-data on remove
Date: Thu,  7 Nov 2024 12:47:04 +0100
Message-ID: <20241107114712.538976-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114712.538976-1-heiko@sntech.de>
References: <20241107114712.538976-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hid-sensor-hub creates the individual device structs and transfers them
to the created mfd platform-devices via the platform_data in the mfd_cell.

Before e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
the sensor-hub was managing access centrally, with one "completion" in the
hub's data structure, which needed to be finished on removal at the latest.

The mentioned commit then moved this central management to each hid sensor
device, resulting on a completion in each struct hid_sensor_hub_device.
The remove procedure was adapted to go through all sensor devices and
finish any pending "completion".

What this didn't take into account was, platform_device_add_data() that is
used by mfd_add{_hotplug}_devices() does a kmemdup on the submitted
platform-data. So the data the platform-device gets is a copy of the
original data, meaning that the device worked on a different completion
than what sensor_hub_remove() currently wants to access.

To fix that, use device_for_each_child() to go through each child-device
similar to how mfd_remove_devices() unregisters the devices later and
with that get the live platform_data to finalize the correct completion.

Fixes: e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
Cc: stable@vger.kernel.org
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/hid/hid-sensor-hub.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 7bd86eef6ec7..4c94c03cb573 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -730,23 +730,30 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	return ret;
 }
 
+static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
+{
+	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+
+	if (hsdev->pending.status)
+		complete(&hsdev->pending.ready);
+
+	return 0;
+}
+
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
 	unsigned long flags;
-	int i;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
+
 	spin_lock_irqsave(&data->lock, flags);
-	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
-		struct hid_sensor_hub_device *hsdev =
-			data->hid_sensor_hub_client_devs[i].platform_data;
-		if (hsdev->pending.status)
-			complete(&hsdev->pending.ready);
-	}
+	device_for_each_child(&hdev->dev, NULL,
+			      sensor_hub_finalize_pending_fn);
 	spin_unlock_irqrestore(&data->lock, flags);
+
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);
 }
-- 
2.45.2


