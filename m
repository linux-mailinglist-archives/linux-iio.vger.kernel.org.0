Return-Path: <linux-iio+bounces-13915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FBCA01AE5
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099FE1882E8D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF718453E;
	Sun,  5 Jan 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox6bCrvo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE338F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098025; cv=none; b=DeBFELszo7uqQEQ60vTSg0Qlu7153sY/MEp1/BOrnmgwakrDkgTQheOl8xcXaE+j1yRPWwx+RH8pzO27pnNS8//eSdcDh5D+iNQcQbzmqmEHdgPpMS2rhrWtRppi7umzQzSG29kbfPAGOGGaCtjiEe/9wv+b2EQsdPRp5I/hM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098025; c=relaxed/simple;
	bh=WNYIJEHgCJHVWy/TBjRkd/pVhx++SSb4QBgaXiMc9gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGO/lz58n0V5ZpvrHqxEc68r1uS/XvKB/CngJbhr/sPEVugz70V/FSNH9auvMew/q8eJELN00/6OU0tmj/MZr6XoB4lnXyRL7mIv4LKtEey97x1G/sY7BL0Tl8McGe5xGazBqOqi7TU+Q5FD+e193qaDcNqNyhaiq8ru3Uol8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox6bCrvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E538C4CED0;
	Sun,  5 Jan 2025 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098025;
	bh=WNYIJEHgCJHVWy/TBjRkd/pVhx++SSb4QBgaXiMc9gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ox6bCrvo0ul7VFekDQE01ydlrb3265v/V7WJJTzJ/d1rOVX5JMSyesIO7jAxV7bCd
	 3PG7/MZflNx2cHJLVVV2NqTT7eGPshnwvWAS6BCFjnmiZFs+BHuhL9lKKgjZcuxlIE
	 lDOZxQfBQL+ZmivWQpRK+dRLPTltbQvtRjJ05R6IN3umvLPZOa1DXPqY/QWFdz55AC
	 sD9HcrbAH237i1R7PbKZcPfFIgQmzhdaBl1hj89CDHycLhmV16nMDGIs+ddwpoZUWR
	 ar54X6Pq6OElTlQ2UV0LifPqkF/NnPUnZwe6V2KYfmb5HeyLxwy7qLEKNDlsBsLYq6
	 3dcMrZg5/1fGw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 16/27] iio: adc: ad9467: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:01 +0000
Message-ID: <20250105172613.1204781-17-jic23@kernel.org>
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
 drivers/iio/adc/ad9467.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index d358958ab310..635c0d10c7bc 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -813,6 +813,18 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
+{
+	int ret;
+
+	ret = clk_set_rate(st->clk, r_clk);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	return ad9467_calibrate(st);
+}
+
 static int ad9467_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -842,14 +854,11 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 		if (sample_rate == r_clk)
 			return 0;
 
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = clk_set_rate(st->clk, r_clk);
-			if (ret)
-				return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
-			guard(mutex)(&st->lock);
-			ret = ad9467_calibrate(st);
-		}
+		ret = __ad9467_update_clock(st, r_clk);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.47.1


