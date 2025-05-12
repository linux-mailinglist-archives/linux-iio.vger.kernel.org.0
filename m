Return-Path: <linux-iio+bounces-19477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B2AB415B
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 20:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EF31757ED
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAA296FDE;
	Mon, 12 May 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF8f/kSs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D91296FD0;
	Mon, 12 May 2025 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073041; cv=none; b=klbhfwDVTrF/uufUgK2O8yg6fHXN9vOjCnIfGjEyXhnPSWXEZjE0FL/sXiJStWI4ovXXttHy+E30gzEBzO5DxrAz9FKQKG+NBHuCGOq3Yw4sLbuofh9d/mwcakTMLubetJMcnB9v0d0EGUIylXxDvIlZmEFIz6VGwLyAm2yVEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073041; c=relaxed/simple;
	bh=cfwhkIvCUQq1I3YtpJwADzwcB+M6wGxuTXs51KteIBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3eDHanZ+UKCFj5Bt+RTOE9i0/wWMB+rHyqaul+ZO+rpLHnHjt5oYT+UOdOUYM+vwvNxybOU6KX3qkW1N8Qn6dD17eAqoioZWxnk2xS4ME9Fw3RAfSbtKU1mjhr+M8l9TWAkGrPRHiDhGeCBx7PCyAtr3Qx3l0BNou/sc4xgWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF8f/kSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99736C4CEE9;
	Mon, 12 May 2025 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073041;
	bh=cfwhkIvCUQq1I3YtpJwADzwcB+M6wGxuTXs51KteIBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF8f/kSsCr0yy1WWXTFFeheCdUh+0r6iFw4qSJDMM1RotoOBdIgy9jvGtbSBp+swX
	 qz2ZcOg7kI/gVexUbjpY//0AipxsCBVIT+21AcE8jW3keV0e1LnFyY0gydpy7ueS5I
	 rmKgX5KQt/yNb80UQGVXF+jtQk1ImX8sqlhbQQv5OfxzfzSrrAZVu2myY+byXzB8Ou
	 sPKxyMNJrELdcUOuh7nhY1wmxUQZjGoyULXh3u9tuhpPfgTQBMTSgGsgETZdoknW+d
	 RilbdMGRHzCcVKAqPRSUOSyMg6fUJAb2XzqB5DVhGYKuL/HnYqPLatlNYfrdeIEyKR
	 a28BUEN+bkBeg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 03/15] iio: imu: st_lsm6dsx: Fix wakeup source leaks on device unbind
Date: Mon, 12 May 2025 14:03:38 -0400
Message-Id: <20250512180352.437356-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180352.437356-1-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 4551383e78d59b34eea3f4ed28ad22df99e25d59 ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20250406-b4-device-wakeup-leak-iio-v1-3-2d7d322a4a93@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4fdcc2acc94ed..96c6106b95eef 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2719,8 +2719,11 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	}
 
 	if (device_property_read_bool(dev, "wakeup-source") ||
-	    (pdata && pdata->wakeup_source))
-		device_init_wakeup(dev, true);
+	    (pdata && pdata->wakeup_source)) {
+		err = devm_device_init_wakeup(dev);
+		if (err)
+			return dev_err_probe(dev, err, "Failed to init wakeup\n");
+	}
 
 	return 0;
 }
-- 
2.39.5


