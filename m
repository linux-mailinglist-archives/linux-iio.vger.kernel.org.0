Return-Path: <linux-iio+bounces-15004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF994A27C5D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BB2165975
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD02054FD;
	Tue,  4 Feb 2025 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ3rq2oI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FB14B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699431; cv=none; b=m+fSmGfxc8Z5OoqCTqeUGX+XeTvOnJqpo6NstKwdI82/Ynxd3DEKGm0AVIPwbYuwNUnO+rOVtcEIvIzfVPdqHKckgQEf1XTovRmqnts9xPpWhmYcD5PkESWhrHjFP0k7AMRoIaAhelR9xMlElsIUUcUOOgsn2Gxyobj6vlz1BGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699431; c=relaxed/simple;
	bh=5X2E1m0lJQ8mY2eFcoGegOEVVKa3ldQCRFOxhKwmSuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTVjTe6Mh7U9AK5o3Ib1Hm6XT+qmR5lsoKnC877pvYk94ePqfai9vkjuukcexLgPx0s9MkRUa4KS0IJZDneyAMf5auBDCjBvVLVHt5AQ2+E1WzmJTkTN69crLgNqKTzP2A/H8QLjquxgacDE0210NAhN7nxX7KhWx7S5QyIYlPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ3rq2oI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289F2C4CEE2;
	Tue,  4 Feb 2025 20:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699431;
	bh=5X2E1m0lJQ8mY2eFcoGegOEVVKa3ldQCRFOxhKwmSuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQ3rq2oI8bj0GhvRVPEgUkCgIpF66MdmVWSz0LtOgDBzEvxzq5ci1ujxpWvxy0Ckg
	 Qjj88jbNbhglUu6g3RJQG2SkC5Vi5JuFm0CoJiwhs8RXfZnoTVna6oMIyE0RUiEIHu
	 cw1dULGresUwy240/S8cxUIBmE3/QY3QIFSfo7ywHNPo/Fx1u+TNrPpMjIxPCjzQRn
	 +XixAAIunMGa1wwSYnl07qrDi9uslrxNL9UDoEAXOxAkYF6Wp9Mr+xCSFsjEJmR/cc
	 TY0AffKLTn67iqyeXlEbVR5Opokb1RM1K+bjgMQiCSWikAljeY7QMBbQaJggSlUJvE
	 8ZR+UP5lYwRqA==
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
Subject: [PATCH 10/27] iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:32 +0000
Message-ID: <20250204200250.636721-11-jic23@kernel.org>
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
Cc: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/iio/adc/ad4130.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index de32cc9d18c5..1a38b52abbe4 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1060,13 +1060,11 @@ static int _ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
 static int ad4130_read_sample(struct iio_dev *indio_dev, unsigned int channel,
 			      int *val)
 {
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct ad4130_state *st = iio_priv(indio_dev);
+	struct ad4130_state *st = iio_priv(indio_dev);
 
-		guard(mutex)(&st->lock);
-		return _ad4130_read_sample(indio_dev, channel, val);
-	}
-	unreachable();
+	guard(mutex)(&st->lock);
+
+	return _ad4130_read_sample(indio_dev, channel, val);
 }
 
 static int ad4130_read_raw(struct iio_dev *indio_dev,
@@ -1076,10 +1074,16 @@ static int ad4130_read_raw(struct iio_dev *indio_dev,
 	struct ad4130_state *st = iio_priv(indio_dev);
 	unsigned int channel = chan->scan_index;
 	struct ad4130_setup_info *setup_info = &st->chans_info[channel].setup;
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		return ad4130_read_sample(indio_dev, channel, val);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ad4130_read_sample(indio_dev, channel, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE: {
 		guard(mutex)(&st->lock);
 		*val = st->scale_tbls[setup_info->ref_sel][setup_info->pga][0];
-- 
2.48.1


