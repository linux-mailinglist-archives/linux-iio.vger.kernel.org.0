Return-Path: <linux-iio+bounces-15205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B1A2DFC9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108CB3A557D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085821E0E13;
	Sun,  9 Feb 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6JRQJlK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86071E0DFE
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124491; cv=none; b=UKoljh5f3+Jnp+gCxGRkRdgCipJniZTlEo2e1SPZvRGvo4ZtIj+4uGNx+tfTMoqgC5UxBqAIfcm6Sba3AgJCbBKSlZ0tDNkzr+B8U7tl1jWSMMWDBpzKib/fVvmkQQcmpBUASOFcl5uGndQG+GqaiWGw402LGkMn9KpRE7OlOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124491; c=relaxed/simple;
	bh=glz/mK5s3rwAtTfjyYCokd/AaG+capxlzhjrVi9toGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHD99valNhqGwcitao4oIl0+0prZ62vqzUmtVyo3O4EY6KiLGL0Uot+lJC+ehbdqvfj08NErmp+CWojzzzoSfv99uBCUC+RF4dn1TgIppJRwrLgiLSgFzOTJ67EwKf0s6nU/uUJ79gLZ++KJi411SeVzIyVaSN7H8XPyt2SjRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6JRQJlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C130C4CEDD;
	Sun,  9 Feb 2025 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124491;
	bh=glz/mK5s3rwAtTfjyYCokd/AaG+capxlzhjrVi9toGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6JRQJlKTFQ3P9lGw114kpUGGc1gOJrVUSVQr0IO3kfnfturpCHbVkftBx+yo+TB4
	 yRw4/oVIaLyH8F8RAVl4n5BaPJqWxRJfc37dcYp1v9rvCg1xCgy/Ngc0suh4VsuzJ4
	 t3vh+pijcTWafCLHzqyNDggWIlNTztLgUU/rX/DU5U/y0B4TfnYLB1WLBeJWIJbDgZ
	 nvRdLikN9yZmJ0VfBlEXqNDliO7isrY8YCz8RooxtW3oig1YjugU4jSPGLAsaGAiDt
	 C9oko7y2nGMWK7Ts0WkAQaluprFdkpoLn8hhaLBKyf94zH/1y068d6GfibUYQ0JcrO
	 gea3wbUdDw8uw==
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
Subject: [PATCH v2 12/27] iio: adc: ad7606: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:09 +0000
Message-ID: <20250209180624.701140-13-jic23@kernel.org>
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

Cc: Guillaume Stols <gstols@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d8e3c7a43678..39b5bf09e46d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -752,13 +752,13 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 
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
2.48.1


