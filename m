Return-Path: <linux-iio+bounces-17694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D59A7CF1F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0249B16BC48
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0B175D47;
	Sun,  6 Apr 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUVd3RwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ECB1487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960036; cv=none; b=DnbKj6c6YRfP43lInXTdIMA7tCtNG5SvEYTsFbMv6k9x6v0Ctqvc0BkX1pJmx57Mc0nKnDNlb8ww3KnR4sOJNlP2zNK2IgXgt9uZmYhY0H03tzB0KMicFNi+W8eVKvt2uKkmYL4CTd7jXN65zD9mvLqcfZfFBt1ZnJKvfv/rcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960036; c=relaxed/simple;
	bh=gkpXFhKfjFsrwr+J1Mh/7swCsWVpkiy27IDthZqCm9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVOt53IJgJSabZTHg24jiws63z9kW0rRPNNRi94/oPBtQlsoOIcRfcuhkS2jEnAvD4CyhUTtSEjdgLC7vTy17wWPwLCsFZgphSCahDkVNtz7t7gvGeKEwpAJ0BBQOF3F45Y69bb0RMOvp/lWDmBAng2BXvZoR8zxGOJt0Jz9gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUVd3RwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8EBC4CEE7;
	Sun,  6 Apr 2025 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960035;
	bh=gkpXFhKfjFsrwr+J1Mh/7swCsWVpkiy27IDthZqCm9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUVd3RwCw8QwFyU0CJNrdYex5Emulr9tVyshbU6+u+slKz+8OBARzxZb9n970xGyt
	 xzpXX9GlPPzn1pB7jeb4V2zlu2yHOB6EHuyVEeualQLfQiRR0GxuEfaX35lhOQ61yu
	 pPdmb2p9zIuZfAEFjLCRPbF4uS3AvVwu5Rt9y73CRA4qYs8aUIji+gnkr28i1J+Xu2
	 ToVzB8UIxMDskIVpkz6grvxmVlHYakqpGQ7/qzTgIMhX1zbBBZuKANZuH/4yZx99+K
	 juagD2fHeK2yEHbrCid70Jl7mJnB4gSiBIeUzpxiWIKoQ1wEXzlTzARlAsj9jDRKf6
	 WicSR5jTz6QSA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 06/20] iio: dummy: Use a fixed structure to build up scan to push to buffers.
Date: Sun,  6 Apr 2025 18:19:47 +0100
Message-ID: <20250406172001.2167607-7-jic23@kernel.org>
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

It has long been discouraged for drivers to make use of iio_dev->scan_bytes
directly as that is an implementation detail of the core. As such our
example driver should definitely not be doing so.

A simple anonymous structure definition suffices here as even though
we have a mixture of signed and unsigned channels only the signed ones
use the full storage so the unsigned channels can used signed types as
well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Add a comment about stack buffers not being DMA safe.
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 288880346707..eca5f0652d23 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -46,11 +46,14 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	int i = 0, j;
-	u16 *data;
-
-	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!data)
-		goto done;
+	/*
+	 * Note that some buses such as SPI require DMA safe buffers which
+	 * cannot be on the stack.
+	 */
+	struct {
+		s16 data[ARRAY_SIZE(fakedata)];
+		aligned_s64 timestamp;
+	} scan;
 
 	/*
 	 * Three common options here:
@@ -69,14 +72,11 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	 * constant table fakedata.
 	 */
 	iio_for_each_active_channel(indio_dev, j)
-		data[i++] = fakedata[j];
+		scan.data[i++] = fakedata[j];
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
-	kfree(data);
-
-done:
 	/*
 	 * Tell the core we are done with this trigger and ready for the
 	 * next one.
-- 
2.49.0


