Return-Path: <linux-iio+bounces-13918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6AA01AE8
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0F53A2EB2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C118870C;
	Sun,  5 Jan 2025 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqWIdsDb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FA8F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098033; cv=none; b=JZAqU9abOkclgim3Fep1HzsFLRmiaWXy6Uo84oobAC9L1268esvzyYjM029DreQujHOaHEGw1/by2odeG2Pmx+e0JtW0BePWFnX36MQ+iqAJz2gM3WBSA3+479U108XOlQXl25uHpocKTnycNONMXyjBHh6rJY4AEJ1qhpeqrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098033; c=relaxed/simple;
	bh=Jtc7TozGykM0Wj6p93o65xTHuGnOYj1z1cMBkhoxmG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MThRh1XhHYDZNEn5Y5SH+dmChevggmqrTArSdzx2w6LpVO+oqLetDco5Pmf4ciVIBAnd8yGVA5lpxGrxfAdWvXYzfGXGebIdn7S8kpP1IvHNbu17xFlpttzGx2z8EpEpdgfp2heBjUt0fKNB9oBCjYVgLdsOLwPbAHMpUUZXEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqWIdsDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B884C4CED0;
	Sun,  5 Jan 2025 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098032;
	bh=Jtc7TozGykM0Wj6p93o65xTHuGnOYj1z1cMBkhoxmG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqWIdsDbqHj4fGSq8ckhQMqFnRf+2TLnhjwhCKfJRy+IaaPn235FLhoAEfWLapDop
	 quIbVeVGio4sniqrjsxM2h7FUxRiPRgXoKpnBg45/uop23ErwFbVVnVr8XpnUcx2J8
	 JGFjNoZkrG/K8Z2ujneZOIxtYm6NaJt8M9IMm0kp30AH6p2qzlQA+Hl6UMZsKmu3tx
	 JLqm+yg1nrSnf1KgmBJbWs7c79eRuJXkDvUihWD4Zv3SXybgwZQqgpm84Ivre+GoM8
	 G2ELQpXreWoMmAyDQLc4/EL69WHx8vYq22iqAl4YC+NprPrTr2d4t4+Mw29kAlSrW2
	 Q1OrPBAHkgRsw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 19/27] iio: adc: ti-adc161s626: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:04 +0000
Message-ID: <20250105172613.1204781-20-jic23@kernel.org>
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
 drivers/iio/adc/ti-adc161s626.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 474e733fb8e0..28aa6b80160c 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -137,13 +137,13 @@ static int ti_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ti_adc_read_measurement(data, chan, val);
-			if (ret)
-				return ret;
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ti_adc_read_measurement(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = regulator_get_voltage(data->ref);
 		if (ret < 0)
-- 
2.47.1


