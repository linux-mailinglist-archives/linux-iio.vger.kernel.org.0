Return-Path: <linux-iio+bounces-16640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D107BA5872C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBDE166F7E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3F204C0E;
	Sun,  9 Mar 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlJxsIcy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D611F8752
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544532; cv=none; b=oXLkLZYm3JaIUz+D8R3TT4Ok/1lCFG8BukhZkQAleQSyYYNLYSV/rL/Tr5J8RNMGkeQfrwDoJGdIJrZSATJPbiHknFZpfa6TQ8Ek559lnWoDj4wq8f1/phlKK4PzryVUmnty/R/v4F7QS07fXv0zE2yw5c/Oe0kCEyeklPyoQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544532; c=relaxed/simple;
	bh=bnCWghGKRr9mojtqNSZbme/uL3OehPix7A03oSbBCOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxOO4GCauZqSmv3HeQ/ZRCfNCmAuOtQ6q5RF7vtgQzDch7t86jQqmQjnB/ryM1hhUN77mZGRZhlobqoLunovp2M+UYljIxlJw/Cczk5A+gWoDaVOc5V7Z9cw+M1/vRmpfR32+5b478c7sazo+WdYhlXllnQHP1byWyfdta5DOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlJxsIcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922ABC4CEE3;
	Sun,  9 Mar 2025 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544532;
	bh=bnCWghGKRr9mojtqNSZbme/uL3OehPix7A03oSbBCOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TlJxsIcyraflZDSyePU4pHkT5xQWyz0ksllf48KoVvWmyEL5gtplnyNWYu9Slpuge
	 FrIHc4QRVMN+9PNb/OYy/iovbPdvPQHRafEqflDHG6ACab165GVPwbzf5JKEKWUSFL
	 ZXmeN/BffDOm7S7X5+36yudA/X1V/p/ciiyCd2VzutB/SBkanF431hewUhj9Hr3kl+
	 bRSsIvvPv31QMA38x/wkZPyn8Ej8uoSJx6zslyRNhbujKo3nrNa4NN8KLsxYCTgvx3
	 GVunqdVd2gxlaiVccGEUGc1xai7dJnqcv4NTrXOdnZ+zbz3jf5BhbEvZsb/uXL3oVD
	 8MRcReMopvayA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/16] iio: pressure: zpa2326: Use aligned_s64 for the timestamp
Date: Sun,  9 Mar 2025 18:20:58 +0000
Message-ID: <20250309182100.1351128-15-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309182100.1351128-1-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On x86_32 s64 fields are only aligned to 32 bits.  Hence force
the alignment of the field and padding in the structure by using
aligned_s64 instead.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/zpa2326.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 0a510d5fc1d4..30f007794f5b 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -582,7 +582,7 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	struct {
 		u32 pressure;
 		u16 temperature;
-		u64 timestamp;
+		aligned_s64 timestamp;
 	}   sample;
 	int err;
 
-- 
2.48.1


