Return-Path: <linux-iio+bounces-15000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461AA27C58
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D96188504F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8520409A;
	Tue,  4 Feb 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssZW+F4w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2514B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699412; cv=none; b=p+cHwEuxHc31poVG4oyTGxrybHWPwum+F5sUlbA7yRDOZrUqpnnx9MV8AUr1PV8Y28Nv9AWxjdP2wraomcAV+I0268tvnCnnMS+33uoBhDgS9uY8T9cYNPdpwKD8LYRWvZk6LAZpSROF0QYKThMuJNZrD54hkk1XQ7z92e6Hbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699412; c=relaxed/simple;
	bh=bI9IJB3nieW8XS1BBdqTBl3IRvqhP07gqqzbGKME3sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMVvgKc4PjUxLEgo8WuUN2HHNcE3Z7fl/C3v3ySL2tab4Oel3mcSmGSFS2FAtJ6rXYcxwA8rSYwOcSAn/VAzz53/GFZTKlPdubvEuhKVGC8YJ7JxJK44aqsXW2oVAi88B5w7f4mm8HNAKLnESLa/ZXwDKFQi79ZiubeyilnHJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssZW+F4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF68DC4CEE2;
	Tue,  4 Feb 2025 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699412;
	bh=bI9IJB3nieW8XS1BBdqTBl3IRvqhP07gqqzbGKME3sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssZW+F4wZkKCK0vpI9e3b3r3yJXoIh/6qBQFn7DHC7zifPA11gJ7gfQa6Kk2VxIfY
	 MyQYg+j0iI4nEwkWNVHJFngeJVBtBXQte+Udj84lSiGeOfqVpZNYkbY7+8zPirwAfw
	 yfYhoYLXYKcVsId+z+ytzwFoTZxYHxUa1V7j4xeGq7KOBqBAUStm6niXeCO+vHKKX8
	 545j6FkFdlYAnz+pz3OICU9RSY5kfAhUXmiJW4CevfaT1CbZXuI94HbrrbAnJYjnV/
	 qt/3EkS5ij0L20DKGEyBQECDHP/vkVggkzXHCk0loWidlkCt6IxRbXXox4p/XrocQ5
	 Ero/XWFNpp4jA==
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
Subject: [PATCH 06/27] iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:28 +0000
Message-ID: <20250204200250.636721-7-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index f7819dd2775c..73d972416c01 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -429,16 +429,23 @@ static int sx9324_read_raw(struct iio_dev *indio_dev,
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
-			return sx9324_read_gain(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx9324_read_gain(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9324_read_samp_freq(data, val, val2);
 	default:
-- 
2.48.1


