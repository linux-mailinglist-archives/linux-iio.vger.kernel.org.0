Return-Path: <linux-iio+bounces-25310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7068BF53EF
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD183B24B7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEDA303C93;
	Tue, 21 Oct 2025 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kucIaksK"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F4321F20;
	Tue, 21 Oct 2025 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035550; cv=none; b=f4A8JHdWvOYns+E2T5T69HpCzsrjdGcbLL6r8h8QRq50Yy/oSxhuIAopMS3rgvjMfEHGsG1J+qJ22xRwTBYZbIu4zLEDoeyt/kDGGIBle7ZlGNJqCwPRPkiN+ZVCt/25udl9VG/WBL+5W3xds1irQnZEbK9456fgJUpSdHnV5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035550; c=relaxed/simple;
	bh=SWpTT1AsvwN9BcDXeqkBEErSLe50vRw5nVI48pkTpyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEaMwo175dcPu7Q8yEcTRCOqz7EH029a3EkZY9tZoqRFbKT11gTLotxYpK/UX1yXS04d2O3agDMiba6bI3Nn0QqbzAcqN+9KbUiN5a0xqyU1ehWzyxOga9AkWANwPjCjRJdjqBPQwnVC4CRzwVNmkvgnS4PEuhiwwK9dNOXYh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kucIaksK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761035544;
	bh=SWpTT1AsvwN9BcDXeqkBEErSLe50vRw5nVI48pkTpyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kucIaksKWvlcEaeRMHFzCVMjelqrrKFtEkaYL3kta4pjYcpDyiiGlu2I8mQwZSEYR
	 38gDg9d21afNLOK4TD2y0k0xMFkxin9H+LzBdyJOpkYncydkMdqhMf9mCKrTEgZXZx
	 nTel9aLqIJ2Ixex4eJpb6axAvg+UBfdytpxWtX/82IBtouWCV4uwXH5s9J2aeyWPew
	 l+OX2HxuuVU/wQl4PfQ13OXyodtAMslyYLv/7+Tf/YOA2PaOavru210YSTMKMr7eFD
	 C6N1JZCcyGG3W5wQEwnxh4M+PqzMd/Z3qyean9Edxr/8deR1Mix2WVTs1nEO6p1RE+
	 Ojuakuy57o/hA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BEF9D17E1305;
	Tue, 21 Oct 2025 10:32:23 +0200 (CEST)
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
Subject: [PATCH v7 02/10] spmi: Remove redundant dev_name() print in spmi_device_add()
Date: Tue, 21 Oct 2025 10:32:11 +0200
Message-ID: <20251021083219.17382-3-angelogioacchino.delregno@collabora.com>
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
2.51.1


