Return-Path: <linux-iio+bounces-19476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC0AB414C
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 20:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3C419E7AB4
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D8296FC4;
	Mon, 12 May 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8j8WVFb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D296296FAD;
	Mon, 12 May 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073040; cv=none; b=Dd7P949tOJcZbSd7liVcaOHhchDyIKJh0uNTOFoEQiQamRVsiZu4jXLJbXi+6eVwk5apXAk3hWFXIPZ+13s+wo10El1WjbZtUB97TedNUXEh4x9uH3QuzW647Me04eTSGeVg6JUkwq/1OvmytpQ6o7nKt0H+AvR9O98e2xtmxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073040; c=relaxed/simple;
	bh=McqaIT+gEMWfbbCa1ee9IekzZwCIcHhQs2BJ6/L+maw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJq1yOOBGMbmC8Xd0px7Dt+/vHFUc8HcHtXMs1P5GqDT2479PrMdB/aCGp7DbTj7qCtBk6FDExMamRnh6WXYuahuaC7+YWkGszn9G4/YtVYzjBWldPB5ASMphn1Dbu+wsitVB5qOHmoVVgGbDhRpHRNNp1ROZyT6+Nv114kHJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8j8WVFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E848C4CEF0;
	Mon, 12 May 2025 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073040;
	bh=McqaIT+gEMWfbbCa1ee9IekzZwCIcHhQs2BJ6/L+maw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8j8WVFbRYDQ7p2cGDUpVltik/CuFPGfzbfrtUu5EMXoPv3ztPLMO8ieK3PYuaAU/
	 W8ey+MK1EXOPkQGtGKgXUjvXkLt1Ach/JmFdZ2eDApUNIbB4+U2aKj4xl3xDFpyB+e
	 2HN9k8aWDBLZF0UTaxH1sqwZMqLWU8Bq1X5xFZKYKwbuA7Gb342Yfn5o09PiOxNji1
	 DMkEXNyUlaSjvS18LbA+LWvhRT/RLVeJIzVaCVc1tDeyWC6YBm3bWkgpv3uHbPd/O0
	 MiH3q6SpyIPPBDmjOlooRLhlO+eXGXzGhlQoUqRwstBIu2ut72R/YZ4sOVLXavP3Dw
	 StKiuf6pZ2w+g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 02/15] iio: adc: qcom-spmi-iadc: Fix wakeup source leaks on device unbind
Date: Mon, 12 May 2025 14:03:37 -0400
Message-Id: <20250512180352.437356-2-sashal@kernel.org>
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

[ Upstream commit ad3764b45c1524872b621d5667a56f6a574501bd ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20250406-b4-device-wakeup-leak-iio-v1-2-2d7d322a4a93@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/qcom-spmi-iadc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index 7fb8b2499a1d0..b64a8a407168b 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -543,7 +543,9 @@ static int iadc_probe(struct platform_device *pdev)
 		else
 			return ret;
 	} else {
-		device_init_wakeup(iadc->dev, 1);
+		ret = devm_device_init_wakeup(iadc->dev);
+		if (ret)
+			return dev_err_probe(iadc->dev, ret, "Failed to init wakeup\n");
 	}
 
 	ret = iadc_update_offset(iadc);
-- 
2.39.5


