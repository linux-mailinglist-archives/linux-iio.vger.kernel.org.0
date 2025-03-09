Return-Path: <linux-iio+bounces-16629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EFFA58730
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0984A3ABF8D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8B31F8746;
	Sun,  9 Mar 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoHubapb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF01F09A0
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544506; cv=none; b=VKwe6BrLLUoOD/3ynb75Uti5knHykcXdkvvrE5PRElmW8eAJJznuC+JCUi8AR/9aalZCbyf+/ZLCEJH8tiC7jvSyczKzztC2FG9PjIP8lrYn/+A37dMdQ+n7BHSrV5zYTmfveMbDxMhdB7opKOK30bGC9RBBjV9rAtaKpUURGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544506; c=relaxed/simple;
	bh=kaXqmgyQHSZuAjyczm0H4+eEK7ZuyilrK2K9p3bRMi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtvaY4uBqsw9SSde692SW8gNyj2bxAV2vrd8/N5Hjth/u4Zq8OPwuXWd/g8D4itgOLCb8Jy4jLl46MvIJzVVntezODGL6W5ZreltJ+m/boEuXq6EQ7Yo6RzzLgszpsuanAwe7xXB2ic08CYskfqD3w673AimkmkY/TY7usVEvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoHubapb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823DBC4CEE3;
	Sun,  9 Mar 2025 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544506;
	bh=kaXqmgyQHSZuAjyczm0H4+eEK7ZuyilrK2K9p3bRMi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VoHubapbyV1zk2xj867c2MLDvdgJeg76S9MYzLrcZEraxgeog43FAb+8cWEOCRsPK
	 qkodaf0CFI+LuaLDZ2AbTERWDxHcnaLwO5tG6ySFOs/p08Ysj3UWjLkVMSNdyHCon7
	 TQ5iv5q9WQpCCYI+m5/y6ZCPeACNt5bOuCMrsfCJkh1vHIpyTSTrK65SRMpeiRKYxV
	 KArs169rhAXYr7KD5UW1zcJR2AMDWU6gG+TvCLLINxSSm11pNUTPljUmj/83KyFKRc
	 Rv9MyXSiY+Bn8L8VG0EspAfhR63EslEwL6H5M8ib5r5d1g79ArEty81rBj49Pb2RTC
	 kWCGMIl25EqaQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/16] iio: dummy: Switch to iio_push_to_buffers_with_ts() and provide size of storage
Date: Sun,  9 Mar 2025 18:20:47 +0000
Message-ID: <20250309182100.1351128-4-jic23@kernel.org>
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

Provide the storage size so that the helper can sanity check that it
is large enough for the configured channels.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 050dd993f012..4f2281c5a930 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -70,8 +70,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	iio_for_each_active_channel(indio_dev, j)
 		scan.data[i++] = fakedata[j];
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 	/*
 	 * Tell the core we are done with this trigger and ready for the
-- 
2.48.1


