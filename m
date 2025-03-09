Return-Path: <linux-iio+bounces-16601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58EFA585EF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5276E188A1DB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F01E520F;
	Sun,  9 Mar 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uiu+IFv8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2851E51FC
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539534; cv=none; b=WX1T1coOqkk//UOGf0lt3Ky/6Dpy4NtXalYavyFdgDcpxcTpj50jejP973mKLlwbeiwP19+gtZFanR4UbcUdPcHtYjSGxqa8C9ia+2/hpfPqRzhJ09WuMQBT2eZ3r9kiyj5iX2C2740t6CwhoVzz6W6HHQ+vkhGuH7re/CJE+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539534; c=relaxed/simple;
	bh=atNVxPelO0EvIhapjy+GuilNReWE4gyI3jWjGSwFQSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaxwKmk8vs6O/8t7qKIXjt9F+uLMrqLVg5eMpbH7qA9xhuvOaW0rLDkdtzKmw5pzCtVgmXmqtxxNa6vsFNXXZHTeFp5F2fOhFWA/JXHnlKjJHXcg+loXO83pkqQP/ZhHqMWEYZzmuNIJmdRcyN7r/0ufSFgFxlwFSa8Ey3cvmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uiu+IFv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83084C4CEEC;
	Sun,  9 Mar 2025 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539534;
	bh=atNVxPelO0EvIhapjy+GuilNReWE4gyI3jWjGSwFQSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uiu+IFv8/s87rh0aQLJwb+/hmg6vGZpGmsaI0XLz6oGyRAHXveyl3OqPwziNb/XZD
	 wz+FTfcGnLQRNzKCKF1IDKUA1Sin2FofK2/Hxz82Qdk4qxDNFW+KxNirF+qZphqOMu
	 eb5NAzVwQTqOiE08Uzl0PDt/hL4tkUfoUgs3qV6PAVKmA+bd38oPyyTsbDnb3kYLJ9
	 N1rgYcLoT3+hi1rHSRGKsf9kXzaO9U7J2i6v/8XoM2eeHZsMYI5dw6LxJe78ehfKAn
	 OmoHedNgzpwd7q7cGZoPtfkryI1lWq+q/rCC3E5aQ5idGiyQN1YEpf6hwyMDaar7/w
	 DmN1tr4cdEb1w==
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 4/8] iio: adc: ti-ads1100: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 16:58:15 +0000
Message-ID: <20250309165819.1346684-5-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309165819.1346684-1-jic23@kernel.org>
References: <20250309165819.1346684-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/adc/ti-ads1100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 0519f8afb033..b0790e300b18 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -223,12 +223,11 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = ads1100_get_adc_result(data, chan->address, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


