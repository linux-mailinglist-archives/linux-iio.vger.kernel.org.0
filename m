Return-Path: <linux-iio+bounces-15214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4554A2DFD5
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B413A5955
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9931E1A3D;
	Sun,  9 Feb 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw/2WY6p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A11E0E13
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124558; cv=none; b=ZUKm88IEtYGaqM7pg+P2aVnMrtwHsAzKy/pHLD3IHZGIOdYYy7VVq6jbZTYSydXvMBBn6vZoco6UimgnCdd199mZLnVrh6lP+HbYWijYW+FTX5nrWKZHnUVRsYA6lV/XXacTCcxznsyDNaBawXjho0wT4bWM+pfU38k+SabUyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124558; c=relaxed/simple;
	bh=eE+Ah0HZqrYQQuVZav40kxZxdhk2oOU0tkAlSJO99Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifpQWjrwieDci9dfd8U38vwagaxqPYO7AifOANRIJHrVbRZSm1WX7wbCBfmtUbsDPRTmH8/+fConX9ha/Lratd/wIVfeH85lqacbXSyRijh7BC5ezGsFz0pAnAWgg47kjogUS329D6bQ6l9eQkQ0SF07OvNVLNYEo8xFGFuSBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw/2WY6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC81CC4CEDD;
	Sun,  9 Feb 2025 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124558;
	bh=eE+Ah0HZqrYQQuVZav40kxZxdhk2oOU0tkAlSJO99Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lw/2WY6pHhfR0bKzbksZM6I3kUf8+Yqa+X99G9Hn15RJ6nTRMqxZ3eKoULhZyu/zt
	 Lrv2Ha1yHw5gskkwLTrh0E+AQm9eAvZoj/V9mePqQ4Fyy+VYALXZu5QLrCUvgvsaUK
	 5qCKgkoSD0ceJl7WztY+HBmwfIOb3gEhRjxLMlfwqIM7lGIsiEzb4zG6PqR5ysgZWF
	 00hh9Ic1kLXHHMC1bmYxzHCjmvYTIe6fEtpwR38XK5l6XcHxSErMJTlHEn6UxF4TB1
	 v38Eoryqc5KWpRibOo2UiAiHmf6ShT5pXRjPr/RNmVwgAP7feTjVezRaz3lmuHPX8f
	 yLbqIk5ewCqww==
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
Subject: [PATCH v2 21/27] iio: chemical: ens160: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:18 +0000
Message-ID: <20250209180624.701140-22-jic23@kernel.org>
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

Reviewed-by: Gustavo Silva <gustavograzs@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/ens160_core.c | 32 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 48d5ad2075b6..152f81ff57e3 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -100,25 +100,35 @@ static const struct iio_chan_spec ens160_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static int __ens160_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val)
+{
+	struct ens160_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	ret = regmap_bulk_read(data->regmap, chan->address,
+			       &data->buf, sizeof(data->buf));
+	if (ret)
+		return ret;
+	*val = le16_to_cpu(data->buf);
+	return IIO_VAL_INT;
+}
+
 static int ens160_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
 {
-	struct ens160_data *data = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			guard(mutex)(&data->mutex);
-			ret = regmap_bulk_read(data->regmap, chan->address,
-					       &data->buf, sizeof(data->buf));
-			if (ret)
-				return ret;
-			*val = le16_to_cpu(data->buf);
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = __ens160_read_raw(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel2) {
 		case IIO_MOD_CO2:
-- 
2.48.1


