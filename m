Return-Path: <linux-iio+bounces-25311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCDBF53E7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9433189FD4C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485D3054C2;
	Tue, 21 Oct 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B4AADX8r"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A4302766;
	Tue, 21 Oct 2025 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035552; cv=none; b=AtZqdkRVVE11BJxycvCDG3wmRlr3RXcYuCFhvrHKjHkCpTBCZMwEQUp4Fsrsqfyc6BCW0NHi03egwXNobPNCQaSIgDET3xTD3duIr0de0nV2Dz4YnSjv7tC+1T+9Lp60ruBRMkGO+9Uo/Pzm6KQEus33lsDGjqmC3oRAb+QI3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035552; c=relaxed/simple;
	bh=CseAS8WuO07kDc2UBlBpGUtI3Jez99XxHBhRTTJsLPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyaj8mBGFBupw6dA09KwN+QqIKSVBSLLOpW+oWtBvYCjeq6b+uvxIdUU9gxLEtM89V2Ocf9STRYJppSe/p/U6IyUA2mSgnNtEmTL4thWSNIzqhLSfaBu6o7Bn2DYYfZWGIrUvxnzcwdwqkI2X+Og3n5VQFrgKMfcneSuNh4QfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B4AADX8r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761035545;
	bh=CseAS8WuO07kDc2UBlBpGUtI3Jez99XxHBhRTTJsLPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4AADX8rLFyo3TzCUBKsHaGlGLG+RHSHcG/4VOnxhbzvG3F2RFYU3Mcj/mlGcrheD
	 ET5UDhA1eP6yO0gQHt0ysqSYuLVnGjMCz7HLimVRaFL2uLZGroiXyzyWNTBZGMuXxn
	 9DkTp9Jzlxd2BQ0ToVx1RYj2EiPWLMp82SlcYpIUSXcuh0zh4f/206HvU30dBhNPG0
	 W5/vFSRBX3g3zv21DH5AsI3hHmAuvP88zznH6ceHpNrV61FkYctDOHVol1S2lKXwoA
	 /qRpjQrE8t5zO+oL/LfHusv7Wx+OJ71OZHGOOZ4wlrrnHD725AdF7GF8QWqdUQ+E1s
	 QzLMnE/1CJDBg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A07C717E1407;
	Tue, 21 Oct 2025 10:32:24 +0200 (CEST)
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
Subject: [PATCH v7 03/10] spmi: Remove unneeded goto in spmi_device_add() error path
Date: Tue, 21 Oct 2025 10:32:12 +0200
Message-ID: <20251021083219.17382-4-angelogioacchino.delregno@collabora.com>
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

If any error happens during device_add() just return inside of the
conditional, as the goto path doesn't do anything else if not just
returning.

While at it, to improve readability, also change this function to
explicitly return 0 (for success) at the end.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index c21789c6b59f..29567c0620ae 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -69,13 +69,11 @@ int spmi_device_add(struct spmi_device *sdev)
 	err = device_add(&sdev->dev);
 	if (err < 0) {
 		dev_err(&sdev->dev, "Can't add device, status %pe\n", ERR_PTR(err));
-		goto err_device_add;
+		return err;
 	}
 
 	dev_dbg(&sdev->dev, "device registered\n");
-
-err_device_add:
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spmi_device_add);
 
-- 
2.51.1


