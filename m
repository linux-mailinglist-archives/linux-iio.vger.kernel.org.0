Return-Path: <linux-iio+bounces-27693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15089D1D2F0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A99AA308BD68
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B091937FF46;
	Wed, 14 Jan 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ioJIkF0y"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9D31B805;
	Wed, 14 Jan 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380009; cv=none; b=aOruzY6IjsNTc45pTuR9/3P8gVGIA4rbqB5y663lU00uyAonZXGDTzmd42rilQqhNk8kXmm+AkeIcfdm8bQS/M4bMD/sXCQPBmr5+Q0oBzZYBzZ1JPavlyqSfX2vPTGBfnQWaseG+819xkCMJyVRRBH6t5jTqqGu7HVRB0iWxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380009; c=relaxed/simple;
	bh=puglyhIXE+LNwfUJWKVRL/k18ozKRTOIa2afD4k7Cn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHzsFOmQxI8d5vtZKb/+My0JSOKJVMkLye5wsRmmwjAr592Trv/8PM05ketxI2T6sDpcWSaZJt3yaw280TEuJAO7Uq8IEt0A0ftfs9ZwHzNsj0MPTrKftEFEUKjpNrW1q3cUTzJOgGdGphbnz76vSP2N6JeyhV+HbUOu0jdl4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ioJIkF0y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768380003;
	bh=puglyhIXE+LNwfUJWKVRL/k18ozKRTOIa2afD4k7Cn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioJIkF0y4OVpLlsGXj2OoLbqdVB7A2T5bSxisYk5Mg3D+HMriQ8fnAb2ougRv4h4M
	 sDNtCMPyJ78ttiUehdNEQGPdnCL3UEgm7d5aFNJ72N9Ecvjs5SLwlafwEOyViIJwaC
	 l5NTK/LKirMagvW/OzRHqgNjhgYyZaCyZuz+u9QKfIoRh3fhUYCEsITQ28bK9lkTXE
	 cSEASCy4NgjwFokSM9oKBskf7IDGoycmgjkNYptBkLYcj7exzE56kBoyXZlb+N0Uv2
	 LMkphDSjVXPrXheQtquzqtAss/UAtmBX6SCP/oX4fqF/CPZGcrCmQnoX1K+3q48hOC
	 k/qtURPKKsHUw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 746A317E1523;
	Wed, 14 Jan 2026 09:40:02 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	sboyd@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v7 02/10] spmi: Remove redundant dev_name() print in spmi_device_add()
Date: Wed, 14 Jan 2026 09:39:49 +0100
Message-ID: <20260114083957.9945-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function spmi_device_add() uses dev_{dbg,err}() for respectively
debug and error prints, and passes the same device pointer as both
the dev_{dbg,err}() parameters and to a dev_name() that is part of
the actual message.
This means that the device name gets printed twice!

Remove the redundant dev_name() from the messages.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index bcb71f25194f..c21789c6b59f 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -68,12 +68,11 @@ int spmi_device_add(struct spmi_device *sdev)
 
 	err = device_add(&sdev->dev);
 	if (err < 0) {
-		dev_err(&sdev->dev, "Can't add %s, status %pe\n",
-			dev_name(&sdev->dev), ERR_PTR(err));
+		dev_err(&sdev->dev, "Can't add device, status %pe\n", ERR_PTR(err));
 		goto err_device_add;
 	}
 
-	dev_dbg(&sdev->dev, "device %s registered\n", dev_name(&sdev->dev));
+	dev_dbg(&sdev->dev, "device registered\n");
 
 err_device_add:
 	return err;
-- 
2.52.0


