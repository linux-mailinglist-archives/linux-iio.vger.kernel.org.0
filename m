Return-Path: <linux-iio+bounces-17695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC20A7CF20
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD45C3A72EF
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F017A2FB;
	Sun,  6 Apr 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md2+mgE6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16C1487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960039; cv=none; b=KTdSWjQLI6J4hipx4rZ7cLNwvlBWkVNtdhjaNim4PKY64p53lAU/fucsZ3Ssot3KAuRQQD1E8xVouutfzJ3Kzl8VyzAYRgOQuCxsITK6z6sAalWf15lmlQGO1bpJXu5Ux17b/OPo4wa90VA2jxokPWkLFftSP0s4HK712Ho25Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960039; c=relaxed/simple;
	bh=X1re6tjkDhC95EdCAoKUNa7RYQSZR580C6uSuYUaJB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubbghP48pwi/PV94N/GK5G69Pu6DzwAKTbc+/R40DbLQliWDvmAmLW53A4BdYCNoHwGE9GcjbWAqz4AbrNFH/4i6GsmBRUOUBCyqZHgg6xptoFfjuqz29bHcJSO/I++rMAvXhn/7weR55TRLJHr3vfh/iYmsbnd6IPsXqbsi9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md2+mgE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD3C4CEEA;
	Sun,  6 Apr 2025 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960038;
	bh=X1re6tjkDhC95EdCAoKUNa7RYQSZR580C6uSuYUaJB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Md2+mgE6RW4MHa+SXve8Yyp6DeXxZM9FEp/3w/n1S85YLlDPECp/q1XjLG16X7Cft
	 G099U8HBes5UAB1jJcdAPgS8gbiRCvqIpNqt8h84XqA4jXGe8OWQWYZJwfdYzsQICs
	 skPnfRHuk4ZPN8rs1z4DfIE0015pie5FdVZ+2+7HZwecj4H4rgCWZzl9rjqKzUI14E
	 6oXthgF913Rz1CfLk4Fl4b9+Y0CHf8TMVHTZAuAYRIb//Uw4cqDa5spDespf3bslwa
	 xHr8N1B3ja70FZ4FDqRCzXZw5JLSVJMoutkE7cFUvsoNjOyk8kXLbERfZmbfYRF5gv
	 vwpR1TXEKkcfA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 07/20] iio: dummy: Switch to iio_push_to_buffers_with_ts() and provide size of storage
Date: Sun,  6 Apr 2025 18:19:48 +0100
Message-ID: <20250406172001.2167607-8-jic23@kernel.org>
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

Provide the storage size so that the helper can sanity check that it
is large enough for the configured channels.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index eca5f0652d23..7b5adbb4a422 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -74,8 +74,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	iio_for_each_active_channel(indio_dev, j)
 		scan.data[i++] = fakedata[j];
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 	/*
 	 * Tell the core we are done with this trigger and ready for the
-- 
2.49.0


