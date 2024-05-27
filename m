Return-Path: <linux-iio+bounces-5346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C18D05F9
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C82E1C224E3
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558573452;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqq0Oumi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22761FEF;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823216; cv=none; b=rsieb8pJ4S5kg08GtKMLUSCCU73P7vNEdyNM5YlM7Fdos9UNp+eds7XIjokil+a4tP8DmyQFiX1xibADbib3Ky8c/AoFsDzCf8fGacRDl3ji7VzcuxIr//4F9EQVfSaqu6/poTDHDJn4OdJyCMDNXEyBabT1Jkqwhq6WteDmHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823216; c=relaxed/simple;
	bh=jDeJ/2LLIq3QhO9uL4NshnL3jZave7YV0UkfwYZ8P+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQnAYXZirpmir5I/yUgUiK9RyVbMoWlaUFXhAxgzx7qSDJlekWOK7WC3c2lSRnHb0qEdUMSCjw71QmFp0WNtkyZ5kquZLN8613aGqXl1Q2CQxBIWWU9Ub+Q1ZdPOd14t1mKKUDYxJz8X70hcD6t98stpQX6ZCIgxZ8+jIOeqEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqq0Oumi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 462A8C4AF0A;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823216;
	bh=jDeJ/2LLIq3QhO9uL4NshnL3jZave7YV0UkfwYZ8P+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Pqq0Oumig8hpKuTe8LztOoZThZFNmcmVKansidyAQaTmV6OFEDnyifjM0bmoz0NR+
	 bZzYYfAyQx5Nxbfl/JTbpUuKrg9atfViMf+JLqO2x2YO4J0Tif1M+Uv8ob5746g8Ra
	 VlRVMWuVyT9tsZBvLCwLrDh0HdtRRrIdQF6/krcJS9omio7WYyLs6/n1Sg7xs3V+KL
	 ABZ1IAzISDJ5VGT0C4EDgxak4Rnxl4L9v5KQnihO+WNqJGdQPtBo4gzKyh6WZ3lelX
	 PSps+VHTj6lgYk2+/IButh+YwzgJ9cP2QOKLaQ/fymbYTCeORwtD2U8UY8DZzp3aTc
	 gSNzGeia3qIvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C59C25B74;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 18:19:52 +0300
Subject: [PATCH v2 4/5] iio: adc: ad7173: Clear append status bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-ad7173-fixes-v2-4-8501b66adb1f@analog.com>
References: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
In-Reply-To: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716823214; l=1000;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=3Lih309+QmE+/CCcvFgIQ2n+1Fi+3MwieGtcQTnVs2U=;
 b=rkyQI3J/iTkzHVDAvv+RknEc66IoqXsONEJQUo/RgjWt3qq4jKv58P3m3YfQV59D6IFlE7VkS
 bDsxFrLnNTIB2LxSDoRYNkIPMOJhJvsnLYesmESFEr458lsW9Q+Qozp
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

The previous value of the append status bit was not cleared before
setting the new value. This caused the bit to remain set after enabling
buffered mode for multiple channels and not permit further buffered
reads from a single channel after the fact.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index eb512878c30e..e66a137a76be 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -543,6 +543,7 @@ static int ad7173_append_status(struct ad_sigma_delta *sd, bool append)
 	unsigned int interface_mode = st->interface_mode;
 	int ret;
 
+	interface_mode &= ~AD7173_INTERFACE_DATA_STAT;
 	interface_mode |= AD7173_INTERFACE_DATA_STAT_EN(append);
 	ret = ad_sd_write_reg(&st->sd, AD7173_REG_INTERFACE_MODE, 2, interface_mode);
 	if (ret)

-- 
2.43.0



