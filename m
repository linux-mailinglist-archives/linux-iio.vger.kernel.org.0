Return-Path: <linux-iio+bounces-15203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462AA2DFC7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C16518853BC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2271E0DBA;
	Sun,  9 Feb 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/RLcYs9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CE1E04B9
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124476; cv=none; b=sMX2ETc1ybuQsfGnbxlt1krVO6/ohNoa0dLhPf+vbA+wZ+vUPIiUOD1ZpQQ0a/jf5jmqFTZXcIqTImfFFCqPO9wzHxWHsO8hB8XOw/4/q4MczHIbpzCno01ZT6bYcCPPAnUI8Iz25X/nQivFp9KmD4Biavyot7pX9iwdZ9vq6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124476; c=relaxed/simple;
	bh=4IpfLRZ5I0wsh95AQTJdt9kBCJhifdBhs6msRsfrKbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFHBZ0ebVee3lvL5DifY5r13xz+FSZxq+vuHW/DZtMr6bNARCYbXP8TnHCGXVHmg8XkIhoUKU/xJLRcIBXQ5Wa7iNLSafrstHACzJGh6KMgRg7/6biTjmkLV+C+Y4XuOAku//XsX/wQH8FN7e0cqDeJYlq4or1pCt7C0QYOlRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/RLcYs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31065C4CEE5;
	Sun,  9 Feb 2025 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124475;
	bh=4IpfLRZ5I0wsh95AQTJdt9kBCJhifdBhs6msRsfrKbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/RLcYs9/0m6wJb0y2v+vi0lZeEuqyvc6DrWvknuMkvgHaLFHpnKZj5XiG6ZajA/7
	 DhYef50MHr51eQDsivddsWtSh9jZk7ZKmg3Xb89m4tTZ6cBnePEKPJOA7en/tWqoCY
	 VewnuCGHsNXZ7JJtElVQ7d30sK+BthJPaX9hpN8KmVWG1MxD4NyK/FB92G6Hodcnzz
	 tlTTYj1qjYCnqMkxGNZGitsILg8c9mPePOt32XAtPRHghoiHxtHtViPiCOHGUiQ/WQ
	 Ddf0pMrEPOw/u6lYSiHkOGZJPThWRHHdZSdpGZs2dvC/U69PqBDHF+V4DYk/991zeZ
	 iK4KX4t/LnbxQ==
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
Subject: [PATCH v2 10/27] iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:07 +0000
Message-ID: <20250209180624.701140-11-jic23@kernel.org>
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
to check for unbalanced context.

Cc: Cosmin Tanislav <demonsingur@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4130.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index acc241cc0a7a..061eeb9b1f8d 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1067,13 +1067,11 @@ static int _ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
 static int ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
 			      int *val)
 {
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct ad4130_state *st = iio_priv(indio_dev);
+	struct ad4130_state *st = iio_priv(indio_dev);
 
-		guard(mutex)(&st->lock);
-		return _ad4130_read_sample(indio_dev, channel, val);
-	}
-	unreachable();
+	guard(mutex)(&st->lock);
+
+	return _ad4130_read_sample(indio_dev, channel, val);
 }
 
 static int ad4130_read_raw(struct iio_dev *indio_dev,
@@ -1083,10 +1081,16 @@ static int ad4130_read_raw(struct iio_dev *indio_dev,
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
2.48.1


