Return-Path: <linux-iio+bounces-17438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A28A7657E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E217A3414
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DEF1E3780;
	Mon, 31 Mar 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhCEl4/q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2691E32DD
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423266; cv=none; b=sKXNzowwMtLtlQI7NaTm4Q2545VSQ3KuymwAqBAy2yhl9orEd6MvsUss99pX2JYFjftGMdXZJiLtxPzEo5iOX02sWC6B7F9HlBSrDZSQmSJzCAeFXWoMUTgf6lz2bPp0QPE9O5/DshbW8u3PqgX4LdQ0uAztACg4JqPE312wzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423266; c=relaxed/simple;
	bh=1G8+RedA+cYnYN6BK8VVC6Ap1ZihZtFWfZ/E2J5ieZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbpi/cx6UdKTPfwGoYs5xa/wATRZKFGfLKBtBr4TeW5JqvgQ5A3cwiyVizglj6PgdzlQnYTb0FDRspOwCGmov0y9DsHxBMPQFpDGKoZVYWggyvkkMK/XIFlRbJoSHyb3y135qDj3mMRBLeh0bcP13fBWZlVygEKsReNKzUxuB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhCEl4/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB07EC4CEE3;
	Mon, 31 Mar 2025 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423265;
	bh=1G8+RedA+cYnYN6BK8VVC6Ap1ZihZtFWfZ/E2J5ieZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhCEl4/qfzQQRC2+6iPm4HvCTrLdv5bobXZQp49aLUiMKUKQ1PfXr8V/URUdl0psz
	 dsOmMDkqzSGYrHjRuNXnkb13311FidaofioGmttaDeXw6mSxXJLnGLuPV1DiqA2H45
	 2Ou1pZ2RBQX1AGmYVOGadEEqS3kIKIUYR7DedMKGr8lQr4SsWaz8dqIBtQh9UzvgOe
	 0z6YLPxEyYDr2HQ9Ku2UaVgxuwfUY3IX8IUYc96vk1lZzk/5ocogm4ZjO1BIEGF86Y
	 Q0davvvZQ2l/Y2enZxL/22pS+L5ufQmzKw3/fx+oOpx5bPp9uqgf4DevE0zp/oMWTf
	 FMDPkZpw0M+NQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/37] iio: gyro: adxrs290: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:48 +0100
Message-ID: <20250331121317.1694135-9-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
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
Cc: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/iio/gyro/adxrs290.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 223fc181109c..8fcb41f45baa 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -290,9 +290,8 @@ static int adxrs290_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
@@ -316,7 +315,7 @@ static int adxrs290_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
@@ -366,9 +365,8 @@ static int adxrs290_write_raw(struct iio_dev *indio_dev,
 	struct adxrs290_state *st = iio_priv(indio_dev);
 	int ret, lpf_idx, hpf_idx;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
@@ -408,7 +406,7 @@ static int adxrs290_write_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 	return ret;
 }
 
-- 
2.48.1


