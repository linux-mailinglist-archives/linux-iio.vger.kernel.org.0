Return-Path: <linux-iio+bounces-15218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1747A2DFD9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4448E1885631
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3C51E1A18;
	Sun,  9 Feb 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD5tQrY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF151E0DE6
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124588; cv=none; b=PVzUsEOvDFw4e7elSn+9wCZ8fDjHuKkrg0RTb9Vh0DacvR1FsJA2udLJxu8kX2X9QpAXzvV9rywC4b6CUdf0Wtfy3x1r3leio4Sj3Itf+JJTJ9VNVksroyWr97MgjY1tfKzjivYrv7N2UwWZUgwHrYFD6Huv63jkaW6uFg8i7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124588; c=relaxed/simple;
	bh=j97hnJi67W+aUnVpUiP5gT5/9CUBBP3r74hVPSZJU/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaiXP8CKLsAJO5Z+VTArp+C4vj0bKIackqzgK+fLZQcrNSFFDbmVBKyfEUwX/6bmV06a6kSjhf1bTlSn2drbDkjYrs9v25V3xdpctNGT2HQijUGCQqbbMZFaimhU4lvjVN7/EtZyprmfLoOylSf89lcmAvCTlzmVFuvJbBLtXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD5tQrY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8109BC4CEDD;
	Sun,  9 Feb 2025 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124587;
	bh=j97hnJi67W+aUnVpUiP5gT5/9CUBBP3r74hVPSZJU/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CD5tQrY4kanxmvwVBOEVbqB7fxOeMOrCc0xND651X6nLiAhc13WTB0zc0dYYjzAN5
	 LAZJc1LrjghuUpLg/1kqtGcCldWlQvz5K60PMAD6kkWERn/e5q+kfCJk2+TOCUvb0Z
	 YGaaPmS9nIASHIWBenL2yfnuFLMqfOC5Ivk4ni2GtLj6sNLT5IX1tXQJ2ZD/LKTwth
	 8MBU6em4v2mwCOS786r0N3ziXcp6qnYc0XoTgj2aQSHVc3CVIRUJ0WeV0ONGDNgOdj
	 h9TJVjCS9AFzUr1aU23r+U7hChdgCJB1Q9OK/6xNSGumtRr/pgG2bCx6IlpCLZf0IR
	 XhizaPdJJ+Vhw==
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
Subject: [PATCH v2 25/27] iio: imu: bmi323: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:22 +0000
Message-ID: <20250209180624.701140-26-jic23@kernel.org>
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

Cc: Julien Stephan <jstephan@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


