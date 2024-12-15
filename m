Return-Path: <linux-iio+bounces-13521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1DE9F2557
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A28163C92
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AE1B393C;
	Sun, 15 Dec 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq3NceQD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079971B6D1A
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287413; cv=none; b=ltFVJMdVrUPqlRCQ0Z7sv6n063ZwXptLxMzcf01BkjXfvtXjefCsIP8DvaCFGZRQRYeUmL8PxNTpkrYJMG3J24jo3I/rXLnLiV+0Fq6yyieJGhfxfe9Eur56YEmBRgx9J9/X1esgX+7SjTX5yuz5TdFCzocJl9u4zsTDdIDsUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287413; c=relaxed/simple;
	bh=PDHdQLnWj/WLnDwPCZayZMmmjXMdt0ZGc+n50t9Oh30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEPxA+657ldRaP0EHFgQBJNRAHVhJ41ZrWDGVYT84T4oDOcCK/2tE6a7XlAllCmhdOAKEGOSNaCh1GPY+K6nkK1IydHxvJZl1C5Yf50p9dyLqS/ACM7270Q/ZvrpU0BKKTAKiT1xvBwS5H6bEop1IzyZ55MA4oqfEPPVa6ZdKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq3NceQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1032C4CECE;
	Sun, 15 Dec 2024 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287412;
	bh=PDHdQLnWj/WLnDwPCZayZMmmjXMdt0ZGc+n50t9Oh30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hq3NceQD5X3mhba/732gAorGYzv1Vbh7/6tL1jiyfBbrbJObLWV0okfBYMGg9xskO
	 +ZkBE+E9llkHnLfVaGCsczguAJQq9AHKWbRL4XN7ogy7Z+XM0BVf/r/2d1PQZy4DBV
	 0GoTdt/FxMCQbLrgu/3hVhI8DBV9hFIdDc6+LlbuMDBIUvM4PL1Sk2KXVEo1eTO2qi
	 BFryJ/RLHv/0k4QllWT4Bgs+5092O6SxC/mvLjEGQQdCncFdpowEnkDUKlRVgIZN6J
	 iTgM50/TZLFGmk/UA7Dg4jwsBLAacKIjJyOm++w+i5hUiT4baBm8uujvSnUkKjTeqg
	 mYDysxGa1J3vQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/20] iio: adc: ti-lmp92064: Switch timestamp type from int64_t __aligned(8) to aligned_s64
Date: Sun, 15 Dec 2024 18:29:07 +0000
Message-ID: <20241215182912.481706-17-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The vast majority of IIO drivers use aligned_s64 for the type of the
timestamp field.  It is not a bug to use int64_t and until this series
iio_push_to_buffers_with_timestamp() took and int64_t timestamp, it
is inconsistent.  This change is to remove that inconsistency and
ensure there is one obvious choice for future drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-lmp92064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
index 169e3591320b..1e4a78677fe5 100644
--- a/drivers/iio/adc/ti-lmp92064.c
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -199,7 +199,7 @@ static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
 	struct lmp92064_adc_priv *priv = iio_priv(indio_dev);
 	struct {
 		u16 values[2];
-		int64_t timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} data;
 	int ret;
 
-- 
2.47.1


