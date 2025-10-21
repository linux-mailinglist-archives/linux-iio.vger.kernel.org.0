Return-Path: <linux-iio+bounces-25308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E93BF53D6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489173B30D6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6555304BB3;
	Tue, 21 Oct 2025 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JvJVtvLP"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5432144A;
	Tue, 21 Oct 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035548; cv=none; b=delrJSDIodIENWAIYWejdwEDBJxqSsxya95BPrbAQf2HOeo/nzAvW/jj+Jo5y8oWQtxjaurXXHDWmVIuOQ6LqSJtP9TRBrtXeJ4i5PNX5R1eVYacyXCNpx+iubpUg/aSe6/BgEjJHdS4QwPOlOLHC7zLtfFOUnrmxf5E2zivXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035548; c=relaxed/simple;
	bh=9WiKUoDPbDTG0YYpcvJsCalGKUIGyxlOLCHKpumDdn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs733G0ayHSQACYcWNETbCTFR8/gkY99oTQewNfEPoR/2qRAqnutxWHIEP0V1Rqw+sPv7RtGsOnP10kZDom32iJlXbFPbpAGoHYOhPtrf8UC+FXP54kmZFZV0+n0ITwhANQx95z2/N8O9S1G3FxWIzP+XMUwKfIZY+jH2XijITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JvJVtvLP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761035543;
	bh=9WiKUoDPbDTG0YYpcvJsCalGKUIGyxlOLCHKpumDdn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvJVtvLPPMigCExZuf8LlO7aIDbIx0fYth5gxxVqBYEeqBwwF+Z+wX54csrpsbiBw
	 FD1ESVsUjd1zGmqQFlwTLYSm0ejrBy43x5SM4ymI03rlAlIMEO5t+ZTdeAkaoXMcZ0
	 KnpmcvpVWw6f/yNugAg/W2165V/XwZFsoSlF+oSNYEjGRpQ2YVpkBQk+dbGG4N6tpR
	 jlhq1Hiw8RCx26eS3A6Zlb3OHGB73W+2dajWAEwAnoOajv0ddcInyYwy+zj2/uG3/Q
	 9FEOK2q5qyR3G83VUo+aKtZl34tCbQKkGnqOQwhs8sPvkxWQwuWXCXyMkANpZD4AkI
	 JF7YJdr118MAQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB51617E0456;
	Tue, 21 Oct 2025 10:32:22 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	sre@kernel.org,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	wenst@chromium.org,
	casey.connolly@linaro.org
Subject: [PATCH v7 01/10] spmi: Print error status with %pe format
Date: Tue, 21 Oct 2025 10:32:10 +0200
Message-ID: <20251021083219.17382-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021083219.17382-1-angelogioacchino.delregno@collabora.com>
References: <20251021083219.17382-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of printing just a number, use the %pe format for error
status, increasing readability of error prints.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 3cf8d9bd4566..bcb71f25194f 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -68,8 +68,8 @@ int spmi_device_add(struct spmi_device *sdev)
 
 	err = device_add(&sdev->dev);
 	if (err < 0) {
-		dev_err(&sdev->dev, "Can't add %s, status %d\n",
-			dev_name(&sdev->dev), err);
+		dev_err(&sdev->dev, "Can't add %s, status %pe\n",
+			dev_name(&sdev->dev), ERR_PTR(err));
 		goto err_device_add;
 	}
 
@@ -494,8 +494,8 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		err = of_property_read_u32_array(node, "reg", reg, 2);
 		if (err) {
 			dev_err(&ctrl->dev,
-				"node %pOF err (%d) does not have 'reg' property\n",
-				node, err);
+				"node %pOF err (%pe) does not have 'reg' property\n",
+				node, ERR_PTR(err));
 			continue;
 		}
 
@@ -523,7 +523,7 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		err = spmi_device_add(sdev);
 		if (err) {
 			dev_err(&sdev->dev,
-				"failure adding device. status %d\n", err);
+				"failure adding device. status %pe\n", ERR_PTR(err));
 			spmi_device_put(sdev);
 		}
 	}
-- 
2.51.1


