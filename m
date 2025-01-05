Return-Path: <linux-iio+bounces-13909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574BA01ADF
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57752161E7D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9265165F13;
	Sun,  5 Jan 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPmOixk6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF28F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098009; cv=none; b=fexpU+RNEEDhlDTe9dWLGGTy3EBALNfMoOuPWDLYjC/pUVd5FpUQ/5qxOCIbOOzPBHNgoWX2fNEwQ3wu2mNzn6TYMsWZT4S1prtPkGmqbhERcqJO3dZljfV6u1eLxblS1HfKUxvR+ohGgHjRkl6yNaTckF/zxMvq1lgNQKo/7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098009; c=relaxed/simple;
	bh=ER0444V4E6vvf0TtAZZfsCZ1xjti7ybmWbsZjwHyWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiBGyWFGc3oap9k/8B5mniBFco24zJoFS6oTHcU9Wnw8I5EneHTC6IYFiMJrkLtuBg2381vaMPmlTC3qOl3BeSdkNW0hw4Lw+ku8mCCGOdpIAV3WVrEf7ZWiwJ9NJb4dz2BWJ4ZigdVbgx8e3glVb+FS2wJ1A7BduNIYFQjIGyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPmOixk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ECFC4CED0;
	Sun,  5 Jan 2025 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098009;
	bh=ER0444V4E6vvf0TtAZZfsCZ1xjti7ybmWbsZjwHyWYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPmOixk6pIcvEyBdDCqteoOLwP6SZhjwUHzXccK6qSAxZiMDuvFVyp8Hc260E5Wyj
	 4tkJxZRTIDG9BIq2PvQqokxs+JsMfRgkJhutP+b8fcLf/hnwHiZzpa/wKoEVl8goy8
	 0fZiAU75hLPG4jnFcpiRAk0ZIPUp0pSb0STIlIEAi0bemR8nRtNhUDtR9QDPClbbDQ
	 bS/rgg7udvAlIGqDAQ8utmFBcD9VFfAhExfOVi29e5TB8hC896evfYlJu0n81WfwPw
	 whxvflKt342d2FxBMdWifAK1H4PFJAP/ttl95p++ZXt4DXlOA/4jDAP55X3vtLeRUl
	 SY0AgwCfGldbA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 10/27] iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:55 +0000
Message-ID: <20250105172613.1204781-11-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4130.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index de32cc9d18c5..09012f33ff16 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1060,13 +1060,11 @@ static int _ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
 static int ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
 			      int *val)
 {
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct ad4130_state *st = iio_priv(indio_dev);
+	struct ad4130_state *st = iio_priv(indio_dev);
 
-		guard(mutex)(&st->lock);
-		return _ad4130_read_sample(indio_dev, channel, val);
-	}
-	unreachable();
+	guard(mutex)(&st->lock);
+
+	return _ad4130_read_sample(indio_dev, channel, val);
 }
 
 static int ad4130_read_raw(struct iio_dev *indio_dev,
-- 
2.47.1


