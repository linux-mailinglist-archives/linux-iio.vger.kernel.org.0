Return-Path: <linux-iio+bounces-21096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D78AECAAA
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 00:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EE817311E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 22:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC882517A6;
	Sat, 28 Jun 2025 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="snyhA2IH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AF235364
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751150333; cv=none; b=CDPMiuSw0T8TSwKEZhn2KelESPuknhufHtUaAjriYnl7uT2eafHU8hi6qvKh2ZJs9UCtgE/1/6bqT8SxKPohXq8WIinl9/vGhHEDC19bAQIl+uPBlKc/Uxdf7jdlqUF/hAfWDTXliZUModdpq9UGSKZqoRWMVdwyqjm8x4+gHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751150333; c=relaxed/simple;
	bh=XyXSzTh2k1kUsY/wpFoMC2iSmO2Wiat8DO0p2n4qvd4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZi5KUXzptCpwnOmkjgHmEGCpmV16sQA2ZwVVVzW+y5ZTv4yBmvnSdVf59fbT2PnUNQOSAMT6NzUpk4IAvfutnxrt3tZDOv23HJPcuAm9RP2F5yOHZC0JMrEC8xTt7ffzxq/y44AgzRpU85cQ3ZHuwEWacVRorZjJfjiY0oz3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=snyhA2IH; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30624 invoked from network); 29 Jun 2025 00:38:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1751150324; bh=g4D4A8XAdpX1i4Oxx8GKbKsEsP87KOS/0voX/OWNYJ0=;
          h=From:To:Subject;
          b=snyhA2IHcT9W6z5L2uRF9hYG2TAKfFXK42R8PScodBY/tr+9V01QIGJI/a2Pacg3I
           7bNjQyij1sT9Ura0N5nxwA7mdRyT/bwRX26Yv7rzIKBPqe79CY0jylSSmK77Aq9p/f
           sixeZUB7vK9+iTmZ1NNqUmeNgnAJWrE4rYQe4H2KYhXdZ0YuTzLS5+fQJIZaiHJu1V
           UEAof7cKFtPMJZnFQGbaAYJJg7yY+nCyGNZHC3cY18kQ0YHyop6ksYsv39vfgBmTja
           w+LTDyvsAbgm4XaCUv4LSC7gG12bkh93zR+9kgzDKBu7CmQht6uoUPwvdk9iEz673H
           LytEWgEI4M79w==
Received: from 83.24.145.121.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.145.121])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 29 Jun 2025 00:38:44 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/3] thermal/drivers/mediatek: Add support for MT7981 SoC
Date: Sun, 29 Jun 2025 00:38:36 +0200
Message-Id: <20250628223837.848244-3-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628223837.848244-1-olek2@wp.pl>
References: <20250628223837.848244-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: f11e1f19f95536b631eb315c46069eaa
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AQOB]                               

The temperature sensor support on the MT7981 is exactly the same
as on the MT7986.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 9ee2e7283435..020324901505 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1149,6 +1149,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 		.compatible = "mediatek,mt7622-thermal",
 		.data = (void *)&mt7622_thermal_data,
 	},
+	{
+		.compatible = "mediatek,mt7981-thermal",
+		.data = (void *)&mt7986_thermal_data,
+	},
 	{
 		.compatible = "mediatek,mt7986-thermal",
 		.data = (void *)&mt7986_thermal_data,
-- 
2.39.5


