Return-Path: <linux-iio+bounces-18052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6FA87190
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3821890D2C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557B1A0728;
	Sun, 13 Apr 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="larASdXc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B82AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540516; cv=none; b=Yom0kkOsoOhSNdetNfEgQztXp1pblOTYdRoq5N6uCR4SaqNZ8siUlYxltsZKhvayPkb3D4qRcwRh/LH9YpdpIwDMEmHqqrx7Y3BtXfJZkN2d+IsjO1acnGKC2GohoanK1nybGwRjl8wgN7VPVT+qu+8ZQTzPh7hycD0oe4UZxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540516; c=relaxed/simple;
	bh=rMXZ8ICeBbnBHe4LEzOrD8YzqeEgPdRK27vo0ZwYJnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qo5vSAQO9fHOMLXbBiP34uwd7zYMNesI5LLz1b+TVaew35wrOJ9/B4GfXi5TcfsMG/ANxdidnqg2XEBUJ8QlVGXCZ0BaFT6bef+66Zt9yo8peE9n8UvxkUTcfVIRRmiS5bKCcdAwkT3/lUD01D9oxMMEIRWRLc56mCY2zum+TY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=larASdXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD1BC4CEEA;
	Sun, 13 Apr 2025 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540516;
	bh=rMXZ8ICeBbnBHe4LEzOrD8YzqeEgPdRK27vo0ZwYJnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=larASdXcqQJYBgp0elqhIQNdIyEAij1rpT8zo6tI8YkR7XTsFdQztQ4jpRxEPgA3L
	 J10n4NnZJoXJXMfaMNFQjMB0Ij4emIF9Iu+6rm/qsm/l8smF+SdsnWsf0G3CSmU8Gw
	 UANZrap2LV460iakBgjG5Mu4Vhh9y8hzKHlB7JvKGJhaJai1jSFbvW08BeIx7A3JsW
	 RTZWqcunAe20n9CiDcNmeeJKwafWzj8UrSiiaBTiaITbfLZJV2kVeBVWHHkrCtD8OE
	 UuIo3Jfot8W1IgLZoq1iaSSm+pkk+OPZurMyb6gJD1dcD7Mvy74uTKolpR7O/ajQL0
	 suP0AH/mpOYdQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 08/20] iio: adc: ti-ads131e08: Use new iio_push_to_buffers_with_ts() to provide length sanity check.
Date: Sun, 13 Apr 2025 11:34:31 +0100
Message-ID: <20250413103443.2420727-9-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

By providing the size of the buffer used, runtime checks can be performed
to ensure not overrun.

Also change the pushed data pointer to be that of the structure that also
contains the timestamp.  Not an actual bug but semantically incorrect to
push the channel data when we want the storage with the timestamp as well.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v3: Line wrap tweak (Andy)
---
 drivers/iio/adc/ti-ads131e08.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index c6096b64664e..085f0d6fb39e 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -664,8 +664,8 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 		i++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->tmp_buf.data,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->tmp_buf, sizeof(st->tmp_buf),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.49.0


