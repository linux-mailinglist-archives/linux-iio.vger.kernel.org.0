Return-Path: <linux-iio+bounces-15001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC2A27C59
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D416188434E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375D2046B1;
	Tue,  4 Feb 2025 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlVCavjb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A114B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699417; cv=none; b=XKVknPZv3ZlxJEfHd7/gkBUYqiotoOpjnatofspUBbbp2QdiAKlBlaLkC7Vb0JrPUoIy/XS8C4jplczczSDbnXG1/0w3qF4yTxWHoMKElPIMDKReGAp9LSWIahUnuZ5g+Dy2H70FY9yt6pAGCVWcXAjN/1xPdpFzAz40wGBhtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699417; c=relaxed/simple;
	bh=/2z/DF+G9tiB//ZmP8WuK3FcWPMA/e4kZKCwyw2chkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2TBtgTf5vYFdQM6sOhbW6fQBS/QHkBekuderMUmrHifs8NP551rc11I7DjAUQ7C2Kk61J5/V8aj71dt8B4sD/Uur8s2+NyK7mD1RkgVbNK8UmlgD3zLBBJ/FSWo+jE+BvEoSj7g0e7durg7keyb884EKMMvW+aMVvrTJCtlzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlVCavjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99997C4CEE3;
	Tue,  4 Feb 2025 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699417;
	bh=/2z/DF+G9tiB//ZmP8WuK3FcWPMA/e4kZKCwyw2chkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlVCavjbOPMDAEOsZReBI+a44MFcMexO4oYnwPPJNRX/FpfUB2Btu5JXAQuSWv4Ua
	 g7vCYDxf/vzPCi+A1Kl4GieheN0gQjQxPUOV3yPVOvwwU9qX4tjNW5AxVWWbs8b2bi
	 suXZ004w5mRUzcUBcKNvZDBaWkMZub/tC5jzHOOqHrOEB2AQc1js8YCYwx6A8LX70w
	 2CTa2i6/UanmJc3N9SmPc22nfThJt5WeWiOtrpKmmDfAGbxhOC3yw2pn5dYynOegcX
	 9cd2QTb0HJOjxCajlQNptutPrwuslUc9fuT1JaU0fuIvpJ6w1ic34F5JVFC05qa/6L
	 Fze6yFXN/knGQ==
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
Subject: [PATCH 07/27] iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:29 +0000
Message-ID: <20250204200250.636721-8-jic23@kernel.org>
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
to check for unbalanced context

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
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


