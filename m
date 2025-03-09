Return-Path: <linux-iio+bounces-16638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F6A58729
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91604188C035
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195B202C27;
	Sun,  9 Mar 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJk4ehov"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E41F8752
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544527; cv=none; b=jqMa7kAxu2sNVcXaUG2ytWUy8XB9EX+HSlZh/GkH4VvbmhXx3QHCAautOdeStkDlqYDTPCWfEwTk9pVuLf16wXc9V4RTjq3DUqWMimzS7H9SDZduYFq6nrcPVZIEVH/4H2fXSpZc33a6qw6OX6TOkeHDqok8Dp8qcpxMoVG5T1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544527; c=relaxed/simple;
	bh=qcMzE0ZINzp5kzBq1KLEiCthDLd3npEy4b7RUX293rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6JNBedZmL/swbhTy11dY/7HdUphkMV2oE4QWHqLo+V+SOYhiqC9h13ZZATxGvO3B6yPgi+RfOhb9GAiJS6lV4z8PJUA9afww2epCkmNBBULFbAHl2p42swOJLJK9bDVYrXHMiq92eqK/al7iCUWkEdp8MokZ1ok47XO62tUiu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJk4ehov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08108C4CEE5;
	Sun,  9 Mar 2025 18:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544527;
	bh=qcMzE0ZINzp5kzBq1KLEiCthDLd3npEy4b7RUX293rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJk4ehovWHndAPWKH+vk+2pdEPSCqQHR+B8sOoEcV4hIcEkiyv/D8zKgc2oWDD/Za
	 NSwHfsSLDa7t24HruCBasrjGIwQsSx65JON7bs/b1+eBMP2bMMwdGRgWsKNQzVoEfU
	 rAc5rtxwEbHvK5waMRLeI23hmBmrtcrmliQapr0qZu2wx82fyQffIjeeUPc26eNOS0
	 +zUyileFK6h7/SPFRZMSmz5YoEXN6Qg1UHqJbvxvF/QeiTItUMQV5IOD8beyWnl1Lw
	 TCUN1b00+4nlqestO/KUjy2upyxW4GlhpqZD+U+w/9qMhSmSfMDswHipoc8FLVYmvz
	 45rSPGvLIVlbQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/16] iio: proximity: irsd200: Use a struct for scan and iio_push_to_buffers_with_ts()
Date: Sun,  9 Mar 2025 18:20:56 +0000
Message-ID: <20250309182100.1351128-13-jic23@kernel.org>
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
2.48.1


