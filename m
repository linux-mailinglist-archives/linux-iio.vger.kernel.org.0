Return-Path: <linux-iio+bounces-17703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5DA7CF28
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FF2188D5EE
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51C187FE4;
	Sun,  6 Apr 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkD1plPj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8A1487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960060; cv=none; b=niwgb0pTrf4KuVTkRwQ7rfahyvyFB5y923eraq3XIY3/kV1vp/Ie1HkyjWGc1ZEyJzjl8qHAuN9JGoCC1lCjTl0ECXZPlv2IT7ID5168j1QoZryxwMeU1Nq1T71+JOGVFYNgbAyfXYDrQbRAFpxeopBy5Pbq7wDgnbXneMGxqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960060; c=relaxed/simple;
	bh=9E6lJUXBZG9MHuc0TPKRoODte0DoulOyWiMalyuUveo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+3jixSgc3hZHVvnhXBrbU1K02PhnSy4QaPrNZn+TRwytGGo55+lF9NJzgJ+GRZnpHUh56q554KTGOCba3jwbAnKje6kv5QGRlEy3Ms03okRIyQMPvW/HGtiDRkJNGuBGNzvN0NIhaRpyec85cqdnoFUWzSA8hCceFS6cZAf4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkD1plPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B28C4CEE3;
	Sun,  6 Apr 2025 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960059;
	bh=9E6lJUXBZG9MHuc0TPKRoODte0DoulOyWiMalyuUveo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkD1plPjgTBeTabO46/Q4BGSgO63iHBPMEsjWY5+GEVAq1HcNRIWwRhXgnTh5OSj4
	 bkmdmmKRasDVQTCX/2JQzJAIiIwZUUOHmVcifW841JAqcDnKb4dN0ATRpL0hMFZvBW
	 OtJ9lRXDzXqyJlfQk8S7edDceSbvaphOjyUC8GUqp1cO+vdvZLqBWCPpts4BKVArlk
	 1Pb2rGe2/Fkrlr/mf6YBb+nCehiXIx0mUOgSOA2AlYVe3FiCod/nB3GoQZfIZg+0Bm
	 Duczk9M/cz7JM+xUjHOQvznnjfwDgU/Na9qpaf8QdAcScia1RZYwLN4GrTZj+luhJz
	 SFxxBsjy58Apg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 15/20] iio: resolver: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  6 Apr 2025 18:19:56 +0100
Message-ID: <20250406172001.2167607-16-jic23@kernel.org>
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

This new function allows us to perform debug checks in the helper to ensure
that the overrun does not occur.  Use it in all the simple cases where
either a static buffer or a structure is used in the drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/resolver/ad2s1210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index ab860cedecd1..f79399353b0c 100644
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


