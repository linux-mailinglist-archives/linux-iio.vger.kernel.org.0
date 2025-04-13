Return-Path: <linux-iio+bounces-18045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3FA8718A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A887A7E8F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40815199948;
	Sun, 13 Apr 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqNGk24u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017382AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540499; cv=none; b=bSwvWd3orybC5EUXML5ToemHwJjBC7hs4rSNdbjX27954Svdat9PAqe5dFgunOO7L+G6CP6Smb+chGlO9oQtzHlFkvCCWCf+vyIbl7HlasP2Dnvqa2bTNjczqMWuHkE1Ev8xLkk12rKWziB0fGj6moZ/uVOCAjz5hjgdZiLX5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540499; c=relaxed/simple;
	bh=svSnJ73O7+2+ZFRUy7Ep2cyvVHFCuDBl/x9QMmlIRco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlSvS/31873vBmNrAC/isuIwuxV5tgB+fQckLhSffMdNkL8yPBznH2FBxdVa1Clgm8tSUsmEXrIw1CGJ58J1aURq16C3+bvJTcosgme1nic9vn7VAM7zUoBrja/ljAyAUR6Ak72Nku7A9zILQuK3hqb6BjpdzC3FRM4c0BI/b/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqNGk24u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3481EC4CEEA;
	Sun, 13 Apr 2025 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540498;
	bh=svSnJ73O7+2+ZFRUy7Ep2cyvVHFCuDBl/x9QMmlIRco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cqNGk24uXppZGYElbpxu/1/wunclD46zc9HKgARdwI9KQ/4hlpCWoKrgUZXt6rOft
	 l2+dBQCH0xdEDVXqr+IO+BoDD02ACRrzb79F0qn+15nLgdd8X2ih/izGNjFq5zO8+B
	 Lqa5ew4gam7szgj12nW74Em9/DXMVwMzdR3mkZsF1S7xdmZzcKChxjcCpTElZpusP7
	 YtdL3mOHiljfmh/zHWRDFt0KsEOPJ77ayDH9gzRljEY3GSvwioinPOcbm/0WrKD0qK
	 3If1MK/zeio+GDRFoYwHDCtv3oC/DNqhTTDkQMX2OZAGFpzRoeJi3RiJV6w0ld8L1o
	 /NDFHi5BDIHhA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 01/20] iio: adc: ad7266: Fix potential timestamp alignment issue.
Date: Sun, 13 Apr 2025 11:34:24 +0100
Message-ID: <20250413103443.2420727-2-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On architectures where an s64 is only 32-bit aligned insufficient padding
would be left between the earlier elements and the timestamp. Use
aligned_s64 to enforce the correct placement and ensure the storage is
large enough.

Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16") # aligned_s64 is much newer.
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v3: Improved commit message (Andy)
---
 drivers/iio/adc/ad7266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 18559757f908..7fef2727f89e 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -45,7 +45,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
-- 
2.49.0


