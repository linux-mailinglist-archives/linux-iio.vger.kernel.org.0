Return-Path: <linux-iio+bounces-16637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADFEA5872A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216957A4731
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1493B202979;
	Sun,  9 Mar 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJMoX5RY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B61FE460
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544525; cv=none; b=f5hddu8Bx2EusR4ts3TohVwuSMND1RiWBh1mAfpPOfm5mBVwEVjrHWsjbn8hPqrjYu7RgA0mIDmA1bUMs8aB6FwTRm9QDP4CNpNOJMuBpWc9a+G9HpwaDNf+7cmGgoJyWi28nx+ofJiqTx9Ay6OO5eceZcLpiyj2z17WCjUBoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544525; c=relaxed/simple;
	bh=0KeGeKpsykjxLocVAqvepfj31OzNfjJoFIMgpiplsu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpREoeMHHPWANhszGQR6Jo+6QgAi1xcNQ6AGEsFs+BoVp0wLuLAwhSaTB0gnZT7zDjG8Y9Tme0qZr8hE+6lZ5gvs39bGshUwXh668dqYRBcHzp9Mo/abeTStl2WDGC8lyODaDDbmHvPc/KgMUXNzbC+clk1xp3hcei7t6CHNI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJMoX5RY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F8C4CEE3;
	Sun,  9 Mar 2025 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544525;
	bh=0KeGeKpsykjxLocVAqvepfj31OzNfjJoFIMgpiplsu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJMoX5RYoxX9ryjwztl14WazAJ9cUzPvuSNuJOMoEJhyupfBNI6JIPP6WDFQRYgft
	 NVnBjQUKcjJVMPVXcZw3Yb/KTSB7sWMJGj1d06m1GzASHtIh5aLa+EO+4A47vwJsqn
	 pc1PIYhmyEondg4cj8aVcsmbm/oJLwAbQ5O8f/frkFsnDwUB3CSiJm/xqqO0V0ueR8
	 pOYs6dtaZ/UUwTBWu1jhDEvOP2S4/lNAn4wnNYVDkBi4uAGT4BcSZaM/a8Vz4KBj7+
	 gTKmYXcA4G9DSsSwicurWN6FmX1hcHPXzTrpjR8wCGxWE6h2racpm+mGLXAGPr4YkW
	 irDVi+6zB34Hg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/16] iio: resolver: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:55 +0000
Message-ID: <20250309182100.1351128-12-jic23@kernel.org>
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
2.48.1


