Return-Path: <linux-iio+bounces-5342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F308D05F7
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1781F22FFF
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7473443;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX40qdT8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77A61FE9;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823216; cv=none; b=sm3LRO5UvibSGuP9bWEtfbpy1nrWyYxqpFRaSo/EKmWuaYumDkngyvztsn4atrcROoHGO5VwPP8nDlQtqfvLXNzBZ/+bzaRTNIpEJs2drVID/3F6lCm6aqyjfGMzuI7Q2yHNJTvTM/1mbOEtKl0WZ95mcC4m4ZCVkpjCaCItsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823216; c=relaxed/simple;
	bh=Sg1hOu3VEG/1Zs7niRX5/Vpq317beg+1Hh4A8ALk38o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knUYDk6BYa1Tll+X/ueRL/UurBKAtFxGB+qhPi3i2MjLMvFwk9dE8cZ+kC4xLjgl08NKUfezw4+/nPHCGEQ73SxRqaiXx+DqU63eXt7Pb5Kx8TTOLUUpUiPKsvJEZzPe+e+H1TgLwAG4enWG5Z6Oo+CGNlavaUyfLWFAKaY6uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX40qdT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31C66C4AF08;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823216;
	bh=Sg1hOu3VEG/1Zs7niRX5/Vpq317beg+1Hh4A8ALk38o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eX40qdT8mZjQwz/N2RnWarBnbDo99SUwXPwDNDJau3RSFH71JjL3kWha7W5U95pWb
	 pukP1hnoqjPQMipHzZLuTufTm2CoHdbI8x+tC4hrNwGO7onb/ZQapWSM14lp5W4TOW
	 6hlIFqEPjdZPsgRVjvkIIqj5xSNYvhM0sq/554MRyNeAoxwMSmHmndwPS1dT7B5vKv
	 6kLqRg0E+L3mL4fEozpGY11Oc0dYOoFLs5zmEMzv75DwhVzetBN3lEJQrny2m2Hjkz
	 116sXx5E68/uEu3NMyuy4N7ZLqh3yBVqZRwZNwQvZspAnHMPIaq40Xb/ELbX+QbHSP
	 f9bPfhFfJTn2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D258C27C43;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 18:19:50 +0300
Subject: [PATCH v2 2/5] iio: adc: ad7173: Add ad7173_device_info names
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-ad7173-fixes-v2-2-8501b66adb1f@analog.com>
References: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
In-Reply-To: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716823214; l=1300;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=jyW8M3kG3uqXuCNPYLLJGiYuxqeZCfGKeCCNwqrSJqE=;
 b=DrUTcD1R9ZuJnR/YZHCNSDJvJ7jjkjGobUazPnjtcvPyS6ICzb4aAMgcNMKT9fc7z0y/iQ9Ie
 xbTR9CZyf1rDHa51h7aA+qRrtpG3VM7y5hUs/TlfWgp7xM3bEjO7lzN
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add missing names from the device info struct for 3 models to ensure
consistency with the rest of the models.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 850574437bda..58620be41ef5 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -220,6 +220,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 	},
 	[ID_AD7172_4] = {
+		.name = "ad7172-4",
 		.id = AD7172_4_ID,
 		.num_inputs = 9,
 		.num_channels = 8,
@@ -262,6 +263,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7175_8] = {
+		.name = "ad7175-8",
 		.id = AD7175_8_ID,
 		.num_inputs = 17,
 		.num_channels = 16,
@@ -290,6 +292,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
 	[ID_AD7177_2] = {
+		.name = "ad7177-2",
 		.id = AD7177_ID,
 		.num_inputs = 5,
 		.num_channels = 4,

-- 
2.43.0



