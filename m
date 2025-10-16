Return-Path: <linux-iio+bounces-25131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD6BE2E7F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 12:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2793AB63A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806B3203A9;
	Thu, 16 Oct 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OETseGVq"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646012D4803;
	Thu, 16 Oct 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611460; cv=none; b=L2cRtXQXbKZdc0TpEaW5ojofGIsnLiKC3pzQnFcRkLRap0KZfbHR8fSyDlgtb0hCprFHDXRZMkcBIXWsOynxYjglUXIcQz5CRx+/LwEu8GN26vGuze78Imt16E8j/UOIAxUlhd/8IeI6GavdDCMY9/qSqWTcHovd4oq2vC9S0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611460; c=relaxed/simple;
	bh=GNGbXkx5g66KghcuTCF7WYhpXkKwkYjL1KKYUygGq/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkjS8+X1m132aGGi20/5OHQpp9ZpCS/S6zSgw0DRIm9dWmf8e4I3cOWJtd5ZBtJ5dvPMUvKcRFatmxFvIjvD//7/MEGPrTjGwyzHHRBd4I8WHkmUP7TSsVl/cfWJV0iK2HwcHDpfJd7EwN6gHIxfxeEae7/wOw8UMO6w3Bvjbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OETseGVq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760611456;
	bh=GNGbXkx5g66KghcuTCF7WYhpXkKwkYjL1KKYUygGq/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OETseGVqfOq04SqEZJiNQ1iMjUJmDDzxjybto6AD4cQe+Dao3b2D8JKJrWO0TyH5Q
	 WB5pN81ydtDZi1daFt6F9QvHBTvcDu/wfYndHK3tDpETZCFBzzYElOme/7ibnhAgpn
	 Hp0G/aHDQG9HsAFU5XenCtNtPOdOkTeyIGfwMoe4zEVpega5fDATtsvFKcEFhP17wd
	 4NAQLLgWmZiHFrLu1nLZVYTSPfVKEBSRSdn4cdfntZ/dOzJMbBqljN+BSFb9iHzJ+8
	 zzwP5gXM7DQN6kxHFiuwWx+yp8B2s0vOJv43MMoi3omfZiz+rC0IC3lBYYieLvTa9Q
	 k73DMwLFxev1w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D3AB17E0CF8;
	Thu, 16 Oct 2025 12:44:15 +0200 (CEST)
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
	casey.connolly@linaro.org,
	AngeloGioacchino Del Regno <angleogioacchino.delregno@collabora.com>
Subject: [PATCH v6 1/8] spmi: Print error status with %pe format
Date: Thu, 16 Oct 2025 12:43:55 +0200
Message-ID: <20251016104402.338246-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
References: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of printing just a number, use the %pe format for error
status, increasing readability of error prints.

Signed-off-by: AngeloGioacchino Del Regno <angleogioacchino.delregno@collabora.com>
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
2.51.0


