Return-Path: <linux-iio+bounces-15006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE0A27C5F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729407A1F93
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912EF2063DA;
	Tue,  4 Feb 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXeBNX9v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC1204C20
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699441; cv=none; b=m4ky3tJsnND2gwJlBiPbMtS595YsxcLNaOVAihQIg1nlKPsj58aYAUdgbjFEv8cmFKFHWa+/Cotg8EKiSNynQbcXJwi1v+s2i1De5D2OmQGMDEeK0tNXKgLN0Wo+DPStg/TSb0WAOKG2JEjCeMGtGZFUlIJMOlRc+v0ythDicek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699441; c=relaxed/simple;
	bh=2dTHhAQ7W4Jn3VIiB5zMo/UE4SG7HJTqZFkCfsIkJk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJfrzDECIxNjeo187k8CtObFuvGldOBdm4f0p1teBBFXh0Pw2KbMfDKMa//cuwF2zTa4nEJ+f/mSuYCP7GpPo+e6CmhDq8zSWDOXx0DTtzFts4dRAPeE+s9XaxoKAJ895Kd6TRM564ABvBDIlphveNpagOd2g2AeaZw++ndH9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXeBNX9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D13C4CEE3;
	Tue,  4 Feb 2025 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699441;
	bh=2dTHhAQ7W4Jn3VIiB5zMo/UE4SG7HJTqZFkCfsIkJk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXeBNX9vlP0YxGGE8B9jzYvAk50AAwkopBZeZjf2/T8qKaKZvWYQvZ6AoCr6CGqSf
	 drU+x8sEspkd7O5XnEOhCMAdxLIr8gcy6wrTMhB1debyH4EaDMmnCVU1OEAji6U+0I
	 UEc4u4xgqjLV7HMG5UFPnBbDETHlQKHwYyRj3dGWF5lseYA9AzEcBsFv2Kpoqkz6sl
	 PSjZ0SyvKVUtBMfJtCSB5+k0BkzM053YPm78xAudktMgvvBNng1abjPDcVaRcA3D+E
	 N+0Lj0kEHIptth5RAtpc1LJ3z8KI22Mn6YMmjWAVbN31yEunUWlW3UvtT7VmFuhqRn
	 UhvzN/36zxsFw==
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
Subject: [PATCH 12/27] iio: adc: ad7606: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:34 +0000
Message-ID: <20250204200250.636721-13-jic23@kernel.org>
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
Cc: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d8e3c7a43678..39b5bf09e46d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -752,13 +752,13 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad7606_scan_direct(indio_dev, chan->address, val);
-			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7606_scan_direct(indio_dev, chan->address, val);
+		iio_device_release_direct(indio_dev);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
 			ch = chan->address;
-- 
2.48.1


