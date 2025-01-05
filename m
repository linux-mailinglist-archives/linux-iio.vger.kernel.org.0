Return-Path: <linux-iio+bounces-13910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061FA01AE0
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51EB1882DFD
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A6F172BA9;
	Sun,  5 Jan 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5V3HtMw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BF8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098012; cv=none; b=dtuF1mdrnGk8l7GNpcJ7M9yueF1tbzo0180BZ+fl8i36kZ1AI9VG7SxDurpjcLbC4NjCnSFKXoTaqeswSBqkPtNg/3uCtei+/U6hp5j0bULj8b6PxD9RIqzLsPwpS+SJ8zqY3eauIMBO7zutsaj/XKfIFxfbOO08PxVmfjiGMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098012; c=relaxed/simple;
	bh=LWqHOjlFuf3//TsXJwahIXPO8AJTEI6GqRf9NpFvPU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPUCS3PQ6sOWiHiQRTH/d3IHha6oA21MlTJ1xLuGN+him24F9vjthmbaRqIEaD7KMXzikmmLwE2VDEuclWUp3Aeql/LcurXscww+TNUm/kxOBwmtOuTUylPnooCTnCqV2JsIs3FLkLn1QhsZVkEMivNiyGYs0iVnMFVsL9gtgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5V3HtMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8D3C4CED0;
	Sun,  5 Jan 2025 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098012;
	bh=LWqHOjlFuf3//TsXJwahIXPO8AJTEI6GqRf9NpFvPU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5V3HtMwHlH8OCJfIWG9wQcCJjODBo3odTpX58eP5MPIyMvO+l78C5Zeqcpgmsc5j
	 TbceEU6QqQacvnkq79P/LSH+aeayk73c/pcndBVrlk0HJachd1us7R59SjB9hJbYgG
	 1s030uwZ/8wauDH8+xv/j3560SOurtFkK18LiMNPQiAeEcUd/iEyHZjAwj5tFgQQ5/
	 /7sUX96q+3IeEwCPgkl73VTZv27SYZz3cUHkeSIzpV3duoT0ZdNkaqeqHxt4gZ1ccW
	 qTCRlSOud6DrWw/Vtbv0qsNe8/DVhrlJPju1XwCYwI5ntNvdxfLZocJAvYZy/g4khP
	 KDkLaxlSsOpLQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 11/27] iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:56 +0000
Message-ID: <20250105172613.1204781-12-jic23@kernel.org>
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
 drivers/iio/adc/ad4130.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 09012f33ff16..1a38b52abbe4 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1074,10 +1074,16 @@ static int ad4130_read_raw(struct iio_dev *indio_dev,
 	struct ad4130_state *st = iio_priv(indio_dev);
 	unsigned int channel = chan->scan_index;
 	struct ad4130_setup_info *setup_info = &st->chans_info[channel].setup;
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		return ad4130_read_sample(indio_dev, channel, val);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ad4130_read_sample(indio_dev, channel, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE: {
 		guard(mutex)(&st->lock);
 		*val = st->scale_tbls[setup_info->ref_sel][setup_info->pga][0];
-- 
2.47.1


