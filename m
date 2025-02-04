Return-Path: <linux-iio+bounces-15016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79FA27C69
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B0A1883516
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DBC2147E9;
	Tue,  4 Feb 2025 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nojIAGML"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D614B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699492; cv=none; b=HbE9wIFUxjQ4YmJcHbc2H4x8LNURQrwEzB0MroQPFIwvGy1xCchZNwQdBV3Gey+dXF+rd6oENcowC6ayYQ9JoReVkPW4Ee8QJs00RQeNn1hWEomlxxsY3XJpXCRE042LXWmWT96UCJpJjiEHFDebkyUvoWFALwVjNpmMe0TsSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699492; c=relaxed/simple;
	bh=Nxp50hUA+/KtmNZKJDIGXuw9CLN+asgaJyDs60V6Fa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzyTh+ZoKt3U6b4u7550rqFOXhILKQWF2g3k0z2c6TZ7xlWg16Xh09x7IrnDxlPfZSt8IJF1EqKCZOJUwOq/ShGFIs+wxfF9DVY7z3KSuODEZkeN/0pmdnbEfwB/sU+cxK2c652PRdN1rK1l+kAPU4XVwyIrh4Q3riZ0rgQoZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nojIAGML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C96C4CEDF;
	Tue,  4 Feb 2025 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699491;
	bh=Nxp50hUA+/KtmNZKJDIGXuw9CLN+asgaJyDs60V6Fa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nojIAGMLJJVV367hrW3yIUZbDCDHbRaZ9G0jP0JSq50+1Xa4Ik0n2y6w1KIyulD6x
	 Na6OmmZjgv6dPKGBRsQruTOC5NFW8XVOkaHGSTr6m3GlSzjRLH0uySwflDOcOOEtJr
	 MS4E5WbW5nojaTh77/fEYTxLh3tKl2HhVm0DA97aN7uF+HSzHDgCbup+gAKPYkr2e7
	 YujTyY/uKsT5J9LMLTI2iVwoSlU1XwhwNbsgY4FJR7gdiM9Q/Aaix8z8IpO+VStFIl
	 JEpkhIgjOQv4GfZpVdhSEesE9zDeTiKathxTLm3iS/bzo5LY1MiSwwEQLggdZvr4Hn
	 hKGcNpbi6N4nA==
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
Subject: [PATCH 22/27] iio: dac: ad3552r-hs: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:44 +0000
Message-ID: <20250204200250.636721-23-jic23@kernel.org>
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
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index c1dae58c1975..cd8dabb60c55 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -129,16 +129,19 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
 				int val, int val2, long mask)
 {
 	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		/* For RAW accesses, stay always in simple-spi. */
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return st->data->bus_reg_write(st->back,
-				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
-				    val, 2);
-		}
-		unreachable();
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
2.48.1


