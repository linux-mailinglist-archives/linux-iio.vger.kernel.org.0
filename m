Return-Path: <linux-iio+bounces-16628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A6BA58723
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E59B16A450
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD50215172;
	Sun,  9 Mar 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QteAtsrw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AD1F872F
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544504; cv=none; b=ahoyhKbLc6i94Tx/yE9sEEqs9z3ja7pitZJJJMs3UX+2TdWIT54TMcgnN00yHBbCeFX2X1YLQyr0dipGeLK6P96+y4SXO6WGJhMzGQsz4XpViLAGg9uDV62mMJ1rtB0iPb4o3PtgumOdloN64tSx2bSqMv4F6tkB3M5EpmmApMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544504; c=relaxed/simple;
	bh=Qxny5bMOCtOC+sKV8hE+Di+8of1IWiBqLxx1TDTIfcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZTUhSc/gb11s5PKHS8XJ0ynWXJYFn1KEP3gFPJHwUo6P39Yrei7jpGKvAIc3nHv97QX4QVGuAfBwxar0RBotfnKYvyG84LtoC/2GqtZIh4oWp+wg/f4oraqLyvlxesjIQi9uDIMxgPLUG2RO6ERG+TLXa0jXcvpl9fmCZa7xO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QteAtsrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4147AC19424;
	Sun,  9 Mar 2025 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544503;
	bh=Qxny5bMOCtOC+sKV8hE+Di+8of1IWiBqLxx1TDTIfcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QteAtsrw/F94tBJ+uUoTHJfMvtxagaJBAeQlTuUBTFnVMldAkgm3KSr0SuVfdHBkT
	 UPSwgTy5iwnlLSr9k5cuWiotqoYuGXQTSq/rKUR0eikZH5rjPwxuljTTjEf80b0iX4
	 8ZMlRvCfAUPmJwfMECjae7+uaAVVJAA8bUpH5aEPjsT1HPj2VeA3GQLPT82JXLR/KB
	 ONpm7wzxDplyRThyulPIowN8PIFO20m2XJR6RdyzYOAobJLHETDafs10bsp0X0aijV
	 c0qIU1KvH9KfacVSRzjGIAhscz4Uf+PzfUKUAZTpe/djW1nhyYHZpNGogoGVyehG4p
	 urS80MrfiHc2Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/16] iio: dummy: Use a fixed structure to build up scan to push to buffers.
Date: Sun,  9 Mar 2025 18:20:46 +0000
Message-ID: <20250309182100.1351128-3-jic23@kernel.org>
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

It has long been discouraged for drivers to make use of iio_dev->scan_bytes
directly as that is an implementation detail of the core. As such our
example driver should definitely not be doing so.

A simple anonymous structure definition suffices here as even though
we have a mixture of signed and unsigned channels only the signed ones
use the full storage so the unsigned channels can used signed types as
well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 288880346707..050dd993f012 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -46,11 +46,10 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	int i = 0, j;
-	u16 *data;
-
-	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!data)
-		goto done;
+	struct {
+		s16 data[ARRAY_SIZE(fakedata)];
+		aligned_s64 timestamp;
+	} scan;
 
 	/*
 	 * Three common options here:
@@ -69,14 +68,11 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
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
2.48.1


