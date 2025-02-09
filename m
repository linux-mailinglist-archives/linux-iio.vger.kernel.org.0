Return-Path: <linux-iio+bounces-15208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A8A2DFCC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E5216063B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443DB1E04B9;
	Sun,  9 Feb 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHkDvCGv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044931DFFC
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124515; cv=none; b=o6WQJJ04TnqZDcj3yOp9Tc+9QhdRyKUpjHoE9zfJWBZrEBgCYfdp8UYkWWEEq51JFZoBKrOWabrNtWgI/jCXk74SzE8SGzeQo7ZCBSCGqFtDEo9yVj4S4iyM5TdrYHlqKYlvSmsD+2RXsON+ziILCDivkyu8sQTzcLsDgKDkMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124515; c=relaxed/simple;
	bh=H8Qoi5JGWNco+pJKwEX35K+WMSKStp1uKF8dogDrK2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdAFtjSArzcMjrkF0TPS2FrBQsyq9s3dEXeFvD1drqFkyN6ri/JfrO6m9M3nKJh+3ANLsJ3FGKzZ0CxAFliUxKNoMDRKiXt8otK+V1OPYK0fIeLSOlnJfpG41eqvTh/Rgd6GIWU2/U78Jw4HiRhqIEGGMbbYGMrF0lxFhgAAwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHkDvCGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8E0C4CEDD;
	Sun,  9 Feb 2025 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124514;
	bh=H8Qoi5JGWNco+pJKwEX35K+WMSKStp1uKF8dogDrK2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHkDvCGvppmbr2N1qSjL5QuWBiz+tvCekgHngLVr9n1v6xfnLBJtgZ7t5P99XRK+Z
	 GqwHGpxyDU6bYGi8n4Prby6DrghcbktNKW7mo3AX/wDCXEl7AxGeUVH2+b43oq/8Nz
	 Ps2zhNfu3n8A1996ag1+Nycrw1NkIeedL/KZUnFxfxDQqCUDzd88V+vV3GCmTYq3ua
	 Dr4bDGR15Op17dSEbXK3+aIo7AmZY71ins/ol02HppR1PTNQJIxgKpEHI3bGE0gsDI
	 4l9p2CQk4E9PF1UBhflM1EVo8wqA0G8WCmJRIJXvBW+Y7s+liSYZYSUSEsjVqaYRQR
	 tYGtLNLQYHxCA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 15/27] iio: adc: ad9467: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:12 +0000
Message-ID: <20250209180624.701140-16-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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
to check for unbalanced context. Also use guard() to simplify mutex
unlock paths.

Cc: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad9467.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f30119b42ba0..f7a9f46ea0dc 100644
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
2.48.1


