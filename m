Return-Path: <linux-iio+bounces-18062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F0A8719A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B9F1890E43
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085361A0BE0;
	Sun, 13 Apr 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKxdfmoM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E51A08DF
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540543; cv=none; b=vFcW3eYzw5RBpo4VKZ8Qz9LTrbxgt5fQifHUYqAcQ+9yQ+0jjzcLKbUpEWdOLaTB1CAWOMDKGHritAJbI6mZqj2nVaW8WtJrvaNOa4La6KdjKC50PEHyMPnwJoyS2TEnGJU0YJFN3BHrwzlrRZosL7FuIoURa+YMGfkUBvrbrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540543; c=relaxed/simple;
	bh=5r9r31RBMx2dIw84YeSoHYW0RX5ZPKdhfXyjCUzNHc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFjiLWSJ06oII72vsBbgFjzbFfLrL9DfHUHD2gBGEm/V2pZBYI696rsu+heZVLV+7Vzoqsx6L+JH1kyfAepQWNRJYoXhnLDs48VOLeFGQYu2e5pGdIYrmKTdAuNoCPa4YAX/nWxbmhP0BB1R1kQCjgHGaR4yqJ5AP6/LnILA7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKxdfmoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F10AC4CEDD;
	Sun, 13 Apr 2025 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540543;
	bh=5r9r31RBMx2dIw84YeSoHYW0RX5ZPKdhfXyjCUzNHc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKxdfmoM2g1z6h455C2W+yYdwfR31dwvmA/mMlis6O4QwuRHzLxImBOpttaaidypd
	 FIh2jOTy/52iijMpzcTfNya0KXlDYmEPixHxmfMqooaMnDDQaZIZHwIbMyQ7PGWsRL
	 RPE71SOgEEe7WuMBh4x3KbXgsN63B7/UxTsL000BJy6jGNJrmHd8+ysQudiuUWVt+f
	 eccXUcEB2qNTSzugMpVuY5ltS9zWW3jn6Zu3xyvUQ9dcL0iT0WPwLEcKCgjwnI3jnc
	 6huxua6DwEQFNLOUIOrmu12IM5ReY10d0f8mtyCKnte5W1jYru4e5BkbsWuRQF9mez
	 9A/yKic+XRTEg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 18/20] iio: pressure: zpa2326: Use aligned_s64 for the timestamp
Date: Sun, 13 Apr 2025 11:34:41 +0100
Message-ID: <20250413103443.2420727-19-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On x86_32 s64 fields are only 32-bit aligned.  Hence force the alignment of
the field and padding in the structure by using aligned_s64 instead.

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


