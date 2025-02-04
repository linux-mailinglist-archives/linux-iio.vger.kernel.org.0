Return-Path: <linux-iio+bounces-14999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E728AA27C57
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FFE3A3BA1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F0E20409A;
	Tue,  4 Feb 2025 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8lF4dDD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B414B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699407; cv=none; b=p7r4oMKegkdD0aZkVBhe9JFDN36aIXn3Jg+Pz7vmruJw8jrPz3HXIwhnFg58rEjy/2yQiXLeA9WtDs1C9uQ2zrq5fX0dxdTrLQFPrJALpa21BIcJs5EnTrkL8qBI/7ZgwrHgB1Q7la+J1ucr/31Fm3yOOKrIcD+yk7rsPq89zMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699407; c=relaxed/simple;
	bh=/OGZR6yc7Rs+FpGVtY4XwYosR2D9X1bvqwbA+vxDDJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1xw5B2Gr9f2Uff4xLAQUF+R4UHLklpe47y1+IRvvAIs2cSTvSeYJacSrpwiXxVF4e+tMXfEXo3+IsyFk32SzYVKuyjUFJ+HQ9CxUhG7BlJURI8CY2KkYznVx2dyPC3SNz3rlTJJs1M+yxkgbqUkuOcFRPwurIdgsaAJHNQnshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8lF4dDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F88C4CEDF;
	Tue,  4 Feb 2025 20:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699407;
	bh=/OGZR6yc7Rs+FpGVtY4XwYosR2D9X1bvqwbA+vxDDJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8lF4dDDAqJYJLYHzAXSvUKN7NraLfNU0h7hgOzEBvchSWQBJOAbuIKpEyBG/4MtP
	 7h8Olpm1v4ODRbxbihv0aAdXnpCWIkQzxwie0yb93iEf9ZtjsF/vTosxYBayj/KZxd
	 bfI7FPo5RmdKS1dkiKA2LOGxGAB9SZZhRyLFHfxAp2JP9KnTin8ikHudhjFRLwdCuZ
	 KEe+gv7tMUdc/GwvoBEjP5P5h/CcDdFR/ObNNYzL3ype46RBJqOmNCtu5Duk0yWT5H
	 U4cwcO3a2IC62CHZivqTZm+KYsNJRLj6gQzNc1CCA5j0Rm6EE9QDUe3pGPMREov1qw
	 pNw3bY6/rDWKg==
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
Subject: [PATCH 05/27] iio: proximity: sx9310: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:27 +0000
Message-ID: <20250204200250.636721-6-jic23@kernel.org>
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
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 0d7f0518d4fb..b60707eba39d 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -337,19 +337,26 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
 
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
 
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
-			return sx9310_read_gain(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx9310_read_gain(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9310_read_samp_freq(data, val, val2);
 	default:
-- 
2.48.1


