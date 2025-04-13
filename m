Return-Path: <linux-iio+bounces-18050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCAA8718E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89D91890EBD
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCFC199FAB;
	Sun, 13 Apr 2025 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA8DbrcW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55D2AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540511; cv=none; b=S/HxqK4nrWATwamFcDktv1EqusC3NZr8pNZZpcP7CRft9fFPohFV0VrrQ9EO0/TokIfICO5OmZ8MffF2hCq9lJPRnnPQX+hryiatysLQOnkQwbacwkGDXzdNJCvuz7q7EnQORVGEO5vULp/N5k5gcrsBde/qQa/MGxsCgfBE9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540511; c=relaxed/simple;
	bh=BG9j6HsC0SVSUTBxX5PF6A6X3155QTT/ZSVHI4PZbZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuwZWbKTD4EHhG82tq/FJzy+Q82qHjDKNXkH/0rLg6RxFpqzZALsCOaOsdhmFBYh9hOD6NSDRVgShOUxA/skYtn4/CfNeDqZM5Xq7cLWqWz0AG4d6rK3hZuFth5DV3sCL446Sx5ngR/nN5hi6M0srPHiDBnIVNaJCFYmunHy6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA8DbrcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E69C4CEEA;
	Sun, 13 Apr 2025 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540510;
	bh=BG9j6HsC0SVSUTBxX5PF6A6X3155QTT/ZSVHI4PZbZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eA8DbrcWkYv+OsMk4Dznz6fFakn7/1+rVyDKIOzzeDYL2Ryuzlyf10Ay+sSRWnJ+J
	 i4OBvWwchAAcaoAp9KaJ4GYGp8BzRancll9luaswpkMITdc4eZIsvylfl2jMudGfv3
	 fT0PzzE24FL2pAfod7vscpyVYMsrgXJ6fA8koyGBj4D+F4VufSFe8rLuoGxb0Gp6AW
	 zBYaxGeyRe4d0A9Z7aZ2AgHlYDfwEUh0tEKHllZJouzboXuLDQMKjOgVk83D9TND2P
	 EKhbuIE73+WT8JxmR7d523sAqPh3OYhe5kAD9/3o/Djfini8w5He951iuQNXu4wOeO
	 V5kxvORRaFkjg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 06/20] iio: dummy: Use a fixed structure to build up scan to push to buffers.
Date: Sun, 13 Apr 2025 11:34:29 +0100
Message-ID: <20250413103443.2420727-7-jic23@kernel.org>
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

It has long been discouraged for drivers to make use of iio_dev->scan_bytes
directly as that is an implementation detail of the core. As such our
example driver should definitely not be doing so.

In order to illustrate the more complex case, where a DMA safe buffer is
needed, continue to kzalloc() the storage (but with a structure definition
to provide an explicit data layout). Also add comments on when a DMA safe
buffer is necessary and the two common ways of obtaining one.

Whilst we have a mixture of signed and unsigned channels, the unsigned
channels have ranges that can be stored in a signed value - hence
use signed storage for all channels, simplifying the structure definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3: Go back to kzalloc but with a structure definition. (Andy)
v2: Add a comment about stack buffers not being DMA safe.
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 25 +++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 288880346707..d0a7343e1b35 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -31,6 +31,11 @@ static const s16 fakedata[] = {
 	[DUMMY_INDEX_ACCELX] = 344,
 };
 
+struct dummy_scan {
+	s16 data[ARRAY_SIZE(fakedata)];
+	aligned_s64 timestamp;
+};
+
 /**
  * iio_simple_dummy_trigger_h() - the trigger handler function
  * @irq: the interrupt number
@@ -45,11 +50,18 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	struct dummy_scan *scan;
 	int i = 0, j;
-	u16 *data;
 
-	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!data)
+	/*
+	 * Note that some buses such as SPI require DMA safe buffers which
+	 * cannot be on the stack. Two easy ways to do this:
+	 *  - Local kzalloc (as done here)
+	 *  - A buffer at the end of the structure accessed via iio_priv()
+	 *    that is marked __aligned(IIO_DMA_MINALIGN).
+	 */
+	scan = kzalloc(sizeof(*scan), GFP_KERNEL);
+	if (!scan)
 		goto done;
 
 	/*
@@ -69,13 +81,12 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	 * constant table fakedata.
 	 */
 	iio_for_each_active_channel(indio_dev, j)
-		data[i++] = fakedata[j];
+		scan->data[i++] = fakedata[j];
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, scan,
 					   iio_get_time_ns(indio_dev));
 
-	kfree(data);
-
+	kfree(scan);
 done:
 	/*
 	 * Tell the core we are done with this trigger and ready for the
-- 
2.49.0


