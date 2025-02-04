Return-Path: <linux-iio+bounces-15021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ED4A27C78
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30E01653B8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B0203710;
	Tue,  4 Feb 2025 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOtt8+3v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2E2040A8
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699518; cv=none; b=l8UFQHKpdDpR8fG38NTaD3iPjyUxYbaYSWFSlH3X61YGbYBigNhM6BEIereCwayf8KksBse4bHAiVdtJkMrTXkUiTn5gxxN6AuOZ6H+XvMzva7UGOaOYqrOLDQvsbxAx6McZNBXA8P/tdrtz0wo8dk8zzpjzj9ygUykyDYCuTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699518; c=relaxed/simple;
	bh=nTDvAiR+VPxLXANH/DY0hOcnWcZs8ukFjSZU4w2M5H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKLsrr80PihiUJqLLemY9DL68agP/m4AlNhjczEtVngwdnZTXN6aAkrapLI188c1vyros/h7fL54A6sBfHPPPT6cRPQdyU2jaIRbVY556yxwwRSeOBe/OIErkh2bb33aGsLW44Xfjd8A8IbOOubZwnobFAcZbnWmyB2P2KS/ZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOtt8+3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADA4C4CEE2;
	Tue,  4 Feb 2025 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699517;
	bh=nTDvAiR+VPxLXANH/DY0hOcnWcZs8ukFjSZU4w2M5H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOtt8+3v7CCmVS0Fj5hgMKcd5TDqYFcAQ/qH93FioERQYSzPedFUGYk9bp8F/9eEh
	 llsHFfF9gtQFrjwJwDYT3TurEhQSHXCrWXkpIDw5bMw/TdeYKrSkhHvGondXgXcGGt
	 Jg8uGgKnMcxozAjXfRI4eTRQS3+Swytfzfnxl+OKMlBnr3crv9IOVN3k2A3SZVAuhi
	 WMPqMlsu4V29qkbf9JW3qUXcjnHNw8Az3WNElwK0sBrJwb5xIQizRxMYAwAV914lL4
	 5UCvobkJJ0Cw1Z5JGfsDWLv3Q57K1yL5jYOJsbv6Ef8dTe5U7AcBw2duUKdQimoLdG
	 Qj9Wy1a29mwEA==
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
Subject: [PATCH 26/27] iio: light: bh1745: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:48 +0000
Message-ID: <20250204200250.636721-27-jic23@kernel.org>
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
Cc: Mudit Sharma <muditsharma.info@gmail.com>
---
 drivers/iio/light/bh1745.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 3b4056be54a0..56ab5fe90ff9 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -426,16 +426,16 @@ static int bh1745_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = regmap_bulk_read(data->regmap, chan->address,
-					       &value, 2);
-			if (ret)
-				return ret;
-			*val = value;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		ret = regmap_bulk_read(data->regmap, chan->address, &value, 2);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = value;
+
+		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE: {
 			guard(mutex)(&data->lock);
-- 
2.48.1


