Return-Path: <linux-iio+bounces-13926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBBA01AF0
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1B87A16A2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17149191F8E;
	Sun,  5 Jan 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkB0j+/8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13C8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098053; cv=none; b=RS6ma5vnV8pcWEVGizbHS/muCFaB0XNR2xLzlCGGonDDQVPnlddGVE0Cqcnyl6jsHyHwGRREHrShZfIY15qk3WuhoyQaqqtWT8iKxTJfFuK42d8F8xY8NBK0qTozMHYlzF/K1sUbuxZi9jB+m6oZUcRlaJ/CoxcJV8q+F7TcFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098053; c=relaxed/simple;
	bh=efDmfrqpb35QgZd8qGvw16iYdHkWXdieufTb1POukhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHC5OncKWc/fNIf7P1BEFoFRLKtEOLz+3X14FsLP8P5rt6E8UcwwR9hmKjTKDFT0Y2ylZCEG4MP9246ScQwQ1a6acI3SKBkrULifwjJj37XDU+mDmqFx5QxNmJ50z3vynrSi/GkrLm3D2iH7SwPqD2oSZzV64dYUnk9pAx3O2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkB0j+/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B6EC4CEDD;
	Sun,  5 Jan 2025 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098053;
	bh=efDmfrqpb35QgZd8qGvw16iYdHkWXdieufTb1POukhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkB0j+/8Ct9HDOnprcgTAipv6OSm8CU9J7fzn1KYSLhuOhzcnJP3rnM8awSbYR0s0
	 8Tuznd/pYTtQHm272mlPEvzBaPYAraGvET6IW50V9Y0blr/gvI9CuGIvnjWW+SdQMb
	 dFSANpuooRGW9U7A8MMCQJ/7kdDWZCPTuq48klJAe3MGMchk1+u5q21H3I50bJiBKr
	 t95i+LN2GPufCmbBHwGLV60uzDyoxHpvbAqyzFyX1Yv3wsUHWWcJKdhZq6WVFduLEz
	 zc3siexIZsPncexpFvmIKr8OCoUx6Da7DP1yucyq6R5Y9VM6TrckKWwKA7iNJrvj1V
	 711aJkv5gymEw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 27/27] iio: light: bh1745: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:12 +0000
Message-ID: <20250105172613.1204781-28-jic23@kernel.org>
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
 drivers/iio/light/bh1745.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 00a33760893e..a2f3df7f1818 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -426,16 +426,16 @@ static int bh1745_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = regmap_bulk_read(data->regmap, chan->address,
-					       &value, 2);
-			if (ret)
-				return ret;
-			*val = value;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		ret = regmap_bulk_read(data->regmap, chan->address, &value, 2);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = value;
+
+		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE: {
 			guard(mutex)(&data->lock);
-- 
2.47.1


