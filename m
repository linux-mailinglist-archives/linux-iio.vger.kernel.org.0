Return-Path: <linux-iio+bounces-13920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E2DA01AEA
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286383A2E99
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC613189B8F;
	Sun,  5 Jan 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq5ONPoX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA198F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098039; cv=none; b=lDHGjoB5RByKeMl5qcRD486NLJX+tn45arv4csw9dWALQeAB6wN53XhR5MvKrtTYjfD62eDocw0w21bxEGhjAgvCRDvfLNv8KoKlqN0NU1QjAnlWaijtQ4KgovxVuAjbaAVwVFVXU08LK9jeW1eLQ30+ofQ5Y3m4s9DEXeUIlGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098039; c=relaxed/simple;
	bh=luNL1NLkc3rdtd+YZvmoF9Uh8NjEhpzaCtoloqL0F3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGwqDj2DFrPq0DK+qNdWr8i3WQPfgLM1BRHH36Q5iHLDbOyp0fs6KdOLuX29LyR4V+XnDZUI9rnqnzbkxgJLnAd9YUR/XWzmyjQF9s+LebM43t/cUdEmafkNNS0XSAIfnMfEi9Yc08pmyodEkpIQfIrZyxw2KRwM6bYwEjTlFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq5ONPoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F4C4CED0;
	Sun,  5 Jan 2025 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098038;
	bh=luNL1NLkc3rdtd+YZvmoF9Uh8NjEhpzaCtoloqL0F3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tq5ONPoXkcLvH7LRpcwPrlK26caQCALC0Uwy6M0pBxuTTNTSzEWmmoXGx3lJQO3hD
	 ERpfRP+Goea+utRkHkRsMyIaTDNdPd51xMZ9s/p6C2WRksEu58JQSQ5VYh/Eu3+77o
	 LEknA0zhMy4F7x5gwEu2QnGP30AMlLz9Z5KfjIvzMnFsDG/YTjtisdFlzSNOd05MPG
	 tgGTraQH9lSdCa7Oe9Nu08X3EqMr5Sw0oKAviUrgqkFlEf3VmyGXJHXH98Ch4VRRC3
	 Ca2YjZ3rFjPdLpzV7Cyk86UVvHbn6uDyzYl9S1cPCaz7B9SJzmcdZJGFaUQ6X5l9bE
	 aTcr1JE7pY/xA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 21/27] iio: addac: ad74413r: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:06 +0000
Message-ID: <20250105172613.1204781-22-jic23@kernel.org>
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
to check for unbalanced context. Includes moving a mutex lock
into a function rather than around it to simplify the error handling.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/ad74413r.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index daea2bde7acf..f14d12b03da6 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -826,6 +826,8 @@ static int _ad74413r_get_single_adc_result(struct ad74413r_state *st,
 	unsigned int uval;
 	int ret;
 
+	guard(mutex)(&st->lock);
+
 	reinit_completion(&st->adc_data_completion);
 
 	ret = ad74413r_set_adc_channel_enable(st, channel, true);
@@ -865,12 +867,14 @@ static int ad74413r_get_single_adc_result(struct iio_dev *indio_dev,
 					  unsigned int channel, int *val)
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
+	int ret;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		guard(mutex)(&st->lock);
-		return _ad74413r_get_single_adc_result(st, channel, val);
-	}
-	unreachable();
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = _ad74413r_get_single_adc_result(st, channel, val);
+	iio_device_release_direct(indio_dev);
+	return ret;
 }
 
 static void ad74413r_adc_to_resistance_result(int adc_result, int *val)
-- 
2.47.1


