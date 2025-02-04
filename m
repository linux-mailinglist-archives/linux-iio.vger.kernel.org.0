Return-Path: <linux-iio+bounces-15020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D4A27C77
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC17C18864B2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04321767A;
	Tue,  4 Feb 2025 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltcCzivh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD35214233
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699511; cv=none; b=YZUwCp6n1FdBqg74ZJSuca2Z49WrHd15SlW3iK+s4zTE6yYWuU1XOqbFlob1cwwgqlxkFK1gUii6YngY2zOOpw7FrppLN7KI8L1zOBvXq4CUIACOxrqq8Z/CfS2yI6ziUZoMmTHSqqCYVbcIpSi3KtKu8Dyi26Z6kvcreuYR6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699511; c=relaxed/simple;
	bh=BEUJh2oBdBlqp2ozGWkf82WukJcYhtRL9vauOpsoi0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eniy5Jn9sOkASQCKhb9gDFrAkGHnKr6NZupkKAYUIjbUMobbrF1hc+wOmUv5uK4HZDI3sCpuuZR+Z1XiDI81fzFJhCbMMEwOkj+qCLTGctJ2WLvIZLiQugnU+GXdCz7L6AHU2wZ6zZJbLStLjrtopW6ZO7X4Bp/T6etxFw6Fm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltcCzivh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75939C4CEDF;
	Tue,  4 Feb 2025 20:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699510;
	bh=BEUJh2oBdBlqp2ozGWkf82WukJcYhtRL9vauOpsoi0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltcCzivhYB0L/1mTxok4vQeRdqba0Zh0BxYEGpPVHeGrSdhWYgDvlCgg7bK01G9yY
	 Tlge7nlqB+OOw6kfXX1W0GWo6pRcJtN2BoP5ajpSoBpRiaOCTq+uOaSMMZbZREspG7
	 KFCtqkGBxogIano6C4s0Gm0FSENZMumRayAaXD8mNPpVIDVSAJzU5lvlCbtAuYbaAS
	 smo11lbCTf1KJWjYwWcq+rFbhlmeQCTo/QGec2OwRs5rEHl4xKNyZcxi0n3IPdhEFk
	 JDj7GuxVoZ+2ucsB4IFkB+2dTIlwTQvfiEOPX7HM1bFxtwNs/3BNRIEJt9WG5JIxb1
	 7jVndtK/J6TvQ==
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
Subject: [PATCH 25/27] iio: imu: bmi323: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:47 +0000
Message-ID: <20250204200250.636721-26-jic23@kernel.org>
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
Cc: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 44 ++++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 7f386c5e58b4..fc54d464a3ae 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1702,26 +1702,30 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
 			    int val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return bmi323_set_odr(data,
-					      bmi323_iio_to_sensor(chan->type),
-					      val, val2);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
+				     val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return bmi323_set_scale(data,
-						bmi323_iio_to_sensor(chan->type),
-						val, val2);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
+				       val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return bmi323_set_average(data,
-						  bmi323_iio_to_sensor(chan->type),
-						  val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = bmi323_set_average(data, bmi323_iio_to_sensor(chan->type),
+					 val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_ENABLE:
 		return bmi323_enable_steps(data, val);
 	case IIO_CHAN_INFO_PROCESSED: {
@@ -1747,6 +1751,7 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -1755,10 +1760,11 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_ANGL_VEL:
-			iio_device_claim_direct_scoped(return -EBUSY,
-						       indio_dev)
-				return bmi323_read_axis(data, chan, val);
-			unreachable();
+			if (!iio_device_claim_direct(indio_dev))
+				return -EBUSY;
+			ret = bmi323_read_axis(data, chan, val);
+			iio_device_release_direct(indio_dev);
+			return ret;
 		case IIO_TEMP:
 			return bmi323_get_temp_data(data, val);
 		default:
-- 
2.48.1


