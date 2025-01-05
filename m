Return-Path: <linux-iio+bounces-13906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5CA01ADC
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D0E1882E47
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7B170A1A;
	Sun,  5 Jan 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECZ6Xkch"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1468F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098003; cv=none; b=ANEpIHsb9Asx8/6SrWhmQ+S6opukGMe4ithsMtgcVbYdBotpLFtx49GC+WxBI1HHTj/P066QnrHgaooE3MzhMWfv+Z66RYTMNSJPnBsFcpr3697BXhDgW+Zx3sHV4akWfG1rD101GAkw2Y5tJBprpsvm7w0OV86vKC1bHHHw1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098003; c=relaxed/simple;
	bh=Q0/WJ946MqD0mFVd5xBXELbDxbs0v37GbJ8NV+S5cTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0X9SAPxoQHaH3bmeZXW3JONX4YYC4mu4HDydOlD+a3q1pEcy/FjljlN7RgY1po6G5/zYAeiW/s12JCUEHuktHpvo1iDQ9DzOUsOpbaYbRHZepxd2qmY8R/DHYneY6Ildy9OW8jCSl1Cl1lrjidGqvElsc+pnTY7U5YLkqj7Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECZ6Xkch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E89AC4CEE0;
	Sun,  5 Jan 2025 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098003;
	bh=Q0/WJ946MqD0mFVd5xBXELbDxbs0v37GbJ8NV+S5cTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECZ6Xkchpnix96fTiA2ym7lFIivmDcariEYLiO2FX/3lOsvNDcPiy78QAOzZRr2X7
	 6xTHHPo7QD9JccAgs73Bb7rihiVWvHNTSIj3GGl306BiG4NiSyJTgzCJ2TdIhhGpMe
	 jYIdnDVO5wVFTvpLnZuLry1n62+MmsECeBzxXGXlYgqngnTDNL+cbMmsmEHK//bGD7
	 plvCEUUfFdBArLANYokz1PCzAVX50YJJtHHUDMIWJhGVL4gZkFv5xS+s3eyz6S0EHv
	 mAwSPkeFhDqaA6KGQQPljV+Aq03MjEwCCEowF+y7cLsHDTxJv/z1mOyDdWv6WJcFfY
	 v3SAvN0Zovv5A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 07/27] iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:52 +0000
Message-ID: <20250105172613.1204781-8-jic23@kernel.org>
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
to check for unbalanced context

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/sx9360.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index a6ff16e33c1e..4448988d4e7e 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -321,16 +321,23 @@ static int sx9360_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return sx_common_read_proximity(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx_common_read_proximity(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return sx9360_read_gain(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx9360_read_gain(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9360_read_samp_freq(data, val, val2);
 	default:
-- 
2.47.1


