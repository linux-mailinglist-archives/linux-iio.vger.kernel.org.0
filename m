Return-Path: <linux-iio+bounces-13101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CA9E491B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 00:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C6B2822D2
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1A21146E;
	Wed,  4 Dec 2024 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDjarH3H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB22066C8;
	Wed,  4 Dec 2024 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354877; cv=none; b=mlsJOBtsKCy/RKLmGvzbM9cx+wMWzMz+kiuiADOHZPO1b8vaONnXwq/sW2yC5BuaZZp6D4OwbrUUapi3YvxmF+Xa5Fc9qKxqg5ezZ2iFZ0PuYl3L1gq63awT7dRXYKOiQ1gUrmrIyTIy0ivH3tNE2S+n6G0ZAUgsbHsY6SObrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354877; c=relaxed/simple;
	bh=jpTOQaHI0cbpRyfMC9YHD2bUg6e9MINi/9Fiq2daRJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJZbZuhf7CcetpCfga+llXbww0RehraEcJN+tKKQnaD/elPkweQESe97yhlpWQfLNBVYiCZda3zDGu1X73jBaSjPHoFcxSzIyRBjjTLzgiDe2gDDoFPN5Slc7PYFlpM0H/hzGBx6yrgzTgPfpt55FFpfmbkSYyakOvaE0m3vpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDjarH3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5240C4CED6;
	Wed,  4 Dec 2024 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354877;
	bh=jpTOQaHI0cbpRyfMC9YHD2bUg6e9MINi/9Fiq2daRJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDjarH3HpgNGbXSKsk9rwEpYTPm6j1zlRE/GJPkuozDnpTveUUq6RW5JtKpf3B5cj
	 7l2b5frg5w4pUeIcMEFUTiSZMMyyiVRwPrbCNiHyUaBWGKtETxk93f9oA73rbIA/Fx
	 ofThjMzJFed97MxYHk2zEKJK1hjX/iNxRQiBrAB5khkoPug7E+txaCiA9SDnnqZMyv
	 sRCiYL8UOyJ1PUV6pco57tDdl87T9Z2x5OLpoMNvQpE78PL1wNfy2F4xsvNQitpfeX
	 In9eTWBnz16qCjCajfNNljhOWJ0hv2ID7tOMQLTvK7HQIv8CcwqPs6Q7uyPjjTu0w+
	 RdluMUQN+RYKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	alisa.roman@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 06/15] iio: adc: ad7192: properly check spi_get_device_match_data()
Date: Wed,  4 Dec 2024 17:16:00 -0500
Message-ID: <20241204221627.2247598-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8 ]

spi_get_device_match_data() can return a NULL pointer. Hence, let's
check for it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20241014-fix-error-check-v1-1-089e1003d12f@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7042ddfdfc03e..955e9eff0099e 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1394,6 +1394,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.43.0


