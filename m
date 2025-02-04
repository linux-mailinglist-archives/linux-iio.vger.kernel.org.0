Return-Path: <linux-iio+bounces-15015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9800A27C6B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A697A225D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D482063DB;
	Tue,  4 Feb 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0WNONTR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164014B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699487; cv=none; b=m7MOa8IDrtQr0DIkrW7bO+9M6bqGTvRFFaZEPleG6yGtVipJZvFhzONYKwhaHyDuxjB0t97ijVv9poCLu25v8pQb3VVqnOVrA+bUNL8u9nUORlaihiya7jfL3K7omew5UyDhM4VEcDxkSyPkFsuqTtlAhC/4itrivavtzVv8S3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699487; c=relaxed/simple;
	bh=naa36Kw/w9Q2w+OlD+qDpDcinPo6Sk3StWJlaf/fk2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMfkAhS6kKUmbQY3h0VnFT4P0nk/DIQpd2fSodB7eSU7FcACMrvGh5N9sBa0Cq3l8zgehsdmyjqhvo1ylrqWxK6r16A5tUSN6vOiMI2O1gaA5+9Ew/b4S//ktWPru4KqGDZGhJ33sKRCWyZuf/A8mP28GBkC7MelN+BYEOcldUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0WNONTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C1FC4CEE2;
	Tue,  4 Feb 2025 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699486;
	bh=naa36Kw/w9Q2w+OlD+qDpDcinPo6Sk3StWJlaf/fk2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0WNONTRIEqcbbxDcM6Gkbp6YHtxtziYUyFgLAuJmht/RWB/8H0Y1NDeRt+pRys6/
	 LrBNo0AHUgmhk2G28NCpyopzXrsr6Pn4gozQUPzABsn5bRg1zkqXa/ML6hbhqEeWV/
	 36oE2+G3xeNOOGm24A2CmYjZ2xT1XWovEszQ1rTXwMpHi0phAstb5hbXylnXw5wHLJ
	 5cueNY31wmFb2c7yRSxB74s1IIM44YEInt7rEFOVgZSebH1QZlAak6bcEYfTAL9AkE
	 cxHYX2IAEInKMqTH1E0D3Fq6zM51KIdGVM7nfv/6MEfJh30/ICwj8/o1HzxvSgLw7O
	 dc1qrJKaq6g0g==
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
Subject: [PATCH 21/27] iio: chemical: ens160: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:43 +0000
Message-ID: <20250204200250.636721-22-jic23@kernel.org>
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
Cc: Gustavo Silva <gustavograzs@gmail.com>
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


