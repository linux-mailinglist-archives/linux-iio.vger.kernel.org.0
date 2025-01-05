Return-Path: <linux-iio+bounces-13922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D83EA01AEC
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63583A2DFB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DD18C02E;
	Sun,  5 Jan 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YniBf58r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553388F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098043; cv=none; b=jeAgUD2qYmmOLjr0fklFnXGzPdYxZwEclq/r6YNQDYtBLhzePzzx/92H+CprKlt7TRCoRAVf84VUWF51LWfckKnMFu39XSw2PhrpUQs0igWHTOq/fRHsniA4LGl8FNYwnezaqLMYlwsOiH15IaCRIa6yfVVemtnphtGA+Ca1Pic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098043; c=relaxed/simple;
	bh=g3hjhJia7MsY61ghQy9J5RYMGQ3jPz2uj222N4yHGoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3r+cHxhE1FqRrOd8tyvHPhgoR3jueWTWpQKg7Mfz1PuGP3sNttXsBe/Q68IPUOvTl/F4qIjTdYiIDh1bKxcWYEehXYhDuIeH5WYlSPILzFxbTsADN72aDRzstp0j8sRvT7YI7DHoiVp2+jEQJ1JVb0RPT5VoIHkKDv/cu6gv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YniBf58r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44617C4CED0;
	Sun,  5 Jan 2025 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098043;
	bh=g3hjhJia7MsY61ghQy9J5RYMGQ3jPz2uj222N4yHGoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YniBf58r5TX1IAzK1a55UVZ5K8kqvSNvgB/B+CuDCnEDJA6oPUIZcTuuCLYj38Tcw
	 sllxE1a5qOLhBCEoKWS7GVHqeyVevT3OrEO1FSXgakTC4vbnrvLYNv+JBS1Tb/T+DZ
	 cSTQ5RWxh3monmceliCk4IwhyauBhU9DcKoQ0cfRzf+q/8X+YNjgZgShmA0+2LvwhB
	 TM5FzmwciS3hoGsRAVX8gez8mHPMsQFn6jPaHbVaYCJqDkIP4T5vF+5Jcyda6ybxW6
	 dxvE1w8D9OBoeAOrW5I7RntaV0MZhY84gkpcPPTfxcqwYQGeYnk7kP6wOGZ+aqE82E
	 xwNSC7p9kHs6A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 23/27] iio: dac: ad3552r-hs: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:08 +0000
Message-ID: <20250105172613.1204781-24-jic23@kernel.org>
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
 drivers/iio/dac/ad3552r-hs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 216c634f3eaf..64899a02ab28 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -90,15 +90,18 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
 				int val, int val2, long mask)
 {
 	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return st->data->bus_reg_write(st->back,
-				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
-				    val, 2);
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = st->data->bus_reg_write(st->back,
+			AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
+			val, 2);
+
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.1


