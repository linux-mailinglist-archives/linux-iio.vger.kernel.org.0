Return-Path: <linux-iio+bounces-15199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A32EA2DFBD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1995A7A1FAB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912951E0DBA;
	Sun,  9 Feb 2025 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlXeQiPH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CD1DFD9F
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124446; cv=none; b=hohE1ot50YLbJfHAJyHTiF+09fTnpoda+SBt04MnMqQr3jYUyhLFH4rndeOZvI2ZIElV3vM14J6x7nrqtPCJ/Z9WUN+h6c7KLmNSG//X+zPw20vCGLGl/JoL5hdz04CWkRC3O7AuXGIT2K259EdaCv3vP/SomSKZKk35TZBQW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124446; c=relaxed/simple;
	bh=HlF5z8uFrHezw3K4M6X7Z8yJb59Y8sk5PDWTPY1oZfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBDSCpKSkhBtrlKjtnhk09J4YD2g7GAiDbhYeC5r9l6TTKbODV9THMTAKBZvRqlHY3DREh8Zzrth7zLOPmJQ3QMEkUdTwn3tYt+eLbLHKZzhVNpRbp32HrrzhKFujhtSy7Yq5GcqkfaodGsIIWYnU59brWjGjMENHsj52fvGc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlXeQiPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA3BC4CEDD;
	Sun,  9 Feb 2025 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124445;
	bh=HlF5z8uFrHezw3K4M6X7Z8yJb59Y8sk5PDWTPY1oZfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlXeQiPHliLEuM7NN78aCev/QCtzSjjwokFttbD2vc0/7KYYmSKBp2g0m/sLwdlqY
	 rsiXZTstLAEK35smm4E3XPUqGafMFG7vzf+WGMcvyd5b70E08bqsZYATPJWYv6hw6E
	 OXn/sYjxYToxnUNFvMD9Fq1p6rmdf1wpmtVt9rItfe7e4dkZ2y2NHcrJSCMBblLlG6
	 HBpawXLa/9SRlB7tYIsXSBIbgMrazCNrcopYpxZDOr68UFc5FPnec3YsOym8/UpZh9
	 YPlXlMj0ij9my85wXIO4dPgz4nFhtj74NqNxpFliOePQUFXdcw3R59IehlYZakNLow
	 sGe0nWu0mx+ng==
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
Subject: [PATCH v2 06/27] iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:03 +0000
Message-ID: <20250209180624.701140-7-jic23@kernel.org>
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
to check for unbalanced context

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


