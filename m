Return-Path: <linux-iio+bounces-7627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40D931A54
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 20:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472C6B21CE2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331BF74063;
	Mon, 15 Jul 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XZjcJx2i"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4618B1A
	for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068313; cv=none; b=CvFxHuAWSGjLiySmgQY+j5Xx3hpcbs0wHNjDybm/mOICs7u0SgdzGL1lHYn1NX/+6kl0D+0dig04n+sKvwsstyLopaGTOH7PaxROVhfrT426HqyIOj8L+OdXrv/qRgO5fkPXhpxpH3qyUNtaFBHA1tcMIHu2OqC39d3xxpk29b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068313; c=relaxed/simple;
	bh=LAlSZaW1t3R2wQuNKy/0EykdIUbijoRUH4Yy+C5m8VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttJq2/aztMGkyAjOlS2ErUvU34WHV1mP4XXcGKjBXdOE/HoAHBCa0gHeNuMQtgtPu34Z47AuC0k6GNhV5B9cCgxEY6oxcrgDzS6a9STtlbXisatAXdHn/zdN2t2YM20b3E012gkEUOgtevEzGGw+w7fC+qftKnj/5TlHNTq+LQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XZjcJx2i; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7CBB48886D;
	Mon, 15 Jul 2024 20:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721068309;
	bh=R2R2CWOIXwpSu+iuEJ2+zB4L0z/kJcjqBMsidcigPss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZjcJx2i9zViMOQcLOO6JuM7ISjTO7w+NkbYwxezLp+/H/23LHdwL1QcWqgkesscH
	 +t/2yR/bo3f84+IS87kLZ/ppUjF6M0AQ5a6FfSiS0QOVxo6e1sQNtFXhNzt2qfqvBZ
	 6d3cJZtjqOZt3GegKxbbie9kjIKwEvtVxxTjcqx9JGBdKzaY0MhfnamUhg5hUli5IE
	 qCeOT67YLNu4rEjzqnBIvk4d79FTKmZzitTvusSMJ4sp0hxZXNmLzJUYUh1t5h5tde
	 5Lgzm+nlJhH6oaqC8xQaMS2vXFz9K+f2LxyiszMnMJcP8jU5yn9UKvvq94vfoPmDNr
	 GSGPLjIO8/yrQ==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] iio: light: noa1305: Report available scale values
Date: Mon, 15 Jul 2024 20:28:58 +0200
Message-ID: <20240715183120.143417-4-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715183120.143417-1-marex@denx.de>
References: <20240715183120.143417-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Make use of the new static table of scale values and expose available
scale values via sysfs attribute of the IIO device.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/noa1305.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index 202a5c1bbf798..e778714a942a0 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -102,9 +102,29 @@ static const struct iio_chan_spec noa1305_channels[] = {
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
 	}
 };
 
+static int noa1305_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type,
+			      int *length, long mask)
+{
+	if (chan->type != IIO_LIGHT)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = noa1305_scale_available;
+		*length = ARRAY_SIZE(noa1305_scale_available);
+		*type = IIO_VAL_FRACTIONAL;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int noa1305_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -125,6 +145,7 @@ static int noa1305_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info noa1305_info = {
+	.read_avail = noa1305_read_avail,
 	.read_raw = noa1305_read_raw,
 };
 
-- 
2.43.0


