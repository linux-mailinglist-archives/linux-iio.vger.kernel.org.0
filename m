Return-Path: <linux-iio+bounces-16621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2CA58609
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69357188C2FF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA3F1E1DF3;
	Sun,  9 Mar 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx1T0Y9e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5444A0C
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540068; cv=none; b=B0koXCMll/5xpUoTHEHuZmuD6KeIl3DcHtGNX93Uf/yqSad6dJb6F1Jk24Y4jFxGfTGXNreXGpI9whlBUnH7JxK9XiBJ42dtOTUAVA9/E3KD6FL/qv9Olk1eOAew55m3dN7n/gJZuEh5j6YH1ycYxxGo835MrMTAtsiMm1HFhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540068; c=relaxed/simple;
	bh=JqgFsJLWCiijljkhdZqOU7uLp+uDQ2YD+YY54FqxLjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiQDVLJXzwzuKvCXVMKGmQIeIwiBJsm7QV5caiveLF12Czebk9pLoMhtLf1+gRsSafydiuy0MLDzONn8ao2hy9/lPlYxR1Dq2fL+APpDhwqefbC5aBnwZ1QrOd6bu9mX2REG4yBFdSE8zYryrr+mSM3dLu0vp+kztAOc6G1T6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx1T0Y9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0890C4CEE3;
	Sun,  9 Mar 2025 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540067;
	bh=JqgFsJLWCiijljkhdZqOU7uLp+uDQ2YD+YY54FqxLjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bx1T0Y9ewKnuuoR4CAlfZJpRDnPNwxoN7e37536T5hLFBX8z4Odyi9zmKDsuoreqI
	 Y9IGRJsBIEQ4mE7udn6cjVXNocuPw+bLfVHTSVfWNypj6u+d85dnC0TMumaBVsM99j
	 JjaBCqXWG6XbTfY+Noz3YHHLzmtMz6FCMxIXDez0lk+UB0Lnc7TF7u+E4lO4hXOE9A
	 iVIbqIrpPTr+Q8kXHzwDV5Ka2hdQb8nDKBYfIfrYYdoxX2dhKDmLz76ezrv2XyWQK8
	 1z3JF6MRSV8+nKPAGs1XgzFD4aUiY6P5D/7HGex5OqDFAt1ShOk7bmT4UWB96u6VJZ
	 nrkGCrI3LOE4A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/18] iio: light: tcs3414: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:30 +0000
Message-ID: <20250309170633.1347476-16-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
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
---
 drivers/iio/light/tcs3414.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 884e43e4cda4..39268f855c77 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -134,16 +134,15 @@ static int tcs3414_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = tcs3414_req_data(data);
 		if (ret < 0) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 		ret = i2c_smbus_read_word_data(data->client, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
-- 
2.48.1


