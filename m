Return-Path: <linux-iio+bounces-17706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3823A7CF2B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7518816BC49
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3896C18E377;
	Sun,  6 Apr 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAepdR7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7271487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960068; cv=none; b=tdoBYikj7zLvnyfbWCOH+QHronG5KMyT7pTgBBUuXZBP8VC24maT1zrm9JjTZL22keyY2bhLIBdsaUMBaz9TBjaUSYAZOO/xXggryCFcY+lgJH2MKMJoVApsF+n3MVqJdWIF4jNhKziZOHwV8IuP8N5et8OEABSnCytl1zCtZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960068; c=relaxed/simple;
	bh=js0cKWb2TK+NH13fFKlcUicIJeUNidrwWY12NGr2SII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lolWCIpXHw1e+jPwTjDdl43te0gi4Dz8S2y3KpvpJGDRQyHwF1z+zrX2cLidGZedSlVlkbD7VMPHIN/tg3wGIx653JqvrSwkQGfgZ/uyTPwNHsy+7xy+Nz9prlSbjHWTgozNymJLKnggmBjpnl/F42hy1lst2W3iRNwvzRxCjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAepdR7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BBDC4CEE3;
	Sun,  6 Apr 2025 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960067;
	bh=js0cKWb2TK+NH13fFKlcUicIJeUNidrwWY12NGr2SII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAepdR7s0B2rUPnZsGSJFzv0pQWPWudHWFMWZ8twzKXzbr3uT46hnp3CtSC/LvmfB
	 XhD5OQgS5CLUUV62rQddhMZOa8B7paN1OGKDGIhMJ6vgzrFizGGOIdKwk38w+Ke9Zz
	 /3AkTgtETcyYGAS0NAXgDkKIVXd2RmpawV0DRxCdOrbsoWSNrMBQI3HN+cEHC5QDAB
	 2DEonf81OL5O5cfjBlet3SykXFvTlVbR3NzHxTlZCKwWCznqa6OUeDeS4Bd9e69XwK
	 bYpbUOYfbHz3WWL322U/01vjT6fuQIcplWgWc8cMOGXKFdJfOFZJAKC7JJpokuewzu
	 k6solSQyVH50g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 18/20] iio: pressure: zpa2326: Use aligned_s64 for the timestamp
Date: Sun,  6 Apr 2025 18:19:59 +0100
Message-ID: <20250406172001.2167607-19-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
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
2.49.0


