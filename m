Return-Path: <linux-iio+bounces-13912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E4A01AE2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5027161F9B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B949172BA9;
	Sun,  5 Jan 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiIQGgUl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CA8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098017; cv=none; b=LsdY2aN9SGnwUvbdxwHpE3cU6ixKKNI35YORB5pe7vQuZiNtvtBRhhgVwNE7Mij3fBxXlxZoMUyRKR+7iv5BbkT+8zO6Aw7i8bgctaUH02EFngbiDWWQStE8ZLl3saMcIng9pjOHdZgTUStbaqMm6E1Hvn/DyLxta5Up8r4nTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098017; c=relaxed/simple;
	bh=QDdQBDoAOKy5DBNK9gUZzN0KcyKnxKQPse/9J8M5+xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyTtyS1f+dik1oLxQtudmwEBnhcsJa+nW5UDYD+YwGMfjZ/BDwr9hG9C5Z16tFCrbOEpoFLQ6+iDsNaDCepQZzrV0ee49p4Hp1QxXSIahVLqRXkjv2fbQ8XETyzWmfOaRAa277XyzLh6F3sUJddqVwGpxxxS5wFtKomQt4LHZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiIQGgUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC60EC4CED0;
	Sun,  5 Jan 2025 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098017;
	bh=QDdQBDoAOKy5DBNK9gUZzN0KcyKnxKQPse/9J8M5+xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GiIQGgUl/RUnS4LpNKu4wUgGYWslCFk9uuwVWbHbSYzmc3usEBQ8gXJ5+rLih6qiu
	 s/EjWdYZUi44BoMSN+TkymKt3E5JNJYZWG5WiDC0905/2GI5Q8NTQQZoGFq5df756D
	 0zis6jb7frVrJLTOh5Hs4YhjLc73C5HjLFU0tTHwdDbSQkXpldyUAe4meIF6l0SHCf
	 o8FGI6tcaAejlTzQamqep0kHRW+ID5W1OSZRnQQ+Fkpc1V0Y21w0xjG4xptT1nFti7
	 GKcfpOgQQO7N4S9v+rgK9Lq47mZaaRt2NqgeuTvF+XRHJjju0JwlWHQ8iw70dtnyoh
	 Xr4STWpbyKwCA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 13/27] iio: adc: ad7606: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:58 +0000
Message-ID: <20250105172613.1204781-14-jic23@kernel.org>
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
 drivers/iio/adc/ad7606.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e35d55d03d86..1579cf100569 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -744,13 +744,13 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad7606_scan_direct(indio_dev, chan->address, val);
-			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_scan_direct(indio_dev, chan->address, val);
+		iio_device_release_direct(indio_dev);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
 			ch = chan->address;
-- 
2.47.1


