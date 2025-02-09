Return-Path: <linux-iio+bounces-15211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C831DA2DFCF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1187A0F40
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD61E0DFE;
	Sun,  9 Feb 2025 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJrml+Pv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBC243368
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124537; cv=none; b=BvXIUq+8gdrtGcyaB7raC7oLqAD6caqiejhpwvZiADthXuaPcJkgIAgNbEruXBj5rDNljHQzupeWMj1i74BIgeJg8qul4Lm5nQ1q176WKW0t2sEZ3ZIvmAMSOAkhWuUFzV0oO3LoeVRSI+eY1ruF6AhW7vQU96EAzaTdUgAczOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124537; c=relaxed/simple;
	bh=HNNUFCABRUtOp1yOV4w7UniDWEHM1s91NTJTJAjSvAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1L3fhybbbTeoswoXYv4M+VKIPwXFFJEQEx4JDHQodVnZpTXg7tKGylODqyXFQTqa0OFGIT2Z0nd3irsUTx3+c2Ic7xbsSOTMl9z1Pi9gO/1fL3GbGIOOCXKTqIm71KGNxNMWqUiA5BbQjJ/wGEmv8//XU7W0gVwsc6c5o68yoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJrml+Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BABC4CEDD;
	Sun,  9 Feb 2025 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124536;
	bh=HNNUFCABRUtOp1yOV4w7UniDWEHM1s91NTJTJAjSvAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJrml+PvDIs3+Uej9s3T9S9OhpFZvDotZ45lZ0btJm5HDTK9KoROM0wLGe1NU5V4V
	 ATAlPmlKxHfFtuljNSLQSh94oggkT5DNqyRQDVcacnmM29/gkRtXxY+sE/46K1eXrD
	 SNuBIbLAXa3ZE9/fKyvPeN+rp4nhb2WmQpz+SpR94jgGCYzF76TavLDdYnuTyQt3xW
	 58qbWSbYK5qyWOauLr8dqu5M4nuKm+MWEgORh8Jtq9Em3G/hWSVyMg5TrmpD8efCbF
	 Z/BlIWm31kF86Y938KYjWADunHXwqAN/Bh5OTfoFy2XW/wbTaYcvNsbGkyRQydCKpi
	 Io/Kt67S+oNHQ==
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
Subject: [PATCH v2 18/27] iio: adc: ti-adc161s626: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:15 +0000
Message-ID: <20250209180624.701140-19-jic23@kernel.org>
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc161s626.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 474e733fb8e0..28aa6b80160c 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -137,13 +137,13 @@ static int ti_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ti_adc_read_measurement(data, chan, val);
-			if (ret)
-				return ret;
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ti_adc_read_measurement(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = regulator_get_voltage(data->ref);
 		if (ret < 0)
-- 
2.48.1


