Return-Path: <linux-iio+bounces-15200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B6A2DFC0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F41885390
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19C1E1A18;
	Sun,  9 Feb 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzg1haYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAA1E0E14
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124453; cv=none; b=tcJ6t8H/jpLDu7YbdggwKEvM+Es62jPFoHv2are/tmSfeXu08P/aAa2QV8qRoud+gnrWXyYX9vGKQXlB0mhgErFR5GrIhnpLb8FQJLTgG1LvZ+D/i2caum1oIHhaIC/mLPEhQ0wSoLss/ELT+6i8Hc+iZOHSAZEJF+iUpgz4vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124453; c=relaxed/simple;
	bh=G6jkkNvXb35keFn/+FKv0VCVhqiIl5HXp2F2/4h9VPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3PmEvkf2oj01sfApwXEFS5QK7YxwSwupr91dW/m5clcRZWQUBNssi1Q/eB4+nukA7H0zYjYIwi2wn5ospvihZKngiNGZPTq5u1UzF23rIE52r/ukKbg7JJ7x+b00/3OwWB7H9CIup0Fy1rXHaMrmVxrzo44YBIM2wfh7qm6Nqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzg1haYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E13C4CEDD;
	Sun,  9 Feb 2025 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124453;
	bh=G6jkkNvXb35keFn/+FKv0VCVhqiIl5HXp2F2/4h9VPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zzg1haYfl99McnwKkdPaEuDeNQrHsR0B/QaU1nXhTwNyibkQ2CzpUIoIgFh7DSNbP
	 nGi6ksB3HGorgHfj3cTvbyYFjaYq8lbog/58d/Ap0OKuxMXK4Fd7VDwtlWk/UDKk3I
	 QpmYIk/v+19EfokLn7mDNbyxqg/jk+0yzRb9fGxvzgOoQP0uB7glPELH/67UDMa7De
	 Cu2IFZpaBOOTVKTlsnRcdnoJVNe2RRQEyLBopr2jDnH7Ql1xmPZ5NQ8ZCroFvBt+k5
	 hJQdQtLLAM9F6Q5ewPJ/vmG6Lg++ezF9lLqgTJBuKT2LURVYaVldnlA6Vn56m+YElt
	 zkaoo1rcxmrqw==
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
Subject: [PATCH v2 07/27] iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:04 +0000
Message-ID: <20250209180624.701140-8-jic23@kernel.org>
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
 drivers/iio/proximity/sx9360.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index a6ff16e33c1e..4448988d4e7e 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -321,16 +321,23 @@ static int sx9360_read_raw(struct iio_dev *indio_dev,
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
-			return sx9360_read_gain(data, chan, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = sx9360_read_gain(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9360_read_samp_freq(data, val, val2);
 	default:
-- 
2.48.1


