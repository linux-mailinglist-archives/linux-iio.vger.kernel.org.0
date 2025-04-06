Return-Path: <linux-iio+bounces-17704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC9A7CF29
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F27188D5F9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E518FDAF;
	Sun,  6 Apr 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="satz3QMh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D61487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960062; cv=none; b=T7c5vgDaoiQYzj0QH9bVt+shZttyjiHTpbsi56tbsj8vrncUQit/ldhTGihk1bCElS/AozflprUezy0Qz9fJu/PlYI0xizo5n2VVup5n24k5K2SHC1qCs8KImgea7AWXUD/PM0zhZDsVLwbSPjBUfhGoDQEh0gWRabPjHicVM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960062; c=relaxed/simple;
	bh=DOqfhQzSozf7YdkIxQMRB1DIbXGfVmHcfOFSV4qRBf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR4raz9YWbaLijwh3z1ftpxBhgQeDfzgXAl7nzVsYz7ITNeydbZulK448gx6o9irh5JC8oHN0NVFywj+bkAweaafdWpnvcKI+c29AMQn00Xa/gsw40GlHb5UoUaLXO+NY7c3BEM1ycXHYY6yDz9KD9wiBKk4g+dR911aOfYYVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=satz3QMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46639C4CEE3;
	Sun,  6 Apr 2025 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960062;
	bh=DOqfhQzSozf7YdkIxQMRB1DIbXGfVmHcfOFSV4qRBf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=satz3QMhtqgVIffgvj8YOk95PAXVutS2x+iDbpJhbps6NT5n1ZlqAaOBZRolV6w3Y
	 FeqgOm2DLAY6Ip3GWY+KEuiTJvo1AGxx6LsgAXlxT3f/iXjoKaVUq8kKL302fIxQKo
	 8kMEPCEt3x71EnTR49yEAl5Mb1asPkJmrjwAXjecmqvL2qZka50+H9TdhEeMnED2mj
	 8Q8jwQonJQTnaTZFJk52DQbrGpcOmiS6jMgqbIk1FOdPKGd9XF7+KV/aKt3ThOQJQJ
	 Gfv/ioZlfXC85K30IU5jnhPc91UAoiX/6XRtAqJpNhfJXq3keO8QGUXaUjGGK0Ybp/
	 7PyMxT8Uctp8w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 16/20] iio: proximity: irsd200: Use a struct for scan and iio_push_to_buffers_with_ts()
Date: Sun,  6 Apr 2025 18:19:57 +0100
Message-ID: <20250406172001.2167607-17-jic23@kernel.org>
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

The driver previously used an array of two s64, then type cast the
pointer to write an s16 to the start. The code is made more readable
using a structure.  At the same time switch to the new
iio_push_to_buffers_with_ts() helper to enable runtime checking of the
size of the source buffer.

Note that this approach uses a structure with holes, so use memset()
to ensure those do not contain old kernel data as this data is passed
to userspace.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/irsd200.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index b0ffd3574013..ed15c06c8ef8 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -760,15 +760,19 @@ static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
 {
 	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
 	struct irsd200_data *data = iio_priv(indio_dev);
-	s64 buf[2] = {};
+	struct {
+		s16 channel;
+		aligned_s64 ts;
+	} scan;
 	int ret;
 
-	ret = irsd200_read_data(data, (s16 *)buf);
+	memset(&scan, 0, sizeof(scan));
+	ret = irsd200_read_data(data, &scan.channel);
 	if (ret)
 		goto end;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 end:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.49.0


