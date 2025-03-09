Return-Path: <linux-iio+bounces-16605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5C4A585F3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6DC169528
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37F1DFDBB;
	Sun,  9 Mar 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9PnAdrj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5C1DEFCC
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539550; cv=none; b=jCmUH2R9y3Hr6qIYvvJ0Qyv5tx2TkaBBNczYg/3NxRsZQRq/pWdllXXc3aJz2bl+I1h5EA2YhMmc1JpwfG+kMMkLUutp3YfLbpbVO6oiQPGYS1rMnRu9CKQfhIhBTdkGslJAFXe3a+59o+xz6gADyNIcLGVRaxVYt0TXUU2BPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539550; c=relaxed/simple;
	bh=FPoYjPbpXT295JyRgIuWbxFSN+OMkaJAqASunXDGbqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6Y9rhB9QTvB9rKCUHo7NnzMfexzDAAciFmK87qh9+zh+ANnF0Sqc5Mfp3nN+GDyaIdtb6/PHv2RMlYx1xW/0m7OS84K50+dmJqY6vV56/esO6pCQa5PHa74+0UibGPe6FCDf9TvL2m+/Q58EGTkjuFg/EG9QZX9JrBDSNOxMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9PnAdrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C1C4CEE3;
	Sun,  9 Mar 2025 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539550;
	bh=FPoYjPbpXT295JyRgIuWbxFSN+OMkaJAqASunXDGbqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9PnAdrjS4R4JWzg/Sc2oL5w7Jdddr1WU/VwOV0ivEh9z5S1Jr7ak9B87ia7bG+sw
	 YL7aW8fgPOR2GEuwXDzCvO3PZ6hGvjVYEi3Imf2r8PTERJAtrPykZg9qyuy1tOJpcN
	 UDSXLomYo7SnIO0M9SFMJe2H40DthvWLemltI35DyFTjmLu+I3DFFTfpkg/qAdeRny
	 NEXkIrwPwB0tim7EVg8lgnsdCdUgZ2yG437rE2uh81/t/LuPt+xSRQAQWFBNECnAKd
	 SJa/xG5H6x4IxQi8ajrY0MMe6WqzkAGRNIxkV1uY6mZ4ctDxCKGO3Eg9XvM07g6+Hq
	 lot+XeS9GA5qA==
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 8/8] iio: adc: rcar: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 16:58:19 +0000
Message-ID: <20250309165819.1346684-9-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309165819.1346684-1-jic23@kernel.org>
References: <20250309165819.1346684-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 11170b5852d1..221c075da198 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -199,13 +199,12 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		if (!consumer)
 			return -EINVAL;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = rcar_gyroadc_set_power(priv, true);
 		if (ret < 0) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 
@@ -213,7 +212,7 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		*val &= BIT(priv->sample_width) - 1;
 
 		ret = rcar_gyroadc_set_power(priv, false);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


