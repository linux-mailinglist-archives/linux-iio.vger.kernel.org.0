Return-Path: <linux-iio+bounces-15219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3CA2DFDA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692C53A56F1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F91E1A28;
	Sun,  9 Feb 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWLfRZV9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBF1E0DE6
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124595; cv=none; b=h4j9WEcyOuziUwpelFPDbjemq2ldTAdeBn4UxiTOyKhkKDYGZY4MA36hUj6gGO4s3Z9BoDpNYoJ3eV6dCJdCl1TtFGkmouOGQsHHbP5IQYM9Mo1JjgzLKr+UW8U9Zg8QvdUjhAI2aGpZC+oY0Jyz93Wy3B6wDr8O4nL/kc4qLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124595; c=relaxed/simple;
	bh=FKZuWyaR6hBvkkbrWZS5xyem7htiAp5aQX2oALu3Exk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vonti8gCot3HUzqmdnjZnPuhMn+3Ukgm+Ih3wSRTKNu4e9834N0Q5Zq6c1P5boYIwacQquqz252GbTrISVevtx+pKZ4eanKxZOvO5X63I0ekgaOd82kaPGU2d3dL1gtOj1S/GQe8kscbs3h1Kuq06GFpvRgLH/SGmmunNG2mEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWLfRZV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1CCC4CEDF;
	Sun,  9 Feb 2025 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124595;
	bh=FKZuWyaR6hBvkkbrWZS5xyem7htiAp5aQX2oALu3Exk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWLfRZV9rF4dULLoI4A6FUOFMj5q8ku23xLjVZtFJKrxG4/TDYqtvZxelx4qbzyb9
	 6fg+J+DBFqtlXODMlx4w9Ha+L8/s8yeebWDr9rVw35yo2VkH2q3/ZeoELnTjST7Ck5
	 ai67HCy+SnOQ6CfP5hCZpYkmvFDirk1rAXWsOLonVDID/9kRFAmIjgsliw9nBJvV5g
	 BGwHZKS31+Yx9UvuxRVt+B+xrZXw+DtdzG8lnKkgPit7LOzAImxxsrvQRfmneI36iu
	 21P44YWZdbLZxR01hm+2KeY0vvrfM+6SAslPpEkaBFIYOt7BuuBX0B7vKFXa360kHx
	 6u3bM4MXKYZWw==
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
Subject: [PATCH v2 26/27] iio: light: bh1745: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:23 +0000
Message-ID: <20250209180624.701140-27-jic23@kernel.org>
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

Reviewed-by: Mudit Sharma <muditsharma.info@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/bh1745.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 3b4056be54a0..56ab5fe90ff9 100644
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
2.48.1


