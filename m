Return-Path: <linux-iio+bounces-17696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84803A7CF21
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F253A7238
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81CE17A2E0;
	Sun,  6 Apr 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prH24OLt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D671487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960041; cv=none; b=HcWWOpCxd+M7ZBk/UeG0hXk3fXpc6XVcLxv2Gmx1TPYLLYZ8/kP9FFhgP3EL2/z2fVX8BbmDfjfjyLXVRLZpSAFKgS9SU6vTq/N/1Det72bwewFYU8hbMmuoZA6NoYrKNCeGKsAKlcIzwQJqaiShqB9k7XwnyXvtL/KcRpskpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960041; c=relaxed/simple;
	bh=cckiBeCgHuM50hx7XN3+P47dlqCQlPsiu9kcJLJ6SX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1TRbiQdJ6jDCg8eibyyIdWyWQE2u/qs4x8Z3zrK6hOEv2Z3S/bvbw7oqqsC2eumKdBhICzOJo3HgfM93F/IgOXf0OOLyO3tLxbp//D46GPpgcSPoPRX/LZvDynNGZ9+0GoYLpsaCTGv24O1jBYtCOWh9HpQxrbfaRr7rdXovvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prH24OLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12AAC4CEE3;
	Sun,  6 Apr 2025 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960041;
	bh=cckiBeCgHuM50hx7XN3+P47dlqCQlPsiu9kcJLJ6SX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prH24OLtn/3vgSGed4rkRznfdSBxSYjGApJpX87qVERm0jCTEIf7pTZpkecJy9nX0
	 1trSYl725UiQnjs7rAVzjYOWyj4T3eU+N/GjdeSIhyANt/LT+rjqjccVbOdT/wHtcX
	 u0aAo94QtxX5Lm3LeoAn1PUJQ5lHXra5QlprzAFNJlsX6SLvP/G18uoLStYgyJr+uo
	 OWEi2P3zeBZGLDiAKh+Xi0va26jJcIdhE4X9RFuu70LnkYcEjCzhM4SQq067nd0PP6
	 FBOnByPcFe6F5z4EsNVglgTLgJYlwB4s9rGEYE7xQKfnZ6/YEC/gmRGETXDdnryCfz
	 uJD8In1JNQDXg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 08/20] iio: adc: ti-ads131e08: Use new iio_push_to_buffers_with_ts() to provide length sanity check.
Date: Sun,  6 Apr 2025 18:19:49 +0100
Message-ID: <20250406172001.2167607-9-jic23@kernel.org>
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

By providing the size of the buffer used, runtime checks can be performed
to ensure not overrun.

Also change the pushed data pointer to be that of the structure that also
contains the timestamp.  Not an actual bug but semantically incorrect
to push the channel data when we want the storage with the timestamp
as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads131e08.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index c6096b64664e..6e83d370f0b5 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -664,8 +664,9 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 		i++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->tmp_buf.data,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->tmp_buf,
+				    sizeof(st->tmp_buf),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.49.0


