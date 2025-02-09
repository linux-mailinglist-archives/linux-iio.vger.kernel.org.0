Return-Path: <linux-iio+bounces-15196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6DA2DFBE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23FA3A5BFF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E711E1A08;
	Sun,  9 Feb 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISxs38j5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E311E0DE3
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124424; cv=none; b=gTkEU182pJBvGGNcl3W+XlUQx4iW+jxBOR2ZO1WaTuLbFUUVkyFwUAZ3upD7VZfPHn3GcfpqRDN16xCf7fUZCrX9Ney4203yAhqQwXGK9JSaotmJWSymKYUdStaRbRLpNr6pGer3PJqAbQB95y8O89nnOO6po/rKaE4K7xzXFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124424; c=relaxed/simple;
	bh=n96MC2iUeimgWw2sg+uOKbdsiUONkbRku1hmdXi3aVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWuE50CRSg5HHNfrr3Nza5doZeDe8GbKETgJoO5uJ/9jD58G61MDPDEvM5psaHkWYgIKAROl4lAd8DdxRJkzZXiIzZX6kAQ2zMmNzK49rh8auTa0ga8NnNlIfGYjp7G3Ky4xxxgmXZZ0QVf9NUSBh89Oviu8uAlMY1c6c5VygmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISxs38j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B5FC4CEE9;
	Sun,  9 Feb 2025 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124423;
	bh=n96MC2iUeimgWw2sg+uOKbdsiUONkbRku1hmdXi3aVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISxs38j5284wEw1Qji4FRaTfxAok2yk67+5lcqFeRiB4G6JCiHAXuhExfUXbBv14e
	 U8LR7lBEFJzM111GrsHETXO9tHGLo8jJr3mn7FfnwZAv6FI2rqj0GV9mNLJRdKnGOt
	 DVeGRkiv9lSIcrdl/gM9P06vJSGKtC6bk9JlURzbKfBfSIONJpDNlxSYXrCNl3n7bX
	 QrSSxXZrxTXx0p2ET8DxYsDP8oHgQUVSbrtCXC4lyPMUXMQeVVn8NVnXgT4+Ur07Rm
	 ZPqqgzueOEi4vAl3z4Tmzw5zVeVyLeJ9rHXvot4Pk8H5nzTN//o+dk4u8yvO2ObGLi
	 rB6I2MePkyL5w==
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
Subject: [PATCH v2 03/27] iio: chemical: scd30: Switch to sparse friendly claim/release_direct()
Date: Sun,  9 Feb 2025 18:06:00 +0000
Message-ID: <20250209180624.701140-4-jic23@kernel.org>
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

This driver caused a false positive with __cond_lock() style solution
but is fine with the simple boolean return approach now used.

Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/scd30_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 23ba46f7ca32..3fed6b63710f 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -211,18 +211,17 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 			return IIO_VAL_INT;
 		}
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = scd30_read(state);
 		if (ret) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 
 		*val = state->meas[chan->address];
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
2.48.1


