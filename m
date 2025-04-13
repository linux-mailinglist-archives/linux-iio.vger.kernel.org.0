Return-Path: <linux-iio+bounces-18059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE7A87197
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C53BC524
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EFD1A00F0;
	Sun, 13 Apr 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGc8AayH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5BC19D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540537; cv=none; b=Vlbyi3eIfpXlVUFFKFOAL/0/0vHBbyh/6RKW2Y5fqCqWy+xWTF4CFwY72ZIaOwLnOJ5beg2Kgm1lkHnwBOVFZ78zhFutDAxbfZ+YW84s8r38f4yB6AglN/GmozgBoYDNUh10yP/mMnZ9+ZxNHvjJth8Hv2Ag9IEPdIu98PMWu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540537; c=relaxed/simple;
	bh=+mJiOTUlR+o0aNEGRrL7Jf5Fe8fES3DZ+f2VhmqUIhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTU6Ov04WGXixPZSJA1suLoOlMubEYDXkpkRt6wrWGyXlhkcrdfh7bPFXMrCgL9Q/l5iM4rOGe0h9cojCT0kZ4nWJzjrd26T1dwFUOiC5fG3bDAClW5JT694Ai/TXiZMTTh8CGUTQ8ZYRqtNLHk8ULD2rfNB6UpthBgiJwi4oDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGc8AayH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B1CC4CEEA;
	Sun, 13 Apr 2025 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540536;
	bh=+mJiOTUlR+o0aNEGRrL7Jf5Fe8fES3DZ+f2VhmqUIhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGc8AayHzsglUbS+GqpbhBAZ56vOsI8jHg8+5iOdI0ocLVAF6L+1QRuRbO1c0vnYn
	 Q0m5B/EQ/cWlemIvgV5vz6DVJqV31667wObg1XPh0G0rznemtSRCVSNOZ4VnyHhdre
	 FM8T+EhlCKeQS02VFM21/Dc9cAvcKNAMg4HspEsYZkrjNd4lkuutaSCq2D2d9W+BJi
	 QjKE7p3ZdcaitOY7VdwDw8R0vDQp7dnj5nlRtB3f779ariBcXj7CuXIibFSlDwdkfs
	 KDc2MDMVB8ktEOoPCIriRrJWfBOj3c0kt58Ks0ZR5pYMpZfizZ6xwgQGOsanexowKb
	 wD0tTLGaZSJ5Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 15/20] iio: resolver: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:38 +0100
Message-ID: <20250413103443.2420727-16-jic23@kernel.org>
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

This new function allows us to perform debug checks in the helper to ensure
that the overrun does not occur.  Use it in all the simple cases where
either a static buffer or a structure is used in the drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/resolver/ad2s1210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 80a2f7ebda8f..9b028c8bb1db 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1340,7 +1340,8 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 	}
 
 	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
 
 error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.49.0


